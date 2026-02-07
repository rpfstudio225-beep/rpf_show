Config = {}

Config.RandomTransitions = false
Config.Command ="menucine"
Config.job = "cinema" --- free tickets for this job
Config.Shows = Globals.Shows
Config.Projections = Globals.Projections
Config.Movies = Globals.Movies
Config.Curtains = {
	["SAINTDENIS"] = vector3(2546.522, -1307.835, 48.26664)
}

Config.Soundsets = {
	["Curtain_Open_Music"] = "3160317806_action",
	["Curtain_Opens_Music"] = "2245181467_action",
	["Escape_Noose_Curtain_Music"] = "4224921010_action"
}

Config.CreatedEntries = {}

Config.Language = {
    Play = "A show is already playing",
    Theatre = "Theatre",
    Thedesc = "Select a show to start",
    Open = "Open Curtains",
    Opendesc = "Opens the theatre curtains",
    Close = "Close Curtains",
    Closedesc = "Closes the theatre curtains",
    Movie = "Movies",
    Moviesa = "Select a movie to play in Saint Denis",
    Movieba = "Select a movie to play in Blackwater",
    Movieva = "Select a movie to play in Valentine",
    Menu = "Show Menu",
    Menutext = "Entertainment Menu",
    Ini = "Start the show",
    Selec = "Select a Show",
    Men = "Theatre Menu",
    NoJob = "You don't have the required job to open the menu",
    Zone = "You are not in a theatre or cinema zone",
    Noty = "Performing Arts",
    Biga = "Big Band A",
    Bigb = "Big Band B",
    Bullet = "Bullet Catch",
    Cana = "Cancan A",
    Canb = "Cancan B",
    Scape = "Escape Artist",
    Lasso = "Rope Escape",
    Fire = "Fire Eater",
    Firea = "Fire Dance A",
    Fireb = "Fire Dance B",
    Forze = "Test of Strength",
    Circus = "Circus Oddities",
    Snakea = "Snake Dance A",
    Snakeb = "Snake Dance B",
    Forzea = "Strongwoman",
    Dance = "Sword Dance",
    Bear = "The Bear",
    Josiah = "Josiah",
    Secre = "The Secret of Human Flight",
    Sauva = "Saviors and Savages",
    Ghost = "Ghost Story",
    Direc = "The Curse of Direct Current",
    Daughter = "The Farmer's Daughter",
    Medicine = "Modern Medicine",
    World = "The World's Strongest Man",
    Drawing = "Drawing for the Fiancé",
    Bear2 = "The Bear 2",
    Josiah2 = "Josiah 2",
    Secre2 = "The Secret of Human Flight 2",
    Sauva2 = "Saviors and Savages 2",
    Ghost2 = "Ghost Story 2",
    Film = "MOVIES",
    Filme = "Select a movie",
}

Config.ShowBlip = false
Config.locations = {
   -- { label = "Cinema Saint Denis", blips = -379108622, coords = vector4(2697.16, -1353.54, 48.54, 0.0) }, --- access to the menu without job
   -- { label = "Cinema Valentine", blips = -379108622, coords = vector4(-348.01, 697.84, 117.66, 0.0) },
   -- { label = "Cinema Blackwater", blips = -379108622, coords = vector4(-778.88, -1362.68, 44.09, 0.0) },
  --  { label = "Theater Saint Denis", blips = -417940443, coords = vector4(2546.49, -1299.39, 48.68, 0.0) },
}

Config.NpcJobModel = "A_F_M_ARMTOWNFOLK_01"

--Config.BlipJobName = "Cinema"

--################################ Wandering Shop ###########################--
Config.job = false 
-- Config.job = false -- Everyone has access 
-- Config.job = {"merchant"} -- Only players with that job have access

Config.TiendaNPCActiva = true          -- If true, the wandering shop will appear at the first coordinate in Config.rutas and change its position every time the time set in Config.merchattimelocation passes
Config.npcModel = "u_m_m_sdtrapper_01" -- Name of the NPC
Config.merchattimelocation = 30         -- Time in minutes before the shop changes position
Config.titulo = "Wandering Merchant"   -- This is the name that will appear as the title in the shop menu

Config.promptmerchant = "[G] Open Shop"
Config.Key = 0x760A9C6F

Config.TiendaBlipActivo = true         -- If true, a blip will be shown at the shop’s position
Config.nameBlip = "Wandering Merchant" -- Name that will appear on the blip
Config.spriteBlip = 819673798          -- Blip hash (you can change it to any you want) -- https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips

Config.mostrarComprar = true -- If true, the “Buy” option will appear in the menu; if false, it won’t
Config.mostrarVender = true  -- If true, the “Sell” option will appear in the menu; if false, it won’t


Config.rutas = {
   -- { coords = vector3(-334.11, 773.24, 116.25), heading = 90.66 }, -- First coordinate where the shop appears
 --   { coords = vector3(-343.84, 784.05, 115.83), heading = 180.0 }, -- After Config.merchattimelocation time passes, it will move here
    -- Add as many positions as you want for the shop to rotate around the map
}

Config.ItemsToBuy = {
    { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
    { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
    { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
    { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
    { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
}

Config.ItemsToSell = {
    { label = "Bread", item = "bread", price = 0.5, categoria = "Meal", gold = true, weapon = false },
    { label = "Water", item = "water", price = 0.5, categoria = "Drinks", gold = false, weapon = false },
    { label = "Pickaxe", item = "pickaxe", price = 1.50, categoria = "Tools", gold = false, weapon = false },
    { label = "Rifle Springfield", item = "WEAPON_RIFLE_SPRINGFIELD", price = 10, categoria = "Weapons", gold = false, weapon = true },
    { label = "Rifle Bolt Action", item = "WEAPON_RIFLE_BOLTACTION", price = 10, categoria = "Weapons", gold = false, weapon = true },
}

--################################ Static store ##############################--

Config.TiendasLocales = {
    ["valentine"] = {
        -- If StoreHoursAllowed = true, the store will open at the time marked in -- StoreOpen and close at the time marked in -- StoreClose.  
        -- If StoreHoursAllowed = false, it will not close.
        StoreHoursAllowed = true,
        StoreOpen = 10,
        StoreClose = 18,
        job = false, -- Config.job = false, -- Everyone has access -- job = {"miner", "merchant"}, -- Only players with that job have access
        enablenpc = true,                                      -- enablenpc = false means only the prompt will appear at the coordinates, no NPC
        cordnpc = vector4(-355.27, 704.93, 116.94, 347.93),     -- NPC position
        npcmodel = "A_F_M_ARMTOWNFOLK_01",            -- NPC model name
        enableblip = true,                                     -- enableblip = false means the shop will not show a blip on the map
        coords = vector3(-354.49, 706.55, 116.93),             -- Position of the prompt and blip
        sprite = -379108622,                                    -- Blip hash (you can change it to any you want) -- https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips
        label = "Valentine Cinema",                              -- Name of the shop; also appears as the menu title
        mostrarComprar = true,                                 -- If true, the “Buy” option will appear in the menu; if false, it won’t
        mostrarVender = true,                                  -- If true, the “Sell” option will appear in the menu; if false, it won’t
        ItemsToBuy = {
            { label = "Bear Valentine", item = "movie_disc_bear_valentine", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiah Valentine", item = "movie_disc_josiah_valentine", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flight Valentine", item = "movie_disc_flight_valentine", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviors Valentine", item = "movie_disc_saviors_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststory Valentine", item = "movie_disc_ghoststory_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Damnation Valentine", item = "movie_disc_damnation_valentine", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Farmersdaughter Valentine", item = "movie_disc_farmersdaughter_valentine", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Modernmedicine Valentine", item = "movie_disc_modernmedicine_valentine", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Strongestman Valentine", item = "movie_disc_strongestman_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Sweetheart Valentine", item = "movie_disc_sweetheart_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Beartent Valentine", item = "movie_disc_beartent_valentine", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiahtent Valentine", item = "movie_disc_josiahtent_valentine", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flighttent Valentine", item = "movie_disc_flighttent_valentine", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviorstent Valentine", item = "movie_disc_saviorstent_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststorytent Valentine", item = "movie_disc_ghoststorytent_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
        },
        ItemsToSell = {
            { label = "Bear Valentine", item = "movie_disc_bear_valentine", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiah Valentine", item = "movie_disc_josiah_valentine", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flight Valentine", item = "movie_disc_flight_valentine", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviors Valentine", item = "movie_disc_saviors_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststory Valentine", item = "movie_disc_ghoststory_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Damnation Valentine", item = "movie_disc_damnation_valentine", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Farmersdaughter Valentine", item = "movie_disc_farmersdaughter_valentine", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Modernmedicine Valentine", item = "movie_disc_modernmedicine_valentine", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Strongestman Valentine", item = "movie_disc_strongestman_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Sweetheart Valentine", item = "movie_disc_sweetheart_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Beartent Valentine", item = "movie_disc_beartent_valentine", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiahtent Valentine", item = "movie_disc_josiahtent_valentine", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flighttent Valentine", item = "movie_disc_flighttent_valentine", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviorstent Valentine", item = "movie_disc_saviorstent_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststorytent Valentine", item = "movie_disc_ghoststorytent_valentine", price = 10, categoria = "Tickets", gold = false, weapon = false },
        }
    },

    ["blackwater"] = {
        StoreHoursAllowed = true,
        StoreOpen = 14,
        StoreClose = 23,
        job = false,
        enablenpc = true,
        cordnpc = vector4(-789.8, -1362.62, 43.82, 275.32),
        npcmodel = "A_F_M_ARMTOWNFOLK_02",
        enableblip = true,
        coords = vector3(-788.52, -1362.56, 43.82),
        sprite = -379108622,
        label = "Blackwater Cinema",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bear Blackwater", item = "movie_disc_bear_blackwater", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiah Blackwater", item = "movie_disc_josiah_blackwater", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Fligh Blackwatert", item = "movie_disc_flight_blackwater", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviors Blackwater", item = "movie_disc_saviors_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststory Blackwater", item = "movie_disc_ghoststory_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Damnation Blackwater", item = "movie_disc_damnation_blackwater", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Farmersdaughter Blackwater", item = "movie_disc_farmersdaughter_blackwater", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Modernmedicine Blackwater", item = "movie_disc_modernmedicine_blackwater", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Strongestman Blackwater", item = "movie_disc_strongestman_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Sweetheart Blackwater", item = "movie_disc_sweetheart_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Beartent Blackwater", item = "movie_disc_beartent_blackwater", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiahtent Blackwater", item = "movie_disc_josiahtent_blackwater", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flighttent Blackwater", item = "movie_disc_flighttent_blackwater", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviorstent Blackwater", item = "movie_disc_saviorstent_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststorytent Blackwater", item = "movie_disc_ghoststorytent_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
        },
        ItemsToSell = {
            { label = "Bear Blackwater", item = "movie_disc_bear_blackwater", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiah Blackwater", item = "movie_disc_josiah_blackwater", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Fligh Blackwatert", item = "movie_disc_flight_blackwater", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviors Blackwater", item = "movie_disc_saviors_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststory Blackwater", item = "movie_disc_ghoststory_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Damnation Blackwater", item = "movie_disc_damnation_blackwater", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Farmersdaughter Blackwater", item = "movie_disc_farmersdaughter_blackwater", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Modernmedicine Blackwater", item = "movie_disc_modernmedicine_blackwater", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Strongestman Blackwater", item = "movie_disc_strongestman_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Sweetheart Blackwater", item = "movie_disc_sweetheart_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Beartent Blackwater", item = "movie_disc_beartent_blackwater", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiahtent Blackwater", item = "movie_disc_josiahtent_blackwater", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flighttent Blackwater", item = "movie_disc_flighttent_blackwater", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviorstent Blackwater", item = "movie_disc_saviorstent_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststorytent Blackwater", item = "movie_disc_ghoststorytent_blackwater", price = 10, categoria = "Tickets", gold = false, weapon = false },
        }
    },

    ["stdenist"] = {
        StoreHoursAllowed = true,
        StoreOpen = 19,
        StoreClose = 23,
        job = false,
        enablenpc = true,
        cordnpc = vector4(2542.16, -1282.65, 49.22, 38.49),
        npcmodel = "A_F_M_MIDDLETRAINPASSENGERS_01",
        enableblip = true,
        coords = vector3(2541.12, -1281.42, 49.22),
        sprite = -417940443,
        label = "Saint Denis Theater",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bigband A", item = "show_ticket_bigband_a", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Bigband B", item = "show_ticket_bigband_b", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "bulletcatch", item = "show_ticket_bulletcatch", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Cancan A", item = "show_ticket_cancan_a", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Cancan B", item = "show_ticket_cancan_b", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Escapeartist", item = "show_ticket_escapeartist", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Escapenoose", item = "show_ticket_escapenoose", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Firebreath", item = "show_ticket_firebreath", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Firedance A", item = "show_ticket_firedance_a", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Firedance B", item = "show_ticket_firedance_b", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flexfight", item = "show_ticket_flexfight", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Oddfellows", item = "show_ticket_oddfellows", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Snakedance A", item = "show_ticket_snakedance_a", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Snakedance B", item = "show_ticket_snakedance_b", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Strongwoman", item = "show_ticket_strongwoman", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Sworddance", item = "show_ticket_sworddance", price = 10, categoria = "Tickets", gold = false, weapon = false },
        },
        ItemsToSell = {
            { label = "Bigband A", item = "show_ticket_bigband_a", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Bigband B", item = "show_ticket_bigband_b", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "bulletcatch", item = "show_ticket_bulletcatch", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Cancan A", item = "show_ticket_cancan_a", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Cancan B", item = "show_ticket_cancan_b", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Escapeartist", item = "show_ticket_escapeartist", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Escapenoose", item = "show_ticket_escapenoose", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Firebreath", item = "show_ticket_firebreath", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Firedance A", item = "show_ticket_firedance_a", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Firedance B", item = "show_ticket_firedance_b", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flexfight", item = "show_ticket_flexfight", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Oddfellows", item = "show_ticket_oddfellows", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Snakedance A", item = "show_ticket_snakedance_a", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Snakedance B", item = "show_ticket_snakedance_b", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Strongwoman", item = "show_ticket_strongwoman", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Sworddance", item = "show_ticket_sworddance", price = 10, categoria = "Tickets", gold = false, weapon = false },
        }
    },

    ["stdenisc"] = {
        StoreHoursAllowed = true,
        StoreOpen = 14,
        StoreClose = 21,
        job = false,
        enablenpc = true,
        cordnpc = vector4(2686.98, -1362.13, 48.21, 137.39),
        npcmodel = "A_F_M_ROUGHTRAVELLERS_01",
        enableblip = true,
        coords = vector3(2685.91, -1363.0, 48.21),
        sprite = -379108622,
        label = "Saint Denis Cinema",
        mostrarComprar = true,
        mostrarVender = true,
        ItemsToBuy = {
            { label = "Bear Staint-Denis", item = "movie_disc_bear_saintdenis", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiah Staint-Denis", item = "movie_disc_josiah_saintdenis", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flight Staint-Denis", item = "movie_disc_flight_saintdenis", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviors Staint-Denis", item = "movie_disc_saviors_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststory Staint-Denis", item = "movie_disc_ghoststory_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Damnation Staint-Denis", item = "movie_disc_damnation_saintdenis", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Farmersdaughter Staint-Denis", item = "movie_disc_farmersdaughter_saintdenis", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Modernmedicine Staint-Denis", item = "movie_disc_modernmedicine_saintdenis", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Strongestman Staint-Denis", item = "movie_disc_strongestman_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Sweetheart Staint-Denis", item = "movie_disc_sweetheart_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Beartent Staint-Denis", item = "movie_disc_beartent_saintdenis", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiahtent Staint-Denis", item = "movie_disc_josiahtent_saintdenis", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flighttent Staint-Denis", item = "movie_disc_flighttent_saintdenis", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviorstent Staint-Denis", item = "movie_disc_saviorstent_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststorytent Staint-Denis", item = "movie_disc_ghoststorytent_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
        },
        ItemsToSell = {
            { label = "Bear", item = "movie_disc_bear_saintdenis", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiah", item = "movie_disc_josiah_saintdenis", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flight", item = "movie_disc_flight_saintdenis", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviors", item = "movie_disc_saviors_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststory", item = "movie_disc_ghoststory_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Damnation", item = "movie_disc_damnation_saintdenis", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Farmersdaughter", item = "movie_disc_farmersdaughter_saintdenis", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Modernmedicine", item = "movie_disc_modernmedicine_saintdenis", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Strongestman", item = "movie_disc_strongestman_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Sweetheart", item = "movie_disc_sweetheart_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Beartent", item = "movie_disc_beartent_saintdenis", price = 0.5, categoria = "Tickets", gold = true, weapon = false },
            { label = "Josiahtent", item = "movie_disc_josiahtent_saintdenis", price = 0.5, categoria = "Tickets", gold = false, weapon = false },
            { label = "Flighttent", item = "movie_disc_flighttent_saintdenis", price = 1.50, categoria = "Tickets", gold = false, weapon = false },
            { label = "Saviorstent", item = "movie_disc_saviorstent_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
            { label = "Ghoststorytent", item = "movie_disc_ghoststorytent_saintdenis", price = 10, categoria = "Tickets", gold = false, weapon = false },
        }
    },
}


--############################# Translation ######################--

Config.Textos = {
    btnComprar = "BUY",
    btnVender = "SELL",
    btnCerrar = "CLOSE",
    btnVolver = "BACK",
    tituloComprar = "Buy Items",
    tituloVender = "Sell Items",
    sinCategoria = "No category",
    sinObjetos = "You don't have any items to sell",
    btnAccionComprar = "Buy",
    btnAccionVender = "Sell",
    monedaGold = "🪙",
    monedaDollar = "$",
    btnMax = "Max", 
    Notify = {
        notpermismerchat = "You do not have permission to access this merchant.",
        notpermishop = "You do not have permission to access this shop.",
        buy = "You bought",
        sell = "You sold",
        ford = "for",
        gold = "gold",
        dollar = "for $",
        errorobject = "Error removing the item",
        notobject = "You don’t have enough",
        tobuy = "to sell",
        notbuy = "This item cannot be sold",
        notmoney = "You don’t have enough money",
        notgold = "You don’t have enough gold",
        notspace = "You can’t carry more of this item",
        notmoreweapons = "You can’t carry more weapons",
    },
}
