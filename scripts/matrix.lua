serpentes = {}
for i=1, 20 do
  table.insert(serpentes, {x=math.random(0,80), y=0})
end

function loop()
  for j=1, 2 do
    for i, v in pairs(serpentes) do
      if math.random(1,10) == 1 or v.y > 40 then
        v.y = 0
        v.x = math.random(0,80)
      else
        v.y = v.y + math.random(0,1) 
      end
      tfm.exec.displayParticle(22, (v.x+math.random(-1,1))*10, v.y*10, 0, -1, 0, 0, nil)
    end
  end
end
function criaTimers()
  TICKS = 20
  local s = 1000/TICKS
  for t = 0, 1000 - s, s do
    system.newTimer(function ()
      system.newTimer(loop, 1000, true)
    end, 1000 + t, false)
  end
end

tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.newGame("@6328989")
criaTimers()