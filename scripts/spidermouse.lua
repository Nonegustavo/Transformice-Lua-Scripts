-- Rato Aranha - 10/02/2015
-- Escrito por Ninguem

lado = 39
adm = "Ninguem#0095" -- ponha seu nickname aqui para usar o comando !skip, que inicia novo mapa
tempo = 999999
nome = "Shamaniaco"

function geraMapa()
	local fundo = {0, 1, 2, 7, 8}
	local inicio = string.format([[<C><P Ca="" F="%d" L="6000" G="0,12" /><Z><S><S H="10" lua="1" L="15" o="ffffffff" P="1,999999,0.3,0.2,0,1,0,0" X="200" c="2" Y="100" T="13" /><S X="200" lua="11" L="100" o="ffffffff" P="1,0,0.3,0.2,0,1,0,0" H="20" c="3" Y="-325" T="12" /><S P="1,0,0.3,0.2,0,1,0,0" lua="12" H="20" L="100" o="ffffffff" X="200" c="3" Y="-274" T="12" /><S H="100" lua="13" L="20" o="ffffffff" P="1,0,0.3,0.2,0,1,0,0" X="175" c="3" Y="-300" T="12" /><S P="1,0,0.3,0.2,0,1,0,0" lua="14" X="225" L="20" o="ffffffff" H="100" c="3" Y="-300" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" lua="0" L="200" o="ffffffff" X="200" H="20" Y="123" T="12" /><S X="0" lua="2" L="10" o="ffffffff" P="0,0,0.3,0.2,0,0,0,0" H="10" Y="0" T="12" /><S X="187" P="1,0,0.3,0.2,0,0,0,0" L="20" H="20" c="4" N="" Y="87" T="0" /><S H="20" P="1,0,0.3,0.2,0,0,0,0" L="20" X="213" c="4" N="" Y="87" T="0" /><S X="200" P="1,0,0.3,0.2,0,0,0,0" L="10" H="25" c="4" N="" Y="114" T="0" /><S X="200" P="1,0,20,0.2,0,1,0,0" L="25" H="25" c="2" N="" Y="100" T="4" /><S X="200" P="1,0,20,0.2,0,0,0,0" L="30" H="10" c="4" N="" Y="124" T="4" /><S H="10" P="0,0,0.3,9999,0,0,0,0" L="3000" o="324650" X="1500" c="1" Y="0" T="12" /><S P="0,0,0.3,9999,0,0,0,0" X="4500" L="3000" o="324650" H="10" c="1" Y="0" T="12" /><S H="800" P="0,0,0.3,0.2,0,0,0,0" L="10" o="324650" X="6005" Y="0" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="324650" H="800" X="-5" Y="0" T="12" />]],fundo[math.random(#fundo)])
	local final = [[</S><D><T Y="-400" X="5975" /><T Y="-369" X="5975" /><T Y="-336" X="5975" /><T Y="-303" X="5975" /><T Y="-271" X="5975" /><T Y="-239" X="5975" /><T Y="-206" X="5975" /><T Y="-174" X="5975" /><T Y="-142" X="5975" /><T Y="-109" X="5975" /><T Y="-75" X="5975" /><T Y="-41" X="5975" /><T Y="-6" X="5975" /><T Y="-400" X="5950" /><T Y="-369" X="5950" /><T Y="-336" X="5950" /><T Y="-303" X="5950" /><T Y="-271" X="5950" /><T Y="-239" X="5950" /><T Y="-206" X="5950" /><T Y="-174" X="5950" /><T Y="-142" X="5950" /><T Y="-109" X="5950" /><T Y="-50" X="5950" /><T Y="-41" X="5950" /><T Y="-6" X="5950" /><DC Y="-300" X="200" /><DS Y="600" X="0" /></D><O><O X="194" C="22" Y="93" P="0" /><O X="208" C="22" Y="93" P="0" /><O X="200" C="22" Y="124" P="0" /><O X="200" C="14" Y="108" P="0" /></O><L><JR M1="0" M2="1" /><JR M1="0" M2="2" /><JR M1="0" M2="3" /><JR M1="0" M2="4" /><JR M1="0" M2="10" /></L></Z></C>]]
	for i=1, 300 do
		local frente = math.random(1,2) == 1
		inicio = inicio .. string.format([[<S H="%d" P="0,0,0.3,0.2,0,0,0,0" L="%d" X="%d" c="4" Y="400" T="12" o="%x" %s/>]], math.random(40,400), math.random(40,100), i*50, frente and 0x111111 or 0x222222, frente and [[N=""]] or "")
	end
	return(inicio .. final)
end

function eventNewGame()
	ui.addTextArea(2, "<p><font size='20px'face='Comic Sans MS'color='#000000'>Segure espaço para usar a teia :D", nil, 11, 351, 400, 50, 0, 0, 0, false)
	ui.addTextArea(0, "<p><font size='20px'face='Comic Sans MS'>Segure espaço para usar a teia :D", nil, 10, 350, 400, 50, 0, 0, 0, false)
	ui.addTextArea(1, string.format("<p><font size='15px'face='Comic Sans MS'color='#000000'><b>Melhor tempo:</b>\n%.2s (%ss)", nome, tempo/100), nil, 10, 30, 400, 50, 0, 0, 0, false)
	ui.addTextArea(4, string.format("<p><font size='15px'face='Comic Sans MS'><b>Melhor tempo:</b>\n%.2s (%ss)", nome, tempo/100), nil, 9, 29, 400, 50, 0, 0, 0, false)
	for i, v in pairs(tfm.get.room.playerList) do
		if v.isShaman then
			tfm.exec.bindKeyboard(i, 32, true, true)
			tfm.exec.bindKeyboard(i, 39, true, true)
			tfm.exec.bindKeyboard(i, 37, true, true)
			tfm.exec.bindKeyboard(i, 32, false, true)
			tfm.exec.giveCheese(i)
		end
	end
end

function eventChatCommand(p, cmd)
	if p == adm and cmd == "skip" then
		tfm.exec.newGame(geraMapa())
	end
end

function eventPlayerWon(p, t)
	if t < tempo then
		tempo = t
		nome = p
	end
end

function eventKeyboard(p, key, down, x, y)
	if tfm.get.room.playerList[p].isShaman then
		if key == 32 then
			if down then
				tfm.exec.removePhysicObject(0)
				if lado == 39 then
					tfm.exec.addJoint(1, 1, 2, {type=0,point2=string.format("%d,0",y+x+400),color=0xffffff,line=math.random(1,5),foreground=true})
				else
					tfm.exec.addJoint(1, 1, 2, {type=0,point2=string.format("%d,0",x-(400+y)),color=0xffffff,line=math.random(1,5),foreground=true})
				end
			else
				tfm.exec.addJoint(1, 2, 2, {type=0,point1="0,0",point2="0,1",color=0x324650,line=5})
			end
		else
			lado = key
		end
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

function eventLoop()
	if todosMortos() then
		tfm.exec.newGame(geraMapa())
	end
end

tfm.exec.disableAfkDeath(true)
tfm.exec.disableAllShamanSkills(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.newGame(geraMapa())