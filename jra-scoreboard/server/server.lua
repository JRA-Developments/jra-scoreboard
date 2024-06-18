if Config.Framework == "QBCORE" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()
elseif (Config.Framework == "AUTO" and GetResourceState("qb-core") == "started") then
    Framework = "QBCORE"
    QBCore = exports['qb-core']:GetCoreObject()
    if Config.FrameworkDebugPrintServer then
        print('qbcore started on auto')
    end
elseif (Config.Framework == "AUTO" and GetResourceState("es_extended") == "started") then
    Framework = "ESX"
    ESX = exports["es_extended"]:getSharedObject()
    if Config.FrameworkDebugPrintServer then
        print('es_extended started on auto')
    end
end

function GetPlayerJobCounts()
    local jobCounts = {}
    for _, job in pairs(Config.Jobs) do
        jobCounts[job.job] = 0
    end

    local players
    if Framework == "QBCORE" then
        local players = QBCore.Functions.GetPlayers()
        for _, playerId in ipairs(players) do
            local xPlayer = QBCore.Functions.GetPlayer(playerId)
            local playerJob = xPlayer.PlayerData.job.name
            local onDuty = xPlayer.PlayerData.job.onduty
            
            if jobCounts[playerJob] ~= nil then
                local jobConfig = GetJobConfig(playerJob)
                if jobConfig.countDuty then
                    if onDuty then
                        jobCounts[playerJob] = jobCounts[playerJob] + 1
                    end
                else
                    jobCounts[playerJob] = jobCounts[playerJob] + 1
                end
            end
        end
        return jobCounts, #players
    elseif Framework == "ESX" then
        players = ESX.GetExtendedPlayers()
        for _, player in pairs(players) do
            local playerJob = player.job.name
            if jobCounts[playerJob] ~= nil then
                jobCounts[playerJob] = jobCounts[playerJob] + 1
            end
        end
    end

    return jobCounts, #players
end

function GetJobConfig(jobName)
    for _, job in pairs(Config.Jobs) do
        if job.job == jobName then
            return job
        end
    end
    return nil
end

RegisterNetEvent('jra-scoreboard:fetchData', function()
    local source = source
    local jobCounts, totalPlayers = GetPlayerJobCounts()
    local maxPlayers = Config.MaxPlayers
    TriggerClientEvent('jra-scoreboard:receiveData', source, jobCounts, totalPlayers, maxPlayers)
end)