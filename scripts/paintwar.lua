CODE = {
	"@5867783", "@5870264", "@5870336", "@5870443", "@5882929", "@5883793"
}
ATUAL = CODE[math.random(#CODE)]
--MODOS = {"score"}
MODOS = {"normal", "lock", "normal-time", "lock-time", "score"}
MODOS2 = {"normal", "lock", "score"}
MODO = "normal"
CONT = 0
INTERVALO = os.time()
PLAYER = {}
RATO = {}
for i, v in pairs(tfm.get.room.playerList) do
	RATO[i] = tfm.exec.addImage("15f11b8aea6.png", "&100", 50, 25, i)
end
ui.addTextArea(0, "<p align='center'><a href='event:fechar'><font color='#ffff00'><b>[fechar]", nil, 300, 380, 200, 20, 1, 1, 0.8, true)
MAP = {}
LIST = {spawn={}, score={}, item={}}
CHANGE = false
PODE = false
for i=1, 20 do
	MAP[i] = {}
	for j=1, 40 do
		MAP[i][j] = {nome=false, mort={img=false, nome=false}, lock=false, item={img=false, nome=false}, skin=0, team=false, piso=false}
	end
end

function eventChatCommand(p, cmd)
	if cmd == "help" or cmd == "ajuda" then
		tfm.exec.removeImage(RATO[p])
		RATO[p] = tfm.exec.addImage("15f11b8aea6.png", "&100", 50, 25, p)
		ui.addTextArea(0, "<p align='center'><a href='event:fechar'><font color='#ffff00'><b>[fechar]", p, 300, 380, 200, 20, 1, 1, 0.8, true)
	else
		tfm.exec.chatMessage("<bl>Comandos: !ajuda. (s? isso)", p)
	end
end

function eventTextAreaCallback(id, p, cmd)
	if cmd == "fechar" then
		tfm.exec.removeImage(RATO[p])
		ui.removeTextArea(0, p)
	end
end

function eventNewPlayer(p)
	RATO[p] = tfm.exec.addImage("15f11b8aea6.png", "&100", 50, 25, p)
	ui.addTextArea(0, "<p align='center'><a href='event:fechar'><font color='#ffff00'><b>[fechar]", p, 300, 380, 200, 20, 1, 1, 0.8, true)
end

function split(txt, sep)
	local arg = {}
	for i, v in string.gmatch(txt, string.format("[^%s]+", sep)) do
		table.insert(arg, i)
	end
	return arg
end

function botaMapa(mapa)
	if os.time() > INTERVALO + 3000 then
		tfm.exec.newGame(mapa)
	else
		print("Carregando mapa " .. mapa)
	end
end

function geraXml(xml)
	local ini = string.match(xml, 'Pw=".+%x+,%x+,%x+;"')
	if ini then
		ini = ini:sub(5, -3)
		local obj = split(ini, ";")
		for i, v in pairs(obj) do
			local par = split(v, ",")
			local id = tonumber(par[1],16)
			local y = tonumber(par[2],16)
			local x = tonumber(par[3],16)
			if id == 1  then
				MAP[y][x].on = true
				tfm.exec.addPhysicObject(y*40+x, x*40-20, y*40-20, {type=12,color=0x324650,width=40,height=40,friction=0.3,restitution=0.2})
				--tfm.exec.addImage("Sswy5Ax.png", "!10000", x*40-40, y*40-40, nil)
				--tfm.exec.addImage("x2pRgah.png", "!10000", x*40-40, y*40-40, nil)
			elseif id == 2 then
				table.insert(LIST.score, {xx=x, yy=y})
			elseif id == 3 then
				table.insert(LIST.item, {xx=x, yy=y})
			elseif id == 4 then
				table.insert(LIST.spawn, {xx=x, yy=y})
			end
		end
		return true
	else
		return false
	end
end

function colorir(p, x, y)
	if x > 0 and x <= 40 and y > 0 and y <= 20 and MAP[y][x].on and MAP[y][x].nome ~= p and not MAP[y][x].lock then
		MAP[y][x].nome = p
		tfm.exec.addPhysicObject(y*40+x, x*40-20, y*40-20, {type=12,color=PLAYER[p].cor,width=40,height=40,friction=0.3,restitution=0.2})
		MAP[y][x].team = PLAYER[p].cor
		if MODO == "lock" or MODO == "lock-time" or (PLAYER[p] and PLAYER[p].lock and PLAYER[p].lock.on) then
			MAP[y][x].lock = true
			MAP[y][x].skin = tfm.exec.addImage("15f11b98912.png", "_10000", x*40-40, y*40-40, nil)
		end
	end
end

function adicionaPontos(p)
	local cont = 0
	for i=1, 20 do
		for j=1, 40 do
			if MAP[i][j].nome == p then
				tfm.exec.addPhysicObject(i*40+j, j*40-20, i*40-20, {type=12,color=0x324650,width=40,height=40,friction=0.3,restitution=0.2})
				tfm.exec.displayParticle(15, j*40-20, i*40-20, 0, -2, 0, 0.1, nil)
				MAP[i][j].nome = false
				if MAP[i][j].lock then
					MAP[i][j].lock = false
					tfm.exec.removeImage(MAP[i][j].skin)
				end
				if MAP[i][j].piso then
					tfm.exec.removeImage(MAP[i][j].piso)
					MAP[i][j].piso = false
				end
				cont = cont + 1
			end
		end
	end
	PLAYER[p].score = PLAYER[p].score + cont
	tfm.exec.setPlayerScore(p, PLAYER[p].score, false)
end

function recebeItem(p)
	local lista = {
		["normal"] = {"flecha 3","cannon","conj 5","cadeado","trap","fireworks","cheese","vamp","dinamite","surpresa","chuva","bug"},
		["normal-time"] = {"flecha 3","cannon","cadeado","trap","fireworks","cheese","vamp","dinamite","bug"},
		["lock"] = {"flecha 3","cannon","conj 5","trap","cheese","dinamite"},
		["lock-time"] = {"flecha 3","cannon","trap","cheese","dinamite"},
		["score"] = {"flecha 3","cannon","conj 5","cadeado","trap","fireworks","cheese","vamp","dinamite","surpresa","chuva","bug"}
	}
	local itemImg = {
		["surpresa"] = "15f11b9ee25.png",
		["cheese"] = "15f11ba3e73.png",
		["cadeado"] = "15f11ba808d.png",
		["vamp"] = "15f11bace66.png",
		["cannon"] = "15f11bb276d.png",
		["bomba"] = "15f11bb7aa3.png",
		["fireworks"] = "15f11bbc11b.png",
		["dinamite"] = "15f11bc0ad0.png",
		["chuva"] = "15f11bc5acb.png",
		["bug"] = "15f11bc9b0b.png",
		["flecha 3"] = "15f11bcd8f4.png",
		["conj 5"] = "15f11bd3773.png",
		["trap"] = "15f11bd788b.png"
	}
	local itens = lista[MODO]
	local rand = itens[math.random(#itens)]
	if PLAYER[p].item then
		tfm.exec.removeImage(PLAYER[p].img)
	end
	PLAYER[p].item = rand
	PLAYER[p].img = tfm.exec.addImage(itemImg[rand], "$"..p, -15, -100, nil)
end

function ativaCannon(p, x, y, xx, yy)
	local obj = tfm.exec.addShamanObject(17, tfm.get.room.playerList[p].isFacingRight and x+15 or x-15, y, tfm.get.room.playerList[p].isFacingRight and 90 or -90, tfm.get.room.playerList[p].isFacingRight and 5 or -5, -1, false)
	system.newTimer(function ()
		tfm.exec.removeObject(obj)
	end, 1000, true)
end

function ativaCadeado(p, x, y, xx, yy)
	if PLAYER[p].lock.on then
		system.removeTimer(PLAYER[i].lock.timer)
	else
		for i=1, 20 do
			for j=1, 40 do
				if MAP[i][j].nome == p then
					MAP[i][j].lock = true
					MAP[i][j].skin = tfm.exec.addImage("15f11b98912.png", "_10000", j*40-40, i*40-40, nil)
				end
			end
		end
		PLAYER[p].lock.on = true
	end
	PLAYER[p].lock.timer = system.newTimer(function ()
		for i=1, 20 do
			for j=1, 40 do
				if MAP[i][j].nome == p then
					tfm.exec.removeImage(MAP[i][j].skin)
					MAP[i][j].lock = false
				end
			end
		end
		PLAYER[p].lock.on = false
	end, 15000, false)
end

function ativaTrap(p, x, y, xx, yy)
	if not MAP[yy][xx].item.nome then
		local trapImg = {
			["normal"] = "15f11be1df4.png",
			["normal-time"] = "15f11be1df4.png",
			["lock"] = "15f11be1df4.png",
			["lock-time"] = "15f11be1df4.png",
			["score"] = "15f11bea136.png",
		}
		MAP[yy][xx].item.nome = "trap"
		MAP[yy][xx].item.img = tfm.exec.addImage(trapImg[MODO], "_1000", xx*40-40, yy*40-40, nil)
	end
end

function ativaFireworks(p, x, y, xx, yy)
	local part = {0, 1, 2, 4, 9, 11, 13}
	for i=1, 50 do
		local xxx = math.random(1,40)
		local yyy = math.random(1,20)
		if MAP[yyy][xxx].on then
			colorir(p, xxx, yyy)
			for j=1, 10 do
				tfm.exec.displayParticle(part[math.random(#part)], xxx*40-20, yyy*40-20, math.random(-10,10)/5, math.random(-10,10)/5, 0, 0, nil)
			end
		end
	end
end

function ativaCheese(p, x, y, xx, yy)
	local perto = {}
	local r = 30
	for i = 0, 360, 10 do
		local angle = i * math.pi / 180
		local ptx, pty = x + r * math.cos( angle ), y + r * math.sin( angle )
		tfm.exec.displayParticle(3,ptx,pty,math.cos(angle)*3,math.sin(angle)*3,0,0)
	end
	for i, v in pairs(PLAYER) do
		local xxx = tfm.get.room.playerList[i].x
		local yyy = tfm.get.room.playerList[i].y
		if i ~= p and xxx > x-100 and xxx < x+100 and yyy > y-100 and yyy < y+100 then
			table.insert(perto, i)
		end
	end
	if #perto > 0 then
		local nome = perto[math.random(#perto)]
		tfm.exec.giveCheese(nome)
		ui.addTextArea(3000, "<p align='center'>"..p.." te deu um queijo.", nome, 300, 360, 200, 20, 1, 0xff0000, 0.5, true)
		system.newTimer(function ()
			ui.removeTextArea(3000, nome)
		end, 5000, false)
	end
end

function ativaVamp(p, x, y, xx, yy)
	local perto = {}
	local r = 100
	for i = 0, 360, 10 do
		local angle = i * math.pi / 180
		local ptx, pty = x + r * math.cos( angle ), y + r * math.sin( angle )
		tfm.exec.displayParticle(13,ptx,pty,-(math.cos(angle)*4),-(math.sin(angle)*4),0,0)
	end
	for i, v in pairs(PLAYER) do
		local xxx = tfm.get.room.playerList[i].x
		local yyy = tfm.get.room.playerList[i].y
		if i ~= p and xxx > x-100 and xxx < x+100 and yyy > y-100 and yyy < y+100 then
			table.insert(perto, i)
		end
	end
	if #perto > 0 then
		local nome = perto[math.random(#perto)]
		for i=1, 20 do
			for j=1, 40 do
				if MAP[i][j].nome == nome then
					colorir(p, j, i)
					for n=1, 10 do
						tfm.exec.displayParticle(13, j*40-20, i*40-20, math.random(-10,10)/5, math.random(-10,10)/5, 0, 0, nil)
					end
				end
			end
		end
		ui.addTextArea(3000, "<p align='center'>"..p.." roubou suas cores!", nome, 300, 360, 200, 20, 1, 0xff0000, 0.5, true)
		system.newTimer(function ()
			ui.removeTextArea(3000, nome)
		end, 5000, false)
	end
end

function ativaSurpresa(p, x, y, xx, yy)
	local piso = {
		{img="15f11befb47.png", f=0, r=0.2},
		{img="15f11bf7572.png", f=0, r=1.2},
		{img="15f11bfcfa6.png", f=0, r=20},
		{img="15f11c00c29.png", f=20, r=0.2},
	}
	local rand = math.random(4)
	if PLAYER[p].piso then
		system.removeTimer(PLAYER[p].piso)
	end
	for i=1, 20 do
		for j=1, 40 do
			if MAP[i][j].nome == p then
				if MAP[i][j].piso then
					tfm.exec.removeImage(MAP[i][j].piso)
				end
				tfm.exec.addPhysicObject(i*40+j, j*40-20, i*40-20, {type=12, color=PLAYER[p].cor, width=40, height=40, friction=piso[rand].f, restitution=piso[rand].r})
				MAP[i][j].piso = tfm.exec.addImage(piso[rand].img, "_10000", j*40-40, i*40-40, p)
			end
		end
	end
	PLAYER[p].piso = system.newTimer(function ()
		PLAYER[p].piso = false
		for i=1, 20 do
			for j=1, 40 do
				if MAP[i][j].nome == p and MAP[i][j].piso then
					tfm.exec.removeImage(MAP[i][j].piso)
					MAP[i][j].piso = false
					tfm.exec.addPhysicObject(i*40+j, j*40-20, i*40-20, {type=12, color=PLAYER[p].cor, width=40, height=40, friction=0.3, restitution=0.2})
				end
			end
		end
	end, 15000, false)
end

function ativaBug(p, x, y, xx, yy)
	local perto = {}
	local r = 30
	for i = 0, 720 do
		local angle = i * math.pi / 180
		local ptx, pty = x + r * math.cos( angle ), y + r * math.sin( angle )
		tfm.exec.displayParticle(11,ptx,pty,math.cos(angle)*10,math.sin(angle)*10,0,0)
	end
	for i, v in pairs(PLAYER) do
		local xxx = tfm.get.room.playerList[i].x
		local yyy = tfm.get.room.playerList[i].y
		if i ~= p and xxx > x-200 and xxx < x+200 and yyy > y-200 and yyy < y+200 then
			table.insert(perto, i)
		end
	end
	for i=1, #perto do
		if PLAYER[perto[i]].bug.img then
			system.removeTimer(PLAYER[perto[i]].bug.timer)
		else
			PLAYER[perto[i]].bug.img = true
		end
		PLAYER[perto[i]].bug.timer = system.newTimer(function ()
			if PLAYER[perto[i]] then
				PLAYER[perto[i]].bug.img = false
			end
		end, 10000, false)
		ui.addTextArea(3000, "<p align='center'>"..p.." bugou voc?.", perto[i], 300, 360, 200, 20, 1, 0xff0000, 0.5, true)
		system.newTimer(function ()
			ui.removeTextArea(3000, nome)
		end, 5000, false)
	end
end

function ativaChuva(p, x, y, xx, yy)
	for i=1, 300 do
		local xxx = math.random(1,40)
		local yyy = math.random(1,20)
		if MAP[yyy][xxx].nome and MAP[yyy][xxx].nome ~= p and not MAP[yyy][xxx].lock then
			MAP[yyy][xxx].nome = false
			tfm.exec.addPhysicObject(yyy*40+xxx, xxx*40-20, yyy*40-20, {type=12,color=0x324650,width=40,height=40,friction=0.3,restitution=0.2})
			if MAP[yyy][xxx].piso then
				tfm.exec.removeImage(MAP[yyy][xxx].piso)
				MAP[yyy][xxx].piso = false
			end
			for j=1, 10 do
				tfm.exec.displayParticle(14, xxx*40-20, yyy*40-20, math.random(-10,10)/5, math.random(-10,10)/5, 0, 0, nil)
			end
		end
	end
end

function usaItem(p, x, y, xx, yy)
	local mouse = {
		["dinamite"] = true,
		["conj 5"] = true,
		["conj 4"] = true,
		["conj 3"] = true,
		["conj 2"] = true,
		["conj 1"] = true
	}
	if mouse[PLAYER[p].item] then
		ui.addTextArea(2000, "<p align='center'>Clique para usar este item.", p, 300, 360, 200, 20, 1, 0xffff00, 0.5, true)
		system.newTimer(function ()
			ui.removeTextArea(2000, p)
		end, 5000, false)
	elseif PLAYER[p].item:sub(1,6) == "flecha" then
		local flecha = {false, "flecha 1", "flecha 2"}
		local img = {false, "15f11c05b6e.png", "15f11c0a7b4.png"}
		tfm.exec.removeImage(PLAYER[p].img)
		if img[tonumber(PLAYER[p].item:sub(8,8))] then
			PLAYER[p].img = tfm.exec.addImage(img[tonumber(PLAYER[p].item:sub(8,8))], "$"..p, -15, -100, nil)
		end
		PLAYER[p].item = flecha[tonumber(PLAYER[p].item:sub(8,8))]
		local obj = tfm.exec.addShamanObject(35, tfm.get.room.playerList[p].isFacingRight and x+15 or x-15, y, tfm.get.room.playerList[p].isFacingRight and 0 or 180, tfm.get.room.playerList[p].isFacingRight and 30 or -30, -2, false)
		system.newTimer(function ()
			tfm.exec.removeObject(obj)
		end, 1000, false)
	else
		local itens = {
			["cannon"] = ativaCannon,
			["cadeado"] = ativaCadeado,
			["trap"] = ativaTrap,
			["fireworks"] = ativaFireworks,
			["cheese"] = ativaCheese,
			["vamp"] = ativaVamp,
			["surpresa"] = ativaSurpresa,
			["bug"] = ativaBug,
			["chuva"] = ativaChuva,
		}
		if itens[PLAYER[p].item] then
			local f = itens[PLAYER[p].item]
			f(p, x, y, xx, yy)
		end
		PLAYER[p].item = false
		tfm.exec.removeImage(PLAYER[p].img)
	end
end

function eventMouse(p, x, y)
	if PODE and PLAYER[p] and PLAYER[p].stamina > 0 and PLAYER[p].item then
		local mouse = {
			["dinamite"] = true,
			["conj 5"] = true,
			["conj 4"] = true,
			["conj 3"] = true,
			["conj 2"] = true,
			["conj 1"] = true
		}
		if mouse[PLAYER[p].item] then
			if PLAYER[p].item == "dinamite" then
				local part = {0, 1, 2, 4, 9, 11, 13}
				local img = tfm.exec.addImage("15f11c0f2f6.png", "_1000", x-20, y-20, nil)
				tfm.exec.removeImage(PLAYER[p].img)
				PLAYER[p].item = false
				system.newTimer(function ()
					tfm.exec.removeImage(img)
					tfm.exec.explosion(x, y, 100, 160, false)
					for j=1, 10 do
						tfm.exec.displayParticle(part[math.random(#part)], x, y, math.random(-10,10)/3, math.random(-10,10)/3, 0, 0, nil)
					end
				end, 3000, false)
			else
				local conj = {false, "conj 1", "conj 2", "conj 3", "conj 4"}
				local img = {false, "15f11c13e8d.png", "15f11c1770d.png", "15f11c1af65.png", "15f11c1f3ad.png"}
				tfm.exec.removeImage(PLAYER[p].img)
				if img[tonumber(PLAYER[p].item:sub(6,6))] then
					PLAYER[p].img = tfm.exec.addImage(img[tonumber(PLAYER[p].item:sub(6,6))], "$"..p, -15, -100, nil)
				end
				PLAYER[p].item = conj[tonumber(PLAYER[p].item:sub(6,6))]
				local id = CONT
				CONT = (CONT + 1)%50
				tfm.exec.addPhysicObject(id+50000, math.floor(x/10)*10+5, math.floor(y/10)*10+5, {type=12,color=0x324650,width=10,height=10,friction=0.3,restitution=0.2})
				system.newTimer(function ()
					tfm.exec.removePhysicObject(id+50000)
				end, 10000, false)
			end
		else
			ui.addTextArea(2000, "<p align='center'>Pressione E para usar este item.", p, 300, 360, 200, 20, 1, 0xffff00, 0.5, true)
			system.newTimer(function ()
				ui.removeTextArea(2000, p)
			end, 5000, false)
		end
	end
end

function eventKeyboard(p, t, d, x, y)
	if PODE and PLAYER[p] and PLAYER[p].stamina and PLAYER[p].bug and PLAYER[p].stamina > 0 and not PLAYER[p].bug.img then
		local xx = math.ceil(x/40)
		local yy = math.ceil(y/40)
		if t == 40 or t == 83 then
			if x > 0 and x < 1600 and y > 0 and y < 800 and MAP[yy][xx].item.nome then
				if MAP[yy][xx].item.nome == "score" then
					adicionaPontos(p)
				elseif MAP[yy][xx].item.nome == "item" then
					recebeItem(p)
				elseif MAP[yy][xx].item.nome == "trap" then
					local obj = tfm.exec.addShamanObject(math.random(1,2) == 1 and 61 or 68, x, y, 0, 0, 0, false)
					system.newTimer(function ()
						tfm.exec.removeObject(obj)
					end, 10000, false)
				end
				MAP[yy][xx].item.nome = false
				tfm.exec.removeImage(MAP[yy][xx].item.img)
			else
				colorir(p, xx, yy+1)
				colorir(p, xx+1, yy)
				colorir(p, xx-1, yy)
			end
			PLAYER[p].stamina = PLAYER[p].stamina - 1
		elseif (t == 69 or t == 67) and PLAYER[p].item then
			usaItem(p, x, y, xx, yy)
		end
	end
end

function eventPlayerDied(p)
	if PODE then
		for i=1, 20 do
			for j=1, 40 do
				if MAP[i][j].nome == p then
					MAP[i][j].nome = false
					MAP[i][j].team = false
					MAP[i][j].mort.img = tfm.exec.addImage("15f11c24173.png", "_1000", j*40-40, i*40-40, nil)
					if MAP[i][j].lock then
						tfm.exec.removeImage(MAP[i][j].skin)
					end
					if MAP[i][j].piso then
						tfm.exec.removeImage(MAP[i][j].piso)
						MAP[i][j].piso = false
					end
					MAP[i][j].lock = true
					MAP[i][j].mort.nome = p
				end
			end
		end
		system.newTimer(function ()
			for i=1, 20 do
				for j=1, 40 do
					if MAP[i][j].mort.nome == p then
						tfm.exec.addPhysicObject(i*40+j, j*40-20, i*40-20, {type=12,color=0x324650,width=40,height=40,friction=0.3,restitution=0.2})
						tfm.exec.removeImage(MAP[i][j].mort.img)
						MAP[i][j].lock = false
						MAP[i][j].mort.nome = false
					end
				end
			end
			tfm.exec.respawnPlayer(p)
			if PLAYER[p] then
				tfm.exec.setNameColor(p, PLAYER[p].cor)
				PLAYER[p].item = false
			end
			tfm.exec.giveMeep(p)
			local rand = math.random(#LIST.spawn)
			tfm.exec.movePlayer(p, LIST.spawn[rand].xx*40-20, LIST.spawn[rand].yy*40-20, false, 0, 0, false)
		end, 1000, false)
	end
end

function eventNewGame()
	tfm.exec.setGameTime(120)
	INTERVALO = os.time()
	PODE = false
	CHANGE = true
	for i=1, 20 do
		for j=1, 40 do
			MAP[i][j] = {on=false, nome=false, mort={img=false, nome=false}, lock=false, item={img=false, nome=false}, team=false, piso=false}
		end
	end
	for i=1, #LIST.spawn do
		table.remove(LIST.spawn)
	end
	for i=1, #LIST.item do
		table.remove(LIST.item)
	end
	for i=1, #LIST.score do
		table.remove(LIST.score)
	end
	local cont = 0
	for i, v in pairs(tfm.get.room.playerList) do
		if PLAYER[i] and PLAYER[i].lock and PLAYER[i].lock.on then
			system.removeTimer(PLAYER[i].lock.timer)
		end
		if PLAYER[i] and PLAYER[i].bug and PLAYER[i].bug.img then
			system.removeTimer(PLAYER[i].bug.timer)
		end
		PLAYER[i] = nil
		cont = cont + 1
	end
	if geraXml(tfm.get.room.xmlMapInfo.xml) then
		MODO = cont > 7 and MODOS[math.random(#MODOS)] or MODOS2[math.random(#MODOS2)]
		local img = {
			["normal"] = "15f11c2a1db.png",
			["normal-time"] = "15f11c2a1db.png",
			["lock"] = "15f11c33829.png",
			["lock-time"] = "15f11c33829.png",
			["score"] = "15f11c3a290.png"
		}
		local a = tfm.exec.addImage(img[MODO], "&1000", 200, 50, nil)
		system.newTimer(function ()
			tfm.exec.removeImage(a)
		end, 7000, false)
		if MODO == "normal" or MODO == "lock" or MODO == "score" then
			local cores = {
				0xFF3737, 0x3136AF, 0x6DBC54, 0xFFF62C, 
				0xADEE4D, 0x948D2A, 0x202020, 0x715035,
				0xFFABAB, 0x4588FE, 0x6DECC9, 0xE5E5E5,
				0xFF6C22, 0x795796, 0xFF61E9, 0xFF3089
			}
			for i, v in pairs(tfm.get.room.playerList) do
				tfm.exec.bindKeyboard(i, 40, true, true)
				tfm.exec.bindKeyboard(i, 83, true, true)
				tfm.exec.bindKeyboard(i, 69, true, true)
				tfm.exec.bindKeyboard(i, 67, true, true)
				system.bindMouse(i, true)
				local rand = math.random(#cores)
				PLAYER[i] = {stamina=0, score=0, cor=cores[rand], item=false, img=false, lock = {on=false, timer=0}, piso=false, bug={img=false, timer=0}}
				tfm.exec.setNameColor(i, cores[rand])
				tfm.exec.giveMeep(i)
				table.remove(cores, rand)
				rand = math.random(#LIST.spawn)
				tfm.exec.movePlayer(i, LIST.spawn[rand].xx*40-20, LIST.spawn[rand].yy*40-20, false, 0, 0, false)
				tfm.exec.setPlayerScore(i, 0, false)
				if #cores == 0 then
					break
				end
			end
		elseif MODO == "normal-time" or MODO == "lock-time" then
			local cores = {
				0xFF3737, 0x3136AF, 0x6DBC54, 0xFFF62C, 
			}
			local equipe = {
				"vermelho", "azul", "verde", "amarelo"
			}
			local cont = 0
			for i, v in pairs(tfm.get.room.playerList) do
				tfm.exec.bindKeyboard(i, 40, true, true)
				tfm.exec.bindKeyboard(i, 83, true, true)
				tfm.exec.bindKeyboard(i, 69, true, true)
				tfm.exec.bindKeyboard(i, 67, true, true)
				ui.addTextArea(4000, "<p align='center'>Voc? est? no time ".. equipe[cont+1], i, 300, 360, 200, 20, 1, cores[cont+1], 0.5, true)
				system.bindMouse(i, true)
				PLAYER[i] = {stamina=0, score=0, cor=cores[cont+1], bug={img=false, timer=0}, item=false, img=false, lock = {on=false, timer=0}, piso=false}
				tfm.exec.setNameColor(i, cores[cont+1])
				tfm.exec.giveMeep(i)
				local rand = math.random(#LIST.spawn)
				tfm.exec.movePlayer(i, LIST.spawn[rand].xx*40-20, LIST.spawn[rand].yy*40-20, false, 0, 0, false)
				cont = (cont + 1)%4
			end
			system.newTimer(function ()
				ui.removeTextArea(4000, nome)
			end, 5000, false)
		end
		PODE = true
	else
		ATUAL = CODE[math.random(#CODE)]
		CHANGE = false
	end
end
function eventPlayerLeft(p)
	PLAYER[p] = nil
end

function posicionaScore()
	local rand = math.random(#LIST.score)
	if not MAP[LIST.score[rand].yy][LIST.score[rand].xx].item.nome then
		MAP[LIST.score[rand].yy][LIST.score[rand].xx].item.nome = "score"
		MAP[LIST.score[rand].yy][LIST.score[rand].xx].item.img = tfm.exec.addImage("15f11bea136.png", "_1000", LIST.score[rand].xx*40-40, LIST.score[rand].yy*40-40, nil)
	end
end

function posicionaItem()
	local rand = math.random(#LIST.item)
	if not MAP[LIST.item[rand].yy][LIST.item[rand].xx].item.nome then
		MAP[LIST.item[rand].yy][LIST.item[rand].xx].item.nome = "item"
		MAP[LIST.item[rand].yy][LIST.item[rand].xx].item.img = tfm.exec.addImage("15f11be1df4.png", "_1000", LIST.item[rand].xx*40-40, LIST.item[rand].yy*40-40, nil)
	end
end

function eventLoop(current, remaining)
	if not CHANGE then
		botaMapa(ATUAL)
	elseif PODE then
		if MODO == "score" and math.floor(current/2000)%5 == 0 then
			posicionaScore()
		end
		if math.floor(current/2000)%15 == 0 then
			posicionaItem()
		end
		for i, v in pairs(PLAYER) do
			v.stamina = v.stamina >= 2 and v.stamina or v.stamina + 1
			if MODO ~= "score" then
				v.score = 0 
			end
		end
		local maior = 0
		local cor = 0
		local nome = ""
		local times = {
			[0xFF3737]={score=0,nome="vermelho"},
			[0x3136AF]={score=0,nome="azul"},
			[0x6DBC54]={score=0,nome="verde"},
			[0xFFF62C]={score=0,nome="amarelo"}
		}
		if MODO == "normal" or MODO == "lock" then
			for i=1, 20 do
				for j=1, 40 do
					if MAP[i][j].nome then
						PLAYER[MAP[i][j].nome].score = PLAYER[MAP[i][j].nome].score + 1
					end
				end
			end
			for i, v in pairs(PLAYER) do
				if v.score > maior then
					maior = v.score
					nome = i
					cor = v.cor
				end
				if tfm.get.room.playerList[i].score ~= v.score then
					tfm.exec.setPlayerScore(i, v.score, false)
				end
			end
			ui.addTextArea(10, "", nil, -20, 0, 20, 400, cor, cor, 1, true)
			ui.addTextArea(11, "", nil, 800, 0, 20, 400, cor, cor, 1, true)
			ui.addTextArea(12, "", nil, 0, 3, 800, 20, cor, cor, 1, true)
			ui.addTextArea(13, "", nil, 0, 400, 800, 20, cor, cor, 1, true)
		elseif MODO == "normal-time" or MODO == "lock-time" then
			for i=1, 20 do
				for j=1, 40 do
					if MAP[i][j].team then
						times[MAP[i][j].team].score = times[MAP[i][j].team].score + 1
					end
				end
			end
			for i, v in pairs(times) do
				if v.score > maior then
					maior = v.score
					cor = i
				end
			end
			ui.addTextArea(10, "", nil, -20, 0, 20, 400, cor, cor, 1, true)
			ui.addTextArea(11, "", nil, 800, 0, 20, 400, cor, cor, 1, true)
			ui.addTextArea(12, "", nil, 0, 3, 800, 20, cor, cor, 1, true)
			ui.addTextArea(13, "", nil, 0, 400, 800, 20, cor, cor, 1, true)
		elseif MODO == "score" then
			for i, v in pairs(PLAYER) do
				if v.score > maior then
					maior = v.score
					nome = i
					cor = v.cor
				end
			end
			ui.addTextArea(10, "", nil, -20, 0, 20, 400, cor, cor, 1, true)
			ui.addTextArea(11, "", nil, 800, 0, 20, 400, cor, cor, 1, true)
			ui.addTextArea(12, "", nil, 0, 3, 800, 20, cor, cor, 1, true)
			ui.addTextArea(13, "", nil, 0, 400, 800, 20, cor, cor, 1, true)
		end
		if remaining < 0 then
			if MODO == "normal" or MODO == "lock" or MODO == "score" then
				tfm.exec.chatMessage(string.format("<j>%s venceu o round (%d pisos)", nome, maior))
			elseif MODO == "normal-time" or MODO == "lock-time" then
				local txt = " "
				for i, v in pairs(PLAYER) do
					txt = PLAYER[i].cor == cor and (txt .. i .. " ") or txt
				end
				if cor ~= 0 then
					tfm.exec.chatMessage(string.format("<j>Time %s (%s) venceu o round (%d pisos)", times[cor].nome, txt, maior))
				end
			elseif MODO == "score" then
				tfm.exec.chatMessage(string.format("<j>%s venceu o round (%d pontos)", nome, maior))
			end
			CHANGE = false
			ATUAL = CODE[math.random(#CODE)]
			botaMapa(ATUAL)
		end
	end
end

tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAllShamanSkills(true)
tfm.exec.setRoomMaxPlayers(16)
tfm.exec.newGame(ATUAL)