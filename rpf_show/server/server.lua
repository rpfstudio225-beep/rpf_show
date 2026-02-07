local VorpCore = {}
local isPlaying = false

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterCommand(Config.Command, function(source)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job

    if job == Config.job then
        TriggerClientEvent("rs_cinema:openMenuCine", _source)
    else
        VorpCore.NotifyLeft(source, Config.Language.Noty, Config.Language.NoJob, "menu_textures", "cross", 3000, "COLOR_RED")
    end
end)

RegisterNetEvent("rs_cinema:SyncPlayScene")
AddEventHandler("rs_cinema:SyncPlayScene", function(scene)
    TriggerClientEvent("rs_cinema:playScene", -1, scene)
end)

RegisterNetEvent("rs_cinema:SyncShow")
AddEventHandler("rs_cinema:SyncShow", function(show, projection, movie)
    if isPlaying then
        VorpCore.NotifyLeft(source, Config.Language.Noty, Config.Language.Play, "menu_textures", "cross", 3000, "COLOR_RED")
        return
    end

    TriggerClientEvent("rs_cinema:PlayShow", -1, show, projection, movie)
end)

RegisterNetEvent("rs_cinema:SyncMovie")
AddEventHandler("rs_cinema:SyncMovie", function(show, projection, movie)
    -- Obtener jugadores y depurar valores
    local players = GetPlayers()

    for _, player in ipairs(players) do
        local playerTown = GetPlayerTownName(player)
        local formattedPlayerTown = string.lower(string.gsub(playerTown, "%s+", ""))
        local formattedProjection = string.lower(string.gsub(projection, "%s+", ""))

        if formattedPlayerTown == formattedProjection then
           TriggerClientEvent("rs_cinema:PlayMovie", player, "MOVIE", projection, movie)
        end    
    end
end)

local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local items = {
   {name = "show_ticket_bigband_a",      type = "SHOW", showName = "BIGBAND_A"},
   {name = "show_ticket_bigband_b",      type = "SHOW", showName = "BIGBAND_B"},
   {name = "show_ticket_bulletcatch",    type = "SHOW", showName = "BULLETCATCH"},
   {name = "show_ticket_cancan_a",       type = "SHOW", showName = "CANCAN_A"},
   {name = "show_ticket_cancan_b",       type = "SHOW", showName = "CANCAN_B"},
   {name = "show_ticket_escapeartist",   type = "SHOW", showName = "ESCAPEARTIST"},
   {name = "show_ticket_escapenoose",    type = "SHOW", showName = "ESCAPENOOSE"},
   {name = "show_ticket_firebreath",     type = "SHOW", showName = "FIREBREATH"},
   {name = "show_ticket_firedance_a",    type = "SHOW", showName = "FIREDANCE_A"},
   {name = "show_ticket_firedance_b",    type = "SHOW", showName = "FIREDANCE_B"},
   {name = "show_ticket_flexfight",      type = "SHOW", showName = "FLEXFIGHT"},
   {name = "show_ticket_oddfellows",     type = "SHOW", showName = "ODDFELLOWS"},
   {name = "show_ticket_snakedance_a",   type = "SHOW", showName = "SNAKEDANCE_A"},
   {name = "show_ticket_snakedance_b",   type = "SHOW", showName = "SNAKEDANCE_B"},
   {name = "show_ticket_strongwoman",    type = "SHOW", showName = "STRONGWOMAN"},
   {name = "show_ticket_sworddance",     type = "SHOW", showName = "SWORDDANCE"},
   {name = "movie_disc_bear_saintdenis",            type = "MOVIE", townName = "SAINTDENIS", movieName = "BEAR"},
   {name = "movie_disc_josiah_saintdenis",          type = "MOVIE", townName = "SAINTDENIS", movieName = "JOSIAH"},
   {name = "movie_disc_flight_saintdenis",          type = "MOVIE", townName = "SAINTDENIS", movieName = "SECRET_OF_MANFLIGHT"},
   {name = "movie_disc_saviors_saintdenis",         type = "MOVIE", townName = "SAINTDENIS", movieName = "SAVIORS_AND_SAVAGES"},
   {name = "movie_disc_ghoststory_saintdenis",      type = "MOVIE", townName = "SAINTDENIS", movieName = "GHOST_STORY"},
   {name = "movie_disc_damnation_saintdenis",       type = "MOVIE", townName = "SAINTDENIS", movieName = "DIRECT_CURRENT_DAMNATION"},
   {name = "movie_disc_farmersdaughter_saintdenis", type = "MOVIE", townName = "SAINTDENIS", movieName = "FARMERS_DAUGHTER"},
   {name = "movie_disc_modernmedicine_saintdenis",  type = "MOVIE", townName = "SAINTDENIS", movieName = "MODERN_MEDICINE"},
   {name = "movie_disc_strongestman_saintdenis",    type = "MOVIE", townName = "SAINTDENIS", movieName = "WORLDS_STRONGEST_MAN"},
   {name = "movie_disc_sweetheart_saintdenis",      type = "MOVIE", townName = "SAINTDENIS", movieName = "SKETCHING_FOR_SWEETHEART"},
   {name = "movie_disc_beartent_saintdenis",        type = "MOVIE", townName = "SAINTDENIS", movieName = "BEAR_TENT"},
   {name = "movie_disc_josiahtent_saintdenis",      type = "MOVIE", townName = "SAINTDENIS", movieName = "JOSIAH_TENT"},
   {name = "movie_disc_flighttent_saintdenis",      type = "MOVIE", townName = "SAINTDENIS", movieName = "SECRET_OF_MANFLIGHT_TENT"},
   {name = "movie_disc_saviorstent_saintdenis",     type = "MOVIE", townName = "SAINTDENIS", movieName = "SAVIORS_AND_SAVAGES_TENT"},
   {name = "movie_disc_ghoststorytent_saintdenis",  type = "MOVIE", townName = "SAINTDENIS", movieName = "GHOST_STORY_TENT"},
   {name = "movie_disc_bear_blackwater",            type = "MOVIE", townName = "BLACKWATER", movieName = "BEAR"},
   {name = "movie_disc_josiah_blackwater",          type = "MOVIE", townName = "BLACKWATER", movieName = "JOSIAH"},
   {name = "movie_disc_flight_blackwater",          type = "MOVIE", townName = "BLACKWATER", movieName = "SECRET_OF_MANFLIGHT"},
   {name = "movie_disc_saviors_blackwater",         type = "MOVIE", townName = "BLACKWATER", movieName = "SAVIORS_AND_SAVAGES"},
   {name = "movie_disc_ghoststory_blackwater",      type = "MOVIE", townName = "BLACKWATER", movieName = "GHOST_STORY"},
   {name = "movie_disc_damnation_blackwater",       type = "MOVIE", townName = "BLACKWATER", movieName = "DIRECT_CURRENT_DAMNATION"},
   {name = "movie_disc_farmersdaughter_blackwater", type = "MOVIE", townName = "BLACKWATER", movieName = "FARMERS_DAUGHTER"},
   {name = "movie_disc_modernmedicine_blackwater",  type = "MOVIE", townName = "BLACKWATER", movieName = "MODERN_MEDICINE"},
   {name = "movie_disc_strongestman_blackwater",    type = "MOVIE", townName = "BLACKWATER", movieName = "WORLDS_STRONGEST_MAN"},
   {name = "movie_disc_sweetheart_blackwater",      type = "MOVIE", townName = "BLACKWATER", movieName = "SKETCHING_FOR_SWEETHEART"},
   {name = "movie_disc_beartent_blackwater",        type = "MOVIE", townName = "BLACKWATER", movieName = "BEAR_TENT"},
   {name = "movie_disc_josiahtent_blackwater",      type = "MOVIE", townName = "BLACKWATER", movieName = "JOSIAH_TENT"},
   {name = "movie_disc_flighttent_blackwater",      type = "MOVIE", townName = "BLACKWATER", movieName = "SECRET_OF_MANFLIGHT_TENT"},
   {name = "movie_disc_saviorstent_blackwater",     type = "MOVIE", townName = "BLACKWATER", movieName = "SAVIORS_AND_SAVAGES_TENT"},
   {name = "movie_disc_ghoststorytent_blackwater",  type = "MOVIE", townName = "BLACKWATER", movieName = "GHOST_STORY_TENT"},  
   {name = "movie_disc_bear_valentine",             type = "MOVIE", townName = "VALENTINE", movieName = "BEAR"},
   {name = "movie_disc_josiah_valentine",           type = "MOVIE", townName = "VALENTINE", movieName = "JOSIAH"},
   {name = "movie_disc_flight_valentine",           type = "MOVIE", townName = "VALENTINE", movieName = "SECRET_OF_MANFLIGHT"},
   {name = "movie_disc_saviors_valentine",          type = "MOVIE", townName = "VALENTINE", movieName = "SAVIORS_AND_SAVAGES"},
   {name = "movie_disc_ghoststory_valentine",       type = "MOVIE", townName = "VALENTINE", movieName = "GHOST_STORY"},
   {name = "movie_disc_damnation_valentine",        type = "MOVIE", townName = "VALENTINE", movieName = "DIRECT_CURRENT_DAMNATION"},
   {name = "movie_disc_farmersdaughter_valentine",  type = "MOVIE", townName = "VALENTINE", movieName = "FARMERS_DAUGHTER"},
   {name = "movie_disc_modernmedicine_valentine",   type = "MOVIE", townName = "VALENTINE", movieName = "MODERN_MEDICINE"},
   {name = "movie_disc_strongestman_valentine",     type = "MOVIE", townName = "VALENTINE", movieName = "WORLDS_STRONGEST_MAN"},
   {name = "movie_disc_sweetheart_valentine",       type = "MOVIE", townName = "VALENTINE", movieName = "SKETCHING_FOR_SWEETHEART"},
   {name = "movie_disc_beartent_valentine",         type = "MOVIE", townName = "VALENTINE", movieName = "BEAR_TENT"},
   {name = "movie_disc_josiahtent_valentine",       type = "MOVIE", townName = "VALENTINE", movieName = "JOSIAH_TENT"},
   {name = "movie_disc_flighttent_valentine",       type = "MOVIE", townName = "VALENTINE", movieName = "SECRET_OF_MANFLIGHT_TENT"},
   {name = "movie_disc_saviorstent_valentine",      type = "MOVIE", townName = "VALENTINE", movieName = "SAVIORS_AND_SAVAGES_TENT"},
   {name = "movie_disc_ghoststorytent_valentine",   type = "MOVIE", townName = "VALENTINE", movieName = "GHOST_STORY_TENT"}, 
}

RegisterNetEvent("rs_cinema:SetPlaying")
AddEventHandler("rs_cinema:SetPlaying", function(state)
    isPlaying = state
end)

for _, item in ipairs(items) do
    if item.type == "SHOW" and item.showName then
        exports.vorp_inventory:registerUsableItem(item.name, function(data)
            local source = data.source
            VorpInv.CloseInv(source)

            if isPlaying then
                VorpCore.NotifyLeft(source, Config.Language.Noty, Config.Language.Play, "menu_textures", "cross", 3000, "COLOR_RED")
                return
            end

            TriggerClientEvent("rs_cinema:StartPlay", -1, item.showName)
            VorpInv.subItem(source, item.name, 1)
        end, GetCurrentResourceName())
    end
end

local ActiveMovies = {}

local CinemaLocations = {
    ["SaintDenis"] = vector3(2697.16, -1353.54, 48.54),
    ["Blackwater"] = vector3(-778.88, -1362.68, 44.09),
    ["Valentine"] = vector3(-348.01, 697.84, 117.66)
}

local function NormalizeTownName(name)
    return string.lower(string.gsub(name or "", "%s+", ""))
end

function GetPlayerTownName(player)
    local playerCoords = GetEntityCoords(GetPlayerPed(player))
    for town, location in pairs(CinemaLocations) do
        if #(playerCoords - location) < 10.0 then
            return town
        end
    end
    return nil
end

RegisterNetEvent("rs_cinema:SetMovie")
AddEventHandler("rs_cinema:SetMovie", function(cinemaName, state)
    local key = NormalizeTownName(cinemaName)
    
    if state then
        ActiveMovies[key] = state
    else
        ActiveMovies[key] = nil
    end

    TriggerClientEvent("rs_cinema:UpdateMovieStatus", -1, cinemaName, state)
end)

for _, item in ipairs(items) do
    if item.type == "MOVIE" and item.townName and item.movieName then
        exports.vorp_inventory:registerUsableItem(item.name, function(data)
            local source = data.source
            VorpInv.CloseInv(source)

            local formattedItemTown = NormalizeTownName(item.townName)

            if ActiveMovies[formattedItemTown] then
                VorpCore.NotifyLeft(source, Config.Language.Noty, Config.Language.Play, "menu_textures", "cross", 3000, "COLOR_RED")
                return
            end

            ActiveMovies[formattedItemTown] = item.movieName

            local players = GetPlayers()

            for _, player in ipairs(players) do
                local playerTown = GetPlayerTownName(player)
                local formattedPlayerTown = NormalizeTownName(playerTown)

                if formattedPlayerTown == formattedItemTown then
                    TriggerClientEvent("rs_cinema:PlayMovie", player, "MOVIE", item.townName, item.movieName)
                end    
            end

            VorpInv.subItem(source, item.name, 1)
        end, GetCurrentResourceName())
    end
end
