Citizen.CreateThread(function()
    local inZone = false
    local currentZone = nil

    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local zoneFound = false
        local zoneNameFound = nil

        for zoneName, zoneData in pairs(Config.Greenzone) do
            if #(pos - zoneData.coords) < zoneData.radius then
                zoneFound = true
                zoneNameFound = zoneName
                break
            end
        end

        if zoneFound then
            if not inZone then
                inZone = true
                exports.ox_lib:notify({
                    title = "Greenzone - Status",
                    description = "You have entered a green zone.",
                    position = "top",
                    type = "inform"
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
                    title = "Greenzone - Status",
                    description = "You have left the green zone.",
                    position = "top",
                    type = "inform"
                })
            end

            SetEntityInvincible(ped, false)
            SetPlayerInvincible(PlayerId(), false)
        end

        Citizen.Wait(zoneFound and 0 or 500)
    end
end)
