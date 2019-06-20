--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 10



-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
	bread = 50,
	water = 100,
	WEAPON_COMBATPISTOL = 1, -- poid poir une munnition
	WEAPON_STUNGUN = 1, -- poid poir une munnition
	WEAPON_MICROSMG = 1, -- poid poir une munnition
	WEAPON_PUMPSHOTGUN = 1, -- poid poir une munnition
	WEAPON_ASSAULTRIFLE = 1, -- poid poir une munnition
	WEAPON_SPECIALCARBINE = 1, -- poid poir une munnition
	WEAPON_SNIPERRIFLE = 1, -- poid poir une munnition
	WEAPON_APPISTOL = 1, -- poid poir une munnition
	WEAPON_PISTOL = 1, -- poid poir une munnition
	WEAPON_ASSAULTSMG = 1, -- poid poir une munnition
	WEAPON_ASSAULTSHOTGUN = 1, -- poid poir une munnition
	WEAPON_FLAREGUN = 1, -- poid poir une munnition
	black_money = 1, -- poids pour un argent
}

Config.VehicleLimit = {
    [0] = 15500, --Compact
    [1] = 16500, --Sedan
    [2] = 17500, --SUV
    [3] = 14500, --Coupes
    [4] = 16500, --Muscle
    [5] = 11500, --Sports Classics
    [6] = 8500, --Sports
    [7] = 8500, --Super
    [8] = 5500, --Motorcycles
    [9] = 17500, --Off-road
    [10] = 19000, --Industrial
    [11] = 17000, --Utility
    [12] = 17000, --Vans
    [13] = 0, --Cycles
    [14] = 50000, --Boats
    [15] = 50000, --Helicopters
    [16] = 50000, --Planes
    [17] = 220000, --Service
    [18] = 220000, --Emergency
    [19] = 220000, --Military
    [20] = 19000, --Commercial
    [21] = 0, --Trains
}