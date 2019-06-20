Config = {}
Config.Locale = 'en' -- traduções disponives br-en

Config.RequiredCopsRob = 2 -- Quantidade de policias na cidade para roubar
Config.RequiredCopsSell = 2 -- Quantidade de policias na cidade para vender

Stores = {
	["jewelry"] = {
		position = { ['x'] = -629.99, ['y'] = -236.542, ['z'] = 38.05 },
		reward = math.random(30000,67000),
		nameofstore = "jewelry",
		lastrobbed = 0
	}
}
