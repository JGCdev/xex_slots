ESX                             = nil
local PlayerData                = {}
local open 						= false

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

        TriggerEvent("esx:getSharedObject", function(xPlayer)
            ESX = xPlayer
        end)
    end

    while not ESX.IsPlayerLoaded() do 
        Citizen.Wait(500)
    end

    if Config.BlipsEnabled and ESX.IsPlayerLoaded() then
        PlayerData = ESX.GetPlayerData()
        CreateBlip()
    end
end)

RegisterNetEvent("xex_slots:enterBets")
AddEventHandler("xex_slots:enterBets", function ()
    local bets = KeyboardInput(_U('set_bet'), "", Config.MaxBetNumbers)
    if tonumber(bets) ~= nil then
    	TriggerServerEvent('xex_slots:BetsAndMoney', tonumber(bets))
    else
		unsit()
    	TriggerEvent('esx:showNotification', _U('only_numbers'))
    end
end)

RegisterNetEvent("xex_slots:UpdateSlots")
AddEventHandler("xex_slots:UpdateSlots", function(lei)
	SetNuiFocus(true, true)
	open = true
	SendNUIMessage({
		showPacanele = "open",
		coinAmount = tonumber(lei)
	})
end)

RegisterNetEvent("xex_slots:unsit")
AddEventHandler("xex_slots:unsit", function()
	unsit()
end)


RegisterNUICallback('exitWith', function(data, cb)
	cb('ok')
	SetNuiFocus(false, false)
	open = false
	TriggerServerEvent("xex_slots:PayOutRewards", data.coinAmount)
	if Config.SittingEnabled then
		unsit()
	end
end)

RegisterNUICallback('sendHook', function(data, cb)
	cb('ok')
	if Config.WebhookEnabled then
		local messageString = _U('win_hook',  GetPlayerServerId(PlayerId()), data.premio)
		TriggerServerEvent('xex_slots:sendDiscordHook', messageString)
	end
end)


local closestSlotMachine = nil
Citizen.CreateThread(function ()
	SetNuiFocus(false, false)
	open = false
	while true do
		Citizen.Wait(10)
		langaAparat = false
		local found = false

		for i=1, #Config.Slots, 1 do
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Slots[i].x, Config.Slots[i].y, Config.Slots[i].z, true) < 2  then
				found = true
				x = i
				wTime = 0
				langaAparat = true
				closestSlotMachine = Config.Slots[i]
				if open then
					ESX.ShowHelpNotification(_U('press_to_exit'))
					DisableControlAction(0, 1, true) -- LookLeftRight
					DisableControlAction(0, 2, true) -- LookUpDown
					DisableControlAction(0, 24, true) -- Attack
					DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
					DisableControlAction(0, 142, true) -- MeleeAttackAlternate
					DisableControlAction(0, 106, true) -- VehicleMouseControlOver
				else
					ESX.ShowHelpNotification(_U('press_to_join'))
				end
			end
		end

		if not found then
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(1)
		local found = false
		if langaAparat then
			found = true
			if IsControlJustReleased(0, 38) then
				if Config.SittingEnabled then
					sit()
				else
					TriggerEvent('xex_slots:enterBets')
				end
			end
		end

		if not found then
			Citizen.Wait(1500)
		end
	end
end)

local lastPos = nil
local currentSitObj = nil
function sit()
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	for k,v in pairs(Config.Slots) do
		if (v.id == closestSlotMachine.id) then
			local prop = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey(v.prop), false)
			if DoesEntityExist(prop) then
				local pos = GetEntityCoords(prop)
				local id = pos.x .. pos.y .. pos.z
		
				ESX.TriggerServerCallback('xex_slots:getPlace', function(occupied)
		
					if occupied then
						ESX.ShowNotification(_U('site_occupied'))
					else
						local playerPed = GetPlayerPed(-1)
						lastPos = GetEntityCoords(playerPed)
						currentSitObj = id
		
						TriggerServerEvent('xex_slots:takePlace', id)
						local offsetX = v.offsetX
						local offsetY = v.offsetY
						local offsetZ = v.offsetZ
						local posX = pos.x + offsetX
						local posY =  pos.y + offsetY
						local posZ =  pos.z - offsetZ
						TaskStartScenarioAtPosition(playerPed, 'PROP_HUMAN_SEAT_BENCH', posX, posY, posZ, GetEntityHeading(prop)+0.0, 0, true, true)
						TriggerEvent('xex_slots:enterBets')
					end
		
				end, id)
			end
		end
	end
end

function unsit()
	local playerPed = GetPlayerPed(-1)
	ClearPedTasks(playerPed)
	TriggerServerEvent('xex_slots:leavePlace', currentSitObj)
	Citizen.Wait(4000)
end

function CreateBlip()
	for k,v in ipairs(Config.Slots)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 436)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 49)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('blip_name'))
		EndTextCommandSetBlipName(blip)
	end
end

function KeyboardInput(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end

