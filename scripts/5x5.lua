-- 5x5 (cinco por cinco)
-- Escrito por Ninguem -- 07/02/2016

adm = "Ninguem#0095" -- ponha seu nickname aqui para poder usar o comando !new
-- comando !new = inicia uma nova partida

mapa = [[<C><P Ca="" D="x_transformice/x_maps/x_rentree2015/map-classe.jpg" /><Z><S><S H="300" L="10" o="2f1b14" X="150" c="4" Y="185" T="12" lua="0" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="2f1b14" X="650" c="4" Y="185" T="12" H="300" /><S P="0,0,0.3,0.2,0,0,0,0" L="599" o="2f1b14" X="408" c="4" Y="300" T="12" H="10" /><S H="10" L="599" o="2f1b14" X="421" c="4" Y="40" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S H="400" L="150" o="e3d493" X="75" c="4" Y="219" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="150" o="e3d493" X="725" c="4" Y="199" T="12" H="400" /><S H="80" L="849" o="e3d493" X="400" c="4" Y="340" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="100" X="50" H="40" Y="400" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="300" H="40" X="250" Y="400" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="150" X="475" H="40" Y="400" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="50" H="40" X="575" Y="400" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="200" X="700" H="40" Y="400" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="150" H="40" X="122" Y="410" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="300" X="417" H="40" Y="410" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="100" H="40" X="722" Y="410" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="849" o="e3d493" X="401" c="4" Y="-1" T="12" H="80" /><S L="100" H="20" X="70" Y="370" T="4" P="0,0,20,0.2,0,0,0,0" /><S L="100" X="730" H="20" Y="370" T="4" P="0,0,20,0.2,0,0,0,0" /></S><D><P P="1,0" C="fdfdfd" Y="440" T="90" X="400" /><P C="fdfdfd" Y="440" T="90" X="605" P="1,0" /><P C="fdfdfd" Y="440" T="90" P="1,0" X="810" /><P C="fdfdfd" Y="440" T="90" X="195" P="1,0" /><P C="fdfdfd" Y="440" T="90" P="1,0" X="-10" /></D><O /></Z></C>]]
mapa = "@6517613"
jogador = {}
nome = {}
modo = "inicio"

function soLetras(txt)
	letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for i=1, #txt do
		if not string.find(letras, txt:sub(i,i)) then
			return false
		end
	end
	return true
end

function temRepetidas(txt)
	local letras = {}
	for i=1, #txt do
		if letras[txt:sub(i,i)] then
			return true
		end
		letras[txt:sub(i,i)] = true
	end
	return false
end

function desenhaLetras(p)
	local alfabeto = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local txt = "<p align='center'><font size='17' face='Comic Sans MS'>"
	for i=1, #alfabeto do
		local l = jogador[nome[p]].letras[alfabeto:sub(i,i)]
		txt = txt.. string.format("<%s><a href='event:%s'>%s</a> ", l == 1 and "j" or l == 2 and "r" or "n", alfabeto:sub(i,i), alfabeto:sub(i,i))
	end
	ui.addTextArea(3, txt, p, 150, 50, 500, nil, 0, 0, 0, false)
end

function desenhaTentativas()
	local txt = "<b><p align='center'><font face='Comic Sans MS' size='15px'>"
	for i, v in pairs(jogador[1].tentativas) do
		txt = txt .. string.format("<n>%s - <j>%d\n", v.palavra, v.letras)
	end
	ui.addTextArea(4, txt, p, 150, 100, 250, 180, 0, 0, 0, false)
	
	txt = "<b><p align='center'><font face='Comic Sans MS' size='15px'>"
	for i, v in pairs(jogador[2].tentativas) do
		txt = txt .. string.format("<n>%s - <j>%d\n", v.palavra, v.letras)
	end
	ui.addTextArea(5, txt, p, 400, 100, 250, 180, 0, 0, 0, false)
	ui.addPopup(1, 2, "Digite uma palavra de 5 letras (dessa vez pode repetir letras)", jogador[1].nome, 200, 300, 400, true)
	ui.addPopup(1, 2, "Digite uma palavra de 5 letras (dessa vez pode repetir letras)", jogador[2].nome, 200, 300, 400, true)
end

function start()
	desenhaLetras(jogador[1].nome)
	desenhaLetras(jogador[2].nome)
	desenhaTentativas()
end

function compara(n)
	local letra = {}
	local cont = 0
	for i=1, #jogador[n].novaTentativa do
		letra[jogador[n].novaTentativa:sub(i,i)] = true
	end
	for i, v in pairs(letra) do
		for j=1, #jogador[n].palavra do
			if i == jogador[n].palavra:sub(j,j) then
				cont = cont + 1
			end
		end
	end
	table.insert(jogador[n].tentativas, 1, {palavra=jogador[n].novaTentativa, letras=cont})
	jogador[n].novaTentativa = false
end

function fimDeJogo(n)
	local m = n == 1 and 2 or 1
	ui.removeTextArea(4)
	ui.removeTextArea(5)
	ui.addTextArea(-1, string.format("<p align='center'><font face='Comic Sans MS' size='30px'>%s ACERTOU <j>%s<n>!\n<font size='20px'>%s ERROU <r>%s", string.upper(jogador[n].nome), jogador[n].palavra, string.upper(jogador[m].nome), jogador[m].palavra), nil, 200, 100, 400, nil, 0, 0, 0, false)
end

function avaliaPalavras()
	if jogador[1].novaTentativa == jogador[1].palavra then
		if jogador[2].novaTentativa == jogador[2].palavra then
			ui.removeTextArea(4)
			ui.removeTextArea(5)
			ui.addTextArea(-1, string.format("<p align='center'><font face='Comic Sans MS' size='30px'>EMPATE\n%s ACERTOU <j>%s<n>!\n%s ACERTOU <j>%s", string.upper(jogador[1].nome), jogador[1].palavra, string.upper(jogador[2].nome), jogador[2].palavra), nil, 200, 100, 400, nil, 0, 0, 0, false)
		else
			fimDeJogo(1)
		end
		return false
	end
	if jogador[2].novaTentativa == jogador[2].palavra then
		fimDeJogo(2)
		return false
	end
	compara(1)
	compara(2)
	desenhaTentativas()
end

function eventNewGame()
	jogador = {}
	nome = {}
	ui.removeTextArea(-1)
	ui.removeTextArea(3)
	ui.addTextArea(1, "<p align='center'><vp>[espaço]", nil, 20, 360, 100, 20, 0, 0, 0, false)
	ui.addTextArea(2, "<p align='center'><vp>[espaço]", nil, 680, 360, 100, 20, 0, 0, 0, false)
	for i, v in pairs(tfm.get.room.playerList) do
		system.bindKeyboard(i, 32, true, true)
	end
end

function eventKeyboard(p, t, d, x, y)
	if modo == "inicio" then
		if x > 20 and x < 120 then
			if not jogador[1] then
				jogador[1] = {nome=p, palavra=false, tentativas={}, novaTentativa=false, letras={}}
				ui.addTextArea(1, "<p align='center'><j>"..p, nil, 20, 360, 100, 20, 0, 0, 0, false)
				nome[p] = 1
				if jogador[2] then
					for i, v in pairs(jogador) do
						ui.addPopup(0, 2, "<p align='center'>Escolha uma palavra de 5 letras com 5 letras diferentes", v.nome, 200, 150, 400, true)
					end
				end
			end
		elseif x > 680 and x < 780 then
			if not jogador[2] then
				jogador[2] = {nome=p, palavra=false, tentativas={}, novaTentativa=false, letras={}}
				ui.addTextArea(2, "<p align='center'><j>"..p, nil, 680, 360, 100, 20, 0, 0, 0, false)
				nome[p] = 2
				if jogador[1] then
					for i, v in pairs(jogador) do
						ui.addPopup(0, 2, "<p align='center'>Escolha uma palavra de 5 letras com 5 letras diferentes", v.nome, 200, 150, 400, true)
					end
				end
			end
		end
	end
end

function eventPopupAnswer(id, p, cmd)
	if id == 0 then -- popup de inicio
		cmd = string.upper(cmd)
		if #cmd == 5 and not temRepetidas(cmd) and soLetras(cmd) then
			jogador[nome[p] == 1 and 2 or 1].palavra = cmd
			if not jogador[1].palavra or not jogador[2].palavra then
				ui.addTextArea(3, "<p align='center'><font face='Comic Sans MS' size='20px'>Aguardando o outro jogador...", p, 200, 150, 400, nil, 0, 0, 0, false)
			else
				start()
			end
		else
			ui.addPopup(0, 2, "<p align='center'>Escolha uma palavra de 5 letras com 5 letras diferentes", p, 200, 150, 400, true)
		end
	elseif id == 1 then -- popup de tentativa
		cmd = string.upper(cmd)
		if #cmd == 5 and soLetras(cmd) then
			jogador[nome[p]].novaTentativa = cmd
			if not jogador[1].novaTentativa or not jogador[2].novaTentativa then
				ui.addTextArea(-1, "<p align='center'><font face='Comic Sans MS' size='14' color='#000000'>Aguardando o outro jogador...", p, 200, 300, 400, nil, 0, 0, 0, false)
			else
				avaliaPalavras()
			end
		else
			ui.addPopup(1, 2, "Digite uma palavra de 5 letras (dessa vez pode repetir letras)", p, 200, 300, 400, true)
		end
	end
end

function eventTextAreaCallback(id, p, cmd)
	if id == 3 then
		if jogador[nome[p]].letras[cmd] == 1 then
			jogador[nome[p]].letras[cmd] = 2
		elseif jogador[nome[p]].letras[cmd] == 2 then
			jogador[nome[p]].letras[cmd] = false
		else
			jogador[nome[p]].letras[cmd] = 1
		end
		desenhaLetras(p)
	end
end

function eventChatCommand(p, cmd)
	if p == adm then
		if cmd == "new" then
			tfm.exec.newGame(mapa)
		end
	end
end

tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.newGame(mapa)