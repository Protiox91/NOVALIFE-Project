--[[ 

--------------------------------------TEMPLATE

	zoneXFromOutToIn = {
		x = obviously X,
		y = obviously Y,
		z = obviously Z,
		w = obviously WIDTH,
		h = obviously HEIGHT,		
		visible = true,
		t = obviously TYPE,
		color = {
			r = obviously RED,
			g = obviously GREEN,
			b = obviously BLUE
		}
	},

If you don't want the marker to be visible, you're not obliged to
type more data after it:

	zoneXFromOutToIn = {
		x = obviously X,
		y = obviously Y,
		z = obviously Z,
		w = obviously WIDTH,
		h = obviously HEIGHT,		
		visible = false
	},

--------------------------------------TYPES OF MARKER

Upside Down Cone = 0,
Vertical Cylinder = 1,
Thick Chevron Up = 2,
Thin Chevron Up = 3,
Checkered Flag Rect = 4,
Checkered Flag Circle = 5,
Verticle Circle = 6,
Plane Model = 7,
Lost MC Dark = 8,
Lost MC Light = 9,
Number 0 = 10,
Number 1 = 11,
Number 2 = 12,
Number 3 = 13,
Number 4 = 14,
Number 5 = 15,
Number 6 = 16,
Number 7 = 17,
Number 8 = 18,
Number 9 = 19,
Chevron Up x 1 = 20,
Chevron Up x 2 = 21,
Chevron Up x 3 = 22,
Horizontal Circle Fat = 23,
Replay Icon = 24,
Horizontal Circle Skinny = 25,
Horizontal Circle Skinny Arrow = 26,
Horizontal Split Arrow Circle = 27,
Debug Sphere = 28,
Dollar Sign = 29,
Horizontal Bars = 30,
Wolf Head = 31

]]

Config = {}

-- C key by default
Config.actionKey = 38

-- markers AKA Teleporters
Config.zones = {
	
	--WeedEnter = {
		--x = 2221.858,
		--y = 5614.81,
		--z = 54.902,
		--w = 2.0,
		--h = 1.0,
		--visible = true,
		--t = 29,
		--color = {
		--	r = 0,
		--	g = 102,
		--	b = 0
		--}
		
	--},

	BunkEnter = {
		x = 1571.7811,
		y = 2242.494,
		z = 79.061,
		w = 1.0,
		h = 1.0,
		visible = true,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0
		}
		
	},
	
	BunkExit = {
		x = 880.560,
		y = -3249.213,
		z = -98.292,
		w = 1.0,
		h = 1.0,
		visible = true,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0
		}
		
	},

	--CasierEnter = {
	--	x = 402.800,
	--	y = -996.27,
	--	z = -99.002,
	--	w = 2.0,
	--	h = 1.0,
	--	visible = true,
	--	t = 29,
	--	color = {
	--		r = 0,
	--		g = 102,
	--		b = 0
	--	}
		
	--},

	--CasierExit = {
	--	x = 2221.858,
	--	y = 5614.81,
	--	z = 54.902,
	--	w = 2.0,
	--	h = 1.0,
	--	visible = true,
	--	t = 29,
	--	color = {
	--		r = 0,
	--		g = 102,
	---		b = 0
	--	}
	--	
	--},
	
	MoneyWashEnter = {
		x = 1639.516,
		y = 4879.4,
		z = 42.141,
		w = 2.0,
		h = 1.0,
		visible = true,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0
		}
		
	},
	
	MoneyWashExit = {
		x = 1138.146,
		y = -3199.096,
		z = -39.666,
		w = 2.0,
		h = 1.0,
		visible = true,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0
		}
		
	},

	--MethEnter = {
	--	x = 1386.659,
	--	y = 3622.805,
	--	z = 35.012,
	--	w = 2.0,
	--	h = 1.0,		
	--	visible = true,
	--	t = 1,
	--	color = {
	--		r = 102,
	--		g = 0,
	--		b = 0
	--	}
	--},
	
	--MethExit = {
	--	x = 1012.136,
	----	y = -3202.527,
	--	z = -38.993,
	--	w = 2.0,
	--	h = 1.0,		
	--	visible = true,
	--	t = 1,
	--	color = {
	--		r = 102,
	--		g = 0,
	--		b = 0
	--	}
	--},

	CokeEnter = {
		x = 47.842,
		y = 3701.961,
		z = 40.722,
		w = 2.0,
		h = 1.0,		
		visible = true,
		t = 1,
		color = {
			r = 102,
			g = 0,
			b = 0
		}
	},
	
	--CokeExit = {
	--	x = 1103.613,
	--	y = -3196.25,
	--	z = -38.993,
	--	w = 2.0,
	--	h = 1.0,		
	----	visible = true,
	--	t = 1,
	--	color = {
	--		r = 102,
	--		g = 0,
	--		b = 0
	--	}
	--},
}

-- Landing point, keep the same name as markers
Config.point = {

	--WeedEnter = {
		----x = 1066.009,
		--y = -3183.386,
		--z = -39.164
	--},
	
	BunkExit = {
		x = 1571.7811,
		y = 2242.494,
		z = 79.061
	},

	BunkEnter = {
		x = 880.560,
		y = -3249.213,
		z = -98.292
	},


	--MethEnter = {
	--	x = 998.629,
	--	y = -3199.545,
	--	z = -36.394
	--},
	
	--MethExit = {
	--	x = 1395.33,
	--	y = 3623.705,  
	--	z = 35.012
	--},

	--CokeEnter = {
	--	x = 1088.636,
	--	y = -3188.551, 
	--	z = -38.993
	--},
	
	--CokeExit = {
	--	x = 41.412,
	--	y = 3705.19, 
	--	z = 40.719
	--},
	
	MoneyWashEnter = {
		x = 1118.405,
		y = -3193.687,
		z = -40.394
	},
	
	MoneyWashExit = {
		x = 1639.008,
		y = 4870.545,
		z = 42.03
	}
}


-- Automatic teleport list (no need to puseh E key in the marker)
Config.auto = {

}
