local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('porttablet', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent('cain-portjob:client:openPortTablet', src)
    end
end)


RegisterNetEvent('cain-portjob:server:updatePortRep', function(amount, union)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local unionrep = union.."rep"
    local curRep = xPlayer.PlayerData.metadata[unionrep]
    xPlayer.Functions.SetMetaData(unionrep, (curRep + amount))
end)

RegisterNetEvent('cain-portjob:server:payForJob', function(amount)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddMoney('bank', amount, 'Union Pay')
end)

