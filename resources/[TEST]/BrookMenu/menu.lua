--local job = xPlayer.job.label 
--local jobg = xPlayer.job.grade_label
--local money = xPlayer.account.money
--local bank = 
--local sale = 
local hasCinematic = false
local engine = true
local showcoord = false
local PlayerData = {}
local ped = GetPlayerPed(-1)
local vehicle = GetVehiclePedIsIn(ped, false)
local sp = 3.6
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("NovaLife", "~b~NOVALIFE RP")
confMenu = NativeUI.CreateMenu("Configuration", "~b~NOVALIFE RP")
credMenu = NativeUI.CreateMenu("Crédits", "~b~NOVALIFE RP")
animMenu = NativeUI.CreateMenu("Animations", "~b~NOVALIFE RP")
rpMenu = NativeUI.CreateMenu("Roleplay", "~b~NOVALIFE RP")
vehMenu = NativeUI.CreateMenu("Véhicule", "~b~NOVALIFE RP")
demMenu = NativeUI.CreateMenu("Démarches", "~b~NOVALIFE RP")
arMenu = NativeUI.CreateMenu("Arrestation", "~b~NOVALIFE RP")
vetMenu = NativeUI.CreateMenu("Vétements", "~b~NOVALIFE RP")
intMenu = NativeUI.CreateMenu("Intéractions", "~b~NOVALIFE RP")
divMenu = NativeUI.CreateMenu("Divers", "~b~NOVALIFE RP")
modMenu = NativeUI.CreateMenu("Modération", "~b~NOVALIFE RP")
Brookmenu = NativeUI.CreateMenu("Vendeur illégal", "~b~NOVALIFE RP")
Limitmenu = NativeUI.CreateMenu("Limitateur de Vitesse", "~b~NOVALIFE RP")
_menuPool:Add(mainMenu)
_menuPool:Add(confMenu)
_menuPool:Add(credMenu)
_menuPool:Add(animMenu)
_menuPool:Add(rpMenu)
_menuPool:Add(vehMenu)
_menuPool:Add(demMenu)
_menuPool:Add(arMenu)
_menuPool:Add(vetMenu)
_menuPool:Add(intMenu)
_menuPool:Add(divMenu)
_menuPool:Add(modMenu)
_menuPool:Add(Brookmenu)
_menuPool:Add(Limitmenu)

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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

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

function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function startAttitude(lib, anim)
    Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
        RequestAnimSet(anim)
         
        while not HasAnimSetLoaded(anim) do
            Citizen.Wait(1)
        end
		SetPedMotionBlur(playerPed, false)
        SetPedMovementClipset(playerPed, anim, true)
    end)
end

function animsAction(animObj)
	--if (IsInVehicle()) then
	--	local source = GetPlayerServerId();
	--	ESX.ShowNotification("Sortez de votre vÃ©hicule pour faire cela !")
	--else
		Citizen.CreateThread(function()
			if not playAnim then
				local playerPed = GetPlayerPed(-1);
				if DoesEntityExist(playerPed) then -- Ckeck if ped exist
					dataAnim = animObj

					-- Play Animation
					RequestAnimDict(dataAnim.lib)
					while not HasAnimDictLoaded(dataAnim.lib) do
						Citizen.Wait(0)
					end
					if HasAnimDictLoaded(dataAnim.lib) then
						local flag = 0
						if dataAnim.loop ~= nil and dataAnim.loop then
							flag = 1
						elseif dataAnim.move ~= nil and dataAnim.move then
							flag = 49
						end

						TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
						playAnimation = true
					end
					-- Wait end annimation
					while true do
						Citizen.Wait(0)
						if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
							playAnim = false
							TriggerEvent('ft_animation:ClFinish')
							break
						end
					end
				end -- end ped exist
			end
		end)
	--end
end


function MenuPrincipal(menu)
    local click1 = NativeUI.CreateItem("Me concernant", "Toutes vos infos RP") 
    local click2 = NativeUI.CreateItem("Configuration", "Configurer votre jeu") 
    local click3 = NativeUI.CreateItem("Crédits serveur", "Qui sont les créateurs de ce serveur ?") 
    local click4 = NativeUI.CreateItem("Véhicule", "Véhicule")
    local click5 = NativeUI.CreateItem("Animations", "Menu Animations")
    local click6 = NativeUI.CreateItem("Modération", "Menu Modération")
    local click7 = NativeUI.CreateItem("Gestion Entrerpise", "Gestion Entrerpise")
    local click8 = NativeUI.CreateItem("Vétements", "Vétements")
    local click9 = NativeUI.CreateItem("Actions", "Menu Actions")
    local click10 = NativeUI.CreateItem("Mon Travail", "Menu Travail")
    menu.OnItemSelect = function(sender, item, index)
        if item == click1 then
            rpMenu:Visible(not rpMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == click2 then
            confMenu:Visible(not confMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == click3 then
            credMenu:Visible(not credMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == click4 then
            vehMenu:Visible(not vehMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == click5 then
            animMenu:Visible(not animMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == click8 then
            vetMenu:Visible(not vetMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == click9 then
            intMenu:Visible(not intMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == click10 then
            if PlayerData.job and PlayerData.job.name == 'police' then
                mainMenu:Visible(not mainMenu:Visible())  
                Wait(75)   
                TriggerEvent("Brook:menupolice")
            elseif PlayerData.job and PlayerData.job.name == 'mechanic' then
                mainMenu:Visible(not mainMenu:Visible())
                Wait(75)      
                TriggerEvent('Brook:menumecano')
            elseif PlayerData.job and PlayerData.job.name == 'taxi' then
                mainMenu:Visible(not mainMenu:Visible())
                Wait(75)        
                TriggerEvent("Brook:menutaxi")
            elseif PlayerData.job and PlayerData.job.name == 'ambulance' then
                mainMenu:Visible(not mainMenu:Visible()) 
                Wait(75)   
                TriggerEvent("Brook:menuamb")
            elseif PlayerData.job and PlayerData.job.name == 'brinks' then
                mainMenu:Visible(not mainMenu:Visible()) 
                Wait(75)   
                TriggerEvent("Brook:menubrinks")
            elseif PlayerData.job and PlayerData.job.name == 'charbon' or PlayerData.job.name == 'fisherman' or PlayerData.job.name == 'fueler' or PlayerData.job.name == 'garbage' or PlayerData.job.name == 'lumberjack' or PlayerData.job.name == 'miner' or PlayerData.job.name == 'poolcleaner' or PlayerData.job.name == 'salvage' or PlayerData.job.name == 'slaughterer' or PlayerData.job.name == 'tailor' or PlayerData.job.name == 'tailor' then
                advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "~r~Tu n'est qu'un intérimaire !")
            end
        end
    end
    menu:AddItem(click1)
    menu:AddItem(click10)
    menu:AddItem(click5)
    menu:AddItem(click8)
    menu:AddItem(click9)
    --menu:AddItem(click4)
    menu:AddItem(click2)
    menu:AddItem(click3)
end

function configmenu(menu)
    local c1 = NativeUI.CreateItem("--- HUD ---", "Configurer votre HUD") 
    local c2 = NativeUI.CreateItem("Ouvrir", "Ouvrir votre HUD") 
    local c3 = NativeUI.CreateItem("Fermer", "Fermer votre HUD") 
    local c4 = NativeUI.CreateItem("--- Compteur de Vitesse ---", "Configurer votre compteur")
    local c5 = NativeUI.CreateItem("N°1 (+ jauge essence)", "Changer de compteur") 
    local c6 = NativeUI.CreateItem("N°2", "Changer de compteur") 
    local c7 = NativeUI.CreateItem("N°3", "Changer de compteur")  
    local c8 = NativeUI.CreateItem("RETOUR","Retourner au menu principal")
    local c9 = NativeUI.CreateItem("Mode Cinématique", "Mettre Mode Cinématique") 
    menu.OnItemSelect = function(sender, item, index)
        if item == c2 then
            advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "~g~Le HUD est ouvert !")
            exports.esx_customui:toggle(true)  
            --exports.BrookAPI:open() 
            DisplayRadar(true)         
        elseif item == c3 then
            advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "~r~Le HUD est fermé !")
            exports.esx_customui:toggle(false)
            --exports.BrookAPI:close()  
            DisplayRadar(false)
        elseif item == c5 then
            exports.speedometer:changeSkin('default')
        elseif item == c6 then
            exports.speedometer:changeSkin('id6')
        elseif item == c7 then
            exports.speedometer:changeSkin('id7')
        elseif item == c8 then
            confMenu:Visible(not confMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == c9 then
            hasCinematic = not hasCinematic
			if hasCinematic == true then
				SendNUIMessage({openCinema = true})
				exports.esx_customui:toggle(false)
                DisplayRadar(false)
                confMenu:Visible(not confMenu:Visible())
			else
				SendNUIMessage({openCinema = false})
                exports.esx_customui:toggle(true)  
				DisplayRadar(true)
            end
        end
    end
    menu:AddItem(c1)
    menu:AddItem(c2)
    menu:AddItem(c3)
    menu:AddItem(c9)
    menu:AddItem(c4)
    menu:AddItem(c5)
    menu:AddItem(c6)
    menu:AddItem(c7)
    menu:AddItem(c8)
end

function credit(menu)
    local cl1 = NativeUI.CreateItem("Developpeur : Jack Brook", "Développeur") 
    local cl2 = NativeUI.CreateItem("Admin(s) : Xame | Eliott.", "Admins") 
    local cl3 = NativeUI.CreateItem("Modo(s) : Flav | Hamid | Salva", "Modérateurs")
    local cl4 = NativeUI.CreateItem("RETOUR")
    menu.OnItemSelect = function(sender, item, index)
        if item == cl1 then
            notify("~r~Développeur : ~n~Jack Brook")
            advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "Merci de jouer sur ~p~~h~NovaLife ~p~~h~RP !")   
        elseif item == cl2 then
            notify("~b~Admin(s) : ~n~Xame ~n~Eliott.")
            advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "Merci de jouer sur ~p~~h~NovaLife ~p~~h~RP !")
        elseif item == cl3 then
            notify("~b~Modérateur(s) : ~n~Flav ~n~Fabien Salva")
            advancednotify("CHAR_LIFEINVADER", 1, "NovaLife RP", false, "Merci de jouer sur ~p~~h~NovaLife ~p~~h~RP !")
        elseif item == cl3 then
            credMenu:Visible(not credMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        end
    end
    menu:AddItem(cl1)
    menu:AddItem(cl2)
    menu:AddItem(cl3) 
    menu:AddItem(cl4) 
end

function rpinfo(menu)
    --local job = xPlayer.job.label 
    --local jobg = xPlayer.job.grade_label
    --local cla2 = NativeUI.CreateItem("Votre métier : "..job.."-"..jobg.." ","Votre job")
    local cla5 = NativeUI.CreateItem("RETOUR","Retourner au menu principal")
    local cla6 = NativeUI.CreateItem("Montrer sa carte d'identité","Montrer sa carte d'identité")
    local cla7 = NativeUI.CreateItem("Voir sa carte d'identité","Voir sa carte d'identité")
    local cla8 = NativeUI.CreateItem("Montrer son permis","Montrer son permis")
    local cla9 = NativeUI.CreateItem("Voir son permis","Voir son permis")
    local cla10 = NativeUI.CreateItem("Mes Factures","Mes Factures")
    local cla11 = NativeUI.CreateItem("Mes Poches","Ouvre votre invenatire")
    local cla12 = NativeUI.CreateItem("Mon Sac","Ouvre le menu du Sac")
    
    menu.OnItemSelect = function(sender, item, index)
        if item == cla5 then
            rpMenu:Visible(not rpMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == cla6 then
            hasID(function (hasID)
                if hasID == true then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                    end
                else 
                    advancednotify("CHAR_LIFEINVADER", 1, "Mairie", false, "Vous n'avez pas de carte d'identitée !")
                end
            end)
        elseif item == cla7 then
            hasID(function (hasID)
                if hasID == true then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                else
                    advancednotify("CHAR_LIFEINVADER", 1, "Mairie", false, "Vous n'avez pas de carte d'identitée !")
                end
            end)
        elseif item == cla8 then
            hasPC(function (hasPC)
                if hasPC == true then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                    end
                else
                    advancednotify("CHAR_LIFEINVADER", 1, "Mairie", false, "Vous n'avez pas de permis !")
                end
            end)
        elseif item == cla9 then
            hasPC(function (hasPC)
                if hasPC == true then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                else
                    advancednotify("CHAR_LIFEINVADER", 1, "Mairie", false, "Vous n'avez pas de permis !")
                end
            end)
        elseif item == cla10 then
            rpMenu:Visible(not rpMenu:Visible())
            TriggerEvent('Brook:openMenuFactures')
        elseif item == cla11 then
            rpMenu:Visible(not rpMenu:Visible())
            TriggerEvent('Brook:inv')
        elseif item == cla12 then
            rpMenu:Visible(not rpMenu:Visible())  
            Wait(750)  
            TriggerEvent('Brook:sac')
        end
    end
    menu:AddItem(cla11) 
    menu:AddItem(cla10) 
    menu:AddItem(cla12) 
    menu:AddItem(cla6) 
    menu:AddItem(cla7)
    menu:AddItem(cla8)
    menu:AddItem(cla9)
    --menu:AddItem(cla13)
    --menu:AddItem(cla3)
    --menu:AddItem(cla2)
    --menu:AddItem(cla3) 
    menu:AddItem(cla5)
end

function vehicle(menu)
    local clar1 = NativeUI.CreateItem("Allumer/Fermer Moteur","Allumer ou Fermer Moteur")
    local clar3 = NativeUI.CreateItem("Ouvrir/Fermer Capot","Ouvrir/Fermer Capot")
    local clar4 = NativeUI.CreateItem("Ouvrir/Fermer Coffre","Ouvrir/Fermer Coffre")
    local clar2 = NativeUI.CreateItem("RETOUR","Retourner au menu principal")
    local clar5 = NativeUI.CreateItem("Limitateur de vitesse","Régler le limitateur")
    menu.OnItemSelect = function(sender, item, index)
        if item == clar2 then
            vehMenu:Visible(not vehMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())                 
        elseif item == clar1 then
            if (IsInVehicle()) then 
                if engine == true then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est éteint !")
                    SetVehicleEngineOn(GetVehiclePedIsIn( GetPlayerPed(-1), false ), true, false, true)
                    SetVehicleUndriveable(GetVehiclePedIsIn( GetPlayerPed(-1), false ), false)
                    DisableControlAction(0,20,true)
                    engine = false
                else
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est allumé !")
                    SetVehicleEngineOn(GetVehiclePedIsIn( GetPlayerPed(-1), false ), false, false, true)
                    SetVehicleUndriveable(GetVehiclePedIsIn( GetPlayerPed(-1), false ), true)
                    EnableControlAction(0,20,true)
                    engine = true
                end
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule !")
            end
        elseif item == clar3 then  
            if (IsInVehicle()) then 
                local porteCapot = true
                if porteCapot then
                    SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 4, false, false)
                    porteCapot = false
                else                    
                    SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 4, false, false)
                    porteCapot = true
                end
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule !")
            end     
        elseif item == clar4 then  
            if (IsInVehicle()) then 
                local porteCoffreOuvert = true
                if porteCoffreOuvert then
                    SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 5, false, false)
                else
                    SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 5, false, false)
                end
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule !")
            end     
        elseif item == clar5 then 
            vehMenu:Visible(not vehMenu:Visible())
            Limitmenu:Visible(not Limitmenu:Visible())
        end
    end  
    --menu:AddItem(clar5)
    menu:AddItem(clar1)
    menu:AddItem(clar3)
    menu:AddItem(clar4)
    menu:AddItem(clar2)
end

function anim(menu)
    local ha1 = NativeUI.CreateItem("Démarches","")
    local ha2 = NativeUI.CreateItem("Arrêter l'animation","Arrêter l'animation")
    local ha3 = NativeUI.CreateItem("Arrestation","")
    local ha4 = NativeUI.CreateItem("Travail","")
    local ha7 = NativeUI.CreateItem("Festives","")
    local ha5 = NativeUI.CreateItem("Divers","")
    local ha6 = NativeUI.CreateItem("RETOUR","Retourner au menu principal")
    menu.OnItemSelect = function(sender, item, index)
        if item == ha1 then
            animMenu:Visible(not animMenu:Visible())
            demMenu:Visible(not demMenu:Visible())
        elseif item == ha2 then
            local ped = GetPlayerPed(-1);
            if ped then
                ClearPedTasks(ped);
            end
        elseif item == ha6 then
            animMenu:Visible(not animMenu:Visible())
            mainMenu:Visible(not mainMenu:Visible())
        elseif item == ha5 then
            animMenu:Visible(not animMenu:Visible())
            divMenu:Visible(not divMenu:Visible())
        elseif item == ha3 then
            animMenu:Visible(not animMenu:Visible())
            arMenu:Visible(not arMenu:Visible())
        end
    end
    menu:AddItem(ha2)
    menu:AddItem(ha3)
    menu:AddItem(ha1)
    menu:AddItem(ha5)
    menu:AddItem(ha6)
end

function arrest(menu)
    local hg1 = NativeUI.CreateItem("Arrestation","") 
    local hg2 = NativeUI.CreateItem("Position de fouille","")
    local hg3 = NativeUI.CreateItem("RETOUR","")
    menu.OnItemSelect = function(sender, item, index)
        if item == hg1 then
            animsAction({ lib = "random@arrests@busted", anim = "idle_c" })
        elseif item == hg2 then
            animsAction({ lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female" })    
        elseif item == hg3 then
            animMenu:Visible(not animMenu:Visible())
            arMenu:Visible(not arMenu:Visible())
        end
    end
    menu:AddItem(hg1)
    menu:AddItem(hg2)
    menu:AddItem(hg3)
end

function demarches(menu)
    local h1 = NativeUI.CreateItem("Normal Homme","")
    local h2 = NativeUI.CreateItem("Normal Femme","")
    local h4 = NativeUI.CreateItem("Pouffiasse","")
    local h3 = NativeUI.CreateItem("Homme effiminé","")
    local h5 = NativeUI.CreateItem("Depressif","")
    local h6 = NativeUI.CreateItem("Depressif F","")
    local h7 = NativeUI.CreateItem("Musclé","")
    local h8 = NativeUI.CreateItem("Hipster","")
    local h9 = NativeUI.CreateItem("Business","")
    local h10 = NativeUI.CreateItem("Intimideur","")
    local h11 = NativeUI.CreateItem("Bourré","")
    local h12 = NativeUI.CreateItem("Malheureux(se)","")
    local h13 = NativeUI.CreateItem("Triste","")    
    local h14 = NativeUI.CreateItem("Choc","")
    local h15 = NativeUI.CreateItem("Sombre","")
    local h16 = NativeUI.CreateItem("Fatigué","")
    local h17 = NativeUI.CreateItem("Pressé","")
    local h18 = NativeUI.CreateItem("Frimeur(se)","")  
    local h19 = NativeUI.CreateItem("Fier(e)","")
    local h20 = NativeUI.CreateItem("Petite course","")
    local h21 = NativeUI.CreateItem("Prostitué","")  
    local h22 = NativeUI.CreateItem("Impertinent(e)","")
    local h23 = NativeUI.CreateItem("Arrogant(e)","")
    local h24 = NativeUI.CreateItem("Blessé","")
    local h25 = NativeUI.CreateItem("Trop mangé","")    
    local h26 = NativeUI.CreateItem("Casual","")
    local h27 = NativeUI.CreateItem("Determiner","")
    local h28 = NativeUI.CreateItem("Peureux(se)","")
    local h29 = NativeUI.CreateItem("Trop Swag","")
    local h30 = NativeUI.CreateItem("Travailleur(se)","")
    local h31 = NativeUI.CreateItem("Brute","")
    local h32 = NativeUI.CreateItem("Rando","")
    local h33 = NativeUI.CreateItem("Femme Gangster","")
    local h35 = NativeUI.CreateItem("Gangster","")
    local h34 = NativeUI.CreateItem("RETOUR","")
    menu.OnItemSelect = function(sender, item, index)
        if item == h1 then
            startAttitude("move_m@multiplayer","move_m@multiplayer")
        elseif item == h2 then
            startAttitude("move_f@multiplayer","move_f@multiplayer")
        elseif item == h33 then
            startAttitude("move_m@gangster@ng","move_m@gangster@ng")
        elseif item == h35 then
            startAttitude("move_m@gangster@generic","move_m@gangster@generic")
        elseif item == h32 then
            startAttitude("move_m@hiking","move_m@hiking")        
        elseif item == h31 then
            startAttitude("move_m@tough_guy@","move_m@tough_guy@")                   
        elseif item == h30 then
            startAttitude("move_m@tool_belt@a","move_m@tool_belt@a")
        elseif item == h13 then
            startAttitude("move_m@leaf_blower","move_m@leaf_blower")
        elseif item == h29 then
            startAttitude("move_m@swagger@b","move_m@swagger@b")
        elseif item == h28 then
            startAttitude("move_m@scared","move_m@scared")
        elseif item == h27 then
            startAttitude("move_m@brave@a","move_m@brave@a")
        elseif item == h26 then
            startAttitude("move_m@casual@a","move_m@casual@a")
        elseif item == h25 then
            startAttitude("move_m@fat@a","move_m@fat@a")
        elseif item == h24 then
            startAttitude("move_m@injured","move_m@injured")
        elseif item == h23 then
            startAttitude("move_f@arrogant@a","move_f@arrogant@a")
        elseif item == h22 then
            startAttitude("move_f@sassy","move_f@sassy") 
        elseif item == h21 then
            startAttitude("move_f@maneater","move_f@maneater")
        elseif item == h20 then
            startAttitude("move_m@quick","move_m@quick")    
        elseif item == h18 then
            startAttitude("move_m@money","move_m@money")
        elseif item == h20 then
            startAttitude("move_m@posh@","move_m@posh@")
        elseif item == h17 then
            startAttitude("move_m@hurry_butch@a","move_m@hurry_butch@a")
        elseif item == h16 then
            startAttitude("move_m@buzzed","move_m@buzzed")
        elseif item == h15 then
            startAttitude("move_m@shadyped@a","move_m@shadyped@a")
        elseif item == h12 then
            startAttitude("move_m@sad@a","move_m@sad@a")
        elseif item == h14 then
            startAttitude("move_m@shocked@a","move_m@shocked@a")
        elseif item == h11 then
            startAttitude("move_m@hobo@a","move_m@hobo@a")        
        elseif item == h10 then
            startAttitude("move_m@hurry@a","move_m@hurry@a")
        elseif item == h9 then
            startAttitude("move_m@business@a","move_m@business@a")        
        elseif item == h6 then
            startAttitude("move_f@depressed@a","move_f@depressed@a")
        elseif item == h5 then
            startAttitude("move_m@depressed@a","move_m@depressed@a")
        elseif item == h3 then
            startAttitude("move_m@confident","move_m@confident")
        elseif item == h4 then
            startAttitude("move_f@heels@c","move_f@heels@c")
        elseif item == h7 then
            startAttitude("move_m@muscle@a","move_m@muscle@a")
        elseif item == h34 then
            animMenu:Visible(not animMenu:Visible())
            demMenu:Visible(not demMenu:Visible())
        elseif item == h8 then
            startAttitude("move_m@hipster@a","move_m@hipster@a")
        end
    end
    menu:AddItem(h1)
    menu:AddItem(h2)
    menu:AddItem(h3)
    menu:AddItem(h4)
    menu:AddItem(h5)
    menu:AddItem(h6)
    menu:AddItem(h7)
    menu:AddItem(h8)
    menu:AddItem(h9)
    menu:AddItem(h10)
    menu:AddItem(h11)
    menu:AddItem(h12)
    menu:AddItem(h13)
    menu:AddItem(h14)
    menu:AddItem(h15)
    menu:AddItem(h16)
    menu:AddItem(h17)
    menu:AddItem(h18)
    menu:AddItem(h19)
    menu:AddItem(h20)
    menu:AddItem(h21)
    menu:AddItem(h22)
    menu:AddItem(h23)
    menu:AddItem(h24)
    menu:AddItem(h25)
    menu:AddItem(h26)
    menu:AddItem(h27)
    menu:AddItem(h28)
    menu:AddItem(h29)
    menu:AddItem(h30)
    menu:AddItem(h31)
    menu:AddItem(h32)
    menu:AddItem(h33)
    menu:AddItem(h35)
    menu:AddItem(h34)
end

function vetement(menu)
    local hgg1 = NativeUI.CreateItem("Enlever le haut","")
    local hgg2 = NativeUI.CreateItem("Enlever le bas","")
    local hgg3 = NativeUI.CreateItem("Enlever chaussures","")
    local hgg4 = NativeUI.CreateItem("Remettre vetements","")
    local hgg5 = NativeUI.CreateItem("Accessoires","")
    local hgg6 = NativeUI.CreateItem("RETOUR","")
    menu.OnItemSelect = function(sender, item, index)
        if item == hgg1 then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local clothesSkin = { ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['torso_1'] = 15, ['torso_2'] = 0, ['arms'] = 15, ['arms_2'] = 0 }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end)
        elseif item == hgg2 then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local clothesSkin = { ['pants_1'] = 21, ['pants_2'] = 0 }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end)
        elseif item == hgg3 then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local clothesSkin = {['shoes_1'] = 34, ['shoes_2'] = 0 }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end)
        elseif item == hgg4 then
            TriggerEvent('skinchanger:getSkin', function(skin)
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                end)
            end)
        elseif item == hgg5 then
            vetMenu:Visible(not vetMenu:Visible())
            Wait(750) 
            TriggerEvent("Brook:access")
        elseif item == hgg6 then
          vetMenu:Visible(not vetMenu:Visible())
          mainMenu:Visible(not mainMenu:Visible())
        end
    end
    menu:AddItem(hgg1)
    menu:AddItem(hgg2)
    menu:AddItem(hgg3)
    menu:AddItem(hgg5)
    menu:AddItem(hgg4)
    menu:AddItem(hgg6)
end

function interact(menu)
    local kj1 = NativeUI.CreateItem("Appeler UBER","")
    local kj2 = NativeUI.CreateItem("Menotter","Il vous faut des menottes")
    local kj3 = NativeUI.CreateItem("Déployer Voiture Télécommandée","Déployer Voiture Télécommandée")
    local kj4 = NativeUI.CreateItem("Fouiller le mort","")
    menu.OnItemSelect = function(sender, item, index)

        if item == kj4 then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if IsPlayerDead(closestPlayer) then
                ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

                    local itemName = data.weapons[1].name
                    local itemType = 'item_weapon'
                    local amount = data.weapons[1].ammo

                    local vitemName = data.inventory[1].name
                    local vitemType = 'item_standard'
                    local vamount = data.inventory[1].count
                    
                    TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(closestPlayer), itemType, itemName, amount)
                    TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(closestPlayer), vitemType, vitemName, vamount)
                end, GetPlayerServerId(closestPlayer))
            end
        elseif item == kj2 then
            hasMEN(function (hasMEN)
                if hasMEN == true then
                    local closestPlayer = ESX.Game.GetClosestPlayer()
                    TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
                else
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu n'a pas de menottes ! Va en acheter !")
                end
            end)
        elseif item == kj1 then
            local source = source
            local playerPed = PlayerPedId()
		    local coords = GetEntityCoords(playerPed)
            TriggerEvent('BrookAI:callTaxi', source, coords)
        elseif item == kj3 then
            hasRC(function (hasRC)
                if hasRC == true then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu viens de déployer la voiture télécommandée !")
                    exports.BrookAPI:RCCarStart()
                else
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Va en acheter !")
                end
            end) 
        end
    end
    --menu:AddItem(kj1)
    menu:AddItem(kj2)
    menu:AddItem(kj4)
    menu:AddItem(kj3)
end

function div(menu)
    local fgh1 = NativeUI.CreateItem("Fumer une clope","")
    local fgh2 = NativeUI.CreateItem("Boire un café","")
    local fgh3 = NativeUI.CreateItem("S\'asseoir (par terre)","")
    local fgh4 = NativeUI.CreateItem("Se gratter les parties","")
    local fgh5 = NativeUI.CreateItem("Faire la manche","")
    local fgh6 = NativeUI.CreateItem("Attendre","")
    local fgh7 = NativeUI.CreateItem("S\'allonger sur le dos","")
    local fgh8 = NativeUI.CreateItem("S\'allonger sur le ventre","")
    local fgh9 = NativeUI.CreateItem("Prendre une photo","")
    local fgh10 = NativeUI.CreateItem("RETOUR","")
    menu.OnItemSelect = function(sender, item, index)
        if item == fgh1 then
            animsActionScenario({ anim = "WORLD_HUMAN_SMOKING" })
        elseif item == fgh2 then
            animsAction({ lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a" })
        elseif item == fgh3 then
            animsActionScenario({ anim = "WORLD_HUMAN_PICNIC" })
        elseif item == fgh4 then
            animsAction({ lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" })
        elseif item == fgh5 then
            animsActionScenario({ anim = "WORLD_HUMAN_BUM_FREEWAY" })
        elseif item == fgh6 then
            animsActionScenario({ anim = "world_human_leaning" })
        elseif item == fgh7 then
            animsActionScenario({ anim = "WORLD_HUMAN_SUNBATHE_BACK" })
        elseif item == fgh8 then
            animsActionScenario({ anim = "WORLD_HUMAN_SUNBATHE" })
        elseif item == fgh9 then
            animsActionScenario({ anim = "WORLD_HUMAN_MOBILE_FILM_SHOCKING" })
        elseif item == fgh10 then
            divMenu:Visible(not divMenu:Visible())
            animMenu:Visible(not animMenu:Visible())
        end
    end
    menu:AddItem(fgh1)
    menu:AddItem(fgh2)
    menu:AddItem(fgh3)
    menu:AddItem(fgh4)
    menu:AddItem(fgh5)
    menu:AddItem(fgh6)
    menu:AddItem(fgh7)
    menu:AddItem(fgh8)
    menu:AddItem(fgh9)
    menu:AddItem(fgh10)
end

function mod(menu)
    local mod3 = NativeUI.CreateItem("NoClip","")
    local mod4 = NativeUI.CreateItem("Invincible","")
    local mod5 = NativeUI.CreateItem("Réparer Véhicule","")
    local mod6 = NativeUI.CreateItem("TP marqueur","")
    local mod7 = NativeUI.CreateItem("S\'octroyer de l\'argent","")
    local mod8 = NativeUI.CreateItem("Spawn véhicule","")
    local mod10 = NativeUI.CreateItem("Blackout toute la ville (BETA)","")
    local mod11 = NativeUI.CreateItem(" --- EVENTS --- ","")
    local mod12 = NativeUI.CreateItem("Afficher coordonnées","")
    local mod13 = NativeUI.CreateItem(" --- BROOK --- ","")
    local mod15 = NativeUI.CreateItem("MENU","")
    local mod14 = NativeUI.CreateItem("TENUE","")
    menu.OnItemSelect = function(sender, item, index)
        if item == mod10 then
            SetArtificialLightsState(true)
        elseif item == mod3 then
            admin_no_clip()
            modMenu:Visible(not modMenu:Visible())
        elseif item == mod4 then
            admin_godmode()
        elseif item == mod5 then
            admin_vehicle_repair()
        elseif item == mod6 then
            admin_tp_marcker()
            modMenu:Visible(not modMenu:Visible())
        elseif item == mod7 then
            admin_give_money()
        elseif item == mod8 then
            admin_vehicle_spawn()
            modMenu:Visible(not modMenu:Visible())
        elseif item == mod12 then
            modo_showcoord()
        elseif item == mod15 then
            modMenu:Visible(not modMenu:Visible())
            Brookmenu:Visible(not Brookmenu:Visible())   
        elseif item == mod15 then
            advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Hmmm ....")
        end
    end
    menu:AddItem(mod6)
    menu:AddItem(mod3)
    menu:AddItem(mod4)
    menu:AddItem(mod5)
    menu:AddItem(mod8)
    menu:AddItem(mod12)
    menu:AddItem(mod11)
    menu:AddItem(mod10)
    menu:AddItem(mod13)
    menu:AddItem(mod14)
    menu:AddItem(mod15)
end

function Brook(menu)
    local job = NativeUI.CreateItem("Donner graine de weed","")
    local job1 = NativeUI.CreateItem("Donner plant de feuille de coca","")
    local job2 = NativeUI.CreateItem("Donner graine de weed","")
    menu.OnItemSelect = function(sender, item, index)
        if item == job then

        end    
    end
    menu:AddItem(job)
    menu:AddItem(job1)
end

function Limit(menu)
    local lob = NativeUI.CreateItem("Régler le limitateur de vitesse à 30 KM/H","")
    local lob1 = NativeUI.CreateItem("Régler le limitateur de vitesse à 50 KM/H","")
    local lob2 = NativeUI.CreateItem("Régler le limitateur de vitesse à 70 KM/H","")
    local lob3 = NativeUI.CreateItem("Régler le limitateur de vitesse à 100 KM/H","")
    local lob4 = NativeUI.CreateItem("Régler le limitateur de vitesse à 140 KM/H","")
    local lob5 = NativeUI.CreateItem("Désactiver le limitateur de vitesse","")
    local lob6 = NativeUI.CreateItem("RETOUR","")
    menu.OnItemSelect = function(sender, item, index)
        if item == lob5 then
            if (IsInVehicle()) then 
                advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Le limitateur a bien été desactivé !")
                SetEntityMaxSpeed(vehicle, 99999/sp)
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule pour faire cela !")
            end
        elseif item == lob then
            if (IsInVehicle()) then 
                advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Le limitateur a bien été règlé !")
                SetEntityMaxSpeed(vehicle, 30/sp)
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule pour faire cela !")
            end
        elseif item == lob1 then
            if (IsInVehicle()) then 
                advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Le limitateur a bien été règlé !")
                SetEntityMaxSpeed(vehicle, 50/sp)
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule pour faire cela !")
            end
        elseif item == lob2 then
            if (IsInVehicle()) then 
                advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Le limitateur a bien été règlé !")
                SetEntityMaxSpeed(vehicle, 70/sp)
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule pour faire cela !")
            end
        elseif item == lob3 then
            if (IsInVehicle()) then 
                advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Le limitateur a bien été règlé !")
                SetEntityMaxSpeed(vehicle, 100/sp)
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule pour faire cela !")
            end
        elseif item == lob4 then
            if (IsInVehicle()) then 
                advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Le limitateur a bien été règlé !")
                SetEntityMaxSpeed(vehicle, 140/sp)
            else
                advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu dois être dans un véhicule pour faire cela !")
            end
        elseif item == lob6 then
            Limitmenu:Visible(not Limitmenu:Visible())
            vehMenu:Visible(not vehMenu:Visible())
        end    
    end
    menu:AddItem(lob)
    menu:AddItem(lob1)
    menu:AddItem(lob2)
    menu:AddItem(lob3)
    menu:AddItem(lob4)
    menu:AddItem(lob5)
    menu:AddItem(lob6) 
end


---INIT---

MenuPrincipal(mainMenu)
configmenu(confMenu)
credit(credMenu)
rpinfo(rpMenu)
vehicle(vehMenu)
anim(animMenu)
demarches(demMenu)
arrest(arMenu)
vetement(vetMenu)
interact(intMenu)
div(divMenu)
mod(modMenu)
Brook(Brookmenu)
Limit(Limitmenu)
_menuPool:RefreshIndex()

---THREADS---

Citizen.CreateThread(function()
    while true do
        Wait(15)
        if IsControlPressed(0, 322) or IsControlPressed(0, 177) and cardOpen then
            SendNUIMessage({action = "close"})
            cardOpen = false
        end
    end				
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 289) then -- If the key you specified in the config is pressed open then menu, if the menu is open close the menu.
            mainMenu:Visible(not mainMenu:Visible())
        end
        if IsControlJustPressed(1, 10) then
            ESX.TriggerServerCallback('Brook:getUsergroup', function(group)
                playergroup = group
                if playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'owner' then
                    modMenu:Visible(not modMenu:Visible())
                end
            end)
        end
    end
end)

local noclip = false
local noclip_speed = 1.5

function admin_no_clip()
  noclip = not noclip
  local ped = GetPlayerPed(-1)
  if noclip then -- activé
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, false, false)
	notify("Noclip ~g~activé")
  else -- désactivé
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true, false)
	notify("Noclip ~r~désactivé")
  end
end

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

function isNoclip()
  return noclip
end

-- noclip/invisible
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(2)
    if noclip then
      local ped = GetPlayerPed(-1)
      local x,y,z = getPosition()
      local dx,dy,dz = getCamDirection()
      local speed = noclip_speed

      -- reset du velocity
      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

      -- aller vers le haut
      if IsControlPressed(0,32) then -- MOVE UP
        x = x+speed*dx
        y = y+speed*dy
        z = z+speed*dz
      end

      -- aller vers le bas
      if IsControlPressed(0,269) then -- MOVE DOWN
        x = x-speed*dx
        y = y-speed*dy
        z = z-speed*dz
      end

      SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
    end
  end
end)

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

function admin_tp_marcker()
    local playerPed = GetPlayerPed(-1)
	local WaypointHandle = GetFirstBlipInfoId(8)
	if DoesBlipExist(WaypointHandle) then
		local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
		--SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, coord.z, false, false, false, true)
		SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
		notify("Téléporté sur le marqueur !")
	else
		notify("Pas de marqueur !")
	end
end

function admin_give_money()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	notify("~b~Entrez le montant à vous octroyer...")
	inputmoney = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(2)
		if inputmoney == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputmoney = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoney = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoney = 0
			end
		end
		if inputmoney == 2 then
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('Brook:giveCash', money)
			inputmoney = 0
		end
	end
end)

function admin_vehicle_spawn()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	notify("~b~Entrez le nom du véhicule...")
	inputvehicle = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputvehicle == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputvehicle = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputvehicle = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputvehicle = 0
			end
		end
		if inputvehicle == 2 then
		local vehicleidd = GetOnscreenKeyboardResult()

				local car = GetHashKey(vehicleidd)
				
				Citizen.CreateThread(function()
					Citizen.Wait(10)
					RequestModel(car)
					while not HasModelLoaded(car) do
						Citizen.Wait(0)
					end
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
					veh = CreateVehicle(car, x,y,z, 0.0, true, false)
					SetEntityVelocity(veh, 2000)
					SetVehicleOnGroundProperly(veh)
					SetVehicleHasBeenOwnedByPlayer(veh,true)
					local id = NetworkGetNetworkIdFromEntity(veh)
					SetNetworkIdCanMigrate(id, true)
					SetVehRadioStation(veh, "OFF")
					SetPedIntoVehicle(GetPlayerPed(-1),  veh,  -1)
				end)
		
        inputvehicle = 0
		end
	end
end)

function modo_showcoord()
	if showcoord then
		showcoord = false
	else
		showcoord = true
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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		if showcoord then
			local playerPos = GetEntityCoords(GetPlayerPed(-1))
			local playerHeading = GetEntityHeading(GetPlayerPed(-1))
			Text("~r~X~s~: " ..playerPos.x.." ~b~Y~s~: " ..playerPos.y.." ~g~Z~s~: " ..playerPos.z.." ~y~Angle~s~: " ..playerHeading.."")
		end
	end
end)