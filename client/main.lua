local createPed = function()
  exports['qb-target']:SpawnPed({
    model = Config.Doctor.model,
    coords = Config.Doctor.coords,
    minusOne = true,
    freeze = true,
    invincible = true,
    blockevents = true,
    -- animDict = 'abigail_mcs_1_concat-0',
    -- anim = 'csb_abigail_dual-0',
    -- flag = 1,
    -- scenario = 'WORLD_HUMAN_AA_COFFEE',
    target = {
      options = {
        {
          num = 1,
          type = "client",
          label = Config.Lang.HEAL_PLAYERS,
          targeticon = 'fa-solid fa-suitcase-medical',
          action = function(entity)
            TriggerEvent("dk:illagale_doctor:target")
          end,
        }
      },
      distance = 2.5,
    },
    spawnNow = true,
    currentpednumber = 0,
  })
end

Citizen.CreateThread(function()
  createPed()
end)
