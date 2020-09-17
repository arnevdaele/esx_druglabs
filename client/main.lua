---------------------------------------
--     ESX_DRUGLABS by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

ESX = nil
isLoggedIn = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    isLoggedIn = true
end)

hasCokeKey = false
hasMethKey = false

-- CHECK KEYS
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if ESX ~= nil and isLoggedIn then
            ESX.TriggerServerCallback('esx_druglabs:server:hasMethKey', function(cb)
                if cb then
                    hasMethKey = true
                else
                    hasMethKey = false
                end
            end)
            ESX.TriggerServerCallback('esx_druglabs:server:hasCokeKey', function(cb)
                if cb then
                    hasCokeKey = true
                else
                    hasCokeKey = false
                end
            end)
        end
        Citizen.Wait(5000)
    end
end)

-- CREATE METH LAB IPL
Citizen.CreateThread(function()
    BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()

    BikerMethLab.Style.Set(BikerMethLab.Style.basic)
    BikerMethLab.Security.Set(BikerMethLab.Security.upgrade)
    BikerMethLab.Details.Enable(BikerMethLab.Details.production, true)

    RefreshInterior(BikerMethLab.interiorId)
end)

-- CREATE COKELAB IPL
Citizen.CreateThread(function()
    BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()

    BikerCocaine.Style.Set(BikerCocaine.Style.upgrade)
    BikerCocaine.Security.Set(BikerCocaine.Security.upgrade)
    BikerCocaine.Details.Enable({BikerCocaine.Details.cokeBasic1, BikerCocaine.Details.cokeBasic2, BikerCocaine.Details.cokeBasic3, BikerCocaine.Details.cokeUpgrade1, BikerCocaine.Details.cokeUpgrade2}, true)

    RefreshInterior(BikerCocaine.interiorId)
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
