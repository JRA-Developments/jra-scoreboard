Config = {
    Framework = "AUTO", -- "AUTO" -- will automatically detect what framework either ESX or QBCORE otherwise you can use "ESX" or "QBCORE"
    FrameworkDebugPrintClient = false, 
    FrameworkDebugPrintServer = false,  

    ServerName = "JRA Scoreboard", -- set this to your servers name
    Keybind = 'F10', -- set this to a key this will automatically save in your settings/keybinds/fivem look for openscoreboard to change it to something else
    MaxPlayers = GetConvarInt('sv_maxclients', 32),

    -- Player Information 
    PlayerInformationHeader = true, -- set this to false if you dont want to display a header for the player information
    ShowPlayerInformation = true,

    -- Server Information 
    ShowServerInformationHeader = true, -- set this to false if you dont to display a header for the server information
    ShowOnlinePlayerCount = true, -- set this to false if you dont want to display the amount of player online in the server
    
    -- Jobs Information 
    ShowJobsHeader = true, -- set this to false if you dont want to display a header for the jobs
    ShowJobs = true, -- set this to false to disable showing the jobs 
    ShowActualNumberOfJobsOnline = true, -- set this to true to show the actual number of job workers online instead of low, medium, high
    Jobs = {
        { job = "police", label = "🚓 Los Santos Police Department", countDuty = true },
        { job = "ambulance", label = "🚑 Los Santos EMT", countDuty = true },
        { job = "mechanic", label = "🔧 Benny`s Customs", countDuty = true },
    },
    UseIndicatorDots = true, -- set this to false to not show the indicator dots
    JobAmountIndicatorDots = {
        low =  '🔴 - LOW',
        medium = '🟡 - MEDIUM',
        high = '🟢 - HIGH',
    },

    -- Activity Information 
    ShowActivitiesHeader = true, -- set this to false if you dont want to show a header for the activities
    ShowActivities = true, -- set this to false to disable showing the activities
    Activities = {
        { name = "Store Robbery", requiredPolice = 2 },
        { name = "Bank Robbery", requiredPolice = 3 },
        { name = "Jewellery", requiredPolice = 2 },
        { name = "Pacific Bank", requiredPolice = 5 },
        { name = "Paleto Bay Bank", requiredPolice = 4 },
    },
    ActivityAmountIndicatorDots = {
        notable =  '🔴',
        isable = '🟢',
    },
}