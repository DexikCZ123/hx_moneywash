ESX                           = nil
local PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(5000)
	end

	PlayerData = ESX.GetPlayerData()
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)



Citizen.CreateThread(function()

local sleep = 1500 
local player = PlayerPedId()
local playerCoords = GetEntityCoords(player)



for k,v in ipairs(Config.Money) do
    local distance = #(playerCoords - v)
 if distance <= 5 then
 sleep = 0 
 if distance <= 3 then
    ESX.ShowFloatingHelpNotification(_U('press_e'),vector3(v))
    if distance <= 1.5 and IsPedOnFoot(player) and  IsControlJustReleased(0, 38) then
    FreezeEntityPosition(PlayerPedId(), true)
    ClearPedTasksImmediately(PlayerPedId())
        TriggerEvent(
            'mythic_progbar:client:progress',
            {
                name = 'moneywash',
                duration = Config.duration,
                label = _U('laundering_money'), 
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true
                },
            },
            function(status) 
                if not status then
                ClearPedTasks(playerPed)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerServerEvent('moneywash:process')
            end
          end
        )
        
    end
   end
  Wait(sleep)
 end
end)

