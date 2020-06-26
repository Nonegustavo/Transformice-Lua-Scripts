ligado=0
adm="Ninguem"
seguir="off"
id = 0
tfm.exec.disableAutoNewGame(true)
tfm.exec.newGame("#17")

TICKS = 40;

local s = 1000/TICKS;
for t = 0, 1000 - s, s do
system.newTimer(function () system.newTimer(loop, 1000, true) end, 1000 + t, false);
end

function loop()
	local sim={true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false}
	local rest={0, 1, 2, 20}
	if seguir == "off" then
	tfm.exec.addPhysicObject(id, math.random(0,800), math.random(0,400), {type=12, width=math.random(10,100), height=math.random(10,100), restitution=rest[math.random(#rest)], miceCollision=sim[math.random(#sim)], groundCollision=false, color=0x6a7495})
	else
		tfm.exec.addPhysicObject(id, math.random(-200,200)+tfm.get.room.playerList[seguir].x, math.random(-200,200)+tfm.get.room.playerList[seguir].y, {type=12, width=math.random(10,100), height=math.random(10,100), miceCollision=sim[math.random(#sim)], groundCollision=false, color=0x6a7495, foreground=false})
	end
	id = (id + 1) % 10
end

function eventChatCommand(p, cmd)
	if p == adm and cmd:sub(1,7) == "glitch " then
		seguir = cmd:sub(8) or "off"
	elseif p == adm and cmd:sub(1,3) == "np " then
		tfm.exec.newGame(cmd:sub(4))
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

function eventNewGame()
	tfm.exec.setUIMapName("ERREUR 0x" .. tfm.get.room.xmlMapInfo.mapCode .. " by " .. tfm.get.room.xmlMapInfo.author)
	tfm.exec.addPhysicObject(110, 1000, -200, {miceCollision=false, width=100, height=10, type=12, color=1})
	tfm.exec.addPhysicObject(111, 1000, 600, {miceCollision=false, width=100, height=10, type=12, restitution=9999, color=1})
	tfm.exec.addPhysicObject(112, 1000, 0, {miceCollision=false, width=100, height=10, type=12, linearDamping=5, fixedRotation=true, dynamic=true, color=1})
	tfm.exec.addJoint(115, 110, 110, {type=0, point1="0,100", point2="800,100", line=200, color=0xffff33, foreground=true, alpha=0.2})
	tfm.exec.addJoint(116, 110, 110, {type=0, point1="0,300", point2="800,300", line=200, color=0xffff33, foreground=true, alpha=0.2})
	tfm.exec.addJoint(113, 112, 112, {type=0, point1="0,0", point2="800,0", line=100, color=0xffffff, foreground=true, alpha=0.04})
	tfm.exec.addJoint(114, 112, 112, {type=0, point1="0,-60", point2="800,-60", line=10, color=0, foreground=true, alpha=0.02})
	
end

function eventLoop(current, remaining)
	if remaining < 0 or todosMortos() then
		tfm.exec.newGame("#17")
	end
end

function eventNewPlayer(p)
	tfm.exec.addImage("164912987df.png", "&0", 0, 0, p)
tfm.exec.addImage("164912a578d.png", "&1", -1100, -1300, p)
end

tfm.exec.addImage("164912987df.png", "&0", 0, 0, nil)
tfm.exec.addImage("164912a578d.png", "&1", -1100, -1300, nil)

