----------------------------------------------------------------------
----------------------- Developped by AlphaKush ----------------------
----------------------------------------------------------------------

Config              = {}
Config.DrawDistance = 100.0
Config.MarkerColor  = {r = 120, g = 120, b = 240}
Config.EnableSocietyOwnedVehicles = false -- à tester
Config.EnablePlayerManagement     = true
Config.MaxInService               = -1
Config.Locale = 'fr'

Config.Zones = {

	--CloakRoom = { --Vestaire privé président
		--Pos   = {x = 126.43100738525, y = -729.10052490234, z = 241.15190124512},
		--Pos   = {x = -425.739, y = 1092.472, z = 250.310},
		--Size  = {x = 1.0, y = 1.0, z = 1.0},
		--Color = {r = 0, g = 204, b = 3},
		--Type  = 1
	--},

	CloakRoom2 = { --Vestaire garde du corps
		Pos   = {x = -441.037, y = 1091.925, z = 250.310},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 1
	},

	OfficeEnter = { --entré du batiement
		Pos   = {x = -429.0690612793, y = 1110.7834472656, z = 326.69631958008},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 1
	},

	OfficeExit = { -- sorti du batiment
		--Pos   = {x = 136.16203308105, y = -761.72442626953, z = 241.15211486816},
		Pos   = {x = -435.473, y = 1100.271, z = 250.310},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 91, b = 0},
		Type  = 1
	},

	OfficeInside = { -- spawn interieur batiment
		--Pos   = {x = 135.32885742188, y = -764.09942626953, z = 241.15211486816},
		Pos   = {x = -436.020, y = 1097.488, z = 251.287},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = -1
	},

	OfficeOutside = { --spawn exterieur batiment
		Pos   = {x = -428.12902832031, y = 1115.4178466797, z = 325.76840209961},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = -1
	},

	OfficeActions = { -- Marker action boss
		--Pos   = {x = 156.23593139648, y = -740.03515625, z = 241.1519317624},
		Pos   = {x = -426.559, y = 1088.256, z = 250.310},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 1
	},

	--- Garage ----

	GarageEnter = { -- entrée garage
		Pos   = {x = -467.5237121582, y = 1128.8880615234, z = 324.85531616211},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 1
	},

	GarageInside = { -- spawn interieur garage
		Pos   = {x = 234.87281799316, y = -1003.8368530273, z = -99.999954223633},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
	},

	GarageExit = { -- exit le garage ascensseur
		Pos   = {x = 240.86296081543, y = -1004.7778930664, z = -99.999969482422},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 91, b = 0},
		Type  = 1
	},

	GarageOutside = { -- spawn exterieur du garage
		Pos   = {x = -460.72052001953, y = 1127.3813476563, z = 324.85491943359},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
	},

	VehicleSpawner = { -- Menu dans le garage pour les véhicules
		Pos   = {x = 233.05233764648, y = -977.39697265625, z = -99.999954223633},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 242, g = 255, b = 0},
		Type  = 1
	},

	VehicleSpawnPoint = { --Spawn du véhicule dans le garage
		Pos   = {x = 228.47023010254, y = -988.41326904297, z = -98.999954223633},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
	},

	VehicleSpawnExterior = { --Spawn devant l'observatoir à la sorti du garage
			Pos = {x = -413.34255981445, y = 1177.6545410156, z = 325.64166259766},
			Size  = {x = 1.5, y = 1.5, z = 1.0},
			Color = {r = 0, g = 204, b = 3},
			Type  = -1,
			Heading = 250.0
	},

	GarageExitWithVehicle = { -- Marker pour sortir du garage avec la voiture
			Pos = {x = 227.85629272461, y = -1003.4248657227, z = -99.999954223633},
			Size  = {x = 1.5, y = 1.5, z = 1.0},
			Color = {r = 204, g = 91, b = 0},
			Type  = 1
	},

	VehicleDeleter = { -- Marker pour ranger la voiture
		Pos   = {x = -397.39294433594, y = 1174.0627441406, z = 324.64169311523},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 0, b = 0},
		Type  = 1
	},

	------------ TP hélico -----------
	HelicoEnter = { -- entrée helico
		Pos   = {x = -441.100, y = 1088.104, z = 250.310},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 1
	},

	HelicoInside = { -- spawn interieur place helico
		Pos   = {x = -429.381, y = 1089.499, z = 332.532},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
	},

	HelicoExit = { -- exit helico
		Pos   = {x = -434.781, y = 1090.486, z = 331.550},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 91, b = 0},
		Type  = 1
	},

	HelicoOutside = { -- spawn interieur batiment president
		Pos   = {x = -441.813, y = 1090.175, z = 251.287},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
	},

	HelicoSpawner = { -- Menu pour spawn l'hélico
		Pos   = {x = -424.570, y = 1089.275, z = 331.550},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 242, g = 255, b = 0},
		Type  = 1
	},

	HelicoSpawnPoint = { --Spawn de l'hélico sur la plateforme
		Pos   = {x = -414.833, y = 1096.917, z = 331.550}, --Heading = 291.4347
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
	},

	HelicoDeleter = { -- Marker pour ranger l'hélico
		Pos   = {x = -448.795, y = 1106.329, z = 331.550},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 0, b = 0},
		Type  = 1
	},
}
