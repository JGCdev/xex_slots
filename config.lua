Config = {}
Config.Locale = 'en'
Config.BlipsEnabled = false
Config.SittingEnabled = true
Config.MaxBetNumbers = 4 -- limit to join game (4 digits default)
Config.WebhookEnabled = true
Config.Webhook = "https://discord.com/api/webhooks/yourhook"

Config.Slots = { -- Only fill prop and offset data if Config.SittingEnabled = true 
  	{
		id = 0,
		x = 981.4, 
		y = 46.73,
		z = 74.48,
		prop = "vw_prop_casino_slot_07a",
		offsetX = -0.80, 
		offsetY = -0.35,
		offsetZ = -0.70
	},
  	{
		id = 1,
		x = 977.23, 
		y = 54.716255950928, 
		z = 74.476211547852,
		prop = "vw_prop_casino_slot_07a",
		offsetX = -0.80, 
		offsetY = -0.35,
		offsetZ = -0.70
	},
	{
		id = 2,
		x = 979.44, 
		y = 56.746255950928, 
		z = 74.476211547852,
		prop = "vw_prop_casino_slot_04a",
		offsetX =0.56, 
		offsetY = 0.70,
		offsetZ = -0.70
	},
	{
		id = 3,
		x =982.17, 
		y = 53.546255950928, 
		z = 74.476211547852,
		prop = "vw_prop_casino_slot_05a",
		offsetX =-0.43, 
		offsetY = 0.75,
		offsetZ = -0.70
	},
}
