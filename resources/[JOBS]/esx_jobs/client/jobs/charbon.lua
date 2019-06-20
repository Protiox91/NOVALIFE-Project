Config.Jobs.charbon = {
	BlipInfos = {
		Sprite = 366,
		Color = 4
	},
	Vehicles = {
		Truck = {
			Spawner = 1,
			Hash = "rumpo3",
			Trailer = "none",
			HasCaution = false
		}
	},
	Zones = {

		CloakRoom = {
			Pos = {x = 903.559, y = -3199.361, z = -96.187},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U("dd_dress_locker"),
			Type = "cloakroom",
			Hint = _U("cloak_change"),
			GPS = {x = 740.80, y = -970.06, z = 23.46}
		},

		Weed = {
			Pos = {x = 894.1181, y = -3174.189, z = -96.12},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U("dd_wool"),
			Type = "work",
			Item = {
				{
					name = 'Lieux de travail',
					db_name = "weed_pooch",
					time = 6000,
					max = 40,
					add = 1,
					remove = 1,
					requires = "weed",
					requires_name = "Weed",
					drop = 100
				}
			},
			Hint = 'Lieux de travail',
			GPS = {x = 715.95, y = -959.63, z = 29.39}
		},

		VehicleSpawner = {
			Pos = {x = 740.80, y = -970.06, z = 23.46},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("spawn_veh"),
			Type = "vehspawner",
			Spawner = 1,
			Hint = _U("spawn_veh_button"),
			Caution = 2000,
			GPS = {x = 1978.92, y = 5171.70, z = 46.63}
		},

		VehicleSpawnPoint = {
			Pos = {x = 747.31, y = -966.23, z = 23.70},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 1,
			Heading = 270.1,
			GPS = 0
		},

		VehicleDeletePoint = {
			Pos = {x = 693.79, y = -963.01, z = 22.82},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U("return_vh"),
			Type = "vehdelete",
			Hint = _U("return_vh_button"),
			Spawner = 1,
			Caution = 2000,
			GPS = 0,
			Teleport = 0
		},

		Delivery = {
			Pos = {x = 429.59, y = -807.34, z = 28.49},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Marker = 1,
			Blip = false,
			Name = 'Point de Livraison',
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = 'Point de Livraison',
					time = 750,
					remove = 1,
					max = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 140,
					requires = "weed_pooch",
					requires_name = 'Sachet de weed',
					drop = 100
				}
			},
			Hint = 'Point de Livraison',
			GPS = {x = 1978.92, y = 5171.70, z = 46.63}
		}
	}
}
