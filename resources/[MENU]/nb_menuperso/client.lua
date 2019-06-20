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

ESX = nil
local GUI                       = {}
GUI.Time                        = 0
local PlayerData              = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--Notification joueur
function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end

--Message text joueur
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

function OpenPersonnelMenu()
	
	ESX.UI.Menu.CloseAll()
	
	ESX.TriggerServerCallback('NB:getUsergroup', function(group)
		playergroup = group
		
		local elements = {}
		
		table.insert(elements, {label = '💼 Me concernant',		value = 'menuperso_moi'})
		table.insert(elements, {label = '💳 Carte Identité',			value = 'menuperso_carte_identite'})
		table.insert(elements, {label = '👋 Animations',					value = 'menuperso_actions'})
		if (IsInVehicle()) then
			local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
			if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
				table.insert(elements, {label = '🚗 Vehicule',					value = 'menuperso_vehicule'})
			end
		end
		table.insert(elements, {label = '🗺 GPS',			value = 'menuperso_gpsrapide'})
		if PlayerData.job.grade_name == 'boss' then
			table.insert(elements, {label = '🏭 Gestion d\'entreprise',			value = 'menuperso_grade'})
		end
				
		if playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'owner' then
			table.insert(elements, {label = '👑 Modération',				value = 'menuperso_modo'})
		end
		--table.insert(elements, {label = 'Roleplay',					value = 'menuperso_roleplay'})
		table.insert(elements, {label = '🔑 Configuration',					value = 'menuperso_config'})
		table.insert(elements, {label = '👑 Crédits Serveur',					value = 'menuperso_credits'})

		
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'menu_perso',
			{
				css =  'perso',
				title    = 'Menu Personnel',
				align    = 'top-left',
				elements = elements
			},
			function(data, menu)
	
				local elements = {}
				
				if playergroup == 'mod' then
					table.insert(elements, {label = 'TP sur joueur',    							value = 'menuperso_modo_tp_toplayer'})
					table.insert(elements, {label = 'TP joueur sur moi',             			value = 'menuperso_modo_tp_playertome'})
					--table.insert(elements, {label = 'TP sur coordonées [WIP]',						value = 'menuperso_modo_tp_pos'})
					--table.insert(elements, {label = 'NoClip',										value = 'menuperso_modo_no_clip'})
					--table.insert(elements, {label = 'Mode invincible',									value = 'menuperso_modo_godmode'})
					--table.insert(elements, {label = 'Mode fantôme',								value = 'menuperso_modo_mode_fantome'})
					--table.insert(elements, {label = 'Réparer véhicule',							value = 'menuperso_modo_vehicle_repair'})
					--table.insert(elements, {label = 'Faire apparaître un véhicule',							value = 'menuperso_modo_vehicle_spawn'})
					--table.insert(elements, {label = 'Retourner le véhicule',								value = 'menuperso_modo_vehicle_flip'})
					--table.insert(elements, {label = 'S\'octroyer de l\'argent',						value = 'menuperso_modo_give_money'})
					--table.insert(elements, {label = 'S\'octroyer de l\'argent (banque)',						value = 'menuperso_modo_give_moneybank'})
					--table.insert(elements, {label = 'S\'octroyer de l\'argent sale',						value = 'menuperso_modo_give_moneydirty'})
					table.insert(elements, {label = 'Afficher/Cacher coordonnées',		value = 'menuperso_modo_showcoord'})
					table.insert(elements, {label = 'Afficher/Cacher noms des joueurs',	value = 'menuperso_modo_showname'})
					--table.insert(elements, {label = 'TP sur le marqueur',							value = 'menuperso_modo_tp_marcker'})
					--table.insert(elements, {label = 'Soigner la personne',					value = 'menuperso_modo_heal_player'})
					--table.insert(elements, {label = 'Mode spectateur [WIP]',						value = 'menuperso_modo_spec_player'})
					--table.insert(elements, {label = 'Changer l\'apparence',									value = 'menuperso_modo_changer_skin'})
					--table.insert(elements, {label = 'Sauvegarder l\'apparence',									value = 'menuperso_modo_save_skin'})
				end
			
				if playergroup == 'admin' then
					table.insert(elements, {label = 'TP sur joueur',    							value = 'menuperso_modo_tp_toplayer'})
					table.insert(elements, {label = 'TP joueur sur moi',             			value = 'menuperso_modo_tp_playertome'})
					--table.insert(elements, {label = 'TP sur coordonées [WIP]',						value = 'menuperso_modo_tp_pos'})
					--table.insert(elements, {label = 'NoClip',										value = 'menuperso_modo_no_clip'})
					--table.insert(elements, {label = 'Mode invincible',									value = 'menuperso_modo_godmode'})
					--table.insert(elements, {label = 'Mode fantôme',								value = 'menuperso_modo_mode_fantome'})
					table.insert(elements, {label = 'Reparer vehicule',							value = 'menuperso_modo_vehicle_repair'})
					--table.insert(elements, {label = 'Faire apparaître un véhicule',							value = 'menuperso_modo_vehicle_spawn'})
					table.insert(elements, {label = 'Retourner le véhicule',								value = 'menuperso_modo_vehicle_flip'})
					table.insert(elements, {label = 'S\'octroyer de l\'argent',						value = 'menuperso_modo_give_money'})
					table.insert(elements, {label = 'S\'octroyer de l\'argent (banque)',						value = 'menuperso_modo_give_moneybank'})
					table.insert(elements, {label = 'S\'octroyer de l\'argent sale',						value = 'menuperso_modo_give_moneydirty'})
					table.insert(elements, {label = 'Afficher/Cacher coordonnées',		value = 'menuperso_modo_showcoord'})
					table.insert(elements, {label = 'Afficher/Cacher noms des joueurs',	value = 'menuperso_modo_showname'})
					table.insert(elements, {label = 'TP sur le marqueur',							value = 'menuperso_modo_tp_marcker'})
					table.insert(elements, {label = 'Soigner la personne',					value = 'menuperso_modo_heal_player'})
					--table.insert(elements, {label = 'Mode spectateur [WIP]',						value = 'menuperso_modo_spec_player'})
					--table.insert(elements, {label = 'Changer l\'apparence',									value = 'menuperso_modo_changer_skin'})
					--table.insert(elements, {label = 'Sauvegarder l\'apparence',									value = 'menuperso_modo_save_skin'})
				end
			
				if playergroup == 'superadmin' or playergroup == 'owner' then
					table.insert(elements, {label = 'TP sur joueur',    							value = 'menuperso_modo_tp_toplayer'})
					table.insert(elements, {label = 'TP joueur sur moi',             			value = 'menuperso_modo_tp_playertome'})
					table.insert(elements, {label = 'TP sur coordonées [WIP]',						value = 'menuperso_modo_tp_pos'})
					table.insert(elements, {label = 'NoClip',										value = 'menuperso_modo_no_clip'})
					table.insert(elements, {label = 'Mode invincible',									value = 'menuperso_modo_godmode'})
					table.insert(elements, {label = 'Mode fantôme',								value = 'menuperso_modo_mode_fantome'})
					table.insert(elements, {label = 'Réparer véhicule',							value = 'menuperso_modo_vehicle_repair'})
					table.insert(elements, {label = 'Faire apparaître un véhicule',							value = 'menuperso_modo_vehicle_spawn'})
					table.insert(elements, {label = 'Retourner le véhicule',								value = 'menuperso_modo_vehicle_flip'})
					table.insert(elements, {label = 'S\'octroyer de l\'argent',						value = 'menuperso_modo_give_money'})
					table.insert(elements, {label = 'S\'octroyer de l\'argent (banque)',						value = 'menuperso_modo_give_moneybank'})
					table.insert(elements, {label = 'S\'octroyer de l\'argent sale',						value = 'menuperso_modo_give_moneydirty'})
					table.insert(elements, {label = 'Afficher/Cacher coordonnées',		value = 'menuperso_modo_showcoord'})
					table.insert(elements, {label = 'Afficher/Cacher noms des joueurs',	value = 'menuperso_modo_showname'})
					table.insert(elements, {label = 'TP sur le marqueur',							value = 'menuperso_modo_tp_marcker'})
					table.insert(elements, {label = 'Soigner la personne',					value = 'menuperso_modo_heal_player'})
					table.insert(elements, {label = 'Mode spectateur [WIP]',						value = 'menuperso_modo_spec_player'})
					table.insert(elements, {label = 'Changer l\'apparence',									value = 'menuperso_modo_changer_skin'})
					table.insert(elements, {label = 'Sauvegarder l\'apparence',									value = 'menuperso_modo_save_skin'})
					table.insert(elements, {label = '--- MODELS ---',									value = 'menuperso_modo_model'})
					table.insert(elements, {label = 'Iron Man (MARK46)',									value = 'menuperso_modo_model1'})
					table.insert(elements, {label = 'Iron Man (MARK85)',									value = 'menuperso_modo_model2'})
					table.insert(elements, {label = 'Iron Man ',									value = 'menuperso_modo_model3'})
					table.insert(elements, {label = 'Iron Man (ENDGAME)',									value = 'menuperso_modo_model4'})
				end

				if data.current.value == 'menuperso_modo' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_modo',
						{
							css =  'Modo',
							title    = 'Modération',
							align    = 'top-left',
							elements = elements
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_modo_tp_toplayer' then
								admin_tp_toplayer()
							end

							if data2.current.value == 'menuperso_modo_tp_playertome' then
								admin_tp_playertome()
							end

							if data2.current.value == 'menuperso_modo_tp_pos' then
								admin_tp_pos()
							end

							if data2.current.value == 'menuperso_modo_no_clip' then
								admin_no_clip()
							end

							if data2.current.value == 'menuperso_modo_godmode' then
								admin_godmode()
							end

							if data2.current.value == 'menuperso_modo_mode_fantome' then
								admin_mode_fantome()
							end

							if data2.current.value == 'menuperso_modo_vehicle_repair' then
								admin_vehicle_repair()
							end

							if data2.current.value == 'menuperso_modo_vehicle_spawn' then
								admin_vehicle_spawn()
							end

							if data2.current.value == 'menuperso_modo_vehicle_flip' then
								admin_vehicle_flip()
							end

							if data2.current.value == 'menuperso_modo_give_money' then
								admin_give_money()
							end

							if data2.current.value == 'menuperso_modo_give_moneybank' then
								admin_give_bank()
							end

							if data2.current.value == 'menuperso_modo_give_moneydirty' then
								admin_give_dirty()
							end

							if data2.current.value == 'menuperso_modo_showcoord' then
								modo_showcoord()
							end

							if data2.current.value == 'menuperso_modo_showname' then
								modo_showname()
							end

							if data2.current.value == 'menuperso_modo_tp_marcker' then
								admin_tp_marcker()
							end

							if data2.current.value == 'menuperso_modo_heal_player' then
								admin_heal_player()
							end

							if data2.current.value == 'menuperso_modo_spec_player' then
								admin_spec_player()
							end

							if data2.current.value == 'menuperso_modo_changer_skin' then
								changer_skin()
							end
							if data2.current.value == 'menuperso_modo_model1' then
								local modelHash = ''

								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
									modelHash = 'MK46'
							
									ESX.Streaming.RequestModel(modelHash, function()
										SetPlayerModel(PlayerId(), modelHash)
										SetModelAsNoLongerNeeded(modelHash)
							
										TriggerEvent('esx:restoreLoadout')
									end)
								end)
							end
							if data2.current.value == 'menuperso_modo_model2' then
								local modelHash = ''

								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
									modelHash = 'MK85'

									ESX.Streaming.RequestModel(modelHash, function()
										SetPlayerModel(PlayerId(), modelHash)
										SetModelAsNoLongerNeeded(modelHash)

										TriggerEvent('esx:restoreLoadout')
									end)
								end)
							end
							if data2.current.value == 'menuperso_modo_model3' then
								local modelHash = ''

								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
									modelHash = 'TonyAE'

									ESX.Streaming.RequestModel(modelHash, function()
										SetPlayerModel(PlayerId(), modelHash)
										SetModelAsNoLongerNeeded(modelHash)

										TriggerEvent('esx:restoreLoadout')
									end)
								end)
							end
							if data2.current.value == 'menuperso_modo_model4' then
								local modelHash = ''

								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
									modelHash = 'TonyTeamSuit'

									ESX.Streaming.RequestModel(modelHash, function()
										SetPlayerModel(PlayerId(), modelHash)
										SetModelAsNoLongerNeeded(modelHash)

										TriggerEvent('esx:restoreLoadout')
									end)
								end)
							end
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end
				
				if data.current.value == 'menuperso_vehicule' then
					OpenVehiculeMenu()
				end

				if data.current.value == 'menuperso_moi' then
	
					local elements = {}
					
					
					---table.insert(elements, {label = '🔑 Mes Cles',                            value = 'menuperso_moi_clefs'})
					--table.insert(elements, {label = 'Carte Identité',							value = 'menuperso_carte_identite'})
					table.insert(elements, {label = '🎒 Inventaire',             					value = 'menuperso_moi_inventaire'})
					table.insert(elements, {label = '💳 Mes factures',							value = 'menuperso_moi_factures'})
					--table.insert(elements, {label = '🐶 Animale',    							value = 'menuperso_moi_animal'})
					table.insert(elements, {label = '👓 Accessoire',							value = 'menuperso_moi_accessoire'})
						
					ESX.UI.Menu.Open(
						
						'default', GetCurrentResourceName(), 'menuperso_moi',
						{
							css =  'meconcernant',
							title    = 'Me concernant',
							align    = 'top-left',
							elements = elements
						},
						function(data2, menu2)
						
						    if data2.current.value == 'menuperso_moi_clefs' then
                                TriggerEvent("esx_menu:key")
                            end
							
							--if data2.current.value == 'identite_actions' then
							--	OpenIdentityMenu()
							--end

							if data2.current.value == 'menuperso_moi_animal' then
								openAnimal()
							end

							if data2.current.value == 'menuperso_moi_inventaire' then
								openInventaire()
							end

							if data2.current.value == 'menuperso_moi_factures' then
								openFacture()
							end
							
							if data2.current.value == 'menuperso_moi_accessoire' then
								OpenAccessoryMenu()
							end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end


					-------------------------------------------------------------------------- test-------------------------------------------------------

				if data.current.value == 'menuperso_carte_identite' then
	
					local elements = {}
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					local player, distance = ESX.Game.GetClosestPlayer()
					
					table.insert(elements, {label = '💳 Montrer sa carte aux autres',      value = 'montrerId'})
					table.insert(elements, {label = '💳 Afficher sa carte',				value = 'afficherId'})
					table.insert(elements, {label = '💳 Montrer son permis de conduire', 		value = 'montrerpermis'})
					table.insert(elements, {label = '💳 Voir son permis de conduire', 		value = 'voirpermis'})
					--table.insert(elements, {label = '💳 Montrer son permis de port d arme', 		value = 'montrerarme'})
					--table.insert(elements, {label = '💳 Voir son permis de port d arme', 		value = 'voirarme'})					
					
					ESX.UI.Menu.Open(
						
						'default', GetCurrentResourceName(), 'menuperso_moi',
						{
							css =  'meconcernant',
							title    = 'Me concernant',
							align    = 'top-left',
							elements = elements
						},
						function(data2, menu2)
--scipt ici
						local val = data2.current.value
						
						if val == 'afficherId' then
							TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
						elseif val == 'voirpermis' then
							TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
						elseif val == 'voirarme' then
							TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
						else
							local player, distance = ESX.Game.GetClosestPlayer()
							
							if distance ~= -1 and distance <= 3.0 then
								if val == 'montrerId' then
								TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
								elseif val == 'montrerpermis' then
							TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
								elseif val == 'montrerarme' then
							TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
								end
							else
							  ESX.ShowNotification('Aucun joueur en face !')
							end
						end
							end,
-- fin du script									
						function(data2, menu2)
							menu2.close()
						end
					)
							
						

-- Close the ID card
-- Key events
Citizen.CreateThread(function()
while true do
Wait(0)
if IsControlPressed(0, 322) or IsControlPressed(0, 177) and cardOpen then
SendNUIMessage({
action = "close"
})
cardOpen = false
end
end
end)				
end				
-------------------------------------------------------------------------- test-------------------------------------------------------										
				if data.current.value == 'menuperso_actions' then

					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_actions',
						{
							css =  'anim',
							title    = 'Animations',
							align    = 'top-left',
							elements = {
								{label = 'Annuler l\'animation',  value = 'menuperso_actions__annuler'},
								{label = 'Demarches',  value = 'menuperso_demarche'},
								-- {label = 'Faire ses besoins [WIP]',     value = 'menuperso_actions_pipi'},
								{label = 'Arrestation',  value = 'menuperso_actions_arrest'},
								{label = 'Salutations',  value = 'menuperso_actions_Salute'},
								{label = 'Humeurs',  value = 'menuperso_actions_Humor'},
								{label = 'Travail',  value = 'menuperso_actions_Travail'},
								{label = 'Festives',  value = 'menuperso_actions_Festives'},
								{label = 'Sportives',  value = 'menuperso_actions_Sportives'},
								{label = 'Diverses',  value = 'menuperso_actions_Others'},
								{label = 'Pegi 18+', value = 'menuperso_actions_pegi'},
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_actions__annuler' then
								local ped = GetPlayerPed(-1);
								if ped then
									ClearPedTasks(ped);
								end
							end
							
							if data2.current.value == 'menuperso_actions_arrest' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_arrest',
									{
										css =  'anim',
										title    = 'Controle',
										align    = 'top-left',
										elements = {
											{label = 'Se rendre aux policier',  value = 'menuperso_actions_Travail_serendrealapolice'},
                                            {label = 'Position de fouille',     value = 'menuperso_actions_Others_positiondefouille'},											
										},
									},
									function(data3, menu3)
										
										if data3.current.value == 'menuperso_actions_Travail_serendrealapolice' then
											animsAction({ lib = "random@arrests@busted", anim = "idle_c" })
										end
										
										if data3.current.value == 'menuperso_actions_Others_positiondefouille' then
											animsAction({ lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female" })
										end
									
									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end
							
							if data2.current.value == 'menuperso_demarche' then
                                ESX.UI.Menu.Open(
                                    'default', GetCurrentResourceName(), 'menuperso_actions_18',
                                    {
                                        css =  'anim',
										title    = 'Demarche',
                                        align    = 'top-left',
                                        elements = {
											{label = 'Normal H', value = 'menuperso_actions_demarch_normoh'},
											{label = 'Normal F', value = 'menuperso_actions_demarch_normof'},
                                            {label = 'Homme effiminer',  value = 'menuperso_actions_demarch_normalh'},
                                            {label = 'Bouffiasse',  value = 'menuperso_actions_demarch_normalf'},
                                            {label = 'Depressif',  value = 'menuperso_actions_demarch_depressif'},
                                            {label = 'Depressif F',  value = 'menuperso_actions_demarch_depressiff'},
                                            {label = 'Muscle',  value = 'menuperso_actions_demarch_muscle'},
                                            {label = 'Hipster',  value = 'menuperso_actions_demarch_hipster'},
                                            {label = 'Business',  value = 'menuperso_actions_demarch_business'},
                                            {label = 'Intimide',  value = 'menuperso_actions_demarch_intimide'},
                                            {label = 'Bourrer',  value = 'menuperso_actions_demarch_hobo'},
											{label = 'Malheureux(se)',  value = 'menuperso_actions_demarch_malheureux'},
											{label = 'Triste', value == 'menuperso_actions_demarch_triste'},
                                            {label = 'Choc',  value = 'menuperso_actions_demarch_choc'},
                                            {label = 'Sombre',  value = 'menuperso_actions_demarch_sombre'},
                                            {label = 'Fatiguer',  value = 'menuperso_actions_demarch_fatigue'},
                                            {label = 'Presser',  value = 'menuperso_actions_demarch_pressee'},
											{label = 'Frimeur(se)', value = 'menuperso_actions_demarch_frim'},
                                            {label = 'Fier(e)',  value = 'menuperso_actions_demarch_fier'},
                                            {label = 'Petite course',  value = 'menuperso_actions_demarch_course'},
                                            {label = 'Pupute',  value = 'menuperso_actions_demarch_nom'},
                                            {label = 'Impertinent(e)',  value = 'menuperso_actions_demarch_impertinent'},
                                            {label = 'Arrogant(e)',  value = 'menuperso_actions_demarch_arrogant'}, 
											{label = 'Blesser', value = 'menuperso_actions_demarch_blesse'},
											{label = 'Trop manger', value = 'menuperso_actions_demarch_tropm'},
											{label = 'Casual', value = 'menuperso_actions_demarch_casual'},
											{label = 'Determiner', value = 'menuperso_actions_demarch_deter'},
											{label = 'Peureux(se)', value = 'menuperso_actions_demarch_peur'},
											{label = 'Trop Swag', value = 'menuperso_actions_demarch_swagy'},
											{label = 'Travailleur(se)', value = 'menuperso_actions_demarch_taf'},
											{label = 'Brute', value = 'menuperso_actions_demarch_brute'},
											{label = 'Rando', value = 'menuperso_actions_demarch_rando'},
											{label = 'Gangster F', value = 'menuperso_actions_demarch_gg'},
											{label = 'Gangster', value = 'menuperso_actions_demarch_g1'},

                                        },
                                    },
                                    function(data3, menu3)
									
										if data3.current.value == 'menuperso_actions_demarch_normoh' then
											startAttitude("move_m@multiplayer","move_m@multiplayer")
										end

										if data3.current.value == 'menuperso_actions_demarch_normof' then
											startAttitude("move_f@multiplayer","move_f@multiplayer")
										end
										
										if data3.current.value == 'menuperso_actions_demarch_gg' then
											startAttitude("move_m@gangster@ng","move_m@gangster@ng")
										end
										
										if data3.current.value == 'menuperso_actions_demarch_g1' then
											startAttitude("move_m@gangster@generic","move_m@gangster@generic")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_rando' then
											startAttitude("move_m@hiking","move_m@hiking")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_brute' then
											startAttitude("move_m@tough_guy@","move_m@tough_guy@")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_taf' then
											startAttitude("move_m@tool_belt@a","move_m@tool_belt@a")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_triste' then
											startAttitude("move_m@leaf_blower","move_m@leaf_blower")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_swagy' then
											startAttitude("move_m@swagger@b","move_m@swagger@b")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_peur' then
											startAttitude("move_m@scared","move_m@scared")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_deter' then
											startAttitude("move_m@brave@a","move_m@brave@a")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_casual' then
											startAttitude("move_m@casual@a","move_m@casual@a")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_tropm' then
											startAttitude("move_m@fat@a","move_m@fat@a")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_blesse' then
											startAttitude("move_m@injured","move_m@injured")
										end
										
                                        if data3.current.value == 'menuperso_actions_demarch_arrogant' then
                                            startAttitude("move_f@arrogant@a","move_f@arrogant@a")
                                        end
 										
                                        if data3.current.value == 'menuperso_actions_demarch_impertinent' then
                                            startAttitude("move_f@sassy","move_f@sassy")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_nom' then
                                            startAttitude("move_f@maneater","move_f@maneater")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_course' then
                                            startAttitude("move_m@quick","move_m@quick")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_frim' then
                                            startAttitude("move_m@money","move_m@money")
                                        end
										
										if data3.current.value == 'menuperso_actions_demarch_fier' then
											startAttitude("move_m@posh@","move_m@posh@")
										end
 
                                        if data3.current.value == 'menuperso_actions_demarch_pressee' then
                                            startAttitude("move_m@hurry_butch@a","move_m@hurry_butch@a")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_fatigue' then
                                            startAttitude("move_m@buzzed","move_m@buzzed")
                                        end
  
                                        if data3.current.value == 'menuperso_actions_demarch_sombre' then
                                            startAttitude("move_m@shadyped@a","move_m@shadyped@a")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_malheureux' then
                                            startAttitude("move_m@sad@a","move_m@sad@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_choc' then
                                            startAttitude("move_m@shocked@a","move_m@shocked@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_hobo' then
                                            startAttitude("move_m@hobo@a","move_m@hobo@a")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_intimide' then
                                            startAttitude("move_m@hurry@a","move_m@hurry@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_business' then
                                            startAttitude("move_m@business@a","move_m@business@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_depressiff' then
                                            startAttitude("move_f@depressed@a","move_f@depressed@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_depressif' then
                                            startAttitude("move_m@depressed@a","move_m@depressed@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_normalh' then
                                            startAttitude("move_m@confident","move_m@confident")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_normalf' then
                                            startAttitude("move_f@heels@c","move_f@heels@c")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_muscle' then
                                            startAttitude("move_m@muscle@a","move_m@muscle@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_hipster' then
                                            startAttitude("move_m@hipster@a","move_m@hipster@a")
                                        end
                                   
                                       
 
                                    end,
                                    function(data3, menu3)
                                        menu3.close()
                                    end
                                )
                               
                            end
							
							if data2.current.value == 'menuperso_actions_pipi' then
								ESX.UI.Menu.CloseAll()
							end

							if data2.current.value == 'menuperso_actions_Salute' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Salute',
									{
										css =  'anim',
										title    = 'Salutations',
										align    = 'top-left',
										elements = {
											{label = 'Saluer',  value = 'menuperso_actions_Salute_saluer'},
											{label = 'Serrer la main',     value = 'menuperso_actions_Salute_serrerlamain'},
											{label = 'Tapes en 5',     value = 'menuperso_actions_Salute_tapeen5'},
											{label = 'Salut militaire',  value = 'menuperso_actions_Salute_salutmilitaire'},
											{label = 'Tchek',     value = 'menuperso_actions_Salute_tchek'},
											{label = 'Salut Bandit',     value = 'menuperso_actions_Salute_salutbandit'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Salute_saluer' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_hello" })
										end

										if data3.current.value == 'menuperso_actions_Salute_serrerlamain' then
											animsAction({ lib = "mp_common", anim = "givetake1_a" })
										end

										if data3.current.value == 'menuperso_actions_Salute_tapeen5' then
											animsAction({ lib = "mp_ped_interaction", anim = "highfive_guy_a" })
										end

										if data3.current.value == 'menuperso_actions_Salute_salutmilitaire' then
											animsAction({ lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute" })
										end

										if data3.current.value == 'menuperso_actions_Salute_tchek' then
											animsAction({ lib = "mp_ped_interaction", anim = "handshake_guy_a" })
										end

										if data3.current.value == 'menuperso_actions_Salute_salutbandit' then
											animsAction({ lib = "mp_ped_interaction", anim = "hugs_guy_a" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Humor' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Humor',
									{
										css =  'anim',
										title    = 'Humeurs',
										align    = 'top-left',
										elements = {
											{label = 'Feliciter',  value = 'menuperso_actions_Humor_feliciter'},
											{label = 'Super',     value = 'menuperso_actions_Humor_super'},
											{label = 'Calme-toi',     value = 'menuperso_actions_Humor_calmetoi'},
											{label = 'Avoir peur',  value = 'menuperso_actions_Humor_avoirpeur'},
											{label = 'Merde',  value = 'menuperso_actions_Humor_cestpaspossible'},
											{label = 'Enlacer',  value = 'menuperso_actions_Humor_enlacer'},
											{label = 'Doigts d\'honneur',  value = 'menuperso_actions_Humor_doightdhonneur'},
											{label = 'Se branler',  value = 'menuperso_actions_Humor_branleur'},
											{label = 'Balle dans la tete',  value = 'menuperso_actions_Humor_balledanslatete'},
                                            {label = 'C\'est pas possible !',  value = 'menuperso_actions_Humor_cestpaspossible'},
											{label = 'Jouer de la musique',  value = 'menuperso_actions_Humor_jouerdelamusique'},
											{label = 'Toi',  value = 'menuperso_actions_Humor_toi'},
											{label = 'Viens',     value = 'menuperso_actions_Humor_viens'},
											{label = 'Qu\'est ce qui a ?',     value = 'menuperso_actions_Humor_mais'},
											{label = 'A moi',  value = 'menuperso_actions_Humor_amoi'},
											{label = 'Je le savais, putain',  value = 'menuperso_actions_Humor_putain'},
											{label = 'Facepalm',  value = 'menuperso_actions_Humor_facepalm'},
											{label = 'Mais qu\'est ce que j\'ai fait ?',  value = 'menuperso_actions_Humor_fait'},
											{label = 'On se bat ?',  value = 'menuperso_actions_Humor_bat'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Humor_feliciter' then
											animsActionScenario({anim = "WORLD_HUMAN_CHEERING" })
										end

										if data3.current.value == 'menuperso_actions_Humor_super' then
											animsAction({ lib = "anim@mp_player_intcelebrationmale@thumbs_up", anim = "thumbs_up" })
										end

										if data3.current.value == 'menuperso_actions_Humor_calmetoi' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_easy_now" })
										end

										if data3.current.value == 'menuperso_actions_Humor_avoirpeur' then
											animsAction({ lib = "amb@code_human_cower_stand@female@idle_a", anim = "idle_c" })
										end

										if data3.current.value == 'menuperso_actions_Humor_cestpaspossible' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_damn" })
										end

										if data3.current.value == 'menuperso_actions_Humor_enlacer' then
											animsAction({ lib = "mp_ped_interaction", anim = "kisses_guy_a" })
										end

										if data3.current.value == 'menuperso_actions_Humor_doightdhonneur' then
											animsAction({ lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter" })
										end

										if data3.current.value == 'menuperso_actions_Humor_branleur' then
											animsAction({ lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01" })
										end

										if data3.current.value == 'menuperso_actions_Humor_balledanslatete' then
											animsAction({ lib = "mp_suicide", anim = "pistol" })
										end

										if data3.current.value == 'menuperso_actions_Humor_cestpaspossible' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_damn" })
										end

										if data3.current.value == 'menuperso_actions_Humor_jouerdelamusique' then
											animsActionScenario({anim = "WORLD_HUMAN_MUSICIAN" })
										end

										if data3.current.value == 'menuperso_actions_Humor_toi' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_point" })
										end

										if data3.current.value == 'menuperso_actions_Humor_viens' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft" })
										end

										if data3.current.value == 'menuperso_actions_Humor_mais' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on" })
										end

										if data3.current.value == 'menuperso_actions_Humor_amoi' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_me" })
										end

										if data3.current.value == 'menuperso_actions_Humor_putain' then
											animsAction({ lib = "anim@am_hold_up@male", anim = "shoplift_high" })
										end

										if data3.current.value == 'menuperso_actions_Humor_facepalm' then
											animsAction({ lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm" })
										end

										if data3.current.value == 'menuperso_actions_Humor_fait' then
											animsAction({ lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a" })
										end

										if data3.current.value == 'menuperso_actions_Humor_bat' then
											animsAction({ lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Travail' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Travail',
									{
										css =  'anim',
										title    = 'Travail',
										align    = 'top-left',
										elements = {
											{label = 'Prendre des notes',  value = 'menuperso_actions_Travail_prendredesnotes'},
											{label = 'Inspecter',  value = 'menuperso_actions_Travail_inspecter'},
											{label = 'Nettoyer',  value = 'menuperso_actions_Travail_nettoyerquelquechose'},
											{label = 'Policier',  value = 'menuperso_actions_Travail_policier'},
										    {label = 'Parler a? la radio',  value = 'menuperso_actions_Travail_parleralaradio'},
											{label = 'Faire la circulation',  value = 'menuperso_actions_Travail_fairelacirculation'},
											{label = 'Pecheur',  value = 'menuperso_actions_Travail_pecheur'},
											{label = 'Depanneur',     value = 'menuperso_actions_Travail_depanneur'},
											{label = 'Agriculteur',     value = 'menuperso_actions_Travail_agriculteur'},
                                            --{label = 'Se rendre aux?policier',  value = 'menuperso_actions_Travail_serendrealapolice'},
											{label = 'Reparer sous le vehicule',     value = 'menuperso_actions_Travail_reparersouslevehicule'},
											{label = 'Reparer le moteur',     value = 'menuperso_actions_Travail_reparerlemoteur'},
											{label = 'Enqueter',  value = 'menuperso_actions_Travail_enqueter'},
											{label = 'Regarder avec les jumelles',     value = 'menuperso_actions_Travail_jumelles'},
											{label = 'Observer la personne a? terre',     value = 'menuperso_actions_Travail_persoaterre'},
											{label = 'Parler au client (Taxi)',  value = 'menuperso_actions_Travail_parlerauclient'},
											{label = 'Donner une facture au client (Taxi)',  value = 'menuperso_actions_Travail_factureclient'},
											{label = 'Donner les courses',  value = 'menuperso_actions_Travail_lescourses'},
											{label = 'Servir un shot',     value = 'menuperso_actions_Travail_shot'},
											{label = 'Coup de marteau',  value = 'menuperso_actions_Travail_marteauabomberleverre'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Travail_prendredesnotes' then
											animsActionScenario({anim = "WORLD_HUMAN_CLIPBOARD" })
										end

										if data3.current.value == 'menuperso_actions_Travail_inspecter' then
											animsActionScenario({anim = "CODE_HUMAN_MEDIC_KNEEL" })
										end

										if data3.current.value == 'menuperso_actions_Travail_nettoyerquelquechose' then
											animsActionScenario({ anim = "world_human_maid_clean" })
										end

										if data3.current.value == 'menuperso_actions_Travail_policier' then
											animsActionScenario({anim = "WORLD_HUMAN_COP_IDLES" })
										end

										if data3.current.value == 'menuperso_actions_Travail_pecheur' then
											animsActionScenario({anim = "world_human_stand_fishing" })
										end

										if data3.current.value == 'menuperso_actions_Travail_depanneur' then
											animsActionScenario({anim = "world_human_vehicle_mechanic" })
										end

										if data3.current.value == 'menuperso_actions_Travail_agriculteur' then
											animsActionScenario({anim = "world_human_gardener_plant" })
										end

										if data3.current.value == 'menuperso_actions_Travail_serendrealapolice' then
											animsAction({ lib = "random@arrests@busted", anim = "idle_c" })
										end

										if data3.current.value == 'menuperso_actions_Travail_reparersouslevehicule' then
											animsActionScenario({anim = "world_human_vehicle_mechanic" })
										end

										if data3.current.value == 'menuperso_actions_Travail_reparerlemoteur' then
											animsAction({ lib = "mini@repair", anim = "fixing_a_ped" })
										end

										if data3.current.value == 'menuperso_actions_Travail_enqueter' then
											animsAction({ lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f" })
										end

										if data3.current.value == 'menuperso_actions_Travail_parleralaradio' then
											animsAction({ lib = "random@arrests", anim = "generic_radio_chatter" })
										end

										if data3.current.value == 'menuperso_actions_Travail_fairelacirculation' then
											animsActionScenario({anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT" })
										end

										if data3.current.value == 'menuperso_actions_Travail_jumelles' then
											animsActionScenario({anim = "WORLD_HUMAN_BINOCULARS" })
										end

										if data3.current.value == 'menuperso_actions_Travail_persoaterre' then
											animsActionScenario({anim = "CODE_HUMAN_MEDIC_KNEEL" })
										end

										if data3.current.value == 'menuperso_actions_Travail_parlerauclient' then
											animsAction({ lib = "oddjobs@taxi@driver", anim = "leanover_idle" })
										end

										if data3.current.value == 'menuperso_actions_Travail_factureclient' then
											animsAction({ lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger" })
										end

										if data3.current.value == 'menuperso_actions_Travail_lescourses' then
											animsAction({ lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper" })
										end

										if data3.current.value == 'menuperso_actions_Travail_shot' then
											animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
										end

										if data3.current.value == 'menuperso_actions_Travail_marteauabomberleverre' then
											animsActionScenario({anim = "WORLD_HUMAN_HAMMERING" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Festives' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Festives',
									{
										css =  'anim',
										title    = 'Festives',
										align    = 'top-left',
										elements = {
											{label = 'Danser',  value = 'menuperso_actions_Festives_danser'},
											{label = 'Jouer de la musique',     value = 'menuperso_actions_Festives_jouerdelamusique'},
											{label = 'Boire une biere',     value = 'menuperso_actions_Festives_boireunebiere'},
											{label = 'Air Guitar',  value = 'menuperso_actions_Festives_airguitar'},
											{label = 'Faire le Dj',  value = 'menuperso_actions_Festives_dj'},
											{label = 'Biere en musique',  value = 'menuperso_actions_Festives_bierenzik'},
											{label = 'Air shagging',  value = 'menuperso_actions_Festives_airshagging'},
											{label = 'Rock and roll',  value = 'menuperso_actions_Festives_rockandroll'},
											{label = 'Bourre sur place',  value = 'menuperso_actions_Festives_bourresurplace'},
											{label = 'Vomir en voiture',  value = 'menuperso_actions_Festives_vomirenvoiture'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Festives_danser' then
											animsAction({ lib = "amb@world_human_partying@female@partying_beer@base", anim = "base" })
										end

										if data3.current.value == 'menuperso_actions_Festives_jouerdelamusique' then
											animsActionScenario({anim = "WORLD_HUMAN_MUSICIAN" })
										end

										if data3.current.value == 'menuperso_actions_Festives_boireunebiere' then
											animsActionScenario({anim = "WORLD_HUMAN_PARTYING" })
										end

										if data3.current.value == 'menuperso_actions_Festives_airguitar' then
											animsAction({ lib = "anim@mp_player_intcelebrationfemale@air_guitar", anim = "air_guitar" })
										end

										if data3.current.value == 'menuperso_actions_Festives_dj' then
											animsAction({ lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj" })
										end

										if data3.current.value == 'menuperso_actions_Festives_bierenzik' then
											animsActionScenario({anim = "WORLD_HUMAN_PARTYING" })
										end

										if data3.current.value == 'menuperso_actions_Festives_airshagging' then
											animsAction({ lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging" })
										end

										if data3.current.value == 'menuperso_actions_Festives_rockandroll' then
											animsAction({ lib = "mp_player_int_upperrock", anim = "mp_player_int_rock" })
										end

										if data3.current.value == 'menuperso_actions_Festives_bourresurplace' then
											animsAction({ lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a" })
										end

										if data3.current.value == 'menuperso_actions_Festives_vomirenvoiture' then
											animsAction({ lib = "oddjobs@taxi@tie", anim = "vomit_outside" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Sportives' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Sportives',
									{
										css =  'anim',
										title    = 'Sportives',
										align    = 'top-left',
										elements = {
											{label = 'Montrer ses muscles',     value = 'menuperso_actions_Sportives_fairedesetirements'},
											{label = 'Faire des pompes',     value = 'menuperso_actions_Sportives_fairedespompes'},
											{label = 'Faire des abdos',     value = 'menuperso_actions_Sportives_fairedesabdos'},
											{label = 'Lever des poids',     value = 'menuperso_actions_Sportives_leverdespoids'},
											{label = 'Faire du jogging',     value = 'menuperso_actions_Sportives_fairedujogging'},
											{label = 'Faire du Yoga',     value = 'menuperso_actions_Sportives_faireduyoga'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Sportives_fairedesetirements' then
											animsActionScenario({ anim = "WORLD_HUMAN_MUSCLE_FLEX" })
										end

										if data3.current.value == 'menuperso_actions_Sportives_fairedespompes' then
											animsActionScenario({ anim = "WORLD_HUMAN_PUSH_UPS" })
										end

										if data3.current.value == 'menuperso_actions_Sportives_fairedesabdos' then
											animsActionScenario({anim = "WORLD_HUMAN_SIT_UPS" })
										end

										if data3.current.value == 'menuperso_actions_Sportives_leverdespoids' then
											animsActionScenario({anim = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS" })
										end

										if data3.current.value == 'menuperso_actions_Sportives_fairedujogging' then
											animsActionScenario({ anim = "WORLD_HUMAN_JOG_STANDING" })
										end

										if data3.current.value == 'menuperso_actions_Sportives_faireduyoga' then
											animsActionScenario({ anim = "WORLD_HUMAN_YOGA" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Others' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Others',
									{
										css =  'anim',
										title    = 'Diverses',
										align    = 'top-left',
										elements = {
											{label = 'Fumer une clope',     value = 'menuperso_actions_Others_fumeruneclope'},
											{label = 'S\'asseoir',     value = 'menuperso_actions_Others_sasseoir'},
											{label = 'S\'asseoir (par terre)',     value = 'menuperso_actions_Others_sasseoirparterre'},
											{label = 'S\'allonger (sur le ventre)',     value = 'menuperso_actions_Others_sallongersurleventre'},
											{label = 'S\'allonger (sur le dos)',     value = 'menuperso_actions_Others_sallongersurledos'},
											{label = 'S\'appuyer',     value = 'menuperso_actions_Others_attendre'},
											{label = 'Prendre un selfie',     value = 'menuperso_actions_Others_prendreunselfie'},
											{label = 'Prendre une photo',     value = 'menuperso_actions_Others_prendreunephoto'},
											{label = 'Regarder avec des jumelles',     value = 'menuperso_actions_Others_regarderauxjumelles'},
											{label = 'Faire la statue',     value = 'menuperso_actions_Others_fairelastatut'},
											{label = 'Position de fouille',     value = 'menuperso_actions_Others_positiondefouille'},
											{label = 'Se gratter les parties',     value = 'menuperso_actions_Others_segratterlesc'},
											{label = 'Boire un cafe',  value = 'menuperso_actions_Others_boireuncafe'},
											{label = 'Attendre',     value = 'menuperso_actions_Others_attendre'},
											{label = 'Nettoyer quelque chose',     value = 'menuperso_actions_Others_nettoyerquelquechose'},
											{label = 'Prendre un selfie',     value = 'menuperso_actions_Others_prendreunselfie'},
											{label = 'Faire la manche',     value = 'menuperso_actions_Others_manche'},
											{label = 'Attendre contre un mur',  value = 'menuperso_actions_Others_unmur'},
											{label = 'Preparer a?manger',  value = 'menuperso_actions_Others_mangerrrrrrr'},
											{label = 'Ecouter a?une porte',  value = 'menuperso_actions_Others_uneporte'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Others_boireuncafe' then
											animsAction({ lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a" })
										end

										if data3.current.value == 'menuperso_actions_Others_uneporte' then
											animsAction({ lib = "mini@safe_cracking", anim = "idle_base" })
										end

										if data3.current.value == 'menuperso_actions_Others_fumeruneclope' then
											animsActionScenario({ anim = "WORLD_HUMAN_SMOKING" })
										end

										if data3.current.value == 'menuperso_actions_Others_sasseoir' then
											animsAction({ lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle" })
										end

										if data3.current.value == 'menuperso_actions_Others_sasseoirparterre' then
											animsActionScenario({ anim = "WORLD_HUMAN_PICNIC" })
										end

										if data3.current.value == 'menuperso_actions_Others_sallongersurleventre' then
											animsActionScenario({ anim = "WORLD_HUMAN_SUNBATHE" })
										end

										if data3.current.value == 'menuperso_actions_Others_sallongersurledos' then
											animsActionScenario({ anim = "WORLD_HUMAN_SUNBATHE_BACK" })
										end

										if data3.current.value == 'menuperso_actions_Others_attendre' then
											animsActionScenario({ anim = "world_human_leaning" })
										end

										if data3.current.value == 'menuperso_actions_Others_prendreunselfie' then
											animsActionScenario({ anim = "world_human_tourist_mobile" })
										end

										if data3.current.value == 'menuperso_actions_Others_prendreunephoto' then
											animsActionScenario({ anim = "WORLD_HUMAN_MOBILE_FILM_SHOCKING" })
										end

										if data3.current.value == 'menuperso_actions_Others_regarderauxjumelles' then
											animsActionScenario({ anim = "WORLD_HUMAN_BINOCULARS" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairelastatut' then
											animsActionScenario({ anim = "WORLD_HUMAN_HUMAN_STATUE" })
										end

										if data3.current.value == 'menuperso_actions_Others_positiondefouille' then
											animsAction({ lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female" })
										end

										if data3.current.value == 'menuperso_actions_Others_segratterlesc' then
											animsAction({ lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" })
										end

										if data3.current.value == 'menuperso_actions_Others_attendre' then
											animsActionScenario({ anim = "world_human_leaning" })
										end

										if data3.current.value == 'menuperso_actions_Others_nettoyerquelquechose' then
											animsActionScenario({ anim = "world_human_maid_clean" })
										end

										if data3.current.value == 'menuperso_actions_Others_prendreunselfie' then
											animsActionScenario({ anim = "world_human_tourist_mobile" })
										end

										if data3.current.value == 'menuperso_actions_Others_manche' then
											animsActionScenario({ anim = "WORLD_HUMAN_BUM_FREEWAY" })
										end

										if data3.current.value == 'menuperso_actions_Others_unmur' then
											animsActionScenario({ anim = "world_human_leaning" })
										end

										if data3.current.value == 'menuperso_actions_Others_mangerrrrrrr' then
											animsActionScenario({ anim = "PROP_HUMAN_BBQ" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end
							
							if data2.current.value == 'menuperso_actions_pegi' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_pegi',
									{
										css =  'anim',
										title    = 'Pegi 18+',
										align    = 'top-left',
										elements = {
											{label = 'Racoller',     value = 'menuperso_actions_Others_racoller'},
											{label = 'Racoller 2',     value = 'menuperso_actions_Others_racoller2'},
											{label = 'Se faire sucer en voiture',     value = 'menuperso_actions_Others_sucer'},
											{label = 'Sucer une personne en voiture',     value = 'menuperso_actions_Others_sucerune'},
											{label = 'Faire l\'amour en voiture (homme)',     value = 'menuperso_actions_Others_homme'},
											{label = 'Se faire agrandir le trou dans la voiture',     value = 'menuperso_actions_Others_letrou'},
											{label = 'Se gratter les couilles',     value = 'menuperso_actions_Others_segratter'},
											{label = 'Faire du charme',     value = 'menuperso_actions_Others_charme'},
											{label = 'Pose Tchoin',     value = 'menuperso_actions_Others_tchoin'},
											{label = 'Montrer sa poitrine',     value = 'menuperso_actions_Others_poitrine'},
											{label = 'Strip-tease 1',     value = 'menuperso_actions_Others_strip'},
											{label = 'Strip-tease 2',     value = 'menuperso_actions_Others_tease'},
											{label = 'Strip-tease au sol',     value = 'menuperso_actions_Others_ausol'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Others_racoller' then
											animsActionScenario({ anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" })
										end

										if data3.current.value == 'menuperso_actions_Others_racoller2' then
											animsActionScenario({ anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" })
										end

										if data3.current.value == 'menuperso_actions_Others_sucer' then
											animsAction({ lib = "oddjobs@towing", anim = "m_blow_job_loop" })
										end

										if data3.current.value == 'menuperso_actions_Others_sucerune' then
											animsAction({ lib = "oddjobs@towing", anim = "f_blow_job_loop" })
										end

										if data3.current.value == 'menuperso_actions_Others_homme' then
											animsAction({ lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player" })
										end

										if data3.current.value == 'menuperso_actions_Others_letrou' then
											animsAction({ lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female" })
										end

										if data3.current.value == 'menuperso_actions_Others_segratterlesc' then
											animsAction({ lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" })
										end

										if data3.current.value == 'menuperso_actions_Others_charme' then
											animsAction({ lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02" })
										end

										if data3.current.value == 'menuperso_actions_Others_tchoin' then
											animsActionScenario({ anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" })
										end

										if data3.current.value == 'menuperso_actions_Others_poitrine' then
											animsAction({ lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b" })
										end

										if data3.current.value == 'menuperso_actions_Others_strip' then
											animsAction({ lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f" })
										end

										if data3.current.value == 'menuperso_actions_Others_tease' then
											animsAction({ lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2" })
										end

										if data3.current.value == 'menuperso_actions_Others_ausol' then
											animsAction({ lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3" })
										end


									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end
							


						end,
						function(data2, menu2)
							menu2.close()
						end
					)

				end
				
				if data.current.value == 'menuperso_gpsrapide' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_gpsrapide',
						{
							css =  'gps',
							title    = 'GPS',
							align    = 'top-left',
							elements = {
								{label = 'Comissariat',              value = 'menuperso_gpsrapide_comico'},
								{label = 'Hopital', value = 'menuperso_gpsrapide_hopital'},
								{label = 'Pole-Emploi',     value = 'menuperso_gpsrapide_poleemploi'},
								{label = 'Mecano',  value = 'menuperso_gpsrapide_mecano'},
								{label = 'Garage voiture',  value = 'menuperso_gpsrapide_garage'},
								--{label = 'Garage bateux',  value = 'menuperso_gpsrapide_dock'},
								--{label = 'Garage avion',  value = 'menuperso_gpsrapide_aircraft'},
								--{label = 'Smoke On The Water', value = 'menuperso_gpsrapide_weed'},
								--{label = 'Concessions avion',  value = 'menuperso_gpsrapide_concessionnaire3'},
								--{label = 'Concessions bateau',  value = 'menuperso_gpsrapide_concessionnaire2'},
								{label = 'Concessions voiture',  value = 'menuperso_gpsrapide_concessionnaire1'},
								{label = 'Vanilla Unicorn',  value = 'menuperso_gpsrapide_vanilla'},
								{label = 'Banque',  value = 'menuperso_gpsrapide_bank'},
								--{label = 'Agent immobilier',  value = 'menuperso_gpsrapide_state'},
								{label = 'Epicerie',  value = 'menuperso_gpsrapide_shop'}
								
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_gpsrapide_poleemploi' then
								x, y, z = Config.poleemploi.x, Config.poleemploi.y, Config.poleemploi.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_comico' then
								x, y, z = Config.comico.x, Config.comico.y, Config.comico.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_hopital' then
								x, y, z = Config.hopital.x, Config.hopital.y, Config.hopital.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
							if data2.current.value == 'menuperso_gpsrapide_weed' then
								x, y, z = Config.weed.x, Config.weed.y, Config.weed.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
							if data2.current.value == 'menuperso_gpsrapide_concessionnaire3' then
								x, y, z = Config.concessionnaire3.x, Config.concessionnaire3.y, Config.concessionnaire3.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
							if data2.current.value == 'menuperso_gpsrapide_concessionnaire2' then
								x, y, z = Config.concessionnaire2.x, Config.concessionnaire2.y, Config.concessionnaire2.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_concessionnaire1' then
								x, y, z = Config.concessionnaire1.x, Config.concessionnaire1.y, Config.concessionnaire1.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
							if data2.current.value == 'menuperso_gpsrapide_garage' then
								x, y, z = Config.garage.x, Config.garage.y, Config.garage.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
							if data2.current.value == 'menuperso_gpsrapide_dock' then
								x, y, z = Config.dock.x, Config.dock.y, Config.dock.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
							if data2.current.value == 'menuperso_gpsrapide_aircraft' then
								x, y, z = Config.aircraft.x, Config.aircraft.y, Config.aircraft.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
							if data2.current.value == 'menuperso_gpsrapide_mecano' then
								x, y, z = Config.mecano.x, Config.mecano.y, Config.mecano.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_vanilla' then
								x, y, z = Config.vanilla.x, Config.vanilla.y, Config.vanilla.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_bank' then
								x, y, z = Config.bank.x, Config.bank.y, Config.bank.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end	

							if data2.current.value == 'menuperso_gpsrapide_shop' then
								x, y, z = Config.shop.x, Config.shop.y, Config.shop.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
							if data2.current.value == 'menuperso_gpsrapide_state' then
								x, y, z = Config.state.x, Config.state.y, Config.state.z
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajoutée au GPS !")
							end
							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)

				end
				
				if data.current.value == 'menuperso_grade' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_grade',
						{
							css =  'entreprise',
							title    = 'Gestion d\'entreprise',
							align    = 'top-left',
							elements = {
								{label = 'Recruter',     value = 'menuperso_grade_recruter'},
								{label = 'Virer',              value = 'menuperso_grade_virer'},
								{label = 'Promouvoir', value = 'menuperso_grade_promouvoir'},
								{label = 'Destituer',  value = 'menuperso_grade_destituer'},
								{label = 'Solde du compte de la societe',  value = 'menuperso_grade_argent'}
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_grade_recruter' then
								if PlayerData.job.grade_name == 'boss' then
										local job =  PlayerData.job.name
										local grade = 0
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Aucun joueur à proximité")
									else
										TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(closestPlayer), job,grade)
									end

								else
									Notify("Vous n'êtes pas ~r~PATRON~w~.")

								end
								
							end

							if data2.current.value == 'menuperso_grade_virer' then
								if PlayerData.job.grade_name == 'boss' then
										local job =  PlayerData.job.name
										local grade = 0
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Aucun joueur à proximité")
									else
										TriggerServerEvent('NB:virerplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Vous n'avez pas les ~r~droits~w~.")

								end
								
							end

							if data2.current.value == 'menuperso_grade_promouvoir' then

								if PlayerData.job.grade_name == 'boss' then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Aucun joueur à proximité")
									else
										TriggerServerEvent('NB:promouvoirplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Vous n'avez pas les ~r~droits~w~.")

								end
								
								
							end

							if data2.current.value == 'menuperso_grade_destituer' then

								if PlayerData.job.grade_name == 'boss' then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Aucun joueur à proximité")
									else
										TriggerServerEvent('NB:destituerplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Vous n'avez pas les ~r~droits~w~.")

								end
								
								
							end
							if data2.current.value == 'menuperso_grade_argent' then

								if PlayerData.job.grade_name == 'boss' then
									Notify("~r~Ceci sera bientot disponible, contactez Jack Brook pour plus d'informations !")
										
								else
									Notify("Vous n'avez pas les ~r~droits~w~.")

								end
								
								
							end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end
				
				if data.current.value == 'menuperso_config' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_config',
						{
							css =  'meconcernant',
							title    = 'Configuration',
							align    = 'top-left',
							elements = {
								{label = '--- HUD ---',     value = 'menuperso_config_hud'},
								{label = 'Ouvrir le HUD',     value = 'menuperso_config_ouvrir'},
								{label = 'Fermer le HUD',     value = 'menuperso_config_fermer'},
								{label = '--- COMPTEUR VITESSE ---',     value = 'menuperso_config_n'},
								{label = 'N°1 (+ jauge essence)',     value = 'menuperso_config_n1'},
								{label = 'N°2',     value = 'menuperso_config_n2'},
								{label = 'N°3',     value = 'menuperso_config_n3'}
							},
						},
						function(data2, menu2)
							
							if data2.current.value == 'menuperso_config_hud' then							 						    
							end

						    if data2.current.value == 'menuperso_config_ouvrir' then							 
								TriggerEvent('ui:toggle')  --TriggerEvent('ui:toggle', source,true)
								Notify("~r~Le HUD est ouvert !")						    
							end
							
							if data2.current.value == 'menuperso_config_fermer' then							 
								TriggerEvent('ui:toggle') --TriggerEvent('ui:toggle', source,false)
								Notify("~r~Le HUD est fermé !")						    
							end
							
							if data2.current.value == 'menuperso_config_n1' then
								exports.speedometer:changeSkin('default')
							end

							if data2.current.value == 'menuperso_config_n2' then
								exports.speedometer:changeSkin('id6')
							end

							if data2.current.value == 'menuperso_config_n3' then
								exports.speedometer:changeSkin('id7')
							end
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end
				
				if data.current.value == 'menuperso_credits' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_credits',
						{
							css =  'Modo',
							title    = 'Crédits',
							align    = 'top-left',
							elements = {
								{label = 'Developpeur : Jack Brook',     value = 'menuperso_credits_dev'},
								{label = 'Admin(s) : Xame | Eliott.',              value = 'menuperso_credits_admin'},
								{label = 'Modo(s) : Flav | Hamid | Salva',              value = 'menuperso_credits_mod'}
							},
						},
						function(data2, menu2)
						
						    if data2.current.value == 'menuperso_credits_dev' then
							    Notify("~r~Développeur : ~n~Jack Brook")
                                Notify("Merci de jouer sur ~p~NovaLife ~p~~h~RP !")
                            end

							if data2.current.value == 'menuperso_credits_admin' then
							    Notify("~b~Admin(s) : ~n~Xame ~n~Eliott.")
								Notify("Merci de jouer sur ~p~~h~NovaLife ~p~~h~RP !")
							end

							if data2.current.value == 'menuperso_credits_mod' then
							    Notify("~b~Modérateur(s) : ~n~Flav ~n~Tony Hamid ~n~Fabien Salva")
								Notify("Merci de jouer sur ~p~~h~NovaLife ~p~~h~RP !")
							end
							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end
				if data.current.value == 'menuperso_test' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_test',
						{
							css =  'meconcernant',
							title    = 'Test',
							align    = 'top-left',
							elements = {
								{label = 'Bander la victime',     value = 'menuperso_test_blind'}
							},
						},
						function(data2, menu2)
						
						    if data2.current.value == 'menuperso_test_blind' then
								local player, distance = ESX.Game.GetClosestPlayer()

								if distance ~= -1 and distance <= 3.0 then
									TriggerServerEvent('jsfour-blindfold', player)
								 else
									ESX.ShowNotification('Tu n\'a pas de Sacs')
									ESX.ShowNotification('Il y a personne autour de toi !')
								end
                            end							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end
				
				
			end,
			function(data, menu)
				menu.close()
			end
		)
		
	end)
end

---------------------------------------------------------------------------Vehicule Menu

function OpenVehiculeMenu()
	
	ESX.UI.Menu.CloseAll()
		
	local elements = {}
	
	if vehiculeON then
		table.insert(elements, {label = 'Couper le moteur',			value = 'menuperso_vehicule_MoteurOff'})
	else
		table.insert(elements, {label = 'Démarrer le moteur',		value = 'menuperso_vehicule_MoteurOn'})
	end
	
	if porteAvantGaucheOuverte then
		table.insert(elements, {label = 'Fermer la porte gauche',	value = 'menuperso_vehicule_fermerportes_fermerportegauche'})
	else
		table.insert(elements, {label = 'Ouvrir la porte gauche',		value = 'menuperso_vehicule_ouvrirportes_ouvrirportegauche'})
	end
	
	if porteAvantDroiteOuverte then
		table.insert(elements, {label = 'Fermer la porte droite',	value = 'menuperso_vehicule_fermerportes_fermerportedroite'})
	else
		table.insert(elements, {label = 'Ouvrir la porte droite',		value = 'menuperso_vehicule_ouvrirportes_ouvrirportedroite'})
	end
	
	if porteArriereGaucheOuverte then
		table.insert(elements, {label = 'Fermer la porte arrière gauche',	value = 'menuperso_vehicule_fermerportes_fermerportearrieregauche'})
	else
		table.insert(elements, {label = 'Ouvrir la porte arrière gauche',		value = 'menuperso_vehicule_ouvrirportes_ouvrirportearrieregauche'})
	end
	
	if porteArriereDroiteOuverte then
		table.insert(elements, {label = 'Fermer la porte arrière droite',	value = 'menuperso_vehicule_fermerportes_fermerportearrieredroite'})
	else
		table.insert(elements, {label = 'Ouvrir la porte arrière droite',		value = 'menuperso_vehicule_ouvrirportes_ouvrirportearrieredroite'})
	end
	
	if porteCapotOuvert then
		table.insert(elements, {label = 'Fermer le capot',	value = 'menuperso_vehicule_fermerportes_fermercapot'})
	else
		table.insert(elements, {label = 'Ouvrir le capot',		value = 'menuperso_vehicule_ouvrirportes_ouvrircapot'})
	end
	
	if porteCoffreOuvert then
		table.insert(elements, {label = 'Fermer le coffre',	value = 'menuperso_vehicule_fermerportes_fermercoffre'})
	else
		table.insert(elements, {label = 'Ouvrir le coffre',		value = 'menuperso_vehicule_ouvrirportes_ouvrircoffre'})
	end
	
	if porteAutre1Ouvert then
		table.insert(elements, {label = 'Fermer autre 1',	value = 'menuperso_vehicule_fermerportes_fermerAutre1'})
	else
		table.insert(elements, {label = 'Ouvrir autre 1',		value = 'menuperso_vehicule_ouvrirportes_ouvrirAutre1'})
	end
	
	if porteAutre2Ouvert then
		table.insert(elements, {label = 'Fermer autre 2',	value = 'menuperso_vehicule_fermerportes_fermerAutre2'})
	else
		table.insert(elements, {label = 'Ouvrir autre 2',		value = 'menuperso_vehicule_ouvrirportes_ouvrirAutre2'})
	end
	
	if porteToutOuvert then
		table.insert(elements, {label = 'Tout fermer',	value = 'menuperso_vehicule_fermerportes_fermerTout'})
	else
		table.insert(elements, {label = 'Tout ouvrir',		value = 'menuperso_vehicule_ouvrirportes_ouvrirTout'})
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menuperso_vehicule',
		{
			css =  'vehicle',
			img    = 'menu_vehicule',
			-- title    = 'Véhicule',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
--------------------- GESTION MOTEUR
			if data.current.value == 'menuperso_vehicule_MoteurOn' then
				vehiculeON = true
				SetVehicleEngineOn(GetVehiclePedIsIn( GetPlayerPed(-1), false ), true, false, true)
				SetVehicleUndriveable(GetVehiclePedIsIn( GetPlayerPed(-1), false ), false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_MoteurOff' then
				vehiculeON = false
				SetVehicleEngineOn(GetVehiclePedIsIn( GetPlayerPed(-1), false ), false, false, true)
				SetVehicleUndriveable(GetVehiclePedIsIn( GetPlayerPed(-1), false ), true)
				OpenVehiculeMenu()
			end
--------------------- OUVRIR LES PORTES
			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportegauche' then
				porteAvantGaucheOuverte = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 0, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportedroite' then
				porteAvantDroiteOuverte = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 1, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportearrieregauche' then
				porteArriereGaucheOuverte = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 2, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportearrieredroite' then
				porteArriereDroiteOuverte = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 3, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrircapot' then
				porteCapotOuvert = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 4, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrircoffre' then
				porteCoffreOuvert = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 5, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirAutre1' then
				porteAutre1Ouvert = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 6, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirAutre2' then
				porteAutre2Ouvert = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 7, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirTout' then
				porteAvantGaucheOuverte = true
				porteAvantDroiteOuverte = true
				porteArriereGaucheOuverte = true
				porteArriereDroiteOuverte = true
				porteCapotOuvert = true
				porteCoffreOuvert = true
				porteAutre1Ouvert = true
				porteAutre2Ouvert = true
				porteToutOuvert = true
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 0, false, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 1, false, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 2, false, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 3, false, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 4, false, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 5, false, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 6, false, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 7, false, false)
				OpenVehiculeMenu()
			end
--------------------- FERMER LES PORTES
			if data.current.value == 'menuperso_vehicule_fermerportes_fermerportegauche' then
				porteAvantGaucheOuverte = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 0, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_fermerportes_fermerportedroite' then
				porteAvantDroiteOuverte = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 1, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_fermerportes_fermerportearrieregauche' then
				porteArriereGaucheOuverte = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 2, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_fermerportes_fermerportearrieredroite' then
				porteArriereDroiteOuverte = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 3, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_fermerportes_fermercapot' then
				porteCapotOuvert = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 4, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_fermerportes_fermercoffre' then
				porteCoffreOuvert = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 5, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_fermerportes_fermerAutre1' then
				porteAutre1Ouvert = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 6, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_fermerportes_fermerAutre2' then
				porteAutre2Ouvert = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 7, false, false)
				OpenVehiculeMenu()
			end

			if data.current.value == 'menuperso_vehicule_fermerportes_fermerTout' then
				porteAvantGaucheOuverte = false
				porteAvantDroiteOuverte = false
				porteArriereGaucheOuverte = false
				porteArriereDroiteOuverte = false
				porteCapotOuvert = false
				porteCoffreOuvert = false
				porteAutre1Ouvert = false
				porteAutre2Ouvert = false
				porteToutOuvert = false
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 0, false, false)
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 1, false, false)
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 2, false, false)
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 3, false, false)
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 4, false, false)
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 5, false, false)
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 6, false, false)
				SetVehicleDoorShut(GetVehiclePedIsIn( GetPlayerPed(-1), false ), 7, false, false)
				OpenVehiculeMenu()
			end
			
		end,
		function(data, menu)
			menu.close()
		end
	)
end

---------------------------------------------------------------------------Modération

-- GOTO JOUEUR
function admin_tp_toplayer()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez l'ID du joueur...")
	inputgoto = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputgoto == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputgoto = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputgoto = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputgoto = 0
			end
		end
		if inputgoto == 2 then
			local gotoply = GetOnscreenKeyboardResult()
			local playerPed = GetPlayerPed(-1)
			local teleportPed = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(gotoply))))
			SetEntityCoords(playerPed, teleportPed)
			
			inputgoto = 0
		end
	end
end)
-- FIN GOTO JOUEUR

-- TP UN JOUEUR A MOI
function admin_tp_playertome()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez l'ID du joueur...")
	inputteleport = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputteleport == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputteleport = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				inputteleport = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputteleport = 0
			end
		end
		if inputteleport == 2 then
			local teleportply = GetOnscreenKeyboardResult()
			local playerPed = GetPlayerFromServerId(tonumber(teleportply))
			local teleportPed = GetEntityCoords(GetPlayerPed(-1))
			SetEntityCoords(playerPed, teleportPed)
			
			inputteleport = 0
		end
	end
end)
-- FIN TP UN JOUEUR A MOI

-- TP A POSITION
function admin_tp_pos()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez la position...")
	inputpos = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputpos == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputpos = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputpos = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputpos = 0
			end
		end
		if inputpos == 2 then
			local pos = GetOnscreenKeyboardResult() -- GetOnscreenKeyboardResult RECUPERE LA POSITION RENTRER PAR LE JOUEUR
			local _,_,x,y,z = string.find( pos or "0,0,0", "([%d%.]+),([%d%.]+),([%d%.]+)" )
			
			--SetEntityCoords(GetPlayerPed(-1), x, y, z)
		    SetEntityCoords(GetPlayerPed(-1), x+0.0001, y+0.0001, z+0.0001) -- TP LE JOUEUR A LA POSITION
			inputpos = 0
		end
	end
end)
-- FIN TP A POSITION

-- FONCTION NOCLIP 
local noclip = false
local noclip_speed = 1.0

function admin_no_clip()
  noclip = not noclip
  local ped = GetPlayerPed(-1)
  if noclip then -- activé
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, false, false)
	Notify("Noclip ~g~activé")
  else -- désactivé
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true, false)
	Notify("Noclip ~r~désactivé")
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
    Citizen.Wait(0)
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
-- FIN NOCLIP

-- GOD MODE
function admin_godmode()
  godmode = not godmode
  local ped = GetPlayerPed(-1)
  
  if godmode then -- activé
		SetEntityInvincible(ped, true)
		Notify("Mode invincible ~g~activé")
	else
		SetEntityInvincible(ped, false)
		Notify("Mode invincible ~r~désactivé")
  end
end
-- FIN GOD MODE

-- INVISIBLE
function admin_mode_fantome()
  invisible = not invisible
  local ped = GetPlayerPed(-1)
  
  if invisible then -- activé
		SetEntityVisible(ped, false, false)
		Notify("Mode fantôme : activé")
	else
		SetEntityVisible(ped, true, false)
		Notify("Mode fantôme : désactivé")
  end
end
-- FIN INVISIBLE

-- Réparer vehicule
function admin_vehicle_repair()

    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsUsing(ped)
	
		SetVehicleFixed(car)
		SetVehicleDirtLevel(car, 0.0)

end
-- FIN Réparer vehicule

-- Spawn vehicule
function admin_vehicle_spawn()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez le nom du véhicule...")
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
					Notify("Véhicule livré, bonne route")
				end)
		
        inputvehicle = 0
		end
	end
end)
-- FIN Spawn vehicule

-- flipVehicle
function admin_vehicle_flip()

    local player = GetPlayerPed(-1)
    posdepmenu = GetEntityCoords(player)
    carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
	if carTargetDep ~= nil then
			platecarTargetDep = GetVehicleNumberPlateText(carTargetDep)
	end
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    playerCoords = playerCoords + vector3(0, 2, 0)
	
	SetEntityCoords(carTargetDep, playerCoords)
	
	Notify("Voiture retourné")

end
-- FIN flipVehicle

-- GIVE DE L'ARGENT
function admin_give_money()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez le montant à vous octroyer...")
	inputmoney = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
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
			
			TriggerServerEvent('AdminMenu:giveCash', money)
			inputmoney = 0
		end
	end
end)
-- FIN GIVE DE L'ARGENT

-- GIVE DE L'ARGENT EN BANQUE
function admin_give_bank()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez le montant à vous octroyer...")
	inputmoneybank = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputmoneybank == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputmoneybank = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoneybank = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoneybank = 0
			end
		end
		if inputmoneybank == 2 then
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('AdminMenu:giveBank', money)
			inputmoneybank = 0
		end
	end
end)
-- FIN GIVE DE L'ARGENT EN BANQUE

-- GIVE DE L'ARGENT SALE
function admin_give_dirty()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez le montant à vous octroyer...")
	inputmoneydirty = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputmoneydirty == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputmoneydirty = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoneydirty = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoneydirty = 0
			end
		end
		if inputmoneydirty == 2 then
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('AdminMenu:giveDirtyMoney', money)
			inputmoneydirty = 0
		end
	end
end)
-- FIN GIVE DE L'ARGENT SALE

-- Afficher Coord
function modo_showcoord()
	if showcoord then
		showcoord = false
	else
		showcoord = true
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
		if showcoord then
			local playerPos = GetEntityCoords(GetPlayerPed(-1))
			local playerHeading = GetEntityHeading(GetPlayerPed(-1))
			Text("~r~X~s~: " ..playerPos.x.." ~b~Y~s~: " ..playerPos.y.." ~g~Z~s~: " ..playerPos.z.." ~y~Angle~s~: " ..playerHeading.."")
		end
		
	end
end)
-- FIN Afficher Coord

-- Afficher Nom
function modo_showname()
	if showname then
		showname = false
	else
		Notify("Ouvrir/Fermer le menu pause pour afficher les noms")
		showname = true
	end
end

Citizen.CreateThread(function()
	while true do
		Wait( 1 )
		if showname then
			for id = 0, 200 do
				if NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
					ped = GetPlayerPed( id )
					blip = GetBlipFromEntity( ped )
					headId = Citizen.InvokeNative( 0xBFEFE3321A3F5015, ped, (GetPlayerServerId( id )..' - '..GetPlayerName( id )), false, false, "", false )
				end
			end
		else
			for id = 0, 200 do
				if NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
					ped = GetPlayerPed( id )
					blip = GetBlipFromEntity( ped )
					headId = Citizen.InvokeNative( 0xBFEFE3321A3F5015, ped, (' '), false, false, "", false )
				end
			end
		end
	end
end)
-- FIN Afficher Nom

-- TP MARCKER
function admin_tp_marcker()
	
	ESX.TriggerServerCallback('Brook:getUsergroup', function(group)
		playergroup = group
		
		if playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'owner' then
			local playerPed = GetPlayerPed(-1)
			local WaypointHandle = GetFirstBlipInfoId(8)
			if DoesBlipExist(WaypointHandle) then
				local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
				--SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, coord.z, false, false, false, true)
				SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
				Notify("Téléporté sur le marqueur !")
			else
				Notify("Pas de marqueur !")
			end
		end
		
	end)
end
-- FIN TP MARCKER

-- HEAL JOUEUR
function admin_heal_player()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez l'ID du joueur...")
	inputheal = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputheal == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputheal = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				inputheal = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputheal = 0
			end
		end
		if inputheal == 2 then
		local healply = GetOnscreenKeyboardResult()
		TriggerServerEvent('esx_ambulancejob:revive', healply)
		
        inputheal = 0
		end
	end
end)
-- FIN HEAL JOUEUR

-- SPEC JOUEUR
function admin_spec_player()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez l'ID du joueur...")
	inputspec = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputspec == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputspec = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputspec = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputspec = 0
			end
		end
		if inputspec == 2 then
		local target = GetOnscreenKeyboardResult()
		
		TriggerEvent('es_camera:spectate', source, target)
		
        inputspec = 0
		end
	end
end)
-- FIN SPEC JOUEUR

---------------------------------------------------------------------------Me concernant

function openAnimal()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuAnimal')
end

function openInventaire()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuInventaire')
end

function openFacture()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuFactures')
end

function OpenAccessoryMenu()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:OpenMenuAccessory')
end

---------------------------------------------------------------------------Actions


local playAnim = false
local dataAnim = {}

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


function animsActionScenario(animObj)
	if (IsInVehicle()) then
		local source = GetPlayerServerId();
		ESX.ShowNotification("Sortez de votre vÃ©hicule pour faire cela !")
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

-- Verifie si le joueurs est dans un vehicule ou pas
function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function changer_skin()
	TriggerEvent('esx_skin:openSaveableMenu', source)
end

function save_skin()
	TriggerEvent('esx_skin:requestSaveSkin', source)
end

---------------------------------------------------------------------------------------------------------
--NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('NB:goTpMarcker')
AddEventHandler('NB:goTpMarcker', function()
	admin_tp_marcker()
end)

RegisterNetEvent('NB:openMenuPersonnel')
AddEventHandler('NB:openMenuPersonnel', function()
	OpenPersonnelMenu()
end)
