Config = {}
-- vector4(1215.13, -493.17, 67.16, 80.25)
Config.Doctor = {
  model = "s_m_m_doctor_01",
  coords = vector4(1215.23, -493.11, 67.16, 112.17)
}
Config.payType = "cash" -- cash,bank
Config.PayAmount = {
  Isdead = 2000, -- is dead pay amount
  IsInlaststand = 1000 -- is In last stand pay amount
}
Config.HealWaitTime = 10 -- seconds
Notify = function(msg, time, type)
  -- exports['okokNotify']:Alert('Notice', msg, time, type)
  type = "primary"
  TriggerEvent('QBCore:Notify', msg, type)
end
ProgBar = function(time, text, color)
  exports['an_progBar']:run(time, text, color) -- https://github.com/aymannajim/an_progBar
end
Config.Lang = {
  HEAL_PLAYERS = "Heal",
  NO_PLAYERS_NEED_HEAL = "There are no players nearby who need healing",
  NO_MONEY = "Insufficient amount",
  DR_TRYING = "Doctor is trying",
  DR_RECOVERING = "Doctor is recovering your injury",
  SUCCESS = "Successful recovery",
  COST = "Cost"
}
