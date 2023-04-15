local MIP = false 

RegisterNetEvent('solos-ingredients:server:startmission', function()
    if not MIP then 
        TriggerClientEvent('solos-ingredients:client:startmission', source)
    else 
        TriggerClientEvent('QBCore:Notify', source, 'There is already a mission in progress', 'error')
    end
end)


RegisterNetEvent('solos-ingredients:server:MIP', function(bool)
    MIP = bool
end)

RegisterNetEvent('solos-ingredients:server:itemadd', function(item, amount, bool)
    local QBCore = exports['qb-core']:GetCoreObject()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.AddItem(item, amount, bool) 
end)

-- remove item
RegisterNetEvent('solos-ingredients:server:itemremove', function(item, amount, bool)
    local QBCore = exports['qb-core']:GetCoreObject()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.RemoveItem(item, amount, bool) 
end)
