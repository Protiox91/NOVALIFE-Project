Config              							= {}
Config.DrawDistance 							= 100.0

Config.MarkerColor  							= {r = 120, g = 120, b = 240}
Config.EnableSocietyOwnedVehicles = false
Config.EnablePlayerManagement     = true
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = true
Config.MaxInService               = 5
Config.Locale 										= 'fr'

Config.Blips = {

	Blip = {
		Pos     = { x = 233.012, y = -419.544, z = -119.2 },
		Sprite  = 419,
		Display = 4,
		Scale   = 0.9,
		Colour  = 37,
	},
}

Config.Zones = {

	Cloakrooms = { 
		Pos   = {x = 232.596, y = -423.232, z = -119.2},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 1
	},

	Vaults = {
		Pos   = { x = 242.445, y = -416.496, z = -119.2 },
		Size  = { x = 1.3, y = 1.3, z = 1.0 },
		Color = { r = 30, g = 144, b = 255 },
		Type  = 1,
	},

	Vehicles = {
		Pos          = { x = 249.638, y = -403.171, z = 46.924 },
		SpawnPoint   = { x = 290.998, y = -337.421, z = 43.962 },
		Size         = { x = 1.8, y = 1.8, z = 1.0 },
		Color        = { r = 255, g = 255, b = 0 },
		Type         = 1,
		Heading      = 334.5,
	},
	
	VehicleSpawnPoint = {
		Pos   = { x = 290.998, y = -337.421, z = 43.962 },
		Size  = {x = 1.5, y = 1.5, z = 0.6},
		Type  = -1,
	  },

	VehicleDeleters = {
		Pos   = { x = 274.313, y = -331.102, z = 43.92 },
		Size  = { x = 3.0, y = 3.0, z = 0.2 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 1,
	},

	Helicopters = {
		Pos          = {x = -141.402, y = -584.951, z = 210.775},
		SpawnPoint   = {x = -144.419, y = -592.718, z = 210.775},
		Size         = { x = 1.8, y = 1.8, z = 1.0 },
		Color        = { r = 255, g = 255, b = 0 },
		Type         = 1,
		Heading      = 291.4347,
	},

	HelicopterDeleters = {
		Pos   = {x = -144.419, y = -592.718, z = 210.775},
		Size  = { x = 3.0, y = 3.0, z = 0.2 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 1,
	},

	BossActions = {
		Pos   = {x = 237.9, y = -416.962, z = -119.2},
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 0, g = 100, b = 0 },
		Type  = 1,
	},
}


Config.TeleportZones = {
  EnterHeliport = {
    Pos       = {x = 246.107, y = -411.359, z = 46.924},
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 255, g = 255, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Entrer",
    Type      = "teleport",
    Hint      = "Appuie sur ~INPUT_PICKUP~ pour monter au Heliport.",
    Teleport  = {x = -138.667, y = -585.821, z = 210.775},
  },

  ExitHeliport = {
    Pos       = {x = -136.211, y = -596.204, z = 205.916},
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Sortir",
    Type      = "teleport",
    Hint      = "Appuie sur ~INPUT_PICKUP~ pour partir du Heliport.",
    Teleport  = {x = 230.936, y = -397.367, z = 46.924},
  },
  
   EnterGouv = {
     Pos       = {x = 233.065, y = -411.082, z = 47.112},
     Size      = { x = 2.0, y = 2.0, z = 0.2 },
     Color     = { r = 255, g = 255, b = 0 },
     Marker    = 1,
     Blip      = false,
     Name      = "Entrer",
     Type      = "teleport",
     Hint      = "Paina ~INPUT_PICKUP~ mennäksesi sisään.",
     Teleport  = {x = 235.635, y = -413.073, z = -119.163},
   },

   ExitGouv = {
     Pos       = {x = 224.977, y = -419.397, z = -119.2},
     Size      = { x = 2.0, y = 2.0, z = 0.2 },
     Color     = { r = 204, g = 204, b = 0 },
     Marker    = 1,
     Blip      = false,
     Name      = "Sortir",
     Type      = "teleport",
     Hint      = "Paina ~INPUT_PICKUP~ mennäksesi ulos.",
     Teleport  = {x = 237.976, y = -412.891, z = 47.112},
   },
}

Config.Uniforms = {
	emploie_outfit = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	}

}
