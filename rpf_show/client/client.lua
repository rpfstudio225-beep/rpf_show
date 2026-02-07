local VorpCore = {}

----------

local blips = {}
local postmen = {}

local OpenStores = 0
local PromptGroup <const> = GetRandomIntInRange(0, 0xffffff)

local function setUpPrompt()
    OpenStores = UiPromptRegisterBegin()
    UiPromptSetControlAction(OpenStores, 0x760A9C6F)
    local label = VarString(10, 'LITERAL_STRING', "Open Menu")
    UiPromptSetText(OpenStores, label)
    UiPromptSetEnabled(OpenStores, true)
    UiPromptSetVisible(OpenStores, true)
    UiPromptSetStandardMode(OpenStores, true)
    UiPromptSetGroup(OpenStores, PromptGroup, 0)
    UiPromptRegisterEnd(OpenStores)
end

local function showPrompt(label, action)
    local labelToDisplay <const> = VarString(10, 'LITERAL_STRING', label)
    UiPromptSetActiveGroupThisFrame(PromptGroup, labelToDisplay, 0, 0, 0, 0)

    if UiPromptHasStandardModeCompleted(OpenStores, 0) then
        Wait(100)
        return action
    end
end

--------------------------

AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    ready = true
end)

Citizen.CreateThread(function()

    repeat Wait(2000) until LocalPlayer.state.IsInSession
    setUpPrompt()

    while true do
        Citizen.Wait(1)

        if not ready then
            return
        end

        local sleep = 1000
        local playerPed = PlayerPedId()

        if IsNearbyJobCenter() and (showPrompt("Buy ticket for see the show", "open") == "open") then
            sleep = 0
            UiPromptSetEnabled(OpenStores, true)
            TriggerEvent("rs_cinema:openMenuCine")
        end

    end
end)

function IsNearbyJobCenter()
    for _, jobcenter in pairs(Config.locations) do
        if IsPlayerNearCoords(jobcenter.coords.x, jobcenter.coords.y, jobcenter.coords.z, 2.0) then
            return true
        end
    end
   -- (showPrompt("Found new Job", "open") == "open")
    return false
end

------------------------

CreateThread(function()
    if Config.ShowBlip then 
        for i = 1, #Config.locations do 
            local zone = Config.locations[i]
            if zone.blips and type(zone.blips) == "number" then
                local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, zone.coords.x, zone.coords.y, zone.coords.z) 
                SetBlipSprite(blip, zone.blips, 1)
                SetBlipScale(blip, 0.8)
                Citizen.InvokeNative(0x9CB1A1623062F402, blip, zone.label)
            end
        end
    end
end)


CreateThread(function()
    repeat Wait(100) until ready
    Wait(300)

    local model = GetHashKey(Config.NpcJobModel)
    if not IsModelValid(model) then
        print(("[config.lua] ^1Model %s invalid, fallback to player model^7"):format(Config.NpcJobModel))
        model = GetEntityModel(PlayerPedId())
    end

    RequestModel(model, false)
    repeat Wait(50) until HasModelLoaded(model)

    for _, jobcenter in ipairs(Config.locations) do
        local ped = CreatePed(model, jobcenter.coords.x, jobcenter.coords.y, jobcenter.coords.z - 1.0, jobcenter.coords.w, false, false, false, false)
        repeat Wait(100) until DoesEntityExist(ped)

        Citizen.InvokeNative(0x283978A15512B2FE, ped, true) -- random outfit
        PlaceEntityOnGroundProperly(ped)
        SetEntityCanBeDamaged(ped, false)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetPedCanRagdoll(ped, false)

        table.insert(postmen, ped)
    end

    SetModelAsNoLongerNeeded(model)
end)

function table.find(f, l) -- find element v of l satisfying f(v)
    for _, v in ipairs(l) do
        if f(v) then
            return v
        end
    end
    return nil
end

-- utils

function IsPlayerNearCoords(x, y, z, dst)
    local playerPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, x, y, z, true)

    if distance < dst then
        return true
    end
    return false
end

function DrawText(text, fontId, x, y, scaleX, scaleY, r, g, b, a)
    -- Draw Text
    SetTextScale(scaleX, scaleY);
    SetTextColor(r, g, b, a);
    SetTextCentre(true);
    Citizen.InvokeNative(0xADA9255D, fontId); -- Loads the font requested
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y);

    -- Draw Backdrop
    local lineLength = string.len(text) / 100 * 0.66;
    DrawTexture("boot_flow", "selection_box_bg_1d", x, y, lineLength, 0.035, 0, 0, 0, 0, 200);
end

function DrawTexture(textureDict, textureName, x, y, width, height, rotation, r, g, b, a)

    if not HasStreamedTextureDictLoaded(textureDict) then

        RequestStreamedTextureDict(textureDict, false);
        while not HasStreamedTextureDictLoaded(textureDict) do
            Citizen.Wait(100)
        end
    end
    DrawSprite(textureDict, textureName, x, y + 0.015, width, height, rotation, r, g, b, a, true);
end

AddEventHandler("onResourceStop", function(res)
    if res ~= GetCurrentResourceName() then return end

    for _, ped in ipairs(postmen) do
        if ped and DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    postmen = {}

    for _, blip in ipairs(blips) do
        if blip and DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    blips = {}

    --print("^2[Mailbox]^7 Cleaned up NPCs and blips")

end)

----------------------

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterNetEvent("rs_cinema:openMenuCine")
AddEventHandler("rs_cinema:openMenuCine", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local function isNear(coords)
        return #(playerCoords - coords) < 20.0
    end

    -- Coordenadas de referencia
    local coordsTheaterSD = vector3(2546.49, -1299.39, 48.68)
    local coordsCinemaSD = vector3(2697.16, -1353.54, 48.54)
    local coordsCinemaBW = vector3(-778.88, -1362.68, 44.09)
    local coordsCinemaVA = vector3(-348.01, 697.84, 117.66)

    local Menu = exports.vorp_menu:GetMenuData()
    Menu.CloseAll()

    local MenuElements = {}

    if isNear(coordsTheaterSD) then
        table.insert(MenuElements, { label = Config.Language.Theatre, value = "shows", desc = Config.Language.Thedesc })
        table.insert(MenuElements, { label = Config.Language.Open, value = "openCurtains", desc = Config.Language.Opendesc })
        table.insert(MenuElements, { label = Config.Language.Close, value = "closeCurtains", desc = Config.Language.Closedesc})
    elseif isNear(coordsCinemaSD) then
        table.insert(MenuElements, { label = Config.Language.Movie, value = "movies_sd", desc = Config.Language.Moviesa })
    elseif isNear(coordsCinemaBW) then
        table.insert(MenuElements, { label = Config.Language.Movie, value = "movies_bw", desc = Config.Language.Movieba })
    elseif isNear(coordsCinemaVA) then
        table.insert(MenuElements, { label = Config.Language.Movie, value = "movies_va", desc = Config.Language.Movieva })
    else

		VorpCore.NotifyLeft(Config.Language.Noty, Config.Language.Zone, "menu_textures", "cross", 3000, "COLOR_RED")
        return
    end

    Menu.Open("default", GetCurrentResourceName(), "OpenMenu", {
        title = Config.Language.Menu,
        subtext = Config.Language.Menutext,
        align = "top-left",
        elements = MenuElements,
        itemHeight = "4vh"
    }, function(data, menu)
        if data.current.value == "shows" then
            OpenShowsMenu(menu)
        elseif data.current.value == "movies_sd" then
            OpenMoviesInTown(menu, "SAINTDENIS")
        elseif data.current.value == "movies_bw" then
            OpenMoviesInTown(menu, "BLACKWATER")
        elseif data.current.value == "movies_va" then
            OpenMoviesInTown(menu, "VALENTINE")
        elseif data.current.value == "openCurtains" then
			TriggerServerEvent("rs_cinema:SyncPlayScene", "PBL_OPEN_SLOW")
		elseif data.current.value == "closeCurtains" then
			TriggerServerEvent("rs_cinema:SyncPlayScene", "PBL_CLOSE_SLOW")
        end
    end, function(data, menu)
        menu.close()
    end)
end)

function OpenShowsMenu(parentMenu)
    local shows = {
        { label =  Config.Language.Biga, value = "BIGBAND_A" },
        { label =  Config.Language.Bigb, value = "BIGBAND_B" },
        { label =  Config.Language.Bullet, value = "BULLETCATCH" },
        { label =  Config.Language.Cana, value = "CANCAN_A" },
        { label =  Config.Language.Canb, value = "CANCAN_B" },
        { label =  Config.Language.Scape, value = "ESCAPEARTIST" },
        { label =  Config.Language.Lasso, value = "ESCAPENOOSE" },
        { label =  Config.Language.Fire, value = "FIREBREATH" },
        { label =  Config.Language.Firea, value = "FIREDANCE_A" },
        { label =  Config.Language.Fireb, value = "FIREDANCE_B" },
        { label =  Config.Language.Forze, value = "FLEXFIGHT" },
        { label =  Config.Language.Circus, value = "ODDFELLOWS" },
        { label =  Config.Language.Snakea, value = "SNAKEDANCE_A" },
        { label =  Config.Language.Snakeb, value = "SNAKEDANCE_B" },
        { label =  Config.Language.Forzea, value = "STRONGWOMAN" },
        { label =  Config.Language.Dance, value = "SWORDDANCE" }
    }

    local showMenuElements = {}
    for _, show in ipairs(shows) do
        table.insert(showMenuElements, {
            label = show.label,
            value = show.value,
            desc = Config.Language.Ini .. " " .. show.label
        })
    end

    local Menu = exports.vorp_menu:GetMenuData()
    Menu.CloseAll()

    Menu.Open("default", GetCurrentResourceName(), "OpenShowsMenu", {
        title = Config.Language.Selec,
        subtext = Config.Language.Men,
        align = "top-left",
        elements = showMenuElements,
        lastmenu = "menucine",
        itemHeight = "4vh"
    }, function(data, menu)

        TriggerEvent("rs_cinema:StartShow", data.current.value)
        menu.close()
        parentMenu.close()
    end, function(data, menu)
        menu.close()
        parentMenu.close()
    end)
end

function OpenMoviesInTown(parentMenu, townName)
    local Menu = exports.vorp_menu:GetMenuData()
    Menu.CloseAll()

    local movies = {
        { label = Config.Language.Bear, value = "BEAR" },
        { label = Config.Language.Josiah, value = "JOSIAH" },
        { label = Config.Language.Secre, value = "SECRET_OF_MANFLIGHT" },
        { label = Config.Language.Sauva, value = "SAVIORS_AND_SAVAGES" },
        { label = Config.Language.Ghost, value = "GHOST_STORY" },
        { label = Config.Language.Direc, value = "DIRECT_CURRENT_DAMNATION" },
        { label = Config.Language.Daughter, value = "FARMERS_DAUGHTER" },
        { label = Config.Language.Medicine, value = "MODERN_MEDICINE" },
        { label = Config.Language.World, value = "WORLDS_STRONGEST_MAN" },
        { label = Config.Language.Drawing, value = "SKETCHING_FOR_SWEETHEART" },
        { label = Config.Language.Bear2, value = "BEAR_TENT" },
        { label = Config.Language.Josiah2, value = "JOSIAH_TENT" },
        { label = Config.Language.Secre2, value = "SECRET_OF_MANFLIGHT_TENT" },
        { label = Config.Language.Sauva2, value = "SAVIORS_AND_SAVAGES_TENT" },
        { label = Config.Language.Ghost2, value = "GHOST_STORY_TENT" }
    }

    Menu.Open("default", GetCurrentResourceName(), "movies_menu_" .. townName, {
        title = Config.Language.Film .. " " .. townName,
        subtext = Config.Language.Filme,
        align = "top-left",
        elements = movies,
        itemHeight = "4vh",
    }, function(data, menu)
        if not data.current or not data.current.value then
            return
        end
        TriggerEvent("rs_cinema:StartMovie", "MOVIE", townName, data.current.value)
        menu.close()
        if parentMenu then parentMenu.close() end
    end, function(data, menu)
        menu.close()
        if parentMenu then parentMenu.close() end
    end)
end

RegisterNetEvent("rs_cinema:playScene")
AddEventHandler("rs_cinema:playScene", function(scene)
    local prop = GetClosestObjectOfType(2546.5337, -1308.0767, 54.9782, 10.0, GetHashKey("p_new_theater_curtain"), false, false, false)

    if DoesEntityExist(prop) then

        if not Config.CurtainScene then
            Config.CurtainScene = Citizen.InvokeNative(0x1FCA98E33C1437B3, "script@shows@curtains@curtains", 0, "PBL_IDLE_CLOSED", false, true)
            SetAnimSceneEntity(Config.CurtainScene, "CURTAIN", prop, 0)
        end

        LoadAnimScene(Config.CurtainScene)
        while not _IsAnimSceneLoaded(Config.CurtainScene) do
            Citizen.Wait(10)
        end

        -- Reproducir la animación
        StartAnimScene(Config.CurtainScene)
        SetAnimScenePaused(Config.CurtainScene, false)

        SetAnimScenePlaybackList(Config.CurtainScene, scene)
        Citizen.InvokeNative(0x15598CFB25F3DC7E, Config.CurtainScene, scene, true)

    end
end)

RegisterNetEvent("rs_cinema:StartShow")
AddEventHandler("rs_cinema:StartShow", function(show, projection, movie)
    TriggerServerEvent("rs_cinema:SyncShow", show, projection, movie)
end)

RegisterNetEvent("rs_cinema:StartMovie")
AddEventHandler("rs_cinema:StartMovie", function(show, projection, movie)
    TriggerServerEvent("rs_cinema:SyncMovie", show, projection, movie)
end)

local CinemaLocations = {
    ["SaintDenis"] = vector3(2697.16, -1353.54, 48.54),
    ["Blackwater"] = vector3(-778.88, -1362.68, 44.09),
    ["Valentine"] = vector3(-348.01, 697.84, 117.66)
}

local ActiveMovies = {}

RegisterNetEvent("rs_cinema:UpdateMovieStatus")
AddEventHandler("rs_cinema:UpdateMovieStatus", function(cinemaName, state)
    ActiveMovies[cinemaName] = state
end)

RegisterNetEvent("rs_cinema:PlayMovie")
AddEventHandler("rs_cinema:PlayMovie", function(show, projection, movie)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local cinemaName = nil

    for name, location in pairs(CinemaLocations) do
        if #(playerCoords - location) < 10.0 then
            cinemaName = name
            break
        end
    end

    if not cinemaName then
        return
    end

    if ActiveMovies[cinemaName] then
        VorpCore.NotifyLeft(Config.Language.Noty, Config.Language.Play, "menu_textures", "cross", 3000, "COLOR_RED")
        return
    end

    ActiveMovies[cinemaName] = true
    TriggerServerEvent("rs_cinema:SetMovie", cinemaName, true)

    StartShow(show, projection, movie)

    Citizen.CreateThread(function()
        local duration = 0
        Citizen.Wait(duration)

        ActiveMovies[cinemaName] = false
        TriggerServerEvent("rs_cinema:SetMovie", cinemaName, false)
    end)
end)

local animscene = nil

RegisterNetEvent("rs_cinema:PlayShow")
AddEventHandler("rs_cinema:PlayShow", function(show, projection, movie)
    if animscene and _IsAnimSceneLoaded(animscene) and not _IsAnimSceneFinished(animscene) then
        return
    end

    TriggerServerEvent("rs_cinema:SetPlaying", true)

    animscene = StartShow(show, projection, movie)

    while animscene and not _IsAnimSceneStarted(animscene) do
        Wait(100)
    end

    CreateThread(function()
        while animscene and not _IsAnimSceneFinished(animscene) and not _IsAnimSceneFinished_2(animscene) do
            Wait(1000)
        end

        Wait(500)

        if animscene then
            DeleteAnimScene(animscene)
        end

        animscene = nil
        TriggerServerEvent("rs_cinema:SetPlaying", false)
    end)
end)

RegisterNetEvent("rs_cinema:StartPlay")
AddEventHandler("rs_cinema:StartPlay", function(show, projection, movie)
    if animscene and _IsAnimSceneLoaded(animscene) and not _IsAnimSceneFinished(animscene) then
        return
    end

    TriggerServerEvent("rs_cinema:SetPlaying", true)

    animscene = StartShow(show, projection, movie)

    while animscene and not _IsAnimSceneStarted(animscene) do
        Wait(100)
    end

    CreateThread(function()
        while animscene and not _IsAnimSceneFinished(animscene) and not _IsAnimSceneFinished_2(animscene) do
            Wait(1000)
        end

        Wait(500)

        if animscene then
            DeleteAnimScene(animscene)
        end

        animscene = nil
        TriggerServerEvent("rs_cinema:SetPlaying", false)
    end)
end)


StartShow = function(show, projection, movie)
	if Config.Shows[show] then
		local preventAnimscene, movieData = false, nil

		if (show:upper() == "MOVIE") then
			if IsMovieValid(projection, movie) then
				movieData = SetupMovie(projection, movie)
				projection, movie = Config.Projections[projection], Config.Movies[movie]
			else 
				return
			end
		end

		local rope, attachment = nil, nil
		local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.Shows[show].animscene[1], Config.Shows[show].animscene[2], Config.Shows[show].animscene[3], Config.Shows[show].animscene[4], Config.Shows[show].animscene[5]) --// _CREATE_ANIM_SCENE / ->f_48

		if animscene then
			if Config.Shows[show].position then

				SetAnimSceneOrigin(animscene, Config.Shows[show].position, Config.Shows[show].rotation, 2);
			end

			for index,entity in ipairs(Config.Shows[show].entities) do 
				local handle = 0

				if IsModelInCdimage(entity.model) or type(entity.model) == "string" then
					if IsModelInCdimage(entity.model) then
						while not HasModelLoaded(entity.model) do RequestModel(entity.model) Citizen.Wait(10) end
					end

					if IsModelAPed(entity.model) then
						handle = CreatePed(entity.model, vector3(0.0, 0.0, -500.0), 0.0, false, false, true, true);			
						AddEntityToAudioMixGroup(handle, "Default_Show_Performers_Group", -1.0);
						Citizen.InvokeNative(0x283978A15512B2FE, handle, true)

						if entity.flags then
							for _,flag in ipairs(entity.flags) do
								SetPedConfigFlag(handle, flag, true)
							end
						end

						if entity.ragdoll ~= nil then
							SetPedCanRagdoll(handle, false)			
						end

						if entity.ragdollFlag then
							SetRagdollBlockingFlags(handle, entity.ragdollFlag)
						end
					elseif type(entity.model) == "string" then	
						if IsWeaponValid(GetHashKey(entity.model)) then
							handle = Citizen.InvokeNative(0x9888652B8BA77F73, GetHashKey(entity.model), 0, vector3(0.0, 0.0, 0.0), true, 1.0);
						end
					else
						handle = CreateObject(entity.model, vector3(0.0, 0.0, -500.0), false, false, false, true, true);
					end

					SetAnimSceneEntity(animscene, entity.fields[1], handle, entity.fields[2])
					SetModelAsNoLongerNeeded(entity.model)
				end
			end

			LoadAnimScene(animscene)  
			while not _IsAnimSceneLoaded(animscene) do Citizen.Wait(10) end

			local curtain, curtainZone = GetShowCurtain(show)
			if curtain then
				ResetCurtain(curtainZone)

				if not _IsAnimSceneLoaded(curtain.animscene) then
					LoadAnimScene(curtain.animscene)  
					while not _IsAnimSceneLoaded(curtain.animscene) do Citizen.Wait(10) end
				end

				StartAnimScene(animscene)
				SetAnimScenePaused(animscene, true)

				StartAnimScene(curtain.animscene)
				while not _IsAnimSceneStarted(curtain.animscene) do Citizen.Wait(10) end

				PlayCurtainSound(Config.Shows[show].music)
				SetAnimScenePlaybackList(curtain.animscene, "PBL_OPEN_SLOW")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, curtain.animscene, "PBL_OPEN_SLOW", true)	

				if (show == "ESCAPENOOSE") and not rope then 
					rope, attachment = CreateNooseRope(animscene)
				end

				while not _IsAnimSceneStarted(curtain.animscene) do Citizen.Wait(10) end
				while not (_GetAnimsceneProgress(curtain.animscene) > 0.5) do Citizen.Wait(10) end
			
				SetAnimScenePlaybackList(curtain.animscene, "PBL_IDLE_OPEN")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, curtain.animscene, "PBL_IDLE_OPEN", true)
				SetAnimScenePaused(animscene, false)
			end

			if (show == "ESCAPENOOSE") and not rope then 
				rope, attachment = CreateNooseRope(animscene)
			end

			while not _IsAnimSceneStarted(animscene) do StartAnimScene(animscene) Citizen.Wait(100) end
			if not (show:upper() == "MOVIE") then
				while not _IsAnimSceneFinished(animscene) do Citizen.Wait(10) end
			end
		
			--// Sequences
			if Config.Shows[show].sequence then
				for index,transition in ipairs(Config.Shows[show].sequence) do
					if type(transition) == "table" then
						if Config.RandomTransitions then
							transition = transition[math.random(1, #transition)]
						else transition = transition[1] end
					end

					SetAnimScenePlaybackList(animscene, transition)
					Citizen.InvokeNative(0x15598CFB25F3DC7E, animscene, transition, true)

					while not _IsAnimSceneStarted(animscene) do Citizen.Wait(1) end

					if (show == "ESCAPENOOSE" and transition == "PL_E_Shoot_Rope") then
						if rope then
							DetachRopeFromEntity(rope, Citizen.InvokeNative(0xFB5674687A1B2814, animscene, "Noose", false))
						end
					end

					if (index == #Config.Shows[show].sequence) and Config.Shows[show].endAtProgress then
						break
					end

					while not _IsAnimSceneFinished(animscene) do Citizen.Wait(1) end
				end
			end

			if Config.Shows[show].endAtProgress then
				while not (_GetAnimsceneProgress(animscene) >= Config.Shows[show].endAtProgress) do Citizen.Wait(10) end
			end

			if curtain then
				SetAnimScenePlaybackList(curtain.animscene, "PBL_CLOSE_SLOW")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, curtain.animscene, "PBL_CLOSE_SLOW", true)

				while not _IsAnimSceneStarted(curtain.animscene) do Citizen.Wait(10) end
				while not (_GetAnimsceneProgress(curtain.animscene) > 0.5) do Citizen.Wait(10) end

				SetAnimScenePlaybackList(curtain.animscene, "PBL_IDLE_CLOSED")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, curtain.animscene, "PBL_IDLE_CLOSED", true)
			end
		end


		if (show:upper() == "MOVIE") then
			if animscene then 
				SetAnimScenePlaybackList(animscene, "pl_action")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, animscene, "pl_action", true)
			
				while not _IsAnimSceneStarted(animscene) do Citizen.Wait(10) end
			end
		
			SetTvAudioFrontend(false)
			SetTvVolume(projection.volume)

			AttachTvAudioToEntity(movieData.screen)
			N_0xf49574e2332a8f06(movieData.screen, 5.0)
			N_0x04d1d4e411ce52d0(movieData.screen, movieData.renderTarget)

			SetTvChannel(-1)
			SetTvChannelPlaylist(0, movie.clip, true)
			SetTvChannel(0)

			_LoadStream(movie.audio)
			local stream = N_0x0556c784fa056628("Audience", movie.audio)
			PlayStreamFromPosition(projection.audiencePos, stream)

			Citizen.Wait(100)
			SetEntityVisible(movieData.screen, true)

			while IsStreamPlaying(stream) do
				if (projection.radius and (Vdist(GetEntityCoords(PlayerPedId()), projection.audiencePos) <= projection.radius)) or not projection.radius then
					SetTextRenderId(movieData.renderTarget)
					DrawTvChannel(projection.renderX, projection.renderY, projection.renderScaleX, projection.renderScaleY, 0.0, 255, 255, 255, 128)
				end

				Citizen.Wait(5)
			end
		end

		if (show:upper() == "MOVIE") then
			SetTvChannel(-1)
			SetTextRenderId(0)
			DeleteEntity(movieData.screen)

			if IsStreamPlaying(stream) then
				StopStream(stream)
			end

			if IsNamedRendertargetRegistered(projection.renderTarget) then
				ReleaseNamedRendertarget(projection.renderTarget)
			end
		end

		if animscene then
			if not (show:upper() == "MOVIE") then
				while not _IsAnimSceneFinished(animscene) do Citizen.Wait(10) end
			end

			if rope or attachment then 
				DeleteRope(rope)
				DeleteEntity(attachment) 
			end

			for index,entity in ipairs(Config.Shows[show].entities) do 
				if IsModelAPed(entity.model) then
					DeleteEntity(Citizen.InvokeNative(0xE5822422197BBBA3, animscene, entity.fields[1], false))
				elseif IsModelAVehicle(entity.model) then
					DeleteEntity(Citizen.InvokeNative(0x430EE0A19BC5A287, animscene, entity.fields[1], false))
				else
					DeleteEntity(Citizen.InvokeNative(0xFB5674687A1B2814, animscene, entity.fields[1], false))
				end
			end
			Citizen.InvokeNative(0x84EEDB2C6E650000, animscene)
		end
	end
end

SetupMovie = function(projection, movie)
	projection, movie = Config.Projections[projection], Config.Movies[movie]

	Config.Shows["MOVIE"].animscene[1] = movie.animscene or "script@shows@magic_lantern@ig2_projectionist@thebear"
	Config.Shows["MOVIE"].position = projection.originPos
	Config.Shows["MOVIE"].rotation = projection.originRot

	while not HasModelLoaded(projection.targetModel) do RequestModel(projection.targetModel) Citizen.Wait(10) end
	local screen = CreateObjectNoOffset(projection.targetModel, projection.screenPos, false, false, false, true)
	SetEntityRotation(screen, projection.screenRot, 2, true)
	SetEntityVisible(screen, false)
	SetEntityDynamic(screen, false)
	SetEntityProofs(screen, 31, false)
	FreezeEntityPosition(screen, true)
	SetModelAsNoLongerNeeded(projection.targetModel)

	if not IsNamedRendertargetRegistered(projection.renderTarget) then
		RegisterNamedRendertarget(projection.renderTarget, false)
		LinkNamedRendertarget(projection.targetModel)

		if not IsNamedRendertargetLinked(projection.targetModel) then	
			ReleaseNamedRendertarget(projection.renderTarget)
			return
		end
	end

	return { screen = screen, renderTarget = GetNamedRendertargetRenderId(projection.renderTarget) }
end

IsMovieValid = function(projection, movie)
	return (Config.Projections[projection] and Config.Movies[movie])
end

GetShowCurtain = function(zone)
	if Config.Shows[zone] and Config.Shows[zone].curtain then
		return Config.Curtains[Config.Shows[zone].curtain], Config.Shows[zone].curtain
	end

	return
end

PlayCurtainSound = function(soundName)
	if not soundName then
		if math.random(1,2) == 2 then
			soundName = "Curtain_Opens_Music"
		else
			soundName = "Curtain_Open_Music"
		end
	end

	if Config.Soundsets[soundName] then
		while not LoadStream(soundName, Config.Soundsets[soundName]) do Citizen.Wait(10) end

		local stream = N_0x0556c784fa056628(soundName, Config.Soundsets[soundName])
		if (stream ~= -1) then
			N_0x839c9f124be74d94(stream, 0, 2548.749, -1305.267, 50.01453)
			N_0x839c9f124be74d94(stream, 1, 2543.801, -1305.251, 50.01453)

			PlayStreamFromPosition(2548.749, -1305.267, 50.01453, stream)
		end
	end
end

CreateCurtains = function()
	while not HasModelLoaded(`p_new_theater_curtain`) do RequestModel(`p_new_theater_curtain`) Citizen.Wait(10) end

	for zone,coords in pairs(Config.Curtains) do
		Config.Curtains[zone] = { object = CreateObject(`p_new_theater_curtain`, coords, false, false, false, false) }
		Config.Curtains[zone].animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, "script@shows@curtains@curtains", 0, "PBL_IDLE_CLOSED", false, true)
		SetAnimSceneEntity(Config.Curtains[zone].animscene, "CURTAIN", Config.Curtains[zone].object, 0)
	end

	SetModelAsNoLongerNeeded(`p_new_theater_curtain`)
end

ResetCurtain = function(zone)
	if Config.Curtains[zone] then
		ResetAnimScene(Config.Curtains[zone].animscene, 0)

		SetAnimSceneEntity(Config.Curtains[zone].animscene, "CURTAIN", Config.Curtains[zone].object, 0)

		SetAnimScenePlaybackList(Config.Curtains[zone].animscene, "PBL_IDLE_CLOSED")
		Citizen.InvokeNative(0x15598CFB25F3DC7E, Config.Curtains[zone].animscene, "PBL_IDLE_CLOSED", true)
	end
end

CreateNooseRope = function(animscene)
	local noose = Citizen.InvokeNative(0xFB5674687A1B2814, animscene, "Noose", false)

	if DoesEntityExist(noose) then
		while not HasModelLoaded(`P_SHOTGLASS01X`) do RequestModel(`P_SHOTGLASS01X`) Citizen.Wait(10) end
		local ropeAttachment = CreateObject(`P_SHOTGLASS01X`, GetOffsetFromEntityInWorldCoords(noose, 0.0, -0.6, 0.6023343), false, false, false, false, false)

		local rope = Citizen.InvokeNative(0xE9C59F6809373A99, 2546.724, -1309.638, 50.76665, 0.0, 0.0, 0.0, 0.3, 1, 0, -1, -1082130432)
		N_0x462ff2a432733a44(rope, ropeAttachment, noose, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0) --// ATTACH_ENTITIES_TO_ROPE ?
		N_0x522fa3f490e2f7ac(rope, 1, 1)

		SetModelAsNoLongerNeeded(`P_SHOTGLASS01X`)

		return rope, ropeAttachment
	end

	return nil
end

_LoadStream = function(soundSet)
	local timeout = 0
	while not LoadStream("Audience", soundSet) do
		if timeout > 4 then break end
		timeout = timeout+1

		Citizen.Wait(25) 
	end
end

_IsAnimSceneLoaded = function(animscene)
	return Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0)
end
_IsAnimSceneStarted = function(animscene)
	return Citizen.InvokeNative(0xCBFC7725DE6CE2E0, animscene, true)
end
_IsAnimSceneFinished = function(animscene)
	return (Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) == 1.0)
end
_IsAnimSceneFinished_2 = function(animscene)
	return Citizen.InvokeNative(0xD8254CB2C586412B, animscene, 0)
end
_GetAnimsceneProgress = function(animscene)
	return Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat())
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _,entry in ipairs(Config.CreatedEntries) do
			if (entry.type == "ENTITY") then
				if DoesEntityExist(entry.handle) then DeleteEntity(entry.handle) end
			elseif (entry.type == "CAM") then
				if DoesCamExist(entry.handle) then RenderScriptCams(false, false, 0, false, false, false) DestroyCam(entry.handle) end            
			end
		end

		for _,curtain in pairs(Config.Curtains) do
			if type(curtain) == "table" then
				DeleteEntity(curtain.object)
				Citizen.InvokeNative(0x84EEDB2C6E650000, curtain.animscene)
			end
		end
	end
end)

Citizen.SetTimeout(0, CreateCurtains)