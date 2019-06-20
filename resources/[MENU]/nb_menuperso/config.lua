local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
Config								= {}

--------------------------------------------------------------------------------------------
-- Config
--------------------------------------------------------------------------------------------
-- GENERAL
Config.general = {
	manettes = true,
}
-- GPS RAPIDE
Config.poleemploi = {
	x = -259.08557128906,
	y = -974.677734375,
	z = 31.220008850098,
}
Config.comico = {
	x = 430.91763305664,
	y = -980.24694824218,
	z = 31.710563659668,
}
Config.hopital = {
	x = 307.760,
	y = -1433.470,
	z = 28.970,
}
Config.concessionnaire1 = {
	x = -44.385055541992,
	y = -1109.7479248047,
	z = 26.437595367432,
}
Config.concessionnaire2 = {
	x = -714.357421875,
	y = -1297.3057861328,
	z = 4.1019196510315,
}
Config.concessionnaire3 = {
	x = -940.06,
	y = -2963.15,
	z = 18.85,
}
Config.mecano = {
	x = -208.263,
	y = -1335.572,
	z = 33.894,
}
Config.vanilla = {
	x = 129.246,
	y = -1299.363,
	z = 29.501,
}
Config.bank = {
	x = 260.130,
	y = 204.308,
	z = 109.287,
}
Config.shop = {
	x = -3036.246,
	y = 590.363,
	z = 7.501,
}
Config.garage = {
	x = -361.495,
	y = -132.474,
	z = 37.700,
}
Config.dock = {
	x = -735.87,
	y = -1325.08,
	z = 0.6,
}
Config.aircraft = {
	x = -1268.455,
	y = -3374.492,
	z = 12.950,
}
Config.state = {
	x = -199.151,
	y = -575.000,
	z = 39.489,
}
Config.weed = {
	x = -1172.355,
	y = -1571.750,
	z = 3.660,
}

-- Ouvrir le menu perso
Config.menuperso = {
	clavier = Keys["F2"],
	manette1 = Keys["F2"],
	manette2 = Keys["TOP"],
}
-- Ouvrir le menu job
Config.menujob = {
	clavier = Keys["F6"],
	manette1 = Keys["F1"],
	manette2 = Keys["DOWN"],
}
-- TP sur le Marker
Config.TPMarker = {
	clavier1 = Keys["LEFTSHIFT"],
	clavier2 = Keys["E"],
	manette1 = Keys["LEFTSHIFT"],
	manette2 = Keys["E"],
}
-- Lever les mains
Config.handsUP = {
	clavier = Keys["X"],
	manette1 = Keys["RIGHT"],
	manette2 = Keys["F2"],
}
-- Pointer du doight
Config.pointing = {
	clavier = Keys["B"],
	manette = Keys["B"],
}
-- S'acroupir
Config.crouch = {
	clavier = Keys["LEFTCTRL"],
	manette = Keys["LEFTCTRL"],
}