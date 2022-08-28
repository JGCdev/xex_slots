ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("xex_slots:BetsAndMoney")
AddEventHandler("xex_slots:BetsAndMoney", function(bets)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        if bets % 50 == 0 and bets >= 50 then
            if xPlayer.getMoney() >= bets then
                xPlayer.removeMoney(bets)
                TriggerClientEvent("xex_slots:UpdateSlots", _source, bets)
            else
                TriggerClientEvent('esx:showNotification', _source, _U('no_money'))
                if Config.SittingEnabled then
                    TriggerClientEvent("xex_slots:unsit", _source)
                end
            end
        else
            TriggerClientEvent('esx:showNotification', _source, _U('error_bet'))
            if Config.SittingEnabled then
                TriggerClientEvent("xex_slots:unsit", _source)
            end
        end

    end
end)

RegisterServerEvent("xex_slots:PayOutRewards")
AddEventHandler("xex_slots:PayOutRewards", function(amount)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        amount = tonumber(amount)
        if amount > 0 then
            xPlayer.addMoney(amount)
            TriggerClientEvent('esx:showNotification', _source, _U('exit_machine', amount))
        else
            TriggerClientEvent('esx:showNotification', _source, _U('lose_money'))
        end
    end
end)



-- SEATS
local SeatsTaken = {}
RegisterServerEvent('xex_slots:takePlace')
AddEventHandler('xex_slots:takePlace', function(object)
	table.insert(SeatsTaken, object)
end)

RegisterServerEvent('xex_slots:leavePlace')
AddEventHandler('xex_slots:leavePlace', function(object)

	local _SeatsTaken = {}

	for i=1, #SeatsTaken, 1 do
		if object ~= SeatsTaken[i] then
			table.insert(_SeatsTaken, SeatsTaken[i])
		end
	end

	SeatsTaken = _SeatsTaken
	
end)

ESX.RegisterServerCallback('xex_slots:getPlace', function(source, cb, id)
	local found = false

	for i=1, #SeatsTaken, 1 do
		if SeatsTaken[i] == id then
			found = true
		end
	end
	cb(found)
end)

RegisterNetEvent('xex_slots:sendDiscordHook')
AddEventHandler('xex_slots:sendDiscordHook', function(message)
	local _source = source
	if message then
		PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end)