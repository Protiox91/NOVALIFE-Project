-- VARIABLES --

ESX = nil
--
local personalmenu = {}
local invItem = {}
local billItem = {}
local hasCinematic = false
local engine = true
local showcoord = false
local PlayerData = {}
local ped = GetPlayerPed(-1)
local vehicle = GetVehiclePedIsIn(ped, false)
local sp = 3.6
local isDead = false
local inAnim = false
local playergroup = nil
local societymoney, societymoney2 = nil, nil

-- NativeUI call --

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu(" ", "Menu personnel")
itemMenu = NativeUI.CreateMenu(" ", "Inventaire")
_menuPool:Add(mainMenu)
_menuPool:Add(itemMenu)
_menuPool:ControlDisablingEnabled(false)

local voix = {
    "Crier", 
    "Parler",
    "Chuchoter"
}

local HUD = {
    "Ouvrir",
    "Fermer",
    "Cinématique"
}

local CV = {
    " N°1",
    " N°2",
    " N°3"
}

-- Functions ESX --

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end


	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end
	

	ESX.PlayerData = ESX.GetPlayerData()

	while actualSkin == nil do
		TriggerEvent('skinchanger:getSkin', function(skin) actualSkin = skin end)
		Citizen.Wait(10)
	end

	while playergroup == nil do
		if ESX ~= nil then
			ESX.TriggerServerCallback('Brook:getUsergroup', function(group) playergroup = group end)
			Citizen.Wait(10)
		else
			Citizen.Wait(10)
		end
	end

	RefreshMoney()
	RefreshMoney2()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
	_menuPool:CloseAllMenus()
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshMoney()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	RefreshMoney2()
end)

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSocietyMoney(money)
		end, ESX.PlayerData.job.name)
	end
end

function RefreshMoney2()
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSociety2Money(money)
		end, ESX.PlayerData.job2.name)
	end
end

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		UpdateSocietyMoney(money)
	end
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		UpdateSociety2Money(money)
	end
end)

function UpdateSocietyMoney(money)
	societymoney = ESX.Math.GroupDigits(money)
end

function UpdateSociety2Money(money)
	societymoney2 = ESX.Math.GroupDigits(money)
end

-- FUNCTIONS DE BASE -- 

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
	end)
end

function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function advancednotify(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    SetNotificationMessage(icon, icon, true, type, sender, title, text);
    DrawNotification(false, true);
end

function notify(text) 
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function animsActionScenario(animObj)
	if (IsInVehicle()) then
		local source = GetPlayerServerId();
		ESX.ShowNotification("Sortez de votre véhicule pour faire cela !")
	else
		Citizen.CreateThread(function()
			if not playAnim then
				local playerPed = GetPlayerPed(-1);
				if DoesEntityExist(playerPed) then
					dataAnim = animObj
					TaskStartScenarioInPlace(playerPed, dataAnim.anim, 0, false)
					playAnimation = true
				end
			end
		end)
	end
end

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function hasID (cb)
    if (ESX == nil) then return cb(0) end
    ESX.TriggerServerCallback('Brook:getItemAmount', function(qtty)
      cb(qtty > 0)
    end, 'idtt')
end

function hasBAG (cb)
    if (ESX == nil) then return cb(0) end
    ESX.TriggerServerCallback('Brook:getItemAmount', function(qtty)
      cb(qtty > 0)
    end, 'bag')
end

function hasPPA (cb)
    if (ESX == nil) then return cb(0) end
    ESX.TriggerServerCallback('Brook:getItemAmount', function(qtty)
      cb(qtty > 0)
    end, 'ppa')
end

function hasPC (cb)
    if (ESX == nil) then return cb(0) end
    ESX.TriggerServerCallback('Brook:getItemAmount', function(qtty)
      cb(qtty > 0)
    end, 'pcond')
end

function hasMEN (cb)
    if (ESX == nil) then return cb(0) end
    ESX.TriggerServerCallback('Brook:getItemAmount', function(qtty)
      cb(qtty > 0)
    end, 'men')
end

function hasRC (cb)
    if (ESX == nil) then return cb(0) end
    ESX.TriggerServerCallback('Brook:getItemAmount', function(qtty)
      cb(qtty > 0)
    end, 'rc')
end

function voice(v)
    if v == "Parler"  then
        advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu parle ! (10 M)")
        NetworkSetTalkerProximity(10.0)
        TriggerEvent('esx_customui:voice', "normal")
    elseif v == "Chuchoter" then
        advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu chuchote ! (2 M)")
        NetworkSetTalkerProximity(2.0)
        TriggerEvent('esx_customui:voice', "whisper")
    elseif v == "Crier" then
        advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu crie ! (26 M)")
        NetworkSetTalkerProximity(26.0)
        TriggerEvent('esx_customui:voice', "shout")
    end
end

function Text(text)
    SetTextColour(186, 186, 186, 255)
    SetTextFont(0)
    SetTextScale(0.378, 0.378)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 205)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.017, 0.977)
end

function admin_godmode()
    godmode = not godmode
    local ped = GetPlayerPed(-1)
    
    if godmode then -- activé
        SetEntityInvincible(ped, true)
        notify("Mode invincible ~g~activé")
    else
        SetEntityInvincible(ped, false)
        notify("Mode invincible ~r~désactivé")
    end
end

function admin_vehicle_repair()
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsUsing(ped)
	SetVehicleFixed(car)
	SetVehicleDirtLevel(car, 0.0)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == 'ears' then
				elseif _accessory == "glasses" then
					mAccessory = 0
					startAnim("clothingspecs", "try_glasses_positive_a")
					Citizen.Wait(1000)
					ClearPedTasks(plyPed)
				elseif _accessory == 'helmet' then
					startAnim("missfbi4", "takeoff_mask")
					Citizen.Wait(1000)
					ClearPedTasks(plyPed)
				elseif _accessory == "mask" then
					mAccessory = 0
					startAnim("missfbi4", "takeoff_mask")
					Citizen.Wait(850)
					ClearPedTasks(plyPed)
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			if _accessory == 'ears' then
				ESX.ShowNotification("Vous ne possédez pas d'Accessoire d'Oreilles")
			elseif _accessory == 'glasses' then
				ESX.ShowNotification("Vous ne possédez pas de Lunettes")
			elseif _accessory == 'helmet' then
				ESX.ShowNotification("Vous ne possédez pas de Casque/Chapeau")
			elseif _accessory == 'mask' then
				ESX.ShowNotification("Vous ne possédez pas de Masque")
			end
		end

	end, accessory)
end

-- MENUS --

function init()
	MenuPrincipal(mainMenu)
end

function MenuPrincipal(menu)
	local click12 = NativeUI.CreateListItem("Niveau de Voix :", voix, 1)

	-- ORDRE DES MENUS --
	
    meconcernant(menu)
    portefeuille(menu)
	AnimationMenu(menu)
	travail(menu)
	vetements(menu)
    config(menu)
    menu:AddItem(click12)

    -- ON CLICK --
    menu.OnListChange = function(sender, item, index)
        if item == click12 then
            local mode = item:IndexToItem(index)
            voice(mode)
        end
    end
    -- REFRESH --
    _menuPool:RefreshIndex()
end

function meconcernant(menu)
    meconcernantmenu = _menuPool:AddSubMenu(menu, "Me Concernant")
    AddMenuInventoryMenu(meconcernantmenu)
    MenuFactures(meconcernantmenu)
end

function travail(menu)
	travailmenu = _menuPool:AddSubMenu(menu, "Travail")
	local job = NativeUI.CreateItem("Menu Travail", "Menu Travail")
	travailmenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == job then 
			if ESX.PlayerData.job.name == 'police' then
                --mainMenu:Visible(not mainMenu:Visible())  
                Wait(75)   
                TriggerEvent("Brook:menupolice")
            elseif ESX.PlayerData.job.name == 'mechanic' then
                --mainMenu:Visible(not mainMenu:Visible())
                Wait(75)      
                TriggerEvent('Brook:menumecano')
            elseif ESX.PlayerData.job.job.name == 'taxi' then
                --mainMenu:Visible(not mainMenu:Visible())
                Wait(75)        
                TriggerEvent("Brook:menutaxi")
            elseif ESX.PlayerData.job.job.name == 'ambulance' then
                --mainMenu:Visible(not mainMenu:Visible()) 
                Wait(75)   
                TriggerEvent("Brook:menuamb")
            elseif ESX.PlayerData.job.job.name == 'brinks' then
                --mainMenu:Visible(not mainMenu:Visible()) 
                Wait(75)   
                TriggerEvent('Brook:brinksmenu')
            elseif ESX.PlayerData.job.name == 'charbon' or ESX.PlayerData.job.name == 'fisherman' or ESX.PlayerData.job.name == 'fueler' or ESX.PlayerData.job.name == 'garbage' or ESX.PlayerData.job.name == 'lumberjack' or ESX.PlayerData.job.name == 'miner' or ESX.PlayerData.job.name == 'poolcleaner' or ESX.PlayerData.job.name == 'salvage' or ESX.PlayerData.job.name == 'slaughterer' or ESX.PlayerData.job.name == 'tailor' or ESX.PlayerData.job.name == 'tailor' then
                advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "~r~Tu n'est qu'un intérimaire !")
            end
		end
	end
	travailmenu.SubMenu:AddItem(job)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		AddMenuBossMenu(travailmenu)
	end
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		AddMenuBossMenu2(travailmenu)
	end
	
end

function portefeuille(menu)
	portefeuillemenu = _menuPool:AddSubMenu(menu, "Portefeuiille")
	local ident = NetworkGetNetworkIdFromEntity(ped)
	local ID = NativeUI.CreateItem("Mon ID : "..ident.."", " ")
	portefeuillemenu.SubMenu:AddItem(ID)
end

function AddMenuInventoryMenu(menu)
	inventorymenu = _menuPool:AddSubMenu(menu.SubMenu, "Inventaire")
	local invCount = {}

	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].count > 0 then
			local label	    = ESX.PlayerData.inventory[i].label
			local count	    = ESX.PlayerData.inventory[i].count
			local value	    = ESX.PlayerData.inventory[i].name
			local usable	= ESX.PlayerData.inventory[i].usable
			local rare	    = ESX.PlayerData.inventory[i].rare
			local canRemove = ESX.PlayerData.inventory[i].canRemove

			invCount = {}
			local okCount = 0

			for i = 1, count, 1 do
				okCount = okCount + 1
				table.insert(invCount, okCount)
			end
			
			table.insert(invItem, value)

			invItem[value] = NativeUI.CreateListItem(label .. " (" .. count .. ")", invCount, 1)
			inventorymenu.SubMenu:AddItem(invItem[value])
		end
	end

	local useItem = NativeUI.CreateItem("Utiliser", "")
	itemMenu:AddItem(useItem)

	local giveItem = NativeUI.CreateItem("Donner", "")
	itemMenu:AddItem(giveItem)

	local dropItem = NativeUI.CreateItem("Jeter", "")
	dropItem:SetRightBadge(4)
	itemMenu:AddItem(dropItem)

	inventorymenu.SubMenu.OnListSelect = function(sender, item, index)
		_menuPool:CloseAllMenus(true)
		itemMenu:Visible(true)

		for i = 1, #ESX.PlayerData.inventory, 1 do
			local label	    = ESX.PlayerData.inventory[i].label
			local count	    = ESX.PlayerData.inventory[i].count
			local value	    = ESX.PlayerData.inventory[i].name
			local usable	= ESX.PlayerData.inventory[i].usable
			local rare	    = ESX.PlayerData.inventory[i].rare
			local canRemove = ESX.PlayerData.inventory[i].canRemove
			local quantity  = index

			if item == invItem[value] then
				itemMenu.OnItemSelect = function(sender, item, index)
					if item == useItem then
						if usable then
							TriggerServerEvent('esx:useItem', value)
						else
							ESX.ShowNotification(label .. " n'est pas utilisable")
						end
					elseif item == giveItem then
						local foundPlayers = false
						personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

						if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
			 				foundPlayers = true
						end

						if foundPlayers == true then
							local closestPed = GetPlayerPed(personalmenu.closestPlayer)

							if not IsPedSittingInAnyVehicle(closestPed) then
								if quantity ~= nil and count > 0 then
									TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(personalmenu.closestPlayer), 'item_standard', value, quantity)
									_menuPool:CloseAllMenus()
								else
									ESX.ShowNotification("Montant Invalide")
								end
							else
								ESX.ShowNotification("Impossible de donner " .. label .. " dans un véhicule")
							end
						else
							ESX.ShowNotification("Aucun citoyen à proximité")
						end
					elseif item == dropItem then
						if canRemove then
							if not IsPedSittingInAnyVehicle(closestPed) then
								if quantity ~= nil then
									TriggerServerEvent('esx:removeInventoryItem', 'item_standard', value, quantity)
									_menuPool:CloseAllMenus()
								else
									ESX.ShowNotification("Montant Invalide")
								end
							else
								ESX.ShowNotification("Impossible de jeter de l'argent dans un véhicule")
							end
						else
							ESX.ShowNotification(label .. " n'est pas jetable")
						end
					end
				end
			end
		end
	end
end

function config(menu)
    confMenu = _menuPool:AddSubMenu(menu, "Configuration")
    local c12 = NativeUI.CreateListItem("Mode HUD :", HUD, 1)
	local c13 = NativeUI.CreateListItem("Compteur de vitesse :", CV, 1)
	local c14 = NativeUI.CreateItem("REPORT", "REPORT UN JOUEUR")
    confMenu.SubMenu.OnListChange = function(sender, item, index)
        if item == c12 then
            local huds = item:IndexToItem(index)
            if huds == "Fermer" then
                advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "~r~Le HUD est fermé !")
                exports.esx_customui:toggle(false)
                --exports.BrookAPI:close()  
                DisplayRadar(false)
                SendNUIMessage({openCinema = false})
            elseif huds == "Ouvrir" then
                advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "~g~Le HUD est ouvert !")
                exports.esx_customui:toggle(true)  
                --exports.BrookAPI:open() 
                DisplayRadar(true)  
                SendNUIMessage({openCinema = false})
            elseif huds == "Cinématique" then
                hasCinematic = not hasCinematic
			    if hasCinematic == true then
				    SendNUIMessage({openCinema = true})
				    exports.esx_customui:toggle(false)
                    DisplayRadar(false)
			    else
				    SendNUIMessage({openCinema = false})
                    exports.esx_customui:toggle(true)  
                    DisplayRadar(true)
                end
            end
        elseif item == c13 then
            local cvs = item:IndexToItem(index)
            if cvs == " N°1" then
                exports.speedometer:changeSkin('default')
            elseif cvs == " N°2" then
                exports.speedometer:changeSkin('id6')
            elseif cvs == " N°3" then
                exports.speedometer:changeSkin('id7')
            end
        end
	end
	
	confMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == c14 then
			TriggerEvent('Brook:Display')
			confMenu.SubMenu:Visible(false)
		end
	end
    confMenu.SubMenu:AddItem(c12)
	confMenu.SubMenu:AddItem(c13)
	confMenu.SubMenu:AddItem(c14)
end

function MenuFactures(menu)
	billMenu = _menuPool:AddSubMenu(menu.SubMenu, "Factures")
	billItem = {}
	
	ESX.TriggerServerCallback('Brook:Facture', function(bills)
		for i = 1, #bills, 1 do
			local label = bills[i].label
			local amount = bills[i].amount
			local value = bills[i].id

			table.insert(billItem, value)

			billItem[value] = NativeUI.CreateItem(label, "")
			billItem[value]:RightLabel("$" .. ESX.Math.GroupDigits(amount))
			billMenu.SubMenu:AddItem(billItem[value])
		end

		billMenu.SubMenu.OnItemSelect = function(sender, item, index)
			for i = 1, #bills, 1 do
				local label  = bills[i].label
				local value = bills[i].id

				if item == billItem[value] then
					ESX.TriggerServerCallback('esx_billing:payBill', function()
						_menuPool:CloseAllMenus()
					end, value)
				end
			end
		end
	end)
end

function vetements(menu)
    vetMenu = _menuPool:AddSubMenu(menu, "Vêtements")
    local v1 = NativeUI.CreateItem("Enlever le haut","")
    local v2 =NativeUI.CreateItem("Enlever le bas","")
    local v3 = NativeUI.CreateItem("Enlever chaussures","")
    local v4 = NativeUI.CreateItem("Remettre vetements","")
    vetMenu.SubMenu.OnItemSelect = function(sender, item, index)
        if item == v1 then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local clothesSkin = { ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['torso_1'] = 15, ['torso_2'] = 0, ['arms'] = 15, ['arms_2'] = 0 }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end)
        elseif item == v2 then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local clothesSkin = { ['pants_1'] = 21, ['pants_2'] = 0 }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end)
        elseif item == v3 then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local clothesSkin = {['shoes_1'] = 34, ['shoes_2'] = 0 }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end)
        elseif item == v4 then
            TriggerEvent('skinchanger:getSkin', function(skin)
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                end)
            end)
        end
    end
    vetMenu.SubMenu:AddItem(v1)
    vetMenu.SubMenu:AddItem(v2)
    vetMenu.SubMenu:AddItem(v3)
    vetMenu.SubMenu:AddItem(v4)
    AccessMenu(vetMenu)
end

function AccessMenu(menu)
	accessoryMenu = _menuPool:AddSubMenu(menu.SubMenu, "Accessoires")

	local earsItem = NativeUI.CreateItem("Accessoire d'Oreilles", "")
	accessoryMenu.SubMenu:AddItem(earsItem)
	local glassesItem = NativeUI.CreateItem("Lunettes", "")
	accessoryMenu.SubMenu:AddItem(glassesItem)
	local helmetItem = NativeUI.CreateItem("Chapeau/Casque", "")
	accessoryMenu.SubMenu:AddItem(helmetItem)
	local maskItem = NativeUI.CreateItem("Masque", "")
	accessoryMenu.SubMenu:AddItem(maskItem)

	accessoryMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == earsItem then
			SetUnsetAccessory('Ears')
		elseif item == glassesItem then
			SetUnsetAccessory('Glasses')
		elseif item == helmetItem then
			SetUnsetAccessory('Helmet')
		elseif item == maskItem then
			SetUnsetAccessory('Mask')
		end
	end
end

function AnimationMenu(menu)
	animMenu = _menuPool:AddSubMenu(menu, "Animations")

	AddSubMenuFestivesMenu(animMenu)
	AddSubMenuSalutationsMenu(animMenu)
	AddSubMenuTravailMenu(animMenu)
	AddSubMenuHumeursMenu(animMenu)
	AddSubMenuSportsMenu(animMenu)
	AddSubMenuDiversMenu(animMenu)
	AddSubMenuPEGI21Menu(animMenu)
end

function AddSubMenuFestivesMenu(menu)
	animFeteMenu = _menuPool:AddSubMenu(menu.SubMenu, "Festives")

	local cigaretteItem = NativeUI.CreateItem("Fumer une cigarette", "")
	animFeteMenu.SubMenu:AddItem(cigaretteItem)
	local musiqueItem = NativeUI.CreateItem("Jouer de la musique", "")
	animFeteMenu.SubMenu:AddItem(musiqueItem)
	local DJItem = NativeUI.CreateItem("DJ", "")
	animFeteMenu.SubMenu:AddItem(DJItem)
	local zikItem = NativeUI.CreateItem("Bière en zik", "")
	animFeteMenu.SubMenu:AddItem(zikItem)
	local guitarItem = NativeUI.CreateItem("Air Guitar", "")
	animFeteMenu.SubMenu:AddItem(guitarItem)
	local shaggingItem = NativeUI.CreateItem("Air Shagging", "")
	animFeteMenu.SubMenu:AddItem(shaggingItem)
	local rockItem = NativeUI.CreateItem("Rock'n'roll", "")
	animFeteMenu.SubMenu:AddItem(rockItem)
	local bourreItem = NativeUI.CreateItem("Bourré sur place", "")
	animFeteMenu.SubMenu:AddItem(bourreItem)
	local vomirItem = NativeUI.CreateItem("Vomir en voiture", "")
	animFeteMenu.SubMenu:AddItem(vomirItem)

	animFeteMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == cigaretteItem then
			startScenario("WORLD_HUMAN_SMOKING")
		elseif item == musiqueItem then
			startScenario("WORLD_HUMAN_MUSICIAN")
		elseif item == DJItem then
			startAnim("anim@mp_player_intcelebrationmale@dj", "dj")
		elseif item == zikItem then
			startScenario("WORLD_HUMAN_PARTYING")
		elseif item == guitarItem then
			startAnim("anim@mp_player_intcelebrationmale@air_guitar", "air_guitar")
		elseif item == shaggingItem then
			startAnim("anim@mp_player_intcelebrationfemale@air_shagging", "air_shagging")
		elseif item == rockItem then
			startAnim("mp_player_int_upperrock", "mp_player_int_rock")
		elseif item == bourreItem then
			startAnim("amb@world_human_bum_standing@drunk@idle_a", "idle_a")
		elseif item == vomirItem then
			startAnim("oddjobs@taxi@tie", "vomit_outside")
		end
	end
end

function AddSubMenuSalutationsMenu(menu)
	animSaluteMenu = _menuPool:AddSubMenu(menu.SubMenu, "Salutations")

	local saluerItem = NativeUI.CreateItem("Saluer", "")
	animSaluteMenu.SubMenu:AddItem(saluerItem)
	local serrerItem = NativeUI.CreateItem("Serrer la main", "")
	animSaluteMenu.SubMenu:AddItem(serrerItem)
	local tchekItem = NativeUI.CreateItem("Tchek", "")
	animSaluteMenu.SubMenu:AddItem(tchekItem)
	local banditItem = NativeUI.CreateItem("Salut bandit", "")
	animSaluteMenu.SubMenu:AddItem(banditItem)
	local militaireItem = NativeUI.CreateItem("Salut Militaire", "")
	animSaluteMenu.SubMenu:AddItem(militaireItem)

	animSaluteMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == saluerItem then
			startAnim("gestures@m@standing@casual", "gesture_hello")
		elseif item == serrerItem then
			startAnim("mp_common", "givetake1_a")
		elseif item == tchekItem then
			startAnim("mp_ped_interaction", "handshake_guy_a")
		elseif item == banditItem then
			startAnim("mp_ped_interaction", "hugs_guy_a")
		elseif item == militaireItem then
			startAnim("mp_player_int_uppersalute", "mp_player_int_salute")
		end
	end
end

function AddSubMenuTravailMenu(menu)
	animTravailMenu = _menuPool:AddSubMenu(menu.SubMenu, "Travail")

	local suspectItem = NativeUI.CreateItem("Se rendre", "")
	animTravailMenu.SubMenu:AddItem(suspectItem)
	local pecheurItem = NativeUI.CreateItem("Pêcheur", "")
	animTravailMenu.SubMenu:AddItem(pecheurItem)
	local pEnqueterItem = NativeUI.CreateItem("Police : enquêter", "")
	animTravailMenu.SubMenu:AddItem(pEnqueterItem)
	local pRadioItem = NativeUI.CreateItem("Police : parler à la radio", "")
	animTravailMenu.SubMenu:AddItem(pRadioItem)
	local pCirculationItem = NativeUI.CreateItem("Police : circulation", "")
	animTravailMenu.SubMenu:AddItem(pCirculationItem)
	local pJumelleItem = NativeUI.CreateItem("Police : jumelles", "")
	animTravailMenu.SubMenu:AddItem(pJumelleItem)
	local aRecolterItem = NativeUI.CreateItem("Agriculture : récolter", "")
	animTravailMenu.SubMenu:AddItem(aRecolterItem)
	local dReparerItem = NativeUI.CreateItem("Dépanneur : réparer le moteur", "")
	animTravailMenu.SubMenu:AddItem(dReparerItem)
	local mObserverItem = NativeUI.CreateItem("Médecin : observer", "")
	animTravailMenu.SubMenu:AddItem(mObserverItem)
	local tParlerItem = NativeUI.CreateItem("Taxi : parler au client", "")
	animTravailMenu.SubMenu:AddItem(tParlerItem)
	local tFacturerItem = NativeUI.CreateItem("Taxi : donner la facture", "")
	animTravailMenu.SubMenu:AddItem(tFacturerItem)
	local eCoursesItem = NativeUI.CreateItem("Epicier : donner les courses", "")
	animTravailMenu.SubMenu:AddItem(eCoursesItem)
	local bShotItem = NativeUI.CreateItem("Barman : servir un shot", "")
	animTravailMenu.SubMenu:AddItem(bShotItem)
	local jPhotoItem = NativeUI.CreateItem("Journaliste : Prendre une photo", "")
	animTravailMenu.SubMenu:AddItem(jPhotoItem)
	local NotesItem = NativeUI.CreateItem("Tout : Prendre des notes", "")
	animTravailMenu.SubMenu:AddItem(NotesItem)
	local MarteauItem = NativeUI.CreateItem("Tout : Coup de marteau", "")
	animTravailMenu.SubMenu:AddItem(MarteauItem)
	local sdfMancheItem = NativeUI.CreateItem("SDF : Faire la manche", "")
	animTravailMenu.SubMenu:AddItem(sdfMancheItem)
	local sdfStatueItem = NativeUI.CreateItem("SDF : Faire la statue", "")
	animTravailMenu.SubMenu:AddItem(sdfStatueItem)

	animTravailMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == suspectItem then
			startAnim("random@arrests@busted", "idle_c")
		elseif item == pecheurItem then
			startScenario("world_human_stand_fishing")
		elseif item == pEnqueterItem then
			startAnim("amb@code_human_police_investigate@idle_b", "idle_f")
		elseif item == pRadioItem then
			startAnim("random@arrests", "generic_radio_chatter")
		elseif item == pCirculationItem then
			startScenario("WORLD_HUMAN_CAR_PARK_ATTENDANT")
		elseif item == pJumelleItem then
			startScenario("WORLD_HUMAN_BINOCULARS")
		elseif item == aRecolterItem then
			startScenario("world_human_gardener_plant")
		elseif item == dReparerItem then
			startAnim("mini@repair", "fixing_a_ped")
		elseif item == mObserverItem then
			startScenario("CODE_HUMAN_MEDIC_KNEEL")
		elseif item == tParlerItem then
			startAnim("oddjobs@taxi@driver", "leanover_idle")
		elseif item == tFacturerItem then
			startAnim("oddjobs@taxi@cyi", "std_hand_off_ps_passenger")
		elseif item == eCoursesItem then
			startAnim("mp_am_hold_up", "purchase_beerbox_shopkeeper")
		elseif item == bShotItem then
			startAnim("mini@drinking", "shots_barman_b")
		elseif item == jPhotoItem then
			startScenario("WORLD_HUMAN_PAPARAZZI")
		elseif item == NotesItem then
			startScenario("WORLD_HUMAN_CLIPBOARD")
		elseif item == MarteauItem then
			startScenario("WORLD_HUMAN_HAMMERING")
		elseif item == sdfMancheItem then
			startScenario("WORLD_HUMAN_BUM_FREEWAY")
		elseif item == sdfStatueItem then
			startScenario("WORLD_HUMAN_HUMAN_STATUE")
		end
	end
end

function AddSubMenuHumeursMenu(menu)
	animHumeurMenu = _menuPool:AddSubMenu(menu.SubMenu, "Humeurs")

	local feliciterItem = NativeUI.CreateItem("Féliciter", "")
	animHumeurMenu.SubMenu:AddItem(feliciterItem)
	local superItem = NativeUI.CreateItem("Super", "")
	animHumeurMenu.SubMenu:AddItem(superItem)
	local toiItem = NativeUI.CreateItem("Toi", "")
	animHumeurMenu.SubMenu:AddItem(toiItem)
	local viensItem = NativeUI.CreateItem("Viens", "")
	animHumeurMenu.SubMenu:AddItem(viensItem)
	local keskyaItem = NativeUI.CreateItem("Keskya ?", "")
	animHumeurMenu.SubMenu:AddItem(keskyaItem)
	local moiItem = NativeUI.CreateItem("A moi", "")
	animHumeurMenu.SubMenu:AddItem(moiItem)
	local putainItem = NativeUI.CreateItem("Je le savais, putain", "")
	animHumeurMenu.SubMenu:AddItem(putainItem)
	local epuiserItem = NativeUI.CreateItem("Etre épuisé", "")
	animHumeurMenu.SubMenu:AddItem(epuiserItem)
	local merdeItem = NativeUI.CreateItem("Je suis dans la merde", "")
	animHumeurMenu.SubMenu:AddItem(merdeItem)
	local facepalmItem = NativeUI.CreateItem("Facepalm", "")
	animHumeurMenu.SubMenu:AddItem(facepalmItem)
	local calmeItem = NativeUI.CreateItem("Calme-toi ", "")
	animHumeurMenu.SubMenu:AddItem(calmeItem)
	local jaifaitItem = NativeUI.CreateItem("Qu'est ce que j'ai fait ?", "")
	animHumeurMenu.SubMenu:AddItem(jaifaitItem)
	local peurItem = NativeUI.CreateItem("Avoir peur", "")
	animHumeurMenu.SubMenu:AddItem(peurItem)
	local fightItem = NativeUI.CreateItem("Fight ?", "")
	animHumeurMenu.SubMenu:AddItem(fightItem)
	local paspossibleItem = NativeUI.CreateItem("C'est pas Possible !", "")
	animHumeurMenu.SubMenu:AddItem(paspossibleItem)
	local enlacerItem = NativeUI.CreateItem("Enlacer", "")
	animHumeurMenu.SubMenu:AddItem(enlacerItem)
	local doigtItem = NativeUI.CreateItem("Doigt d'honneur", "")
	animHumeurMenu.SubMenu:AddItem(doigtItem)
	local branleurItem = NativeUI.CreateItem("Branleur", "")
	animHumeurMenu.SubMenu:AddItem(branleurItem)
	local balleItem = NativeUI.CreateItem("Balle dans la tete", "")
	animHumeurMenu.SubMenu:AddItem(balleItem)

	animHumeurMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == feliciterItem then
			startScenario("WORLD_HUMAN_CHEERING")
		elseif item == superItem then
			startAnim("mp_action", "thanks_male_06")
		elseif item == toiItem then
			startAnim("gestures@m@standing@casual", "gesture_point")
		elseif item == viensItem then
			startAnim("gestures@m@standing@casual", "gesture_come_here_soft")
		elseif item == keskyaItem then
			startAnim("gestures@m@standing@casual", "gesture_bring_it_on")
		elseif item == moiItem then
			startAnim("gestures@m@standing@casual", "gesture_me")
		elseif item == putainItem then
			startAnim("anim@am_hold_up@male", "shoplift_high")
		elseif item == epuiserItem then
			startAnim("amb@world_human_jog_standing@male@idle_b", "idle_d")
		elseif item == merdeItem then
			startAnim("amb@world_human_bum_standing@depressed@idle_a", "idle_a")
		elseif item == facepalmItem then
			startAnim("anim@mp_player_intcelebrationmale@face_palm", "face_palm")
		elseif item == calmeItem then
			startAnim("gestures@m@standing@casual", "gesture_easy_now")
		elseif item == jaifaitItem then
			startAnim("oddjobs@assassinate@multi@", "react_big_variations_a")
		elseif item == peurItem then
			startAnim("amb@code_human_cower_stand@male@react_cowering", "base_right")
		elseif item == fightItem then
			startAnim("anim@deathmatch_intros@unarmed", "intro_male_unarmed_e")
		elseif item == paspossibleItem then
			startAnim("gestures@m@standing@casual", "gesture_damn")
		elseif item == enlacerItem then
			startAnim("mp_ped_interaction", "kisses_guy_a")
		elseif item == doigtItem then
			startAnim("mp_player_int_upperfinger", "mp_player_int_finger_01_enter")
		elseif item == branleurItem then
			startAnim("mp_player_int_upperwank", "mp_player_int_wank_01")
		elseif item == balleItem then
			startAnim("mp_suicide", "pistol")
		end
	end
end

function AddSubMenuSportsMenu(menu)
	animSportMenu = _menuPool:AddSubMenu(menu.SubMenu, "Sports")

	local muscleItem = NativeUI.CreateItem("Montrer ses muscles", "")
	animSportMenu.SubMenu:AddItem(muscleItem)
	local muscuItem = NativeUI.CreateItem("Barre de musculation", "")
	animSportMenu.SubMenu:AddItem(muscuItem)
	local pompeItem = NativeUI.CreateItem("Faire des pompes", "")
	animSportMenu.SubMenu:AddItem(pompeItem)
	local abdoItem = NativeUI.CreateItem("Faire des abdos", "")
	animSportMenu.SubMenu:AddItem(abdoItem)
	local yogaItem = NativeUI.CreateItem("Faire du yoga", "")
	animSportMenu.SubMenu:AddItem(yogaItem)

	animSportMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == muscleItem then
			startAnim("amb@world_human_muscle_flex@arms_at_side@base", "base")
		elseif item == muscuItem then
			startAnim("amb@world_human_muscle_free_weights@male@barbell@base", "base")
		elseif item == pompeItem then
			startAnim("amb@world_human_push_ups@male@base", "base")
		elseif item == abdoItem then
			startAnim("amb@world_human_sit_ups@male@base", "base")
		elseif item == yogaItem then
			startAnim("amb@world_human_yoga@male@base", "base_a")
		end
	end
end

function AddSubMenuDiversMenu(menu)
	animDiversMenu = _menuPool:AddSubMenu(menu.SubMenu, "Divers")

	local zikItem = NativeUI.CreateItem("Bière en Zik", "")
	animDiversMenu.SubMenu:AddItem(zikItem)
	local asseoirItem = NativeUI.CreateItem("S'asseoir", "")
	animDiversMenu.SubMenu:AddItem(asseoirItem)
	local murItem = NativeUI.CreateItem("Attendre contre un mur", "")
	animDiversMenu.SubMenu:AddItem(murItem)
	local dosItem = NativeUI.CreateItem("Couché sur le dos", "")
	animDiversMenu.SubMenu:AddItem(dosItem)
	local ventreItem = NativeUI.CreateItem("Couché sur le ventre", "")
	animDiversMenu.SubMenu:AddItem(ventreItem)
	local nettoyerItem = NativeUI.CreateItem("Nettoyer quelque chose", "")
	animDiversMenu.SubMenu:AddItem(nettoyerItem)
	local mangerItem = NativeUI.CreateItem("Préparer à manger", "")
	animDiversMenu.SubMenu:AddItem(mangerItem)
	local fouilleItem = NativeUI.CreateItem("Position de Fouille", "")
	animDiversMenu.SubMenu:AddItem(fouilleItem)
	local selfieItem = NativeUI.CreateItem("Prendre un selfie", "")
	animDiversMenu.SubMenu:AddItem(selfieItem)
	local porteItem = NativeUI.CreateItem("Ecouter à une porte", "")
	animDiversMenu.SubMenu:AddItem(porteItem)

	animDiversMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == zikItem then
			startScenario("WORLD_HUMAN_DRINKING")
		elseif item == asseoirItem then
			startAnim("anim@heists@prison_heistunfinished_biztarget_idle", "target_idle")
		elseif item == murItem then
			startScenario("world_human_leaning")
		elseif item == dosItem then
			startScenario("WORLD_HUMAN_SUNBATHE_BACK")
		elseif item == ventreItem then
			startScenario("WORLD_HUMAN_SUNBATHE")
		elseif item == nettoyerItem then
			startScenario("world_human_maid_clean")
		elseif item == mangerItem then
			startScenario("PROP_HUMAN_BBQ")
		elseif item == fouilleItem then
			startAnim("mini@prostitutes@sexlow_veh", "low_car_bj_to_prop_female")
		elseif item == selfieItem then
			startScenario("world_human_tourist_mobile")
		elseif item == porteItem then
			startAnim("mini@safe_cracking", "idle_base")
		end
	end
end

function AddSubMenuPEGI21Menu(menu)
	animPegiMenu = _menuPool:AddSubMenu(menu.SubMenu, "PEGI 21")

	local hSuceItem = NativeUI.CreateItem("Homme se faire su* en voiture", "")
	animPegiMenu.SubMenu:AddItem(hSuceItem)
	local fSuceItem = NativeUI.CreateItem("Femme faire une gaterie en voiture", "")
	animPegiMenu.SubMenu:AddItem(fSuceItem)
	local hBaiserItem = NativeUI.CreateItem("Homme bais en voiture", "")
	animPegiMenu.SubMenu:AddItem(hBaiserItem)
	local fBaiserItem = NativeUI.CreateItem("Femme bais** en voiture", "")
	animPegiMenu.SubMenu:AddItem(fBaiserItem)
	local gratterItem = NativeUI.CreateItem("Se gratter les couilles", "")
	animPegiMenu.SubMenu:AddItem(gratterItem)
	local charmeItem = NativeUI.CreateItem("Faire du charme", "")
	animPegiMenu.SubMenu:AddItem(charmeItem)
	local michtoItem = NativeUI.CreateItem("Pose michto", "")
	animPegiMenu.SubMenu:AddItem(michtoItem)
	local poitrineItem = NativeUI.CreateItem("Montrer sa poitrine", "")
	animPegiMenu.SubMenu:AddItem(poitrineItem)
	local strip1Item = NativeUI.CreateItem("Strip Tease 1", "")
	animPegiMenu.SubMenu:AddItem(strip1Item)
	local strip2Item = NativeUI.CreateItem("Strip Tease 2", "")
	animPegiMenu.SubMenu:AddItem(strip2Item)
	local stripsolItem = NativeUI.CreateItem("Stip Tease au sol", "")
	animPegiMenu.SubMenu:AddItem(stripsolItem)

	animPegiMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == hSuceItem then
			startAnim("oddjobs@towing", "m_blow_job_loop")
		elseif item == fSuceItem then
			startAnim("oddjobs@towing", "f_blow_job_loop")
		elseif item == hBaiserItem then
			startAnim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_player")
		elseif item == fBaiserItem then
			startAnim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_female")
		elseif item == gratterItem then
			startAnim("mp_player_int_uppergrab_crotch", "mp_player_int_grab_crotch")
		elseif item == charmeItem then
			startAnim("mini@strip_club@idles@stripper", "stripper_idle_02")
		elseif item == michtoItem then
			startScenario("WORLD_HUMAN_PROSTITUTE_HIGH_CLASS")
		elseif item == poitrineItem then
			startAnim("mini@strip_club@backroom@", "stripper_b_backroom_idle_b")
		elseif item == strip1Item then
			startAnim("mini@strip_club@lap_dance@ld_girl_a_song_a_p1", "ld_girl_a_song_a_p1_f")
		elseif item == strip2Item then
			startAnim("mini@strip_club@private_dance@part2", "priv_dance_p2")
		elseif item == stripsolItem then
			startAnim("mini@strip_club@private_dance@part3", "priv_dance_p3")
		end
	end
end

function AddMenuBossMenu(menu)
	bossMenu = _menuPool:AddSubMenu(menu.SubMenu, "Gestion Entreprise: " .. ESX.PlayerData.job.label)

	if societymoney ~= nil then
		coffreItem = NativeUI.CreateItem("Coffre Entreprise:", "")
		coffreItem:RightLabel("$"..societymoney)
		bossMenu.SubMenu:AddItem(coffreItem)
	end

	local recruterItem = NativeUI.CreateItem("Recruter", "")
	bossMenu.SubMenu:AddItem(recruterItem)
	local virerItem = NativeUI.CreateItem("Virer", "")
	bossMenu.SubMenu:AddItem(virerItem)
	local promouvoirItem = NativeUI.CreateItem("Promouvoir", "")
	bossMenu.SubMenu:AddItem(promouvoirItem)
	local destituerItem = NativeUI.CreateItem("Destituer", "")
	bossMenu.SubMenu:AddItem(destituerItem)

	bossMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == recruterItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur à proximité")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_recruterplayer', GetPlayerServerId(personalmenu.closestPlayer), ESX.PlayerData.job.name, 0)
				end
			else
				ESX.ShowNotification("Vous n'avez pas les ~r~droits~w~.")
			end
		elseif item == virerItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur à proximité")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_virerplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification("Vous n'avez pas les ~r~droits~w~.")
			end
		elseif item == promouvoirItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur à proximité")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_promouvoirplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification("Vous n'avez pas les ~r~droits~w~.")
			end
		elseif item == destituerItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur à proximité")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_destituerplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification("Vous n'avez pas les ~r~droits~w~.")
			end
		end
	end
end

function AddMenuBossMenu2(menu)
	bossMenu2 = _menuPool:AddSubMenu(menu.SubMenu, "Gestion Organisation: " .. ESX.PlayerData.job2.label)

	if societymoney2 ~= nil then
		coffre2Item = NativeUI.CreateItem("Coffre Organisation:", "")
		coffre2Item:RightLabel("$"..societymoney2)
		bossMenu2.SubMenu:AddItem(coffre2Item)
	end

	local recruter2Item = NativeUI.CreateItem("Recruter", "")
	bossMenu2.SubMenu:AddItem(recruter2Item)
	local virer2Item = NativeUI.CreateItem("Virer", "")
	bossMenu2.SubMenu:AddItem(virer2Item)
	local promouvoir2Item = NativeUI.CreateItem("Promouvoir", "")
	bossMenu2.SubMenu:AddItem(promouvoir2Item)
	local destituer2Item = NativeUI.CreateItem("Destituer", "")
	bossMenu2.SubMenu:AddItem(destituer2Item)

	bossMenu2.SubMenu.OnItemSelect = function(sender, item, index)
		if item == recruter2Item then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur à proximité")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_recruterplayer2', GetPlayerServerId(personalmenu.closestPlayer), ESX.PlayerData.job2.name, 0)
				end
			else
				ESX.ShowNotification("Vous n'avez pas les ~r~droits~w~.")
			end
		elseif item == virer2Item then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur à proximité")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_virerplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification("Vous n'avez pas les ~r~droits~w~.")
			end
		elseif item == promouvoir2Item then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur à proximité")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_promouvoirplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification("Vous n'avez pas les ~r~droits~w~.")
			end
		elseif item == destituer2Item then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("Aucun joueur à proximité")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_destituerplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification("Vous n'avez pas les ~r~droits~w~.")
			end
		end
	end
end

MenuPrincipal(mainMenu)

-- THREADS

Citizen.CreateThread(function()
	while true do
		_menuPool:ProcessMenus()
		
		plyPed = PlayerPedId()
		plyVehicle = GetVehiclePedIsIn(plyPed, false)

		if IsControlJustReleased(0, 289) and not isDead then
			init()
			ESX.PlayerData = ESX.GetPlayerData()
			mainMenu:Visible(true)
		end

		if showcoord then
			local playerPos = GetEntityCoords(plyPed)
			local playerHeading = GetEntityHeading(plyPed)
			Text("~r~X~s~: " .. playerPos.x .. " ~b~Y~s~: " .. playerPos.y .. " ~g~Z~s~: " .. playerPos.z .. " ~y~Angle~s~: " .. playerHeading)
		end

		if noclip then
			local x, y, z = getPosition()
			local dx, dy, dz = getCamDirection()
			local speed = Config.noclip_speed

			SetEntityVelocity(plyPed, 0.0001, 0.0001, 0.0001)

			if IsControlPressed(0, 32) then
				x = x + speed * dx
				y = y + speed * dy
				z = z + speed * dz
			end

			if IsControlPressed(0, 269) then
				x = x - speed * dx
				y = y - speed * dy
				z = z - speed * dz
			end

			SetEntityCoordsNoOffset(plyPed, x, y, z, true, true, true)
		end

		if showname then
			for id = 0, 255 do
				if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= plyPed then
					local ped = GetPlayerPed(id)
					local headId = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, (GetPlayerServerId(id) .. ' - ' .. GetPlayerName(id)), false, false, "", false)
				end
			end
		end
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		while _menuPool:IsAnyMenuOpen() do
			Citizen.Wait(5)
			if not _menuPool:IsAnyMenuOpen() then
				mainMenu:Clear()
				itemMenu:Clear()
				--weaponItemMenu:Clear()

				_menuPool:Clear()
				_menuPool:Remove()

				personalmenu = {}

				invItem = {}
				--wepItem = {}
				billItem = {}
			end
		end
		Citizen.Wait(10)
	end
end)