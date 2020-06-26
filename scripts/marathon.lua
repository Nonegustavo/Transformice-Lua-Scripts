-- J1ZFW00.png
grounds = ""
decorations = ""
silhueta = ""
sombra = "151c2950671.png"
--sombra = "OYrfh6x.png"
starts = {}
player = {}
stats = {}
code = {}
author = {}
tempo = 0
loading = true
first = false
pisca = false
cont = 1
img = 0
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAfkDeath(true)

lang = {
	en = {
		first = "<rose>%s finished in first place!",
		finish = "<rose>%s finished.",
		loading = "Loading maps...",
		timeUp = "<rose>Time's up!",
		view = "Press left or right to view the maps."
	},
	br = {
		first = "<rose>%s terminou em primeiro lugar!",
		finish = "<rose>%s terminou.",
		loading = "Carregando mapas...",
		timeUp = "<rose>O tempo acabou!",
		view = "Pressione direita ou esquerda para ver os mapas."
	}
}
txt = lang[tfm.get.room.community] or lang.en
print(tfm.get.room.community)

function contaPiso(xml)
	local total = 0
	xml = string.gsub(xml, '<S.-/>', function (a)
		total = total + 1
		return ""
	end)
	xml = string.gsub(xml, '<T.-/>', function (a)
		total = total + 1
		return ""
	end)
	xml = string.gsub(xml, '<F.-/>', function (a)
		total = total + 1
		return ""
	end)
	print(total)
	return total
end

function adicionaCode()
	local xml = tfm.get.room.xmlMapInfo.xml
	if not string.find(xml, 'G=".-"') and not string.find(xml, '6a7495') and not string.find(xml, '6A7495') and contaPiso(xml) <= 50 then
		xml = string.gsub(xml, 'X=".-"', function (a)
			return 'X="'..(tonumber(a:sub(4,-2)) + cont * 1600)..'"'
		end)
		local spawn = string.match(xml, "<DS.-/>")
		local hole = string.match(xml, "<T.-/>")
		if spawn then
			table.insert(starts, {x=tonumber(string.match(spawn,'X=".-"'):sub(4,-2)), y=tonumber(string.match(spawn,'Y=".-"'):sub(4,-2))})
		else
			table.insert(starts, {x=tonumber(string.match(hole, 'X=".-"'):sub(4,-2)), y=tonumber(string.match(hole, 'Y=".-"'):sub(4,-2))})
		end
		xml = string.gsub(xml, "<DS.-/>", "")
		local g = (string.match(xml, "<S>.-</S>")):sub(4,-5)
		g = string.gsub(g, '/>', 'N="" />')
		grounds = grounds .. g
		local d = (string.match(xml, "<D>.-</D>")):sub(4,-5)
		d = string.gsub(d, '/>', 'D="" />')
		decorations = decorations .. d
		silhueta = grounds
		silhueta = string.gsub(silhueta, 'X=".-"', function (a)
			return 'X="'..(tonumber(a:sub(4,-2)) - 1600)..'"'
		end)
		silhueta = string.gsub(silhueta, 'o=".-"', "")
		silhueta = string.gsub(silhueta, 'c=".-"', "")
		silhueta = string.gsub(silhueta, 'T="%d-"', function (a)
			local n = tonumber(a:sub(4,-2))
			if n == 9 or n == 8 then
				return 'T="12" o="647090" c="4"'
			elseif n == 13 then
				return 'T="13" o="586283" c="4"'
			else
				return 'T="12" o="586283" c="4"'
			end
		end)
		silhueta = string.gsub(silhueta, 'N=""', "")
		cont = cont + 1
		table.insert(code, tfm.get.room.currentMap)
		table.insert(author, tfm.get.room.xmlMapInfo.author)
	end
	tfm.exec.setGameTime(3, false)
end

function organizaPartida()
	for i, v in pairs(tfm.get.room.playerList) do
		tfm.exec.movePlayer(i, starts[1].x, starts[1].y, false, 0, 0, false)
		player[i] = {map=1, mort=1}
		tfm.exec.setPlayerScore(i, 0, false)
		tfm.exec.bindKeyboard(i, 37, true, true)
		tfm.exec.bindKeyboard(i, 39, true, true)
	end
	first = true
end

function eventKeyboard(p, t)
	if not loading and player[p].map > 5 then
		if t == 37 and player[p].map > 10 then
			player[p].map = player[p].map - 10
		elseif t == 39 and player[p].map < 50 then
			player[p].map = player[p].map + 10
		end
		tfm.exec.movePlayer(p, 400 + 1600 * (player[p].map/10), -580, false, 0, 0, false)
	end
end

function eventNewGame()
	if loading then
		--tfm.exec.addPhysicObject(1000, 400, -200, {width=3000, height=10, type=0})
		--for i, v in pairs(tfm.get.room.playerList) do
		--	tfm.exec.movePlayer(i, 400, -220, false, 0, 0, false)
		--end
		ui.addTextArea(2, "", nil, 280, 350, (cont+1)*40, 20, 0x222C31, 0x222C31, 1, true)
		print(cont)
		adicionaCode()
	else
		print("partida")
		organizaPartida()
		--tfm.exec.removeImage(img)
		ui.removeTextArea(0, nil)
		ui.removeTextArea(1, nil)
		ui.removeTextArea(2, nil)
		ui.removeTextArea(3, nil)
		tfm.exec.setUIMapName("<font size='10'>"..table.concat(code, ", ").."</font>")
		tfm.exec.setGameTime(300, true)
	end
end

function eventPlayerWon(p, t)
	player[p].map = player[p].map + 1
	tfm.exec.setPlayerScore(p, 1, true)
	if player[p].map > 5 then
		player[p].map = 50
		if first then
			tfm.exec.chatMessage(string.format(txt.first, p))
			first = false
		else
			tfm.exec.chatMessage(string.format(txt.finish, p))
		end
		if tempo > 60 then
			tfm.exec.setGameTime(tempo-30, false)
		elseif tempo > 30 then
			tfm.exec.setGameTime(30, false)
		end
		tfm.exec.respawnPlayer(p)
		tfm.exec.movePlayer(p, 400 + 1600 * (player[p].map/10), -580, false, 0, 0, false)
		tfm.exec.giveCheese(p)
		ui.addTextArea(50, "<p align='center'>"..txt.view, p, 200, 350, 400, 20, 1, 0xffff00, 0.9, true)
		system.newTimer(function ()
			ui.removeTextArea(50, p)
		end, 5000, false)
		print(t)
	else
		tfm.exec.respawnPlayer(p)
		tfm.exec.movePlayer(p, starts[player[p].map].x, starts[player[p].map].y, false, 0, 0, false)
		tfm.exec.addImage(sombra, "$"..p, -1615, -15, nil)
	end
end

function eventNewPlayer(p)
	if loading then
		ui.removeTextArea(50)
		ui.addTextArea(0, "", p, -1500, -1500, 3800, 3400, 0x6a7495, 0x6a7495, 0.95, true)
		ui.addTextArea(1, "", p, 275, 345, 250, 30, 0x324650, 0x324650, 1, true)
		ui.addTextArea(3, "<p align='center'><font size='30px' color='#222C31'>"..txt.loading, p, 0, 300, 800, 100, 0, 0, 0, true)
	else
		player[p] = {map=1, mort=1}
		tfm.exec.respawnPlayer(p)
		tfm.exec.movePlayer(p, starts[1].x, starts[1].y, false, 0, 0, false)
		tfm.exec.addImage(sombra, "$"..p, -1615, -15, nil)
		tfm.exec.bindKeyboard(p, 37, true, true)
		tfm.exec.bindKeyboard(p, 39, true, true)
	end
end

function eventPlayerLeft(p)
	player[p] = nil
end

function eventPlayerDied(p)
	if not loading and player[p] and player[p].map <= 5 then
		--tfm.exec.respawnPlayer(p)
		--tfm.exec.movePlayer(p, 400 + player[p].map*1600, -580, false, 0, 0, false)
    if not loading and player[p] and starts[player[p].map] then
				tfm.exec.respawnPlayer(p)
				tfm.exec.movePlayer(p, starts[player[p].map].x, starts[player[p].map].y, false, 0, 0, false)
				tfm.exec.addImage(sombra, "$"..p, -1615, -15, nil)
				player[p].timer = false
		end
		player[p].mort = player[p].mort + 1
	elseif not loading and player[p] then
		tfm.exec.respawnPlayer(p)
		tfm.exec.movePlayer(p, 400 + 1600 * (player[p].map/10), -580, false, 0, 0, false)
		tfm.exec.giveCheese(p)
	end
end

function eventChatCommand(p, cmd)
	if cmd == "mort" and not loading and player[p].map <= 5 then
		player[p].map = player[p].map * 10
		tfm.exec.killPlayer(p)
		ui.addTextArea(50, "<p align='center'>"..txt.view, p, 200, 350, 400, 20, 1, 0xffff00, 0.9, true)
		system.newTimer(function ()
			ui.removeTextArea(50, p)
		end, 5000, false)
	elseif cmd == "info" and not loading then
		for i=1, #code do
			tfm.exec.chatMessage(string.format("%d - %s - %s", i, author[i], code[i]), p)
		end
	end
end

function todosMortos()
	for i, v in pairs(player) do
		if v.map <= 5 then
			return false
		end
	end
	return true
end

function eventLoop(current, remaining)
	tempo = math.ceil(remaining/1000)
	if loading and remaining < 0 then
		if cont > 5 then
			loading = false
			print("partida")
			tfm.exec.newGame(string.format([[<C><P Ca="" L="9600" /><Z><S>%s<S H="400" L="1600" o="545879" X="800" c="4" N="" Y="200" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="545879" X="2800" c="4" N="" Y="200" T="12" H="400" /><S X="4400" L="800" o="545879" H="400" c="4" N="" Y="200" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="545879" H="400" c="4" N="" Y="200" T="12" X="6000" /><S L="10" o="324650" X="1175" H="3000" Y="200" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="10" o="324650" H="3000" Y="200" T="12" X="2800" /><S L="10" o="324650" H="3000" X="4400" Y="200" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="10" o="324650" X="6000" Y="200" T="12" H="3000" /><S X="7600" L="800" o="545879" H="400" c="4" N="" Y="200" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="545879" H="400" c="4" N="" Y="200" T="12" X="9200" /><S L="10" o="324650" X="7600" H="3000" Y="200" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="10" o="324650" H="3000" Y="200" T="12" X="9200" /><S L="10" X="2000" H="10" Y="-590" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" H="10" X="2000" Y="-570" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" H="10" X="2000" Y="-550" T="1" P="0,0,0,0.2,45,0,0,0" /><S L="10" H="10" X="3600" Y="-590" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" H="10" X="5200" Y="-590" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" H="10" X="6800" Y="-590" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" H="10" X="8400" Y="-590" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" X="8400" H="10" Y="-570" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" X="8400" H="10" Y="-555" T="1" P="0,0,0,0.2,45,0,0,0" /><S L="10" X="6800" H="10" Y="-570" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" X="6800" H="10" Y="-550" T="1" P="0,0,0,0.2,45,0,0,0" /><S L="10" X="5200" H="10" Y="-570" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" X="5200" H="10" Y="-550" T="1" P="0,0,0,0.2,45,0,0,0" /><S L="10" X="3600" H="10" Y="-570" T="4" P="0,0,9999,0.2,0,0,0,0" /><S L="10" X="3600" H="10" Y="-550" T="1" P="0,0,0,0.2,45,0,0,0" /></S><D>%s</D><O /></Z></C>]], silhueta..grounds, decorations))
			else
			print("continua")
			tfm.exec.newGame("#17")
		end
	elseif not loading and (todosMortos() or remaining < 0) then
		for i=1, #starts do
			table.remove(starts)
		end
		for i=1, #code do
			table.remove(code)
		end
		for i=1, #author do
			table.remove(author)
		end
		for i, v in pairs(player) do
			if v.timer then
				system.removeTimer(v.timer)
			end
		end
		grounds = ""
		decorations = ""
		silhueta = ""
		loading = true
		cont = 1
		print("carrega de novo")
		tfm.exec.chatMessage(txt.timeUp)
		ui.addTextArea(0, "", nil, -1500, -1500, 3800, 3400, 0x6a7495, 0x6a7495, 0.95, true)
		ui.addTextArea(1, "", nil, 275, 345, 250, 30, 0x324650, 0x324650, 1, true)
		ui.addTextArea(3, "<p align='center'><font size='30px' color='#222C31'>"..txt.loading, nil, 0, 300, 800, 100, 0, 0, 0, true)
		--img =tfm.exec.addImage("LOKpKjb.png", "&10000", -400, -200, nil)
		tfm.exec.newGame("#17")
	elseif not loading and remaining < 30000 then
		--ui.addTextArea(0, "", nil, 0, 0, 800, 400, 0xff0000, 0xff0000, 0.1, true)
		if pisca then
			--ui.addTextArea(1, "", nil, 0, 0, 800, 20, 0xff0000, 0xff0000, 1, true)
			ui.addTextArea(0, "", nil, 0, 0, 800, 400, 0xff0000, 0xff0000, 0.1, true)
		else
			--ui.removeTextArea(1)
			ui.removeTextArea(0)
		end
		pisca = not pisca
	end
end

ui.addTextArea(0, "", nil, -1500, -1500, 3800, 3400, 0x6a7495, 0x6a7495, 0.95, true)
ui.addTextArea(1, "", nil, 275, 345, 250, 30, 0x324650, 0x324650, 1, true)
ui.addTextArea(3, "<p align='center'><font size='30px' color='#222C31'>"..txt.loading, nil, 0, 300, 800, 100, 0, 0, 0, true)
--img = tfm.exec.addImage("LOKpKjb.png", "&10000", -400, -200, nil)
tfm.exec.newGame("#17")