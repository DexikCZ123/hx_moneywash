ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local grape = 'hrozny'
local grape2 = 'hrozny_c'

RegisterServerEvent('collecting:harvest')
AddEventHandler('collecting:harvest', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local item =  xPlayer.getInventoryItem('nuzky').count

 


    if xPlayer.canCarryItem and xPlayer.canCarryItem('hrozny', 1) then
        local random = math.random(1,8)
        local itemrandom = math.random(1,3)
        if random >= 6 then
        xPlayer.addInventoryItem(grape, itemrandom)
    elseif random <= 3 then
            xPlayer.addInventoryItem(grape2, itemrandom)
    else 
        xPlayer.addInventoryItem('shit_hrozny', itemrandom)


  end
 end
end)


function showNotification(src, msg)
    TriggerClientEvent('esx:showNotification', src, msg)
end

RegisterServerEvent('collecting:zpracovani')
AddEventHandler('collecting:zpracovani', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local item =  xPlayer.getInventoryItem('sud').count

  if item <= 0 then
    showNotification(source, 'Nemate sud!')
  else
    if xPlayer.canCarryItem and xPlayer.canCarryItem('sud_vine') then
        if xPlayer.getInventoryItem(grape) and xPlayer.getInventoryItem(grape).count  >= 5 then
    xPlayer.removeInventoryItem(grape, 5)
    xPlayer.removeInventoryItem('sud', 1)
    xPlayer.addInventoryItem('sud_vine',1)    
        elseif xPlayer.getInventoryItem(grape2) and xPlayer.getInventoryItem(grape2).count  >= 5 then
            xPlayer.removeInventoryItem(grape2, 5)
            xPlayer.removeInventoryItem('sud', 1)
            xPlayer.addInventoryItem('sud_vine_c',1)    
        else 
        --    showNotification(source, 'Nemate hrozny!')
        --    ESX.ShowNotification_error(source,'Nemate Hrozny!')
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Nemate Hrozny!', style = { ['background-color'] = '#D82903', ['color'] = '#FFFFFF' } })


     end
   end
 end
end)



RegisterServerEvent('collecting:sell')
AddEventHandler('collecting:sell', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem('sud_vine') and xPlayer.getInventoryItem('sud_vine').count  >= 1 then
        xPlayer.removeInventoryItem('sud_vine', 1)
        local amount =  math.random(15,40) -- Config.Price1 = math.random(15,40)
        local amount2 = math.ceil((amount / 10) * 10)
        local frakce = math.ceil(amount2 * 0.3)
        local hrac = math.ceil(amount * 0.699)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
            if account then
                account.addMoney(frakce)
            else
                
            end
        end) 
                xPlayer.addAccountMoney('money', hrac)
    elseif xPlayer.getInventoryItem('sud_vine_c') and xPlayer.getInventoryItem('sud_vine_c').count  >= 1 then
        xPlayer.removeInventoryItem('sud_vine_c', 1)

local amount =  math.random(20,50)
local amount2 = math.ceil((amount / 10) * 10)
local frakce = math.ceil(amount2 * 0.3)
local hrac = math.ceil(amount * 0.699)
TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
	if account then
		account.addMoney(frakce)
	else
		
	end
end)
        xPlayer.addAccountMoney('money', hrac)
    else 
        showNotification(source, 'Nemate jiz co prodat!')
    end

end)