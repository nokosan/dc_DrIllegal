QBCore = exports['qb-core']:GetCoreObject()

local deadPlayers
local p = Config.Doctor.coords

local function createDrMenu()
  local patientsList = {}
  patientsList[#patientsList + 1] = {
    isMenuHeader = true,
    header = 'Lists:',
    icon = 'fa-solid fa-infinity'
  }
  local i = 0
  for k, v in pairs(deadPlayers) do
    i = i + 1
    print(v.status)
    local payAmount;
    if v.status == "isDead" then
      payAmount = Config.PayAmount.Isdead
    elseif v.status == "isInlaststand" then
      payAmount = Config.PayAmount.IsInlaststand
    end
    -- local patientName = deadPlayers.Functions.Get
    local playerCharData = v.PlayerData.charinfo
    local playerName = playerCharData.firstname .. playerCharData.lastname
    local status = v.status -- isDead or isInlaststand
    patientsList[#patientsList + 1] = { -- insert data from our loop into the menu
      header = playerName,
      txt = Config.Lang.COST .. ' $' .. payAmount,
      icon = 'fa-solid fa-face-grin-tears',
      params = {
        event = 'dk:client:RevivePlayer', -- event name
        args = {
          deadPlayer = v
        }
      }
    }
  end
  exports['qb-menu']:openMenu(patientsList) -- open our menu
end

RegisterNetEvent("dk:client:RevivePlayer")
AddEventHandler("dk:client:RevivePlayer", function(data)
  print(GetPlayerServerId(PlayerId())) -- get myself source id
  TriggerServerEvent("dk:server:RevivePlayer", GetPlayerServerId(PlayerId()), data.deadPlayer)
end)

-- 获取黑医附近的死亡玩家
-- 1.获取附近的所有玩家,遍历出死亡玩家返回给cilent

local function getPlayersFromHoispital()
  local coords = vector3(p.x, p.y, p.z)
  local radius = 5.0
  local closestPlayers = QBCore.Functions.GetPlayersFromCoords(coords, radius)
  for _, value in pairs(closestPlayers) do
    local srcNo = GetPlayerServerId(value)
    TriggerServerEvent("dk:player:data", srcNo)
  end
end

RegisterNetEvent("dk:client:isDead")
AddEventHandler("dk:client:isDead", function(dPlayers)
  deadPlayers = dPlayers
end)

RegisterNetEvent("dk:illagale_doctor:target")
AddEventHandler("dk:illagale_doctor:target", function()
  getPlayersFromHoispital()
  while deadPlayers == nil do
    Wait(10)
  end
  -- TriggerEvent("table", deadPlayers)
  if #deadPlayers > 0 then
    createDrMenu()
  else
    TriggerEvent('dk:Notify', Config.Lang.NO_PLAYERS_NEED_HEAL, 5000, 'info')
  end
  deadPlayers = nil
end)

RegisterNetEvent("dk:Notify")
AddEventHandler("dk:Notify", function(msg, time, type)
  Notify(msg, time, type)
end)

RegisterNetEvent("dk:progBar")
AddEventHandler("dk:progBar", function(time, text, color)
  ProgBar(time, text, color)
end)
