---------------------------------------
--     ESX_DRUGLABS by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

-- OBJECTS - DO NOT TOUCH
producedCoke = producedCoke or 0
cuttedCoke = cuttedCoke or 0
packagedCoke = packagedCoke or 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local playerPed = PlayerPedId()
        local playerPosition = GetEntityCoords(playerPed)

        if hasCokeKey then
            -- MAIN METH TELEPORTER
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.teleporters.enter.x, Config.Locations.coke.teleporters.enter.y, Config.Locations.coke.teleporters.enter.z, true) < 5) then
                DrawMarker(2, Config.Locations.coke.teleporters.enter.x, Config.Locations.coke.teleporters.enter.y, Config.Locations.coke.teleporters.enter.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.teleporters.enter.x, Config.Locations.coke.teleporters.enter.y, Config.Locations.coke.teleporters.enter.z, true) < 3.5) then
                    DrawText3D(Config.Locations.coke.teleporters.enter.x, Config.Locations.coke.teleporters.enter.y, Config.Locations.coke.teleporters.enter.z+0.15, '~g~E~w~ - Enter')
                    if IsControlJustReleased(0, 38) then
                        teleportToCokeLab()
                    end
                end
            end

            -- MAIN METH EXIT TELEPORTER
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.teleporters.exit.x, Config.Locations.coke.teleporters.exit.y, Config.Locations.coke.teleporters.exit.z, true) < 5) then
                DrawMarker(2, Config.Locations.coke.teleporters.exit.x, Config.Locations.coke.teleporters.exit.y, Config.Locations.coke.teleporters.exit.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.teleporters.exit.x, Config.Locations.coke.teleporters.exit.y, Config.Locations.coke.teleporters.exit.z, true) < 3.5) then
                    DrawText3D(Config.Locations.coke.teleporters.exit.x, Config.Locations.coke.teleporters.exit.y, Config.Locations.coke.teleporters.exit.z+0.15, '~g~E~w~ - Leave')
                    if IsControlJustReleased(0, 38) then
                        teleportOutOfCokeLab()
                    end
                end
            end

            -- COKE PRODUCE
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.process.produce.x, Config.Locations.coke.process.produce.y, Config.Locations.coke.process.produce.z, true) < 3.5) then
                DrawText3D(Config.Locations.coke.process.produce.x, Config.Locations.coke.process.produce.y, Config.Locations.coke.process.produce.z+0.15, '~g~E~w~ - Produce')
                if IsControlJustReleased(0, 38) then
                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                    exports['progressBars']:startUI(Config.WaitingTime, "Producing coke...")
                    Citizen.Wait(Config.WaitingTime)
                    producedCoke = producedCoke + 1
                    ClearPedTasksImmediately(playerPed)
                end
            end

            -- COKE CUTTING
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.process.cut.x, Config.Locations.coke.process.cut.y, Config.Locations.coke.process.cut.z, true) < 3.5) then
                DrawText3D(Config.Locations.coke.process.cut.x, Config.Locations.coke.process.cut.y, Config.Locations.coke.process.cut.z+0.25, 'Cocaine: ~y~' .. producedCoke .. '~w~ grams')
                DrawText3D(Config.Locations.coke.process.cut.x, Config.Locations.coke.process.cut.y, Config.Locations.coke.process.cut.z+0.15, '~g~E~w~ - Start cutting')
                if IsControlJustReleased(0, 38) then
                    if producedCoke >= 1 then
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        exports['progressBars']:startUI(Config.WaitingTime, "Cutting...")
                        Citizen.Wait(Config.WaitingTime)
                        producedCoke = producedCoke - 1
                        cuttedCoke = cuttedCoke + 0.5
                        ClearPedTasksImmediately(playerPed)
                    else
                        ESX.ShowNotification('There is not enough produced cocaine.')
                    end
                end
            end

            -- COKE PACKAGING
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.process.packaging.x, Config.Locations.coke.process.packaging.y, Config.Locations.coke.process.packaging.z, true) < 5) then
                DrawMarker(2, Config.Locations.coke.process.packaging.x, Config.Locations.coke.process.packaging.y, Config.Locations.coke.process.packaging.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.process.packaging.x, Config.Locations.coke.process.packaging.y, Config.Locations.coke.process.packaging.z, true) < 3.5) then
                    DrawText3D(Config.Locations.coke.process.packaging.x, Config.Locations.coke.process.packaging.y, Config.Locations.coke.process.packaging.z+0.35, 'Packaged cocaine: ~y~' .. packagedCoke .. '~w~ bags')
                    DrawText3D(Config.Locations.coke.process.packaging.x, Config.Locations.coke.process.packaging.y, Config.Locations.coke.process.packaging.z+0.25, 'Cutted cocaine: ~y~' .. cuttedCoke .. '~w~ grams')
                    DrawText3D(Config.Locations.coke.process.packaging.x, Config.Locations.coke.process.packaging.y, Config.Locations.coke.process.packaging.z+0.15, '~g~E~w~ - Package')
                    if IsControlJustReleased(0, 38) then
                        if cuttedCoke >= 1 then
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            exports['progressBars']:startUI(Config.WaitingTime, "Packaging coke...")
                            Citizen.Wait(Config.WaitingTime)
                            cuttedCoke = cuttedCoke - 1
                            packagedCoke = packagedCoke + 1
                            ClearPedTasksImmediately(playerPed)
                            TriggerServerEvent('esx_druglabs:server:addCokeStorage', packagedCoke)
                        else
                            ESX.ShowNotification('There is not enough cutted cocaine.')
                        end
                    end
                end
            end

            -- COKE STORAGE
            if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.process.storage.x, Config.Locations.coke.process.storage.y, Config.Locations.coke.process.storage.z, true) < 5) then
                DrawMarker(2, Config.Locations.coke.process.storage.x, Config.Locations.coke.process.storage.y, Config.Locations.coke.process.storage.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(playerPosition, Config.Locations.coke.process.storage.x, Config.Locations.coke.process.storage.y, Config.Locations.coke.process.storage.z, true) < 3.5) then
                    ESX.TriggerServerCallback('esx_druglabs:server:checkCokeStorage', function(serverValue)
                        DrawText3D(Config.Locations.coke.process.storage.x, Config.Locations.coke.process.storage.y, Config.Locations.coke.process.storage.z+0.25, 'Storage: ~y~' .. serverValue .. '~w~ bags')
                        DrawText3D(Config.Locations.coke.process.storage.x, Config.Locations.coke.process.storage.y, Config.Locations.coke.process.storage.z+0.15, '~g~E~w~ - Clear storage')
                        if IsControlJustReleased(0, 38) then
                            if serverValue > 0 then
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                                exports['progressBars']:startUI(Config.WaitingTime, "Clearing storage...")
                                Citizen.Wait(Config.WaitingTime)
                                TriggerServerEvent('esx_druglabs:server:clearCokeStorage', serverValue)
                                packagedCoke = packagedCoke - packagedCoke
                                ClearPedTasksImmediately(playerPed)
                            else
                                ESX.ShowNotification('There is no cocaine left in the storage.')
                            end
                        end
                    end)
                end
            end

        end
    end
end)

function teleportOutOfCokeLab()
    local entity = PlayerPedId()
    
    DoScreenFadeOut(200)
    Citizen.Wait(200)
    SetEntityCoords(entity, Config.Locations.coke.teleporters.enter.x, Config.Locations.coke.teleporters.enter.y, Config.Locations.coke.teleporters.enter.z, 0, 0, 0, false)

    PlaceObjectOnGroundProperly(entity)
    Citizen.Wait(1500)
    DoScreenFadeIn(200)
end

function teleportToCokeLab()
    local entity = PlayerPedId()
    
    DoScreenFadeOut(200)
    Citizen.Wait(200)
    SetEntityCoords(entity, Config.Locations.coke.teleporters.exit.x, Config.Locations.coke.teleporters.exit.y, Config.Locations.coke.teleporters.exit.z, 0, 0, 0, false)

    PlaceObjectOnGroundProperly(entity)
    Citizen.Wait(1500)
    DoScreenFadeIn(200)
end
