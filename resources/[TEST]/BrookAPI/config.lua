TrafficAmount = 20
PedestrianAmount = 20
ParkedAmount = 20
EnableDispatch = false


--[[
	TrafficAmount changes how much traffic there is on the Roads, this goes from 100% to 0%, values over 100% are also supported but not recommended, under 0% will cause a game crash.
	PedestrianAmount changes how many Peds roam the Streets
	ParkedAmount changes how many Parked Cars there are in the world
	EnableDispatch is a toggle between true and false, this enables/disables various features such as:
		- Police Responses
		- Fire Department Responses
		- Swat Responses
		- Ambulance Responses
		- Roadblocks
		- Gangs
]]

Config = {}

-- Amount of Time to Blackout, in milliseconds
-- 2000 = 2 seconds
Config.BlackoutTime = 7500

-- Enable blacking out due to vehicle damage
-- If a vehicle suffers an impact greater than the specified value, the player blacks out
Config.BlackoutFromDamage = true
Config.BlackoutDamageRequired = 25

-- Enable blacking out due to speed deceleration
-- If a vehicle slows down rapidly over this threshold, the player blacks out
Config.BlackoutFromSpeed = true
Config.BlackoutSpeedRequired = 50 -- Speed in MPH

-- Enable the disabling of controls if the player is blacked out
Config.DisableControlsOnBlackout = true

Config = {
    Camera = true,
    LoseConnectionDistance = 100.0
}