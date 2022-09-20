QBCore = exports['qb-core']:GetCoreObject()
local deadPlayers = {}

-- 获取死亡玩家
RegisterNetEvent("dk:player:data")
AddEventHandler("dk:player:data", function(source)
  deadPlayers = {}
  local Player = QBCore.Functions.GetPlayer(tonumber(source)) -- tonumber xd
  local isDead = Player.Functions.GetMetaData("isdead")
  local isInlaststand = Player.Functions.GetMetaData("inlaststand") -- 濒死?
  local status = nil
  Wait(100)
  if isDead == true then
    Player.status = "isDead"
    table.insert(deadPlayers, Player)
  elseif isInlaststand == true then
    Player.status = "isInlaststand"
    table.insert(deadPlayers, Player)
  end
  TriggerClientEvent("dk:client:isDead", source, deadPlayers)
end)

-- revive player
RegisterNetEvent("dk:server:RevivePlayer")
AddEventHandler("dk:server:RevivePlayer", function(source, deadPlayer)
  local deadSource = tonumber(deadPlayer.PlayerData.source)
  local localPlayer = QBCore.Functions.GetPlayer(tonumber(source)) -- Executor
  local payType = tostring(Config.payType)
  local localPlayerMoney = localPlayer.Functions.GetMoney(payType)
  local payAmount
  if deadPlayer.status == "isDead" then
    payAmount = Config.PayAmount.Isdead
  elseif deadPlayer.status == "isInlaststand" then
    payAmount = Config.PayAmount.IsInlaststand
  end
  if tonumber(localPlayerMoney) < payAmount then
    TriggerClientEvent('dk:Notify', source, Config.NO_MONEY, 5000, "info")
    return false
  end
  localPlayer.Functions.RemoveMoney(payType, payAmount)
  TriggerClientEvent('dk:progBar', source, tonumber(Config.HealWaitTime), Config.Lang.DR_TRYING, "#9060DE")
  TriggerClientEvent('dk:progBar', deadSource, tonumber(Config.HealWaitTime), Config.Lang.DR_RECOVERING, "#9060DE")
  Wait(tonumber(Config.HealWaitTime) *1000)
  TriggerClientEvent('hospital:client:Revive', deadSource)
  TriggerClientEvent('dk:Notify', deadSource, Config.Lang.SUCCESS, 5000, "info")
end)
