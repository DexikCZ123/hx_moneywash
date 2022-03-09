ESX                           = nil
local PlayerData = {}
JobBlips = {}

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
	deleteBlips()
	blips()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
    blips()
end)



Citizen.CreateThread(function()
	while true do
		Wait(10)

local player = PlayerPedId()
local playerCoords = GetEntityCoords(player)




for k,v in ipairs(Config.Money) do
    local distance = #(playerCoords - v)

if distance  <= 3 then
    ESX.ShowFloatingHelpNotification('Stiskni E pro prani penez',vector3(v))
    if distance <= 1.5 and IsPedOnFoot(player) and  IsControlJustReleased(0, 38) then
Wait(20)
        TriggerEvent(
            'mythic_progbar:client:progress',
            {
                name = 'moneywash',
                duration = 3000,
                label = 'Peres Penize', 
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true
                },
                animation = {
                    animDict = 'mini@repair',
                    anim = 'fixing_a_player',
                },
            },
            function(status) 
                if not status then
                    ClearPedTasks(PlayerPedId())
               
            end
            end
        )
        



end
end
 end
end
end)


