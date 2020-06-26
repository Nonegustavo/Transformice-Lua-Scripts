letras = {
	{x = 117, y = 80},
	{x = 177, y = 71},
	{x = 224, y = 70},
	{x = 315, y = 71},
	{x = 397, y = 61},
	{x = 474, y = 68},
	{x = 538, y = 48},
	{x = 618, y = 37},
	{x = 36, y = 183},
	{x = 130, y = 198},
	{x = 184, y = 205},
	{x = 250, y = 202},
	{x = 325, y = 199},
	{x = 386, y = 174},
	{x = 460, y = 153},
	{x = 533, y = 151},
	{x = 697, y = 151},
	{x = 84, y = 297},
	{x = 140, y = 317},
	{x = 195, y = 324},
	{x = 268, y = 324},
	{x = 344, y = 316},
	{x = 409, y = 308},
	{x = 474, y = 300},
	{x = 557, y = 289},
	{x = 682, y = 287}
}
color = {0, 1, 2, 9, 11, 13}
jogador = {}
send = {}
light = {}

function split(txt, sep)
	local arg = {}
	for i, v in string.gmatch(txt, string.format("[^%s]+", sep or "%s")) do
		table.insert(arg, i)
	end
	return arg
end

function retornaLetra(x, y)
	for i, v in pairs(letras) do
		if (x-v.x)^2 + (y-v.y)^2 < 100 then
			return i
		end
	end
end

function eventNewPlayer(p)
	jogador[p] = os.time()+3000
	system.bindMouse(p, true)
	tfm.exec.addImage("156a03d2c15.png", "?1", 0, 10, p)
	tfm.exec.respawnPlayer(p)
end

function eventPlayerDied(p)
	tfm.exec.respawnPlayer(s_jogador)
end

function eventMouse(p, x, y)
	if jogador[p] < os.time() then
		local l = retornaLetra(x, y)
		if l then
			jogador[p] = os.time() + 1000
			for i=1, 5 do
				tfm.exec.displayParticle(color[5], letras[l].x+(math.random(-100,100)/1000), letras[l].y+(math.random(-100,100)/1000), 0, 0, 0, 0, nil)
			end
			table.insert(send, {r=tfm.get.room.name, ["l"]=l, t=os.time()+140000, c=5})
		else
			jogador[p] = os.time() + 500
		end
	end
end

function eventNewGame()
	for i, v in pairs(tfm.get.room.playerList) do
		eventNewPlayer(i)
	end
end

function showLights()
	local show = {}
	local hold = {}
	for i, v in pairs(light) do
		if v.t < os.time() then
			table.insert(show, v)
		else
			table.insert(hold, v)
		end
	end
	for i, v in pairs(show) do
		for i=1, 20 do
			tfm.exec.displayParticle(color[v.c], letras[v.l].x+(math.random(-100,100)/1000), letras[v.l].y+(math.random(-100,100)/1000), 0, 0, 0, 0, nil)
		end
		tfm.exec.chatMessage(v.l)
	end
	light = hold
end

function eventLoop(current, remaining)
	showLights()
end

function eventFileLoaded(id, dados)
	print(dados)
	if dados then
		local l = split(dados, ";")
		if l then
			print("ok")
			local ll = {}
			for i, v in pairs(l) do
				local arg = split(v, ",")
				if arg then
					print("leu = "..v)
					local room = arg[1]
					local letter = tonumber(arg[2])
					local time = tonumber(arg[3])
					local color = tonumber(arg[4])
					if time > os.time()-210000 and room~=tfm.get.room.name then
						table.insert(light, {r=room, l=letter, t=time, c=color})
						print("leu = "..letter)
					end
				end
			end
			local s = {}
			for i, v in pairs(light) do
				table.insert(s, v)
			end
			for i, v in pairs(send) do
				table.insert(s, v)
			end
			local txt = {}
			for i, v in pairs(s) do
				table.insert(txt, v.r..","..v.l..","..v.t..","..v.c)
			end
			system.saveFile(table.concat(txt, ";") or "0,0,0,5", 45)
		end
	end
end

system.newTimer(function()
	system.loadFile(45)
end, 70000, true)
system.loadFile(45)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.newGame([[<C><P /><Z><S><S L="800" H="30" X="400" Y="395" T="0" P="0,0,0.3,0.2,0,0,0,0" /></S><D><DS Y="352" X="400" /></D><O /></Z></C>]])