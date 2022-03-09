ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function showNotification(src, msg)
    TriggerClientEvent('esx:showNotification', src, msg)
end

RegisterServerEvent('moneywash:process')
AddEventHandler('moneywash:process', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayer, dCoord = xPlayer, dCoord;
    local pCoords = xPlayer.getCoords(true)
    local playerId = xPlayer.source
    local name = GetPlayerName(playerId)
local countMoney = xPlayer.getAccount('black_money').money
for k,v in ipairs(Config.Money) do
    
local distance = #(pCoords - v)

if distance <= 5 then
    local trigger2 = {
        {
            ["color"] = Config.WebhookColour2,
            ["title"] = GetPlayerName(source).." (".. xPlayer.identifier ..")",
            ["description"] = "Player with ID: " .. "["..playerId.."]".. " ".. name .. " now laundry " .. countMoney.. "$",
            ["footer"] = {
            ["text"] = os.date('%H:%M - %d. %m. %Y', os.time())
            },
        }
    }
PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "Hx_Log", embeds = trigger2}), { ['Content-Type'] = 'application/json' })
end

if distance > 5 then
    local trigger = {
        {
            ["color"] = Config.WebhookColour,
            ["title"] = GetPlayerName(source).." (".. xPlayer.identifier ..")",
            ["description"] = "Player with ID: " .. "["..playerId.."]".. " ".. name .. "| Try to exploit Trigger!!!",
            ["footer"] = {
            ["text"] = os.date('%H:%M - %d. %m. %Y', os.time())
            },
        }
    }
PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "Hx_Log", embeds = trigger}), { ['Content-Type'] = 'application/json' })


end

if distance < 5 then
if countMoney <= 0 then
    showNotification(source, _U('dont_have_blackmoney'))
elseif countMoney >= 1 then
    local random = math.random(5,10)
    local money = math.ceil((countMoney / 10) * 10)
    if random == 5 then
    xPlayer.removeAccountMoney("black_money", countMoney)
    xPlayer.addAccountMoney("money", (money * 0.95))
    elseif random == 6 then
        xPlayer.removeAccountMoney("black_money", countMoney)
        xPlayer.addAccountMoney("money", (money * 0.94))
    elseif random == 7 then
        xPlayer.removeAccountMoney("black_money", countMoney)
        xPlayer.addAccountMoney("money", (money * 0.93))
    elseif random == 8 then
        xPlayer.removeAccountMoney("black_money", countMoney)
        xPlayer.addAccountMoney("money", (money * 0.92))
    elseif random == 9 then
        xPlayer.removeAccountMoney("black_money", countMoney)
        xPlayer.addAccountMoney("money", (money * 0.91))
    elseif random == 10 then
        xPlayer.removeAccountMoney("black_money", countMoney)
        xPlayer.addAccountMoney("money", (money * 0.9))
    end
end
end
end
end)