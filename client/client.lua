local hudLoaded = false
local seatbeltOn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    hudLoaded = true
end)

RegisterNetEvent('QBX:Client:OnPlayerLoaded', function()
    hudLoaded = true
end)

RegisterNetEvent('seatbelt:client:ToggleSeatbelt', function()
    seatbeltOn = not seatbeltOn
end)

RegisterNetEvent('qbx_seatbelt:client:sync', function(state)
    seatbeltOn = state
end)

CreateThread(function()
    while true do
        if hudLoaded then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            local inVehicle = veh ~= 0

            local speed = 0
            local rpm = 0
            local fuel = 100
            local gear = 0

            local isHeli = false
            local altitude = 0
            local heading = 0


            if inVehicle then
                speed = math.floor(GetEntitySpeed(veh) * 3.6)
                rpm = GetVehicleCurrentRpm(veh) * 100
                fuel = GetVehicleFuelLevel(veh)
                fuelHeli = GetVehicleFuelLevel(veh)
                if fuel == 0 then fuel = 100 end
                if fuelHeli == 0 then fuel = 100 end
                gear = GetVehicleCurrentGear(veh)

                local VehicleClass = GetVehicleClass(veh)

                if VehicleClass == 15 then
                    isHeli = true

                    altitude = math.floor(GetEntityHeightAboveGround(veh))
                    heading = math.floor(GetEntityHeading(veh))
                end
            end

            local hunger = 100
            local water = 100

            if LocalPlayer and LocalPlayer.state then
                hunger = LocalPlayer.state.hunger or LocalPlayer.state.hunger_level or 100
                water = LocalPlayer.state.thirst or LocalPlayer.state.thirst_level or 100
            end

            local health = math.max(GetEntityHealth(ped) - 100, 0)
            local armor = GetPedArmour(ped)

            local stamina = GetPlayerSprintStaminaRemaining(PlayerId())
            if not stamina or stamina < 0 then stamina = 100 end
            stamina = math.floor(stamina)

            local talking = NetworkIsPlayerTalking(PlayerId())

            local voiceMode = 2
            local prox = LocalPlayer and LocalPlayer.state and LocalPlayer.state.proximity
            if prox and prox.index then
                voiceMode = prox.index
            end

            local voice = (voiceMode == 1 and 25) or (voiceMode == 2 and 50) or 100

            SendNUIMessage({
                action = "updateHud",
                hudLoaded = hudLoaded,
                isHeli = isHeli,
                showCarHud = inVehicle,
                speed = speed,
                rpm = rpm,
                fuel = fuel,
                fuelHeli = fuelHeli,
                hunger = hunger,
                water = water,
                health = health,
                armor = armor,
                stamina = stamina,
                voice = voice,
                voiceMode = voiceMode,
                talking = talking,
                seatbelt = seatbeltOn,
                gear = gear,
                altitude = altitude,
                heading = heading,
            })
        end

        Wait(50)
    end
end)

RegisterNetEvent("hud:client:LoadMap", function()
    Wait(50)

    lib.notify({
        title = "HUD",
        description = "HUD-ът се зареди успешно.",
        type = "success"
    })

    local defaultAspectRatio = 1920 / 1080
    local resX, resY = GetActiveScreenResolution()
    local aspectRatio = resX / resY
    local minimapOffset = 0

    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio - aspectRatio) / 3.6) - 0.008
    end

    CreateThread(function()
        RequestStreamedTextureDict("squaremap", false)

        while not HasStreamedTextureDictLoaded("squaremap") do
            Wait(50)
        end

        SetMinimapClipType(0)

        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")

        SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.15, 0.1648, 0.193)
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, -0.09, 0.138, 0.20)
        SetMinimapComponentPosition("minimap_blur", "L", "B", -0.01 + minimapOffset, -0.08, 0.272, 0.300)

        SetBlipAlpha(GetNorthRadarBlip(), 0)

        SetRadarBigmapEnabled(false, false)
        Wait(50)
        SetRadarBigmapEnabled(false, false)

        SetMinimapClipType(0)
    end)

    CreateThread(function()
        while true do
            Wait(0)

            HideHudComponentThisFrame(1)
            HideHudComponentThisFrame(2)
            HideHudComponentThisFrame(3)
            HideHudComponentThisFrame(4)
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(9)
            HideHudComponentThisFrame(14)
            HideHudComponentThisFrame(19)
            HideHudComponentThisFrame(21)
        end
    end)
end)

TriggerEvent("hud:client:LoadMap")