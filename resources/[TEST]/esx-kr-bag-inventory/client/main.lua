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

ESX 			    			= nil

local HasBag = false
local Bags = {}
local BagId = false

Citizen.CreateThread(function()
	while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

		Citizen.Wait(0)
    end
    
    -- On restart check down below.

    if ESX.IsPlayerLoaded() then
        ESX.TriggerServerCallback('esx-kr-bag:getAllBags', function(bags)
            if bags ~= nil then
                for i=1, #bags, 1 do
                    TriggerEvent('esx-kr-bag:SpawnBagIntoClient', bags[i].x, bags[i].y, bags[i].z)
                    TriggerEvent('esx-kr-bag:insertIntoClient', bags[i].id)
                end
            end

            ESX.TriggerServerCallback('esx-kr-bag:getBag', function(bag)
                if bag ~= nil then
                    BagId = bag.bag[1].id
                    HasBag = true
                    TriggerEvent('esx-kr-bag:SetOntoPlayer')
                end
            end)
        end)
    end
end)

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = 0.25
   
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(1, 1, 0, 0, 255)
        SetTextEdge(0, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(2)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

    Citizen.Wait(200)

    PlayerData = xPlayer

    ESX.TriggerServerCallback('esx-kr-bag:getAllBags', function(bags)
        if bags ~= nil then
            for i=1, #bags, 1 do
                TriggerEvent('esx-kr-bag:SpawnBagIntoClient', bags[i].x, bags[i].y, bags[i].z)
                TriggerEvent('esx-kr-bag:insertIntoClient', bags[i].id)

            
            end
        end

        ESX.TriggerServerCallback('esx-kr-bag:getBag', function(bag)
            if bag ~= nil then
                BagId = bag.bag[1].id
                HasBag = true
                TriggerEvent('esx-kr-bag:SetOntoPlayer')

            end
        end)
    end)
end)

RegisterNetEvent('esx-kr-bag:SetOntoPlayer')
AddEventHandler('esx-kr-bag:SetOntoPlayer', function(id)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if HasBag and skin.bags_1 ~= 45 then
            TriggerEvent('skinchanger:change', "bags_1", 45)
            TriggerEvent('skinchanger:change', "bags_2", 0)
            TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('esx_skin:save', skin)
            end)
        end
    end)
end)

function LoadAnimation(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
      Wait(100)
    end 
end

RegisterNetEvent('esx-kr-bag:insertIntoClient')
AddEventHandler('esx-kr-bag:insertIntoClient', function(id)
    ESX.TriggerServerCallback('esx-kr-bag:getAllBags', function(bags)
        for i=1, #bags, 1 do
            table.insert(Bags, {id = {coords = {x = bags[i].x, y = bags[i].y, z = bags[i].z}, id = bags[i].id}})
        end
    end)
end)

RegisterNetEvent('esx-kr-bag:ReSync')
AddEventHandler('esx-kr-bag:ReSync', function(id)
    Bags = {}

    ESX.TriggerServerCallback('esx-kr-bag:getAllBags', function(bags)
        for i=1, #bags, 1 do
            table.insert(Bags, {id = {coords = {x = bags[i].x, y = bags[i].y, z = bags[i].z}, id = bags[i].id}})
        end
    end)
end)


function Bag()

    local elements = {}

    table.insert(elements, {label = 'Mettre un Objet', value = 'put'})
    table.insert(elements, {label = 'Prendre un Objet', value = 'take'})
    table.insert(elements, {label = 'Jeter Sac', value = 'drop'})
        
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lel',
        {
            css = 'Inventaire',
            title    = 'Sac',
            align    = 'left',
            elements = elements
        }, function(data, menu)

            if data.current.value == 'put' then
                PutItem()
            elseif data.current.value == 'take'then
                TakeItem()
            elseif data.current.value == 'drop' then
                DropBag()
            end
        end, function(data, menu)
        menu.close()
    end)
end


RegisterNetEvent('esx-kr-bag:GiveBag')
AddEventHandler('esx-kr-bag:GiveBag', function()
    ESX.TriggerServerCallback('esx-kr-bag:getBag', function(bag)
        if bag ~= nil then
            BagId = bag.bag[1].id
            HasBag = true
            TriggerEvent('esx-kr-bag:SetOntoPlayer')
        end
    end)
end)

RegisterNetEvent('esx-kr-bag:CheckBag')
AddEventHandler('esx-kr-bag:CheckBag', function()
    if HasBag then
        return true
    else
        return false
    end
end)

RegisterNetEvent('esx-kr-bag:SpawnBagIntoClient')
AddEventHandler('esx-kr-bag:SpawnBagIntoClient', function(x, y ,z)
    local coords3 = {
        x = x, 
        y = y, 
        z = z
    }

    ESX.Game.SpawnObject(1626933972, coords3, function(bag)
        FreezeEntityPosition(bag, true)
        SetEntityAsMissionEntity(object, true, false)
        SetEntityCollision(bag, false, true)
    end)
end)

function DropBag()
        ESX.UI.Menu.CloseAll()
        HasBag = false

        local coords1 = GetEntityCoords(PlayerPedId())
        local headingvector = GetEntityForwardVector(PlayerPedId())
        local x, y, z = table.unpack(coords1 + headingvector * 1.0)

        local coords2 = {
            x = x,
            y = y,
            z = z - 1
        }

        z2 = z - 1

        TriggerServerEvent('esx-kr-bag:DropBag', BagId, x, y, z2)

        ESX.Game.SpawnObject(1626933972, coords2, function(bag)
            FreezeEntityPosition(bag, true)
            SetEntityCollision(bag, false, true)
            TriggerEvent('skinchanger:change', "bags_1", 0)
            TriggerEvent('skinchanger:change', "bags_2", 0)
            TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('esx_skin:save', skin)
        end)
    end)
end

function IsWeapon(item)
    local hash = GetHashKey(item)
    local IsWeapon = IsWeaponValid(hash)
    
    if IsWeapon then 
        return true 
    else 
        return false 
    end
end


function TakeItem()

    local elements = {}

    ESX.TriggerServerCallback('esx-kr-bag:getBagInventory', function(bag)

        for i=1, #bag, 1 do
            table.insert(elements, {label = bag[i].label .. ' | ' .. bag[i].count .. 'x', value = bag[i].item, count = bag[i].count})
        end
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lels',
        {
            css = 'Inventaire',
            title    = 'Bag',
            align    = 'left',
            elements = elements
        }, function(data, menu)

            local IsWeapon = IsWeapon(data.current.value)
            menu.close()
            if IsWeapon then
                TriggerServerEvent('esx-kr-bag:TakeItem', BagId, data.current.value, data.current.count, "weapon")
            else
                TriggerServerEvent('esx-kr-bag:TakeItem', BagId, data.current.value, data.current.count, "item")
            end

            end, function(data, menu)
            menu.close()
        end)
    end, BagId)
end


function PutItem()

    local elements = {}

    ESX.TriggerServerCallback('esx-kr-bag:getPlayerInventory', function(result)

            for i=1, #result.items, 1 do
            local invitem = result.items[i]
                if invitem.count > 0 then
                    table.insert(elements, { label = invitem.label .. ' | ' .. invitem.count .. 'x', count = invitem.count, name = invitem.name, label2 = invitem.label})
                end
            end
          
          local weaponList = ESX.GetWeaponList()

            for i=1, #weaponList, 1 do
                local weaponHash = GetHashKey(weaponList[i].name)
                local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), weaponHash)
        
                if HasPedGotWeapon(GetPlayerPed(-1), weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
                    table.insert(elements, {label = weaponList[i].label .. ' | ' .. ammo .. 'x', name = weaponList[i].name, count = ammo, label2 = weaponList[i].label})
                end
            end
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lel3',
        {
            css = 'Inventaire',
            title    = 'Bag',
            align    = 'left',
            elements = elements
        }, function(data, menu)
            
            local IsWeapon = IsWeapon(data.current.name)
            menu.close()

                if IsWeapon then
                    TriggerServerEvent('esx-kr-bag:PutItem', BagId, data.current.name, data.current.label2, data.current.count, "weapon")
                else
                    TriggerServerEvent('esx-kr-bag:PutItem', BagId, data.current.name, data.current.label2, data.current.count, "item")
                end

            end, function(data, menu)
            menu.close()
        end)
    end)
end

Citizen.CreateThread(function()
    while true do

        local wait = 500

        for i=1, #Bags, 1 do

            local playercoords = GetEntityCoords(PlayerPedId())

            if GetDistanceBetweenCoords(playercoords, Bags[i].id.coords.x, Bags[i].id.coords.y, Bags[i].id.coords.z, true) <= 1.5 and not HasBag then
                wait = 5
                Draw3DText(Bags[i].id.coords.x, Bags[i].id.coords.y, Bags[i].id.coords.z + 0.45, '~g~[E]~w~ pour récupérer ton Sac')
                Draw3DText(Bags[i].id.coords.x, Bags[i].id.coords.y, Bags[i].id.coords.z + 0.35, '~o~[N]~w~ pour le fouiller')     
                if IsControlJustReleased(0, Keys['E']) then
                    HasBag = true
                    BagId = Bags[i].id.id

                    local Bag = GetClosestObjectOfType(Bags[i].id.coords.x, Bags[i].id.coords.y, Bags[i].id.coords.z, 1.5, 1626933972, false, false, false)

                    NetworkFadeOutEntity(Bag, false, false)
                    DeleteObject(Bag)
                
                    TriggerServerEvent('esx-kr-bag:PickUpBag', Bags[i].id.id)
                end

                if IsControlJustReleased(0, Keys['N']) then
                        HasBag = false
                        BagId = Bags[i].id.id
                        TakeItem()

                    wait = 5
                    Draw3DText(Bags[i].id.coords.x, Bags[i].id.coords.y, Bags[i].id.coords.z + 0.45, '~g~[E]~w~ pour récupérer ton Sac')
                    Draw3DText(Bags[i].id.coords.x, Bags[i].id.coords.y, Bags[i].id.coords.z + 0.35, '~o~[N]~w~ pour le fouiller')
             
                        if IsControlJustReleased(0, Keys['E']) then
                            HasBag = true
                            BagId = Bags[i].id.id
                            local Bag = GetClosestObjectOfType(Bags[i].id.coords.x, Bags[i].id.coords.y, Bags[i].id.coords.z, 1.5, 1626933972, false, false, false)
    
                                NetworkFadeOutEntity(Bag, false, false)
                                DeleteObject(Bag)
                         
                                TriggerServerEvent('esx-kr-bag:PickUpBag', Bags[i].id.id)
                        end
                    if IsControlJustReleased(0, Keys['N']) then
                            HasBag = false
                            BagId = Bags[i].id.id
                            TakeItem()

                        end

                    end
                end
            end

            Citizen.Wait(wait)
        end
    end)


function advancednotify(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    SetNotificationMessage(icon, icon, true, type, sender, title, text);
    DrawNotification(false, true);
end


RegisterNetEvent('Brook:sac')
AddEventHandler('Brook:sac', function()
    if HasBag and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsEntityInAir(PlayerPedId()) then
        Bag()
    else
        advancednotify("CHAR_HUMANDEFAULT", 1, "Moi", false, "Tu ne peut ouvrir ton sac !")  
    end
end)
