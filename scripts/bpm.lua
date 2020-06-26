adm = {
  ["Ninguem#0095"] = true
}
cores = {0xff0000, 0xffff00, 0x00ff00, 0x00ffff, 0x0000ff, 0xff00ff}
space = {}
timers = {}
cor = 1

function isAdm(p)
  return adm[p]
end

function loop()
  --ui.addTextArea(0, "", nil, 0, 0, 800, 400, cores[cor], 1, 0.1, false)
  for i, v in pairs(tfm.get.room.playerList) do
    tfm.exec.setNameColor(i, cores[cor])
  end
  for i=1, 10 do
	tfm.exec.addPhysicObject(i, math.random(800), math.random(400), {type=13, width=math.random(10,30), groundCollision=false, miceCollision=false, color=cores[cor]})
  end
  ui.setMapName(string.format("<font color='#%x'>NOSTALGIA", cores[cor]))
  cor = cor == #cores and 1 or cor + 1
end

function criaTimers(tick)
  for i=1, 20 do
    system.newTimer(function ()
      table.insert(timers, system.newTimer(loop, tick*20, true))
    end, 1000+tick*i, false)
  end
end

function removeTimers()
  for i, v in ipairs(timers) do
    system.removeTimer(v)
  end
  timers = {}
end

function calculaBPM()
  local dif = {}
  local soma = 0
  for i=1, #space-1 do
    table.insert(dif, space[i+1] - space[i])
  end
  for i, v in ipairs(dif) do
    soma = soma + v
  end
  space = {}
  return math.ceil(soma/#dif)
end

function eventKeyboard(p, t, d, x, y)
  table.insert(space, os.time())
end

function eventChatCommand(p, cmd)
  if isAdm(p) then
    if cmd == "bpm" then
      removeTimers()
      criaTimers(calculaBPM())
    end
  end
end

for i, v in pairs(adm) do
  system.bindKeyboard(i, 81, true, true)
end

system.disableChatCommandDisplay("bpm", true)