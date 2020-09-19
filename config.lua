---------------------------------------
--     ESX_DRUGLABS by Dividerz      --
-- FOR SUPPORT: Arne#7777 on Discord --
---------------------------------------

Config = {}

Config.useKeys = true
Config.usingWeight = true
Config.WaitingTime = 5000

Config.Locations = {
    meth = {
        teleporters = {
            enter = vector3(1737.92, 3709.04, 34.14),
            exit = vector3(997.08, -3200.63, -36.39)
        },
        process = {
            filling = vector3(1002.25, -3198.89, -38.99),
            producing = vector3(1005.76, -3200.33, -38.52),
            producing2 = vector3(1014.65, -3198.09, -38.99),
            packaging = vector3(1016.46, -3194.92, -38.99),
            storage = vector3(1731.80, 3707.72, 34.12)
        }
        
    },
    coke = {
        teleporters = {
            enter = vector3(813.29, -2398.82, 23.66),
            exit = vector3(1088.68, -3187.63, -38.99)
        },
        process = {
            produce = vector3(1090.13, -3195.72, -39.12),
            cut = vector3(1095.42, -3195.90, -39.12),
            packaging = vector3(1100.37, -3198.83, -38.99),
            storage = vector3(818.99, -2399.47, 23.66)
        }
    }
}
