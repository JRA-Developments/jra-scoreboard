print("^2JRA Developments - jra-scoreboard version 1.0^7")
if Config.Framework == "QBCORE" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()
elseif (Config.Framework == "AUTO" and GetResourceState("qb-core") == "started") then
    Framework = "QBCORE"
    QBCore = exports['qb-core']:GetCoreObject()
    if Config.FrameworkDebugPrintClient then
        print('qbcore started on auto')
    end
elseif (Config.Framework == "AUTO" and GetResourceState("es_extended") == "started") then
    Framework = "ESX"
    ESX = exports["es_extended"]:getSharedObject()
    if Config.FrameworkDebugPrintClient then
        print('es_extended started on auto')
    end
end
    

local jobCounts = {}

RegisterNetEvent('jra-scoreboard:receiveData', function(receivedJobCounts, totalPlayers, maxPlayers)
    jobCounts = receivedJobCounts

    local options = {}
    if Config.PlayerInformationHeader then
        table.insert(options, {
            title = '🧑 Player Information 🧑',
            description = ''
        })
    end
    if Config.ShowPlayerInformation then
        if Framework == "QBCORE" then
            local PlayerData = QBCore.Functions.GetPlayerData()
            local PlayerName = PlayerData.charinfo.firstname .. ' ' .. PlayerData.charinfo.lastname
            local SessionID = GetPlayerServerId(PlayerId())
            local citizenID = PlayerData.citizenid
            table.insert(options, {
                title = PlayerName,
                description = 'Session ID: ' .. SessionID .. '\nCitizen ID: ' .. citizenID,
            })
        elseif Framework == "ESX" then
            local xPlayer = ESX.GetPlayerData()
            local PlayerName = xPlayer.firstName..' '.. xPlayer.lastName
            local SessionID = GetPlayerServerId(PlayerId())
            table.insert(options, {
                title = PlayerName,
                description = 'Session ID: ' .. SessionID,
            })
        end
    end

    if Config.ShowServerInformationHeader then
        table.insert(options, {
            title = '🎮 Server Information 🎮',
            description = ''
        })
    end
    if Config.ShowOnlinePlayerCount then
        table.insert(options, {
            title = "Total Players",
            description = totalPlayers .. "/" .. maxPlayers.. ' players online',
        })
    end

    if Config.ShowJobsHeader then
        table.insert(options, {
            title = '🛡️ Whitelisted Jobs🛡️ ',
            description = ''
        })
    end
    
    if Config.ShowJobs then
        for _, job in pairs(Config.Jobs) do
            local count = jobCounts[job.job] or 0
            local description = GetJobDescription(count, job)
            table.insert(options, {
                title = job.label,
                description = description
            })
        end
    end

    if Config.ShowActivitiesHeader then
        table.insert(options, {
            title = '👀💰 Activities 👀💰',
            description = ''
        })
    end
    if Config.ShowActivities then
        for _, activity in pairs(Config.Activities) do
            local policeCount = jobCounts["police"] or 0
            local activityStatus = ""
            
            if policeCount >= activity.requiredPolice then
                activityStatus = Config.UseIndicatorDots and Config.ActivityAmountIndicatorDots.isable or ""
            else
                activityStatus = Config.UseIndicatorDots and Config.ActivityAmountIndicatorDots.notable or ""
            end
            
            table.insert(options, {
                title = activity.name,
                description = activityStatus
            })
        end
    end

    lib.registerContext({
        id = 'scoreboard_menu',
        title = Config.ServerName,
        options = options
    })

    lib.showContext('scoreboard_menu')
end)

function GetJobDescription(count, job)
    local description = ''
    local dot = ''
    if count == 0 or count > 0 and count <= 3 then
        dot = Config.UseIndicatorDots and Config.JobAmountIndicatorDots.low
    elseif count > 3 and count <= 5 then
        dot = Config.UseIndicatorDots and Config.JobAmountIndicatorDots.medium
    elseif count > 5 and count <= 10 then
        dot = Config.UseIndicatorDots and Config.JobAmountIndicatorDots.high
    elseif count > 10 then
        dot = Config.UseIndicatorDots and Config.JobAmountIndicatorDots.high
    end
    if Config.ShowActualNumberOfJobsOnline then
        description = count ..' on duty'
    else
        description = dot
    end
    return description
end

RegisterKeyMapping('openscoreboard', 'Open Scoreboard', 'keyboard', Config.Keybind)

RegisterCommand('openscoreboard', function()
    TriggerServerEvent('jra-scoreboard:fetchData')
end, false)