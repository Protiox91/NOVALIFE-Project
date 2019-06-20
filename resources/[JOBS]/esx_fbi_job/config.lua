Config = {}

Config.DrawDistance 			  = 100.0
Config.MarkerType    			  = 1
Config.MarkerSize   			  = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 255, g = 255, b = 255 }
Config.MarkerDeletersColor        = { r = 255, g = 0, b = 0 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false -- enable if you're using esx_identity
Config.EnableSocietyOwnedVehicles = true
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = false -- enable blips for colleagues, requires esx_society
Config.EnablePoliceFine           = true -- enable fine, requires esx_policejob

Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.FBIStations = {

	FBI = {

		Blip = {
			Pos     = { x = 112.105, y = -749.363, z = 45.751 },
			Sprite  = 88,
			Display = 4,
			Scale   = 0.8,
			Colour  = 63,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 200 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 300 },
			{ name = 'WEAPON_ASSAULTSMG',       price = 1250 },
			{ name = 'WEAPON_ASSAULTRIFLE',     price = 1500 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 600 },
			{ name = 'WEAPON_STUNGUN',          price = 500 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 80 },
			{ name = 'WEAPON_FIREEXTINGUISHER', price = 120 },
			{ name = 'WEAPON_FLAREGUN',         price = 60 },
			{ name = 'WEAPON_STICKYBOMB',       price = 250 },
			{ name = 'GADGET_PARACHUTE',        price = 300 },
		},

		Cloakrooms = {
			{ x = 152.046, y = -736.179, z = 241.151 },
		},

		Armories = {
			{ x = 143.654, y = -764.390, z = 241.152 },
		},

		Vehicles = {
			{
				Spawner    = { x = 95.547, y = -723.756, z = 32.133 },
				SpawnPoints = {
					{ x = 100.145, y = -729.447, z = 32.779, heading = 340.8, radius = 6.0 },
					{ x = 104.046, y = -730.836, z = 32.779, heading = 340.8, radius = 6.0 },
					{ x = 107.748, y = -732.138, z = 32.780, heading = 339.2, radius = 6.0 }
				}
			},
		},

		VehicleDeleters = {
			{ x = 96.359, y = -728.160, z = 32.133 },
			{ x = 93.267, y = -720.182, z = 32.133 }
		},

		BossActions = {
			{ x = 148.941, y = -758.541, z = 241.151 }
		},

		Elevator = {
			{
				Top = { x = 136.093, y = -761.823, z = 241.152 },
				Down = { x = 136.093, y = -761.809, z = 44.752 },
				Parking = { x = 65.447, y = -749.675, z = 30.634 }
			}
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'fbi',
			label = 'Voiture FBI'
		},
		{
			model = 'fbi2',
			label = 'SUV FBI'
		}
	},

	agent = {

	},

	special = {

	},

	supervisor = {

	},

	assistant = {

	},

	boss = {

	}
}

-- Look in skinchanger/client/main.lua for more elements.
Config.Uniforms = {

	agent_wear = {
		male = {
			['tshirt_1'] = 130,
			['tshirt_2'] = 0,
			['torso_1'] = 111,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 33,
			['arms_2'] = 0,
			['pants_1'] = 24,
			['pants_2'] = 0,
			['shoes_1'] = 40,
			['shoes_2'] = 9,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 128,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 160,
			['tshirt_2'] = 0,
			['torso_1'] = 136,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 36,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 98,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	special_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 61,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 31,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 128,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 54,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 34,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 98,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	supervisor_wear = {
		male = {
			['tshirt_1'] = 10,
			['tshirt_2'] = 2,
			['torso_1'] = 28,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 33,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 12,
			['chain_2'] = 2,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 38,
			['tshirt_2'] = 2,
			['torso_1'] = 58,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 34,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 22,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	assistant_wear = {
		male = {
			['tshirt_1'] = 31,
			['tshirt_2'] = 0,
			['torso_1'] = 32,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 4,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 28,
			['chain_2'] = 2,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 38,
			['tshirt_2'] = 0,
			['torso_1'] = 7,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 3,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 0,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 21,
			['chain_2'] = 2,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 31,
			['tshirt_2'] = 0,
			['torso_1'] = 31,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 4,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 18,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 38,
			['tshirt_2'] = 0,
			['torso_1'] = 7,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 3,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 0,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 87,
			['chain_2'] = 4,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	}

}