local ped = PlayerPedId()
local QBCore = exports['qb-core']:GetCoreObject()
local missionactive = false 

Citizen.CreateThread(function()
    QBCore.Functions.LoadModel(config.ped.model)
    mission_ped = CreatePed(0, config.ped.model, config.ped.coords.x, config.ped.coords.y, config.ped.coords.z, config.ped.coords.w, false, false)
    FreezeEntityPosition(mission_ped, true)
    SetEntityInvincible(mission_ped, true)
    SetBlockingOfNonTemporaryEvents(mission_ped, true)
 
    Wait(500)
 
    exports['qb-target']:AddBoxZone("ingredientsped", vector3(config.ped.coords.x, config.ped.coords.y, config.ped.coords.z), config.ped.length, config.ped.width, {
     name = "ingredientsped",
     heading = config.ped.heading,
     debugPoly = config.ped.debugPoly,
     minZ = config.ped.minZ,
     maxZ = config.ped.maxZ,
     }, {
     options = {
        {
            num = 1,
            type = "server",
            event = "solos-ingredients:server:startmission",
            icon = 'fa-solid fa-briefcase',
            label = 'Ingredients Mission',
        },
        {
            num = 2,
            type = "client",
            event = "solos-ingredients:client:openingredientsinventory",
            icon = 'fa-solid fa-cart-shopping',
            label = 'Ingredients',
        }
        --cancel mission
    },
    distance = 1.5,
 })
 end)

RegisterNetEvent('solos-ingredients:client:openingredientsinventory', function()
    local hasitem = QBCore.Functions.HasItem("mission_briefcase", 1) 
    local ped = PlayerPedId()
    if hasitem then 
        --remove briefcase
        TriggerServerEvent('solos-ingredients:server:itemremove', "mission_briefcase", 1, false)  -- remove 
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["mission_briefcase"], "remove") -- notify

        -- shake hands animation
        RequestAnimDict('mp_ped_interaction')
        while not HasAnimDictLoaded('mp_ped_interaction') do
            Wait(1)
        end

        TaskPlayAnim(ped, 'mp_ped_interaction', 'handshake_guy_a', 8.0, -8.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(mission_ped, 'mp_ped_interaction', 'handshake_guy_a', 8.0, -8.0, -1, 0, 0, false, false, false)
        
        Wait(2000)

        local Items = {
            label = "ingredients",
            slots = 30,
            items = {}
        }
        local index = 1
        for _, ingredient in pairs(config.ingredients) do
            Items.items[index] = ingredient
            Items.items[index].slot = index
            index = index + 1
        end
        --open shop inventory
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "ingredients", Items)
    else 
        QBCore.Functions.Notify("Get me what I want and then we'll talk", "error")
    end

end)

local function SpawnHostile(coords)
    
    RequestModel(GetHashKey("s_m_y_blackops_01"))
    while not HasModelLoaded(GetHashKey("s_m_y_blackops_01")) do
        Wait(1)
    end
    
-- Spawn hostile NPCs with different weapons and abilities
    local ped = PlayerPedId()
    
    
    hostile = CreatePed(0, "s_m_y_blackops_01", coords - vector3(1, 0, 1), 0.0, 1, 0)
        GiveWeaponToPed(hostile, GetHashKey("WEAPON_ASSAULTRIFLE"), 100, false, true)
        SetPedFleeAttributes(hostile, 0, 0)
        
        FreezeEntityPosition(hostile, true)
end

RegisterCommand('hostiles', function()
    SpawnHostile()
end)


local function SpawnCase(coords)
    RequestModel(GetHashKey("prop_security_case_01"))
    while not HasModelLoaded(GetHashKey("prop_security_case_01")) do
        Wait(1)
    end
    
    briefcase = CreateObject("prop_security_case_01", coords-vector3(0,0,1), 1, 1, 0)
    Wait(1)
    PlaceObjectOnGroundProperly(briefcase)

    -- Add target to briefcase

    exports['qb-target']:AddTargetEntity(briefcase, { 
        options = { 
            { 
                num = 1, 
                type = "client",  
                icon = "fa-solid fa-briefcase",
                label = 'Secure Briefcase',
                event = 'solos-ingredients:client:securebriefcase', 
            }
        },
        distance = 2.5, 
    })
end

RegisterNetEvent('solos-ingredients:client:securebriefcase', function()
    local playercoords = GetEntityCoords(PlayerPedId())
    local object = GetClosestObjectOfType(playercoords, 5.0, GetHashKey("prop_security_case_01"), 0, 0, 0)
    NetworkRequestControlOfEntity(object)
    DeleteEntity(object)
    DeleteObject(object)

    Wait(1000)
    --give item briefcase
    TriggerServerEvent('solos-ingredients:server:itemadd', 'mission_briefcase', 1, false) -- add briefcase      
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["mission_briefcase"], "add") -- notify add briefcase

    missionactive = false
    TriggerServerEvent('solos-ingredients:server:MIP', false)
end)

-- subtitle function
function ShowSubtitle(message, duration)
    BeginTextCommandPrint('STRING')
    AddTextComponentString(message)
    EndTextCommandPrint(duration, time)
end

    -- subtitle event
RegisterNetEvent('solos-ingredients:client:subtitle', function()
    ShowSubtitle("Go to the marked location and retrieve the briefcase", 7500)
end)


-- Register mission command
RegisterNetEvent("solos-ingredients:client:startmission", function()
    -- Request models and wait for them to load
    
    -- Start the mission and set objective markers
    TriggerServerEvent('solos-ingredients:server:MIP', true)
    
    
    missionactive = true
    --subtitle
    TriggerEvent('solos-ingredients:client:subtitle')

    local randomcoords = math.random(1, #config.missioncoords) 
    local coords = config.missioncoords[randomcoords] 

    SpawnCase(coords)
    SpawnHostile(coords)
    SetNewWaypoint(coords.x, coords.y)
    
end)

CreateThread(function()
    while true do 
        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(2937.42, 2771.61, 39.27))
        Wait(1000)
        
        if distance < 50.0 and missionactive then
            FreezeEntityPosition(hostile, false)
            SetPedAccuracy(hostile, 80)
            SetPedSeeingRange(hostile, 10.0)
            SetPedHearingRange(hostile, 20.0)
            SetPedAlertness(hostile, 2)
            SetPedCombatRange(hostile, 2)
            TaskCombatPed(hostile, PlayerPedId(), 0, 16) 
            SetPedCombatAttributes(hostile, 46, true)
            Wait(100)
            SetModelAsNoLongerNeeded(GetHashKey("s_m_y_blackops_01"))
            SetModelAsNoLongerNeeded(GetHashKey("WEAPON_ASSAULTRIFLE"))
            SetModelAsNoLongerNeeded(GetHashKey("prop_security_case_01"))
        return end
    end
end)



CreateThread(function()
    while true do 
        Wait(0)
        if DoesEntityExist(briefcase) then 
            local casecoords = GetEntityCoords(briefcase)
            DrawMarker(2, casecoords+ vector3(0, 0, 0.5), 0, 0, 0, 180.0, 0, 0, 0.25, 0.25, 0.25, 1, 255, 1, 255, 1, 1, 0, 1)
        end
    end
end)
