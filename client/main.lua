---------------------------------------
--     ESX_DRUGLABS by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

Keys = {
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
