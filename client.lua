Citizen.CreateThread(function()
    local inZone = false
    local currentZone = nil

    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local zoneFound = false
        local zoneNameFound = nil

        for zoneName, zoneData in pairs(Config.Greenzone) do
            local distance = #(pos - zoneData.coords)
            if distance < zoneData.radius then
                zoneFound = true
                zoneNameFound = zoneName
                break
            end
        end

        if zoneFound then
            if not inZone then
                inZone = true
                currentZone = zoneNameFound
                exports.ox_lib:notify({
                    description = "You have entered a green zone: " .. zoneNameFound,
                    type = "error",
                    duration = 3000
                })
            end

            SetEntityInvincible(ped, true)
            SetPlayerInvincible(PlayerId(), true)

            local maxHealth = GetEntityMaxHealth(ped)
            if GetEntityHealth(ped) < maxHealth then
                SetEntityHealth(ped, maxHealth)
            end

            if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") then
                SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            end

            DisableControlAction(0, 24, true) 
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 37, true) 
        else
            if inZone then
                inZone = false
                currentZone = nil
                exports.ox_lib:notify({
                    description = "You have left the green zone.",
                    type = "success",
                    duration = 3000
                })
            end

            SetEntityInvincible(ped, false)
            SetPlayerInvincible(PlayerId(), false)
        end

        Citizen.Wait(zoneFound and 0 or 500)
    end
end)
