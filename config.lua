--- @class Zone
--- @field coords vector3 The coordinates of the greenzone
--- @field radius number The radius of the greenzone

--- @class ConfigTable
Config = {}

--- @class Greenzone
--- @field Blokkenpark Zone
--- @field Ziekenhuis Zone
--- @field Cardealer Zone
--- @field spawn Zone
--- @field Casino Zone
--- @field Comserve Zone
--- @field Wapendealer Zone
Config.Greenzone = {
    Blokkenpark = {
        coords = vector3(130.8985, -1065.4132, 29.1924),
        radius = 75.0
    },
    Ziekenhuis = {
        coords = vector3(310.1053, -589.3291, 90.6143),
        radius = 120.0
    },
    Cardealer = {
        coords = vector3(-29.9753, -1097.5773, 27.2743),
        radius = 40.0
    },
    spawn = {
        coords = vector3(-269.7202, -957.2246, 31.2228),
        radius = 50.0
    },
    Casino = {
        coords = vector3(-1828.3601, -1192.9412, 14.3077),
        radius = 50.0
    },
    Comserve = {
        coords = vector3(-1271.2694, -3388.4224, 12.9329),
        radius = 100.0
    },
    Wapendealer = {
        coords = vector3(5067.0186, -4591.5083, -1.1195),
        radius = 50.0
    }
}
