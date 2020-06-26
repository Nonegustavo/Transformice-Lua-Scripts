xx = 0
yy = 0
delay = os.time() + 3000

function eventNewGame()
  tfm.exec.addImage("150c66cd3df.png", "?1", -1100, -1300)
  delay = os.time() + 3000
  xx = 0
  yy = 0
end

function eventKeyboard(p, t, d, x, y)
  if t == 49 then
    yy = yy - 1
  elseif t == 51 then
    xx = xx - 1
  elseif t == 50 then
    yy = yy + 1
  elseif t == 52 then
    xx = xx + 1
  end
  tfm.exec.chatMessage(string.format("x = %d, y = %d", xx, yy), "Ninguem")
end

function loop()
  if os.time() > delay and (xx ~= 0 or yy ~= 0) then
    for i, v in pairs(tfm.get.room.playerList) do
      tfm.exec.movePlayer(i, 0, 0, true, xx, yy, true)
    end
    --for i, v in pairs(tfm.get.room.objectList) do
      --tfm.exec.moveObject(i, 0, 0, true, xx, yy, true)
    --end
  end
  tfm.exec.displayParticle(1, math.random(-100,900), math.random(-100,500), xx*2, yy*2, 0, 0, nil)
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
criaTimers()
system.bindKeyboard("Ninguem", 49, true, true)
system.bindKeyboard("Ninguem", 50, true, true)
system.bindKeyboard("Ninguem", 51, true, true)
system.bindKeyboard("Ninguem", 52, true, true)