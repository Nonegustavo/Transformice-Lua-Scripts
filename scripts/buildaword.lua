----------------------------------------
-- Build a Word - Escrito por Ninguem --
----------------------------------------


_mapa = [[<C><P mgoc="-1" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="%s" X="400" c="4" Y="200" T="12" H="400" /><S L="800" X="400" H="50" Y="380" T="6" P="0,0,0.3,0.2,0,0,0,0" /></S><D><DC Y="338" X="696" /><DS Y="340" X="108" /><P P="1,0" C="fdfdfd" Y="85" T="90" X="692" /></D><O /></Z></C>]]
_cores = {"B9B9B9", "E87676", "E8DE76", "87E876", "76B0E8", "AF76E8", "E876E3", "E8B376"}
_palavras = {"CASA", "CARRO", "BANANA", "CAIXA", "VENTILADOR", "MOUSE", "DINHEIRO", "CORPO", "PAREDE", "BOTA", "MEIA", "TOMADA", "CARTA", "MESA", "CADEIRA", "RUA", "ARVORE", "QUADRADO", "CIRCULO", "ESPELHO", "CAMA", "ARMARIO", "ROUPA", "PORTA", "JANELA",
"DADO", "ESCADA", "FACA" , "JANELA" , "OCULOS" , "PENTE" , "XICARA" , "TECLADO" , "TESOURA" , "ESCOVA" , "GELADEIRA", "MONITOR", "FOGAO", "SACOLA", "BALAO", "GARRAFA", "CELULAR", "COPO", "ESPADA", "COLHER", "ROSA", "PREDIO", "AVIAO", "FOGUETE", "SOL", "LUA", "BURACO", "VULCAO", "ESTRELA", "PLANETA", "GATO", "CACHORRO", "PEIXE", "JARRA", "AGUA", "PANELA", "LAPIS", "ONIBUS", "RATO", "FOGO", "LIVRO", "TELEVISAO", "FIO", "RELOGIO", "QUEIJO", "PAPEL", "FAMILIA", "BONE", "CHAPEU", "SAPATO", "CACHIMBO", "ORELHA", "BOCA", "DENTE", "NARIZ", "VESTIDO", "BOLSA", "ARANHA", "SOFA", "CANETA", "CANECA", "BULE", "CHALEIRA", "MUNDO", "PERNA", "LUVA", "CHAVE", "CARIMBO", "DIAMANTE", "RODA", "PNEU", "SAIA", "MONTANHA", "PASSARO", "MORANGO", "ABACAXI", "UVA", "MELANCIA", "BOLO", "BALA", "PISCINA", "BARCO", "NAVIO", "PRAIA", "CAPACETE", "CAFE", "ASPIRADOR", "EXTINTOR", "RIO", "TORNEIRA", "CORTINA", "SORVETE", "PIRULITO", "PICOLE", "GELO", "BATERIA", "MUSICA", "CORDA", "ESCADA", "BACIA", "ABELHA", "FLOR", "CHUVA", "RAQUETE", "DESENHO", "BANDEIRA", "BOMBA", "BICICLETA", "MOTOCICLETA", "PIRAMIDE", "ARCO", "REVOLVER", "TOCA", "ONDA", "XADREZ", "CAVALO", "CAMELO", "RINOCERONTE", "BOIA", "ANZOL", "VARA", "PORCO", "CERCA", "BUMERANGUE", "CD", "FITA", "RAIO", "IMA", "TELA", "GRADE", "CALCULADORA", "COMPUTADOR", "NOTEBOOK", "GALINHA", "MICROFONE", "PIAO", "PIPA", "FLECHA", "INTERNET", "BALEIA", "TUBARAO", "TREM", "HELICOPTERO", "MARTELO", "SERROTE", "MARRETA", "ALICATE", "BANCO", "PLACA", "ESPINHO", "FURACAO", "CARRETA", "ESPONJA", "CHOCOLATE", "OVO", "SAPO", "PINGUIM", "URSO", "PEDRA", "BARRACA", "OLHO", "CARRINHO", "CASACO", "BOTAO", "CUBO", "TRIANGULO", "ESTRADA", "MOINHO", "GUITARRA", "FLAUTA", "PIANO", "BOLHA", "OURO", "PRATA", "TROFEU", "PERFUME", "COMIDA", "REGADOR", "REMEDIO", "CASTELO", "TORRE", "ASA", "TREVO", "FERRADURA", "COELHO", "CENOURA", "MASCARA", "DINOSSAURO", "DRAGAO", "CESTA", "FOLHA", "PENA", "BONECO", "KART", "CAMINHONETE", "OLEO", "PORTO", "PONTE", "PRIVADA", "GOTA", "PILHA", "POSTE", "LUZ", "LANTERNA", "ABAJUR", "FUNIL", "CONE", "SKATE", "PRANCHA", "FAROL", "IGREJA", "BANHEIRA", "LEITE", "GAVETA", "PUDIM", "PALITO", "FOSFORO", "LABIRINTO", "QUADRO", "REGUA", "GAIOLA", "CAMERA", "FANTASMA", "MORCEGO", "VAMPIRO", "CACHECOL", "MOLA", "CIGARRO", "ENVELOPE", "COLAR", "TORTA", "FOGUEIRA", "MACACO", "ESPATULA", "CARANGUEIJO", "NAVE", "VASSOURA", "PISO", "DOMINO", "PIZZA", "PASTEL", "RAMPA", "CACHOEIRA", "MORRO", "FERRAMENTA", "REDE", "ENGRENAGEM", "MOCHILA", "CHAVEIRO", "BLOCO", "PINCEL", "COROA", "REI", "RAINHA", "HOTEL", "CEU", "MACARRAO", "PATINETE", "SABONETE", "AMPULHETA", "MONUMENTO", "ESTATUA", "GALHO", "BOI", "BUSSOLA", "NINHO", "COLA", "NEVE", "MADEIRA", "LAVA", "TRAMPOLIM", "NOTA", "FUNDO", "CARTEIRA", "SUCO", "SUBMARINO", "TORPEDO", "VELA", "CAVEIRA", "VENENO", "JAULA", "PATO", "CORRENTE", "TRONCO", "TORRADA", "CELULA", "PODIO", "MONTE", "MICROONDAS", "BOLICHE", "ESPETO", "COBRA", "MINHOCA", "CARTOLA", "BINGO", "TANQUE", "LIQUIDIFICADOR", "BATEDEIRA", "CHAMINE", "PETECA", "ILHA", "LIXEIRA", "BINOCULO", "MALA", "ANTENA", "ALMOFADA", "METEORO", "MAPA", "FURADEIRA", "CRUZ", "FOICE", "MACHADO", "PICARETA", "BIGODE", "CIDADE", "ABOBORA", "BRUXA", "ZUMBI", "LEQUE", "TERRA", "AREIA", "VENTO", "TORNADO", "FURACAO", "ANJO", "CATAPULTA", "ANCORA", "ANEL", "SORRISO", "DISCO", "COGUMELO", "COFRE", "BASQUETE", "GIRAFA", "BARBA", "LAREIRA", "GUILHOTINA", "LAPIDE", "TUMULO", "CEMITERIO", "TUNEL", "TELHADO", "ARMADILHA", "ASTERISCO"
}
_acertou = {}
_palavraAtual = ""
_score = 10
_pode = false
_dicas = 0
_palavraDica = ""
_acertaram = false
_shaman = ""
_mostraDica = false

function exibeBotaoDica(p)
	if _dicas > 0 then
		ui.addTextArea(1, "<p align='center'><font size='15px'><a href='event:dica'>Dar dica (".._dicas..")", p, 650, 365, 140, nil, 1, 0xffff00, 0.8, false)
	else
		ui.addTextArea(1, "<p align='center'><font size='15px'>Dicas esgotadas", p, 650, 365, 140, nil, 1, 0xff0000, 0.8, false)
	end
end

function eventNewGame()
	ui.setMapName("Build a Word")
	_pode = true
	_mostraDica = false
	_acertaram = false
	_palavraAtual = _palavras[math.random(#_palavras)]
	_dicas = math.ceil(#_palavraAtual/2)
	_palavraDica = string.rep("_", #_palavraAtual)
	_acertou = {}
	_score = 10
	for i, v in pairs(tfm.get.room.playerList) do
		if v.isShaman then
			tfm.exec.chatMessage("Sua palavra é: <rose>".._palavraAtual, i)
			tfm.exec.setPlayerScore(i, 0, false)
			ui.addTextArea(0, "<p align='center'><font size='20px'><b>Sua palavra é: <rose>".._palavraAtual, i, 0, 365, 800, nil, 0, 0, 0, false)
			_shaman = i
		else
			ui.removeTextArea(0, i)
			ui.removeTextArea(1, i)
			tfm.exec.chatMessage("<vp>Adivinhe o que o Shaman irá construir!", i)
		end
	end
end

function preencheDica()
	local pool = {}
	for i=1, #_palavraDica do
		if _palavraDica:sub(i, i) == "_" then
			table.insert(pool, i)
		end
	end
	local rand = pool[math.random(#pool)]
	local novaPalavraDica = ""
	for i=1, #_palavraDica do
		if i == rand then
			novaPalavraDica = novaPalavraDica .. _palavraAtual:sub(i,i)
		else
			novaPalavraDica = novaPalavraDica .. _palavraDica:sub(i,i)
		end
	end
	_palavraDica = novaPalavraDica
end

function divide(str, sep)
	local palavra = str:sub(1,1)
	for i=2, #str do
		palavra = palavra .. sep .. str:sub(i,i)
	end	
	return palavra
end

function eventTextAreaCallback(id, p, cmd)
	print(cmd)
	if cmd == "dica" then
		if _dicas ~= math.ceil(#_palavraAtual/2) and _dicas > 0 then
			preencheDica()
		end
		_dicas = _dicas - 1
		exibeBotaoDica(p)
		ui.addTextArea(0, "<p align='center'><font size='20px'><b>Dica: <j>"..divide(_palavraDica, " "), nil, 150, 365, 500, nil, 0, 0, 0, false)
	elseif cmd == "help" then
		local txt = "O objetivo aqui é adivinhar a palavra que o Shaman está construindo. Para dar uma resposta, basta falar a palavra no chat. Quanto mais respostas certas, mais rápido você será o Shaman.\n\nQuando você for o Shaman, você deve desenhar a palavra dada usando seus objetos de shaman, porém não poderá falar no chat público, ou perderá sua vez."
		ui.addPopup(0, 0, txt, p, 200, 100, 400, true)
	elseif cmd == "suggest" then
		ui.addPopup(0, 0, "Em breve", p, 200, 100, 400, true)
	end
end

function removeAcento(str)
	str = str:gsub("[ÁÀÃÂáàãâ]", "A")
	str = str:gsub("[ÉÈÊéèê]", "E")
	str = str:gsub("[ÌÍÎíìî]", "I")
	str = str:gsub("[ÒÓÕÔóòõô]", "O")
	str = str:gsub("[ÚÙÛúùû]", "U")
	str = str:gsub("[Çç]", "C")
	return str
end

function eventChatMessage(p, msg)
	msg = removeAcento(msg:upper())
	if _pode then
		if tfm.get.room.playerList[p].isShaman and not _acertaram then
			tfm.exec.chatMessage("<r>Round anulado. </r>Era <vp>".._palavraAtual)
			_pode = false
			system.newTimer(function()
				tfm.exec.newGame(string.format(_mapa, _cores[math.random(#_cores)]))
			end, 3000, false)
		elseif not _acertou[p] then
			if msg:upper() == _palavraAtual then
				_acertou[p] = true
				_acertaram = true
				_dicas = 0
				ui.removeTextArea(1)
				tfm.exec.respawnPlayer(p)
				tfm.exec.giveCheese(p)
				tfm.exec.playerVictory(p)
				tfm.exec.chatMessage("<vp>+".._score.." pontos", p)
				ui.addTextArea(0, "<p align='center'><font size='20px'><b>Você acertou <vp>".._palavraAtual, p, 0, 365, 800, nil, 0, 0, 0, false)
				if _score == 10 then
					tfm.exec.setGameTime(20)
				end
				tfm.exec.setPlayerScore(p, _score, true)
				_score = _score <= 1 and 1 or _score-1
			else
				local perto = false
				for i=1, #_palavraAtual - 3 do
					if msg:upper():find(_palavraAtual:sub(i,i+3)) then
						perto = true
					end
				end
				if msg:upper():find(_palavraAtual) then
					perto = true
				end
				if perto then
					tfm.exec.chatMessage("<j>Está perto!", p)
				end
			end
		end
	end
end

function eventLoop(current, remaining)
	if remaining < 0 and _pode then
		tfm.exec.chatMessage("A palavra era: <vp>".._palavraAtual)
		tfm.exec.newGame(string.format(_mapa, _cores[math.random(#_cores)]))
	end
	if not _mostraDica and current > 30000 and not _acertaram then
		_mostraDica = true
		exibeBotaoDica(_shaman)
	end
end

function eventNewPlayer(p)
	ui.addTextArea(10, "<p align='center'><a href='event:help'>Ajuda", p, 5, 20, 50, nil, nil, nil, 1, true)
	ui.addTextArea(11, "<p align='center'><a href='event:suggest'>Sugira uma palavra", p, 65, 20, 150, nil, nil, nil, 1, true)
end

for i, v in pairs(tfm.get.room.playerList) do
	eventNewPlayer(i)
end

tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoScore(true)
tfm.exec.newGame(string.format(_mapa, _cores[math.random(#_cores)]))
tfm.exec.chatMessage(#_palavras.." palavras na lista")
