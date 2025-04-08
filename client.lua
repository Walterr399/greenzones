-- // [VARIABLES] \\ --
local inGreenZone = false
local nearestZone = nil

-- // [THREADS] \\ --
CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inZone = false
        local currentZone

        for _, zone in pairs(Config.GreenZones) do
            local distance = #(pos - zone.coords)
            if distance <= zone.radius then
                inZone = true
                currentZone = zone
                break
            end
        end

        if inZone and not inGreenZone then
            inGreenZone = true
            nearestZone = currentZone
            enterZone(currentZone)
        elseif not inZone and inGreenZone then
            inGreenZone = false
            exitZone(nearestZone)
            nearestZone = nil
        end

        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        if inGreenZone then
            DisablePlayerFiring(PlayerId(), true)
            DisableControlAction(0, 24, true) 
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 140, true) 
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 37, true) 
            DisableControlAction(0, 44, true) 
            DisableControlAction(0, 289, true) 
            SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
            Wait(0)
        else
            Wait(500)
        end
    end
end)

-- // [FUNCTIONS] \\ --
function enterZone(zone)
    lib.notify({
        title = 'Greenzone',
        description = ('You entered %s'):format(zone.label),
        type = 'inform'
    })
end

function exitZone(zone)
    lib.notify({
        title = 'Greenzone',
        description = ('You left %s'):format(zone.label),
        type = 'warning'
    })
end