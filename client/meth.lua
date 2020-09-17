---------------------------------------
--     ESX_DRUGLABS by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

-- OBJECTS - DO NOT TOUCH
liquidMeth = liquidMeth or 0.0
processedMeth = processedMeth or 0.0
rawMeth = rawMeth or 0.0
packagedMeth = packagedMeth or 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local playerPed = PlayerPedId()
        local playerPosition = GetEntityCoords(PlayerPedId())

        if hasMethKey then
            -- MAIN METH TELEPORTER
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.teleporters.enter.x, Config.Locations.meth.teleporters.enter.y, Config.Locations.meth.teleporters.enter.z, true) < 5) then
                DrawMarker(2, Config.Locations.meth.teleporters.enter.x, Config.Locations.meth.teleporters.enter.y, Config.Locations.meth.teleporters.enter.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.teleporters.enter.x, Config.Locations.meth.teleporters.enter.y, Config.Locations.meth.teleporters.enter.z, true) < 3.5) then
                    DrawText3D(Config.Locations.meth.teleporters.enter.x, Config.Locations.meth.teleporters.enter.y, Config.Locations.meth.teleporters.enter.z+0.15, '~g~E~w~ - Enter')
                    if IsControlJustReleased(0, 38) then
                        teleportToMethLab()
                    end
                end
            end

            -- MAIN METH EXIT TELEPORTER
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.teleporters.exit.x, Config.Locations.meth.teleporters.exit.y, Config.Locations.meth.teleporters.exit.z, true) < 5) then
                DrawMarker(2, Config.Locations.meth.teleporters.exit.x, Config.Locations.meth.teleporters.exit.y, Config.Locations.meth.teleporters.exit.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.teleporters.exit.x, Config.Locations.meth.teleporters.exit.y, Config.Locations.meth.teleporters.exit.z, true) < 3.5) then
                    DrawText3D(Config.Locations.meth.teleporters.exit.x, Config.Locations.meth.teleporters.exit.y, Config.Locations.meth.teleporters.exit.z+0.15, '~g~E~w~ - Leave')
                    if IsControlJustReleased(0, 38) then
                        teleportOutOfMethLab()
                    end
                end
            end

            -- METH PREPARING
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.filling.x, Config.Locations.meth.process.filling.y, Config.Locations.meth.process.filling.z, true) < 12) then
                DrawMarker(2, Config.Locations.meth.process.filling.x, Config.Locations.meth.process.filling.y, Config.Locations.meth.process.filling.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.filling.x, Config.Locations.meth.process.filling.y, Config.Locations.meth.process.filling.z, true) < 2.5) then
                    DrawText3D(Config.Locations.meth.process.filling.x, Config.Locations.meth.process.filling.y, Config.Locations.meth.process.filling.z+0.15, '~g~E~w~ - Fill tank')
                    if IsControlJustReleased(0, 38) then
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        exports['progressBars']:startUI(Config.WaitingTime, "Filling tank...")
                        Citizen.Wait(Config.WaitingTime)
                        liquidMeth = liquidMeth + 0.5
                        ESX.ShowNotification('You filled the tank with 0.5 liters.')
                        ClearPedTasksImmediately(playerPed)
                    end
                end
            end

            -- METH COOKING
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.producing.x, Config.Locations.meth.process.producing.y, Config.Locations.meth.process.producing.z, true) < 12) then
                DrawMarker(2, Config.Locations.meth.process.producing.x, Config.Locations.meth.process.producing.y, Config.Locations.meth.process.producing.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.producing.x, Config.Locations.meth.process.producing.y, Config.Locations.meth.process.producing.z, true) < 1.5) then
                    DrawText3D(Config.Locations.meth.process.producing.x, Config.Locations.meth.process.producing.y, Config.Locations.meth.process.producing.z+0.25, '~g~E~w~ - Produce')
                    DrawText3D(Config.Locations.meth.process.producing.x, Config.Locations.meth.process.producing.y, Config.Locations.meth.process.producing.z+0.05, 'Tank: ~y~' .. liquidMeth .. '~w~ liters')
                    if IsControlJustReleased(0, 38) then
                        if liquidMeth >= 1 then
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            exports['progressBars']:startUI(Config.WaitingTime, "Producing...")
                            Citizen.Wait(Config.WaitingTime)
                            processedMeth = processedMeth + 0.5
                            liquidMeth = liquidMeth - 1
                            ClearPedTasksImmediately(playerPed)
                        else
                            ESX.ShowNotification('The tank seems to be empty.')
                        end
                    end
                end
            end

            -- METH PROCESSING
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.producing2.x, Config.Locations.meth.process.producing2.y, Config.Locations.meth.process.producing2.z, true) < 12) then
                DrawMarker(2, Config.Locations.meth.process.producing2.x, Config.Locations.meth.process.producing2.y, Config.Locations.meth.process.producing2.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.producing2.x, Config.Locations.meth.process.producing2.y, Config.Locations.meth.process.producing2.z, true) < 2.5) then
                    DrawText3D(Config.Locations.meth.process.producing2.x, Config.Locations.meth.process.producing2.y, Config.Locations.meth.process.producing2.z+0.25, '~g~E~w~ - Process')
                    DrawText3D(Config.Locations.meth.process.producing2.x, Config.Locations.meth.process.producing2.y, Config.Locations.meth.process.producing2.z+0.05, 'Liquid meth: ~y~' .. processedMeth .. '~w~ liters')
                    if IsControlJustReleased(0, 38) then
                        if processedMeth >= 0.5 then
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            exports['progressBars']:startUI(Config.WaitingTime, "Processing...")
                            Citizen.Wait(Config.WaitingTime)
                            rawMeth = rawMeth + 0.5
                            processedMeth = processedMeth - 0.5
                            ESX.ShowNotification('You processed 0.5kg of meth.')
                            ClearPedTasksImmediately(playerPed)
                        else
                            ESX.ShowNotification('There is not enough liquid meth.')
                        end
                    end
                end
            end

            -- METH PACKAGING
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.packaging.x, Config.Locations.meth.process.packaging.y, Config.Locations.meth.process.packaging.z, true) < 20) then
                DrawMarker(2, Config.Locations.meth.process.packaging.x, Config.Locations.meth.process.packaging.y, Config.Locations.meth.process.packaging.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.packaging.x, Config.Locations.meth.process.packaging.y, Config.Locations.meth.process.packaging.z, true) < 2.5) then
                    DrawText3D(Config.Locations.meth.process.packaging.x, Config.Locations.meth.process.packaging.y, Config.Locations.meth.process.packaging.z+0.25, '~g~E~w~ - Package')
                    DrawText3D(Config.Locations.meth.process.packaging.x, Config.Locations.meth.process.packaging.y, Config.Locations.meth.process.packaging.z+0.05, 'Raw meth: ~y~' .. rawMeth .. '~w~ kg')
                    if IsControlJustReleased(0, 38) then
                        if rawMeth >= 1 then
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            exports['progressBars']:startUI(Config.WaitingTime, "Packaging...")
                            Citizen.Wait(Config.WaitingTime)
                            packagedMeth = packagedMeth + 1
                            rawMeth = rawMeth - 1
                            ClearPedTasksImmediately(playerPed)
                            TriggerServerEvent('esx_druglabs:server:addMethStorage', packagedMeth)
                        else
                            ESX.ShowNotification('There is not enough raw meth.')
                        end
                    end
                end
            end

            -- METH STORAGE
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.storage.x, Config.Locations.meth.process.storage.y, Config.Locations.meth.process.storage.z, true) < 5) then
                DrawMarker(2, Config.Locations.meth.process.storage.x, Config.Locations.meth.process.storage.y, Config.Locations.meth.process.storage.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.meth.process.storage.x, Config.Locations.meth.process.storage.y, Config.Locations.meth.process.storage.z, true) < 2.5) then
                    ESX.TriggerServerCallback('esx_druglabs:server:checkMethStorage', function(serverValue)
                        DrawText3D(Config.Locations.meth.process.storage.x, Config.Locations.meth.process.storage.y, Config.Locations.meth.process.storage.z+0.25, '~g~E~w~ - Clear storage')
                        DrawText3D(Config.Locations.meth.process.storage.x, Config.Locations.meth.process.storage.y, Config.Locations.meth.process.storage.z+0.05, 'Storage: ~y~' .. serverValue .. '~w~ bags')
                        if IsControlJustReleased(0, 38) then
                            if serverValue > 0 then
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                                exports['progressBars']:startUI(Config.WaitingTime, "Clearing storage...")
                                Citizen.Wait(Config.WaitingTime)
                                TriggerServerEvent('esx_druglabs:server:clearMethStorage', serverValue)
                                packagedMeth = packagedMeth - packagedMeth
                                ClearPedTasksImmediately(playerPed)
                            else
                                ESX.ShowNotification('Storage seems to be empty.')
                            end
                        end
                    end)
                end
            end
        end
    end
end)

function teleportOutOfMethLab()
    local entity = PlayerPedId()
    
    DoScreenFadeOut(200)
    Citizen.Wait(200)
    SetEntityCoords(entity, Config.Locations.meth.teleporters.enter.x, Config.Locations.meth.teleporters.enter.y, Config.Locations.meth.teleporters.enter.z, 0, 0, 0, false)

    PlaceObjectOnGroundProperly(entity)
    Citizen.Wait(1500)
    DoScreenFadeIn(200)
end

function teleportToMethLab()
    local entity = PlayerPedId()
    
    DoScreenFadeOut(200)
    Citizen.Wait(200)
    SetEntityCoords(entity, Config.Locations.meth.teleporters.exit.x, Config.Locations.meth.teleporters.exit.y, Config.Locations.meth.teleporters.exit.z, 0, 0, 0, false)

    PlaceObjectOnGroundProperly(entity)
    Citizen.Wait(1500)
    DoScreenFadeIn(200)
end
