local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local site = 0
local working = false
local constructionTruck = nil
local truckSpawn = nil
local truckSupplies = 0
local hasFibreOp = false
local truckBlip = nil
local hasSupplies = false
local truckParked = false
local unionName = "none"
local cone1 = nil
local cone2 = nil
local cone3 = nil
local cone4 = nil
local cone5 = nil
local cone6 = nil
local sign = nil
local supe1 = nil
local supe2 = nil
local supe3 = nil
local dirtPile = nil
local canUnload = false
local hasShovel = false
local hasDirt = false
local currDirtZone = nil
local currWorkArea = nil
local supplyArea = nil
local workLeft = 6
local workDone = false
local truckParkZone = nil
local drilling = false
local grabbing = false
local carParkBlip = nil
local workBlip = nil
local supplyBlip = nil
local garageCoords = nil
local garageZone = nil
local garageBlip = nil
local hasRubble = false
local isMarkerActive = false
local markerCoords = nil

local function GetClothes()
    TriggerServerEvent('cain-unions:loadPlayerSkin') 
end


local function Notificacion(text, time)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, time)
end

local function cleanup()
    GetClothes()
    Notificacion("Come on back another time if you want to work!", 2000)
    site = 0
    working = false
    ClearAllBlipRoutes()
    if constructionTruck then
        DeleteVehicle(constructionTruck)
        constructionTruck = nil
    end
    truckSpawn = nil
    truckSupplies = 0
    hasFibreOp = false
    if truckBlip then
        RemoveBlip(truckBlip)
        truckBlip = nil
    end
    hasSupplies = false
    truckParked = false
    hasRubble = false
    unionName = "none"
    cone1 = nil
    if cone1 then
        DeleteObject(cone1)
        cone1 = nil
    end
    if cone2 then
        DeleteObject(cone2)
        cone2 = nil
    end
    if cone3 then
        DeleteObject(cone3)
        cone3 = nil
    end
    if cone4 then
        DeleteObject(cone4)
        cone4 = nil
    end
    if cone5 then
        DeleteObject(cone5)
        cone5 = nil
    end
    if cone6 then
        DeleteObject(cone6)
        cone6 = nil
    end
    if sign then
        DeleteObject(sign)
        sign = nil
    end
    if supe1 then
        DeletePed(supe1)
        supe1 = nil
    end
    if supe2 then
        DeletePed(supe2)
        supe2 = nil
    end
    if supe3 then
        DeletePed(supe3)
        supe3 = nil
    end
    if dirtPile then
        DeleteObject(dirtPile)
        dirtPile = nil    
    end
    canUnload = false
    hasShovel = false
    hasDirt = false
    if currDirtZone then
        currDirtZone:destroy()
        currDirtZone = nil
    end
    if currWorkArea then
        currWorkArea:destroy()
        currWorkArea = nil
    end
    if supplyArea then
        exports['qb-target']:RemoveZone("supplyArea")
        supplyArea = nil
    end
    workLeft = 6
    workDone = false
    if truckParkZone then
        truckParkZone:destroy()
        truckParkZone = nil
    end
    drilling = false
    grabbing = false
    
    if workBlip then
        RemoveBlip(workBlip)
        workBlip = nil
    end
    if supplyBlip then
        RemoveBlip(supplyBlip)
        supplyBlip = nil
    end
    if garageZone then
        garageZone:destroy()
        garageZone = nil
    end
    if garageBlip then
        RemoveBlip(garageBlip)
        garageBlip = nil
    end
    garageCoords = nil
    isMarkerActive = false
    markerCoords = nil
end

StartAnim = function(lib, anim)
    RequestAnimDict(lib)
    while not HasAnimDictLoaded(lib) do
        Wait(1)
    end
    TaskPlayAnim(PlayerPedId(), lib, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
end




local function unionFired()
    --Fire from union if under 0
end

local function triggerPortPolice()
    --Generic always changing police trigger
end


CreateThread(function()
    while true do
        Wait(0)
        if isMarkerActive and isMarkerActive == true then
            DrawMarker(23, markerCoords.x, markerCoords.y, markerCoords.z-0.8,
                0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 255, 0, 0, 160, true, 0,
                0, 0)
        end
    end
end)

local function GivePay()
    local pay = Config.Pay - Config.UnionDues
    if unionName == "garbage" then
        pay += Config.PayBonus
    end
    TriggerServerEvent('cain-portjob:server:payForJob', pay)
end

local function GiveRep()
    local rep = Config.DefaultRep
    if unionName == "garbage" then
        rep += Config.ConstructionRepBonus
    end
    TriggerServerEvent('cain-portjob:server:updatePortRep', rep, unionName)
end

local function WaitForGarageKeypress()
    if working and constructionTruck then
        local ped = GetPlayerPed(-1)
        CreateThread(function()
            while garageBlip do
                if IsControlJustReleased(0, 38) then
                    if GetVehiclePedIsIn(ped, false) == constructionTruck then
                        isMarkerActive = false
                        markerCoords = nil
                        TaskLeaveVehicle(ped, constructionTruck, 0)
                        TaskTurnPedToFaceEntity(ped, constructionTruck)
                        GivePay()
                        GiveRep()
                        cleanup()
                        return 
                    end
                end
                
                Wait(0)
            end
        end)
    end
end

local function setupGarage()
    local blip = AddBlipForCoord(garageCoords.x, garageCoords.y, garageCoords.z)
    SetBlipSprite(blip, 225)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 18)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Union Garage")
    EndTextCommandSetBlipName(blip)
    Notificacion("Bring truck back to construction site.", -1)
    garageBlip = blip
    SetBlipRoute(garageBlip, true)
    markerCoords = garageCoords
    isMarkerActive = true
    garageZone = BoxZone:Create(garageCoords, 3, 3, {
        name = "garage",
        debugPoly = false,
        heading = garageCoords.w,
        minZ = garageCoords.z - 5.0,
        maxZ = garageCoords.z + 5.0
    })
    garageZone:onPlayerInOut(function(isPointInside, _)
        if isPointInside then
            local ped = PlayerPedId()
            if GetVehiclePedIsIn(GetPlayerPed(-1), false) == constructionTruck then
              Notificacion("Press E to return truck.", -1)
                WaitForGarageKeypress()
            end
        end
    end)
end


local function setupWorkBlip(num)
    local blip = AddBlipForCoord(Config.RoadLocations[site].workAreas[num].x, Config.RoadLocations[site].workAreas[num].y, Config.RoadLocations[site].workAreas[num].z)
    SetBlipSprite(blip, 544)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 18)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Work Area")
    EndTextCommandSetBlipName(blip)
    workBlip = blip
end

local function setupDirtPickup(num)
    --hasdirt
    currDirtZone = BoxZone:Create(Config.RoadLocations[site].workAreas[workLeft], 3, 3, {
        name = "dirtZone",
        debugPoly = false,
        heading = Config.RoadLocations[site].workAreas[workLeft].w,
        minZ = Config.RoadLocations[site].workAreas[workLeft].z - 3.0,
        maxZ = Config.RoadLocations[site].workAreas[workLeft].z + 3.0
    })
    currDirtZone:onPlayerInOut(function(isPointInside, _)
        if isPointInside then
            local ped = PlayerPedId()
            local function CheckForDirtKeypress()
                --
                while constructionTruck do
                    if drilling == false then
                        if IsControlJustReleased(0, 38) then
                            isMarkerActive = false
                            markerCoords = nil
                            drilling = true
                            local ped = GetPlayerPed(-1)
                            currDirtZone:destroy()
                            currDirtZone = nil

                            --SWAP THIS WITH SHOVEL  
                            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CONST_DRILL", 0, true)
                            
                            
                            FreezeEntityPosition(ped, true)
                            SetBlockingOfNonTemporaryEvents(ped, true)
                            Wait(math.random(4000,8000))
                            ClearPedTasks(ped)
                            FreezeEntityPosition(ped, false)
                            SetBlockingOfNonTemporaryEvents(ped, false)
                            drilling = false
                            DeleteObject(dirtPile)
                            dirtPile = nil
                            hasShovel = true
                            --Create animation 



                            Notificacion("Put rubble into truck!", -1)
                            SetBlipRoute(workBlip, false)
                            RemoveBlip(workBlip)
                            workBlip = nil
                            SetBlipRoute(truckBlip, true)

                            --
                            return
                        end
                    end
                    Wait(0)
                end
            end
            if IsPedInVehicle(GetPlayerPed(-1)) == false then
                Notificacion("Press E to collect rubble.", -1)
                CheckForDirtKeypress()
            end
            
        end
    end)
end

local function createWorkZone()
    markerCoords = Config.RoadLocations[site].workAreas[workLeft]
    isMarkerActive = true
    currWorkArea = BoxZone:Create(Config.RoadLocations[site].workAreas[workLeft], 3, 3, {
        name = "workZone",
        debugPoly = false,
        heading = Config.RoadLocations[site].workAreas[workLeft].w,
        minZ = Config.RoadLocations[site].workAreas[workLeft].z - 3.0,
        maxZ = Config.RoadLocations[site].workAreas[workLeft].z + 3.0
    })
    currWorkArea:onPlayerInOut(function(isPointInside, _)
        if isPointInside then
            local ped = PlayerPedId()
            local function CheckForWorkKeypress()
                while constructionTruck do
                    if drilling == false then
                        if IsControlJustReleased(0, 38) then
                            isMarkerActive = false
                            markerCoords = nil
                            drilling = true
                            local ped = GetPlayerPed(-1)
                            currWorkArea:destroy()
                            currWorkArea = nil
                            local HashKey = GetHashKey(Config.DirtPile)
                            RequestModel(HashKey)
                            
                            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CONST_DRILL", 0, true)
                            FreezeEntityPosition(ped, true)
                            SetBlockingOfNonTemporaryEvents(ped, true)
                            Wait(math.random(10000,18000))
                            ClearPedTasks(ped)
                            FreezeEntityPosition(ped, false)
                            SetBlockingOfNonTemporaryEvents(ped, false)
                            drilling = false
                            dirtPile = CreateObject(HashKey, 
                            Config.RoadLocations[site].workAreas[workLeft].x,
                            Config.RoadLocations[site].workAreas[workLeft].y,
                            Config.RoadLocations[site].workAreas[workLeft].z-3.5,
                            false, true, 0)
                            SetEntityHeading(dirtPile, Config.RoadLocations[site].workAreas[workLeft].w)
                            FreezeEntityPosition(dirtPile, true)
    
                            --Create New Zone to pickup shit
                            setupDirtPickup(workLeft)
                            return
                        end
                    end
                    Wait(0)
                end
            end
            if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
                Notificacion("Press E to start road work.", -1)
                CheckForWorkKeypress()
            end
        end
    end)
end

local function setupSupplyBlip()
    local blip = AddBlipForCoord(Config.MaterialPile.x, Config.MaterialPile.y, Config.MaterialPile.z)
    SetBlipSprite(blip, 544)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 18)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Rubble Pile")
    EndTextCommandSetBlipName(blip)
    supplyBlip = blip
end


local function createDumpPile()
    local supply = Config.MaterialPile
    supplyArea = exports['qb-target']:AddBoxZone('supplyArea', vector3(supply.x, supply.y, supply.z), 1.0, 4.0, { 
		name = "supplyArea", 
		heading = supply.w, 
		debugPoly = false,
		minZ = supply.z-0.55, 
		maxZ = supply.z + 2.0
	    }, {
		    options = {
		        {
			        label = 'Drop Off Rubble',
			        icon = 'fa-solid fa-trowel',
			        action = function(entity)
                        if not grabbing then
                            grabbing = true
                            --REMOVE SHOVEL ANIMATION

                            StartAnim('mini@repair', 'fixing_a_ped')
                            FreezeEntityPosition(GetPlayerPed(-1), true)
                            Wait(1000)
                            FreezeEntityPosition(GetPlayerPed(-1), false)
                            ClearPedTasks(PlayerPedId())
                            hasRubble = false
                            grabbing = false
                            exports['qb-target']:RemoveZone("supplyArea")
                            SetBlipRoute(supplyBlip, false)
                            RemoveBlip(supplyBlip)
                            if truckSupplies > 0 then
                                --Notificaiton to keep unloading
                                SetBlipRoute(truckBlip, true)
                                Notificacion("Unload the last of the rubble from the truck.", 2000)
                            else
                                --CHECK IF WORKDONE
                                if workLeft > 0 then
                                    --Setup new workzone
                                    Notificacion("Get back to the work site!", 3000)
                                    canUnload = false
                                    setupWorkBlip(workLeft)
                                    SetBlipRoute(workBlip, true)
                                    createWorkZone()
                                else
                                    setupGarage()
                                    
                                    --Set blip route
                                end
                            end
                        end
			        end,
			        canInteract = function()
                        if not grabbing and hasRubble == true then
				            return true
                        else
                           return false 
                        end
			        end,
		        }
		    },
		distance = 2.0,
	})
end


local function spawnTruck()
    local truckHash = GetHashKey(Config.Car.model)
    RequestModel(truckHash)
    while not HasModelLoaded(truckHash) do
        Wait(0)
    end
    unionName = QBCore.Functions.GetPlayerData().unions.name
    truckSpawn = garageCoords
    constructionTruck = CreateVehicle(truckHash, truckSpawn.x, truckSpawn.y, truckSpawn.z, truckSpawn.w, true, true)
    SetVehicleModColor_1(constructionTruck, 3, 0, 0)
    SetVehicleExtra(constructionTruck, 1, true)
    SetVehicleExtra(constructionTruck, 2, true)

    local plate = Config.Car.plate..tostring(math.random(1000,9999))
        
    SetVehicleNumberPlateText(constructionTruck, plate)
    while GetVehicleNumberPlateText(constructionTruck) ~= plate do
        Wait(0)
    end
    TriggerServerEvent('qb-vehiclekeys:server:GiveTempKey', GetVehicleNumberPlateText(constructionTruck))
    --SetVehicleLivery(veh, Config.Car.livery)
    local blip = AddBlipForEntity(constructionTruck)
    SetBlipSprite(blip, 225)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 18)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Constructon Truck")
    EndTextCommandSetBlipName(blip)
    truckBlip = blip
    Notificacion(Config.Locales["jobStarted"], -1)
    exports['qb-target']:AddTargetEntity(constructionTruck, { -- The specified entity number
    options = { -- This is your options table, in this table all the options will be specified for the target to accept
      { 
        num = 1, 
        icon = 'fas fa-example', 
        label = 'Load Rubble',       
        action = function(entity) 
           --RemoveShovel
           --Put truck extra to true
           StartAnim('mini@repair', 'fixing_a_ped')
            FreezeEntityPosition(GetPlayerPed(-1), true)
            Wait(1000)
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(GetPlayerPed(-1), false)
           hasShovel = false
           truckSupplies = truckSupplies + 1
           workLeft = workLeft - 1
           if truckSupplies == 1 then
                --Create next workzone
                SetVehicleExtra(constructionTruck, 1, false)
                setupWorkBlip(workLeft)
                SetBlipRoute(workBlip, true)
                createWorkZone()
           else
                SetVehicleExtra(constructionTruck, 2, false)
                canUnload = true
                setupSupplyBlip()
                SetBlipRoute(supplyBlip, true)
                Notificacion("Get to the construction site and unload the rubble!", -1)

           end
        end,
        canInteract = function(entity) 
          if hasShovel then return true end
        end,
      },
      { 
        num = 2, 
        icon = 'fas fa-example', 
        label = 'Unload Rubble',       
        action = function(entity) 
           local dist =  GetDistanceBetweenCoords(GetEntityCoords(constructionTruck).x, GetEntityCoords(constructionTruck).y, GetEntityCoords(constructionTruck).z, Config.MaterialPile.x, Config.MaterialPile.y, Config.MaterialPile.z, false)
           if dist < 10.0 then
                if hasRubble == false then
                    hasRubble = true
                    StartAnim('mini@repair', 'fixing_a_ped')
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                    Wait(1000)
                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    SetBlipRoute(truckBlip, false)
                    --LOAD SHOVEL ANIMATION
                    
                    
                    truckSupplies = truckSupplies - 1
                    createDumpPile()
                    Notificacion("Unload the rubble into the dumpster.", 2000)
                    if truckSupplies == 1 then
                        SetVehicleExtra(constructionTruck, 2, true)
                    else
                        SetVehicleExtra(constructionTruck, 1, true)
                    end
                end
           else
                Notificacion("Bring truck closer to the rubble pile.", -1)
           end
           
           
           
        end,
        canInteract = function(entity) 
          if hasRubble == false and canUnload then return true end
        end,
      },
      { 
        num = 6, 
        icon = 'fas fa-example', 
        label = 'Load Cable',       
        action = function(entity) 

        end,
        canInteract = function(entity) 
          if hasFibreOp then return true end
        end,
      },
    },
    distance = 2.5, 
  })
end



local function setupWorksite()
    --setup work area
    local HashKey = GetHashKey(Config.Barriers)
    --Cone 1
    cone1 = CreateObject(HashKey, 
    Config.RoadLocations[site].coneLocations[1].x,
    Config.RoadLocations[site].coneLocations[1].y,
    Config.RoadLocations[site].coneLocations[1].z-1.0,
    true, true, 0)
    PlaceObjectOnGroundProperly(cone1)
    SetEntityHeading(cone1, Config.RoadLocations[site].coneLocations[1].w)
    FreezeEntityPosition(cone1, true)
    --Cone 2
    cone2 = CreateObject(HashKey, 
    Config.RoadLocations[site].coneLocations[2].x,
    Config.RoadLocations[site].coneLocations[2].y,
    Config.RoadLocations[site].coneLocations[2].z-1.0,
    true, true, 0)
    PlaceObjectOnGroundProperly(cone2)
    SetEntityHeading(cone2, Config.RoadLocations[site].coneLocations[2].w)
    FreezeEntityPosition(cone2, true)
    --Cone 3 
    cone3 = CreateObject(HashKey, 
    Config.RoadLocations[site].coneLocations[3].x,
    Config.RoadLocations[site].coneLocations[3].y,
    Config.RoadLocations[site].coneLocations[3].z-1.0,
    true, true, 0)
    PlaceObjectOnGroundProperly(cone3)
    SetEntityHeading(cone3, Config.RoadLocations[site].coneLocations[3].w)
    FreezeEntityPosition(cone3, true)
    --Cone 4
    cone4 = CreateObject(HashKey, 
    Config.RoadLocations[site].coneLocations[4].x,
    Config.RoadLocations[site].coneLocations[4].y,
    Config.RoadLocations[site].coneLocations[4].z-1.0,
    true, true, 0)
    PlaceObjectOnGroundProperly(cone4)
    SetEntityHeading(cone4, Config.RoadLocations[site].coneLocations[4].w)
    FreezeEntityPosition(cone4, true)
    --Cone 5
    cone5 = CreateObject(HashKey, 
    Config.RoadLocations[site].coneLocations[5].x,
    Config.RoadLocations[site].coneLocations[5].y,
    Config.RoadLocations[site].coneLocations[5].z-1.0,
    true, true, 0)
    PlaceObjectOnGroundProperly(cone5)
    SetEntityHeading(cone5, Config.RoadLocations[site].coneLocations[5].w)
    FreezeEntityPosition(cone5, true)
    --Cone 6
    cone6 = CreateObject(HashKey, 
    Config.RoadLocations[site].coneLocations[6].x,
    Config.RoadLocations[site].coneLocations[6].y,
    Config.RoadLocations[site].coneLocations[6].z-1.0,
    true, true, 0)
    PlaceObjectOnGroundProperly(cone6)
    SetEntityHeading(cone6, Config.RoadLocations[site].coneLocations[6].w)
    FreezeEntityPosition(cone6, true)
    HashKey = GetHashKey(Config.Sign)
    sign = CreateObject(HashKey, 
    Config.RoadLocations[site].signSpawn.x,
    Config.RoadLocations[site].signSpawn.y,
    Config.RoadLocations[site].signSpawn.z-1.0,
    true, true, 0)
    PlaceObjectOnGroundProperly(sign)
    SetEntityHeading(sign, Config.RoadLocations[site].signSpawn.w)
    FreezeEntityPosition(sign, true)
    --Supervisors
    RequestModel(Config.Supervisor)
    while not HasModelLoaded(Config.Supervisor) do
        Wait(0)
    end
    --Supervisor 1
    supe1 = CreatePed(0, Config.Supervisor, Config.RoadLocations[site].supeLocs[1].x, Config.RoadLocations[site].supeLocs[1].y, Config.RoadLocations[site].supeLocs[1].z-1.0, Config.RoadLocations[site].supeLocs[1].w, true, true)
        FreezeEntityPosition(supe1, true)
        SetEntityInvincible(supe1, true)
        SetBlockingOfNonTemporaryEvents(supe1, true)
        TaskLookAtEntity(supe1, PlayerPedId(), -1, 2048, 3)
        TaskStartScenarioInPlace(supe1, 'WORLD_HUMAN_AA_SMOKE', 0, true)
    --Supervisor 2
    supe2 = CreatePed(0, Config.Supervisor, Config.RoadLocations[site].supeLocs[2].x, Config.RoadLocations[site].supeLocs[2].y, Config.RoadLocations[site].supeLocs[2].z-1.0, Config.RoadLocations[site].supeLocs[2].w, true, true)
        FreezeEntityPosition(supe2, true)
        SetEntityInvincible(supe2, true)
        SetBlockingOfNonTemporaryEvents(supe2, true)
        TaskLookAtEntity(supe2, PlayerPedId(), -1, 2048, 3)
        TaskStartScenarioInPlace(supe2, 'WORLD_HUMAN_AA_SMOKE', 0, true)
    supe3 = CreatePed(0, Config.Supervisor, Config.RoadLocations[site].supeLocs[3].x, Config.RoadLocations[site].supeLocs[3].y, Config.RoadLocations[site].supeLocs[3].z-1.0, Config.RoadLocations[site].supeLocs[3].w, true, true)
        FreezeEntityPosition(supe3, true)
        SetEntityInvincible(supe3, true)
        SetBlockingOfNonTemporaryEvents(supe3, true)
        TaskLookAtEntity(supe3, PlayerPedId(), -1, 2048, 3)
        TaskStartScenarioInPlace(supe3, 'WORLD_HUMAN_AA_SMOKE', 0, true)
    
    --SetupWorkArea
    createWorkZone()
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    cleanup()
end)


AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    cleanup()
end)

local function ChangeClothes()
    local gender = QBCore.Functions.GetPlayerData().charinfo.gender
    if gender == 0 then
        TriggerEvent('qb-clothing:client:loadOutfit', Config.RoadWorkUniforms.male)
    else
        TriggerEvent('qb-clothing:client:loadOutfit', Config.RoadWorkUniforms.female)
    end
end

local function startJob()
    if working == false then
        working = true
        local union = QBCore.Functions.GetPlayerData().unions.name
        unionName = union
        if union == "electrical" then
            garageCoords = Config.ElectricalSpawn
        elseif union == "construction" then
            garageCoords = Config.ConstructionSpawn
        elseif union == "port" then
            garageCoords = Config.PortSpawn
        elseif union == "garbage" then
            garageCoords = Config.GarbageSpawn
        else
            print("Error: Shouldn't have this.")
            unionName = "none"
            return
        end
        unionName = union
        site = math.random(1, #Config.RoadLocations)
        ChangeClothes()
        setupWorksite()
        setupWorkBlip(workLeft)
        SetBlipRoute(workBlip, true)
        spawnTruck()

    end
end

RegisterNetEvent('cain-roadwork:client:startJob', function()
    TriggerServerEvent('cain-unions:server:startConstruction')
    startJob()
end)

RegisterNetEvent('cain-unions:client:finishConstruction', function()
    cleanup()
end)
