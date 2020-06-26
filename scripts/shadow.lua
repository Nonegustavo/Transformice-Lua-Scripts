timers = {}

player = {pos={}, time=false}

shadow = {pos={}, time=false}

sombra = {}

watch = "Ninguem#0095"

start = 0

replay = 1

pode = false

map = "#17"

function novoMapa(m)
  map = m or map
  tfm.exec.newGame(map)
end

function criaTimers()
  TICKS = 40
  local s = 1000/TICKS
  for t = 0, 1000 - s, s do
    system.newTimer(function ()
      system.newTimer(loop, 1000, true)
    end, 1000 + t, false)
  end
end

function loop()
  if not pode then
    return false
  end
  -- registrar
  for i, v in pairs(playerList) do
    p = tfm.get.room.playerList[i]
    last = v.pos[#v.pos]
    if not p.isDead then
      --if #v.pos == 0 or (p.x ~= last.x or p.y ~= last.y) then
        table.insert(v.pos, {
        ['x'] = p.x,
        ['y'] = p.y,
        ['vx'] = p.vx,
        ['vy'] = p.vy,
        ['time'] = os.time()-start,
      })
      --end
    end
  end
  
  -- sombra
  power = 10
  if #sombra > 0 then
    if sombra[1].time < os.time()-start then
      pos = table.remove(sombra, 1)
      tfm.exec.moveObject(obj, pos.x, pos.y, false, pos.vx*power, pos.vy*power, false)
    end
  elseif #shadow.pos > 0 then
    tfm.exec.removeObject(obj)
  end
end

function eventNewGame()
  map = tfm.get.room.currentMap
  pode = true
  start = os.time()
  replay = 1
  sombra = {}
  player = {pos={}, time=false}
  playerList = {}
  for i, v in pairs(tfm.get.room.playerList) do
    playerList[i] = {pos={}, time=false}
    tfm.exec.lowerSyncDelay(i)
  end
  print(shadow.map)
  if tfm.get.room.currentMap == shadow.map then
    for i, v in pairs(shadow.pos) do
      table.insert(sombra, v)
    end
    if #sombra > 0 then
      print(#sombra)
      tfm.exec.removeObject(obj)
      obj = tfm.exec.addShamanObject(85, sombra[1].x, sombra[1].y, 0, 0, 0, true)
      tfm.exec.addImage("	1648b81b04b.png", "#"..obj, -18, -18)
      tfm.exec.chatMessage(string.format("<j>Melhor tempo <rose>%ss <j>por <rose>%s", shadow.time/1000, shadow.name))
    end
  else
    shadow = {pos={}, time=false}
  end
  tfm.exec.setGameTime(60)
end

function eventPlayerWon(p)
  player = playerList[p]
  player.time = os.time() - start
  if not shadow.time or shadow.time > player.time then
    shadow = player
    shadow.map = tfm.get.room.currentMap
    shadow.name = p
    tfm.exec.chatMessage("<j>Novo melhor tempo por <rose>"..p)
  end
end

function eventChatCommand(p, cmd)
  if cmd:sub(1,3) == "np " then
    novoMapa(cmd:sub(4))
  end
end

function todosMortos()
  for i, v in pairs(tfm.get.room.playerList) do
    if not v.isDead then
      return false
    end
  end
  return true
end

function eventLoop(current, remaining)
  if remaining < 0 or todosMortos() then
    novoMapa()
  else
    loop()
  end
end

tfm.exec.disablePhysicalConsumables()
tfm.exec.disableAfkDeath()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
--criaTimers()
novoMapa()