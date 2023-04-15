config = {}

config.ped = {
    model = "ig_tomcasino",
    coords = vector4(945.1, -2978.12, 4.9, 168.15), --subtract 1 from original Z value or ped will float in air
    length = 1.0,
    width = 1.0,
    heading = 0.0,
    debugPoly = false,
    minZ = 3.0,
    maxZ = 7.0,
}

config.missioncoords = {
    [1] = vector3(2939.17, 2772.42, 39.27), --construction pit
    [2] = vector3(2177.68, 4944.53, 41.33), --oneil grapeseed
    [3] = vector3(1708.27, 4924.72, 42.08), -- grapeseed convenient store
    [4] = vector3(3417.37, 5502.98, 26.25), -- catfish view
	-- you can add as many as you'd like
}

config.ingredients = { -- these are the items a player will be able to obtain from ped after completing the mission
    
        [1] = {
            name = "coca_leaves",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "coke_powder",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "powdered_milk",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "baking_soda",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "sodium",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "hacid",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "hpoxide",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "toulene",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "weed_ak47_seed",
            price = 1,
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "weed_purple-haze_seed",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "weed_skunk_seed",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 11,
        },
        [12] = {
            name = "weed_white-widow_seed",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 12,
        },
        [13] = {
            name = "weed_og-kush_seed",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 13,
        },
        [14] = {
            name = "weed_amnesia_seed",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 14,
        },
        [15] = {
            name = "weed_nutrition",
            price = 1,
            amount = 5,
            info = {},
            type = "item",
            slot = 15,
        },
    
    
}