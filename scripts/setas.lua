adm = "Ninguem#0095" -- ponha seu nickname aqui para usar o comando !new, que inicia novo mapa
player = {}
arrow = {"&#51;", "&#53;", "&#52;", "&#54;"}
state = "play"
mapa = [[<C><P /><Z><S><S L="800" o="324650" H="40" X="400" Y="380" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="10" o="6a7495" H="400" X="-5" Y="200" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="6a7495" X="805" Y="200" T="12" H="400" /></S><D><T Y="359" X="400" /></D><O /></Z></C>]]
lim = 50

function rand(seed)
	math.randomseed(seed)
  local num = math.random()
  while num - math.floor(num) ~= 0 do
    num = num * 10
  end
	return num
end

function writeLine(seed, line, p)
	local t = {}
	for i=1, 10 do
		seed = rand(seed)
		table.insert(t, seed%4)
		ui.addTextArea(line*100+i, "<p align='center'><font face='Webdings' size='45px' >"..arrow[t[i]+1], p, 100+(i-1)*60, 95+(line-1)*60, 50, 50, 1, 1, 0.8, true)
	end
	return seed, t
end

function eventNewGame()
	lim = 50
  state = "play"
	local seed = os.time()
	ui.removeTextArea(0)
	ui.addTextArea(1, "", nil, 95, 60, 600, 20, 1, 1, 0.8, true)
	--system.newTimer(function()
		for i, v in pairs(tfm.get.room.playerList) do
			player[i] = {score=0, last=seed, arrows={}, line=1, row=1}
			player[i].last, player[i].arrows[1] = writeLine(player[i].last, 1)
			player[i].last, player[i].arrows[2] = writeLine(player[i].last, 2)
			player[i].last, player[i].arrows[3] = writeLine(player[i].last, 3)
			ui.addTextArea(1*100+1, "<p align='center'><font face='Webdings' size='45px' color='#ffff00'>"..arrow[player[i].arrows[1][1]+1], nil, 100+(1-1)*60, 95+(1-1)*60, 50, 50, 1, 0xffff00, 0.8, true)
			system.bindKeyboard(i, 0, true, true)
			system.bindKeyboard(i, 1, true, true)
			system.bindKeyboard(i, 2, true, true)
			system.bindKeyboard(i, 3, true, true)
		end
	--end, 3000, false)
end

function eliminaJogador(p, nome)
	player[p].death = true
	system.bindKeyboard(p, 0, true, false)
	system.bindKeyboard(p, 1, true, false)
	system.bindKeyboard(p, 2, true, false)
	system.bindKeyboard(p, 3, true, false)
	tfm.exec.killPlayer(p)
	ui.addTextArea(0, string.format("<p align='center'><font size='20px'>%s matou você.", nome), p, 200, 200, 400, nil, 1, 0xff0000, 1, true)
end

function atualizaBarras()
	local nome = ""
	local maior = 0
	for i, v in pairs(player) do
		if v.score > maior then
			nome = i
			maior = v.score
		end
	end
	for i, v in pairs(player) do
		if not v.death then
			local diff = lim - (maior - v.score)
			local color = diff >= lim and 0x00ffff or diff/lim > 0.66 and 0x00ff00 or diff/lim > 0.33 and 0xffff00 or 0xff0000
			ui.addTextArea(0, "", i, 95, 60, (diff/lim)*600, 20, color, 1, 1, true)
			tfm.exec.setNameColor(i, color)
			if v.score <= maior - lim then
				eliminaJogador(i, nome)
			end
		end
	end
	local cont = 0
	for i, v in pairs(player) do
		if not v.death then
			cont = cont + 1
		end
	end
	if cont == 1 then
		system.bindKeyboard(nome, 0, true, false)
		system.bindKeyboard(nome, 1, true, false)
		system.bindKeyboard(nome, 2, true, false)
		system.bindKeyboard(nome, 3, true, false)
		ui.addTextArea(0, string.format("<p align='center'><font size='30px'>%s venceu!", nome), nil, 200, 150, 400, nil, 1, 0xffff00, 1, true)
    tfm.exec.setGameTime(5)
    state = "finish"
	end
end

function eventKeyboard(p, t, d, x, y)
	if player[p] then
		if t == player[p].arrows[player[p].line][player[p].row] then
			ui.addTextArea(player[p].line*100+player[p].row, "<p align='center'><font face='Webdings' size='45px' color='#000000'>"..arrow[player[p].arrows[player[p].line][player[p].row]+1], p, 100+(player[p].row-1)*60, 95+(player[p].line-1)*60, 50, 50, 1, 1, 0.8, true)
			if player[p].row >= 10 then
				player[p].last, player[p].arrows[player[p].line] = writeLine(player[p].last, player[p].line, p)
				player[p].row = 1
				player[p].line = player[p].line >= 3 and 1 or player[p].line + 1
			else
				player[p].row = player[p].row + 1
			end
			ui.addTextArea(player[p].line*100+player[p].row, "<p align='center'><font face='Webdings' size='45px' color='#ffff00'>"..arrow[player[p].arrows[player[p].line][player[p].row]+1], p, 100+(player[p].row-1)*60, 95+(player[p].line-1)*60, 50, 50, 1, 0xffff00, 0.8, true)
			player[p].score = player[p].score + 1
		else
			player[p].score = player[p].score - 5
			ui.addTextArea(player[p].line*100+player[p].row, "<p align='center'><font face='Webdings' size='45px' color='#ff0000'>"..arrow[player[p].arrows[player[p].line][player[p].row]+1], p, 100+(player[p].row-1)*60, 95+(player[p].line-1)*60, 50, 50, 1, 0xffff00, 0.8, true)
		end
	end
	atualizaBarras()
end

function eventLoop(current, remaining)
  if state == "play" then
    if current > 180000 then
      lim = 3
    elseif current > 150000 then
      lim = 5
    elseif current > 120000 then
      lim = 10
    elseif current > 105000 then
      lim = 15
    elseif current > 900000 then
      lim = 20
    elseif current > 75000 then
      lim = 25
    elseif current > 600000 then
      lim = 30
    elseif current > 45000 then
      lim = 35
    elseif current > 30000 then
      lim = 40
    elseif current > 15000 then
      lim = 45
    end
  elseif state == "finish" and remaining <= 0 then
    tfm.exec.newGame(mapa)
  end
end

function eventChatCommand(p, cmd)
	if p == adm and cmd == "new" then
		tfm.exec.newGame(mapa)
	end
end

tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.newGame(mapa)