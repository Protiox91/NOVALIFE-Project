Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 255, g = 255, b = 255 }
--language currently available EN and SV
Config.Locale = 'fr'
--this is how much the price shows from the purchase price
-- exapmle the cardealer boughts it for 2000 if 2 then it says 4000

Config.Price = 1 -- this is times how much it should show

Config.Blips = {

	Blip = {	
		Pos     = { x = -50.03, y = -1089.18, z = 25.48},
		Sprite  = 225,
		Display = 4,
		Scale   = 0.6,
		Colour  = 4,
	}
}

Config.Zones = {

  ShopInside = {
    Pos     = { x = -148.701, y = -596.286, z = 167.000 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 177.28,
    Type    = -1,
  },

  Katalog = {
    Pos     = { x = -142.952 , y = -599.909, z = 166.100 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 177.28,
    Type    = 27,
  },

  GoDownFrom = {
    Pos   = { x = -50.03, y = -1089.18, z = 25.48 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 27,
  },

  GoUpFrom = {
    Pos   = { x = -146.449, y = -603.625, z = 166.100 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 27,
  },

}