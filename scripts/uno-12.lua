-- UNO
-- Escrito por Ninguem - Data 04/09/2015

-- Instruções
-- -- Digite Ctrl+A e copie isso tudo
-- -- Vá no cafofo e digite /lua
-- -- Cole o código na janela que abriu e depois clique em enviar.
-- -- A janela vai ficar transparente e o jogo vai iniciar, pode fechá-la.
-- -- IMPORTANTE: se sua conta foi banida por hack alguma vez, não poderá colocar

-- Comandos (funciona apenas para o adm, edite o código logo abaixo para se tornar o adm)
-- !start - inicia a partida
-- !new - começa uma nova partida
-- !skip - pula a vez do jogador atual
-- !ban nome - tira um jogador da partida
-- !draw nome quantidade -- faz o jogador comprar cartas, se não for informado a quantidade comprará 1 carta só

-- VARIÁVEIS EDITÁVEIS

adm = "Ninguem#0095" -- ponha seu nick
gameName = "UNO!" -- nome do mapa
numeroCartas = 5 -- numero de cartas ao inicio do jogo
limiteCartas = 30 -- máximo de cartas que pode ter em mãos
configTempo = 8000 -- tempo limite de uma jogada em milissegundos
autoStart = true -- se for true inicia e encerra a partida sozinho sem precisar dar !start e !new, caso queira manual ponha false
tempoStart = 20000 -- tempo até dar !start automático
tempoNew = 20000 -- tempo até dar !new automático

mapa = [[<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="32335b" X="400" c="3" Y="135" T="12" H="40" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="32335b" H="60" N="" Y="370" T="12" X="400" /><S P="0,0,0,0.2,0,0,0,0" L="200" o="6a7495" X="900" c="3" N="" Y="200" T="12" H="3000" /><S H="3000" L="200" o="6a7495" X="-100" c="3" N="" Y="200" T="12" P="0,0,0,0.2,0,0,0,0" /><S H="100" L="800" o="6a7495" X="400" c="4" N="" Y="-41" T="12" P="0,0,0,0.2,0,0,0,0" /></S><D><P C="ffa930" Y="60" T="90" X="606" P="0,0" /><P C="ffa930" Y="60" T="90" P="0,0" X="812" /><P C="ffa930" Y="60" T="90" X="194" P="0,0" /><P C="ffa930" Y="60" T="90" P="0,0" X="-12" /><P C="ffa930" Y="60" T="90" P="0,0" X="400" /><P C="46478c" Y="125" T="34" X="0" P="0,0" /><DS Y="100" X="400" /><P P="0,0" Y="134" T="16" X="430" /><P X="370" Y="134" T="16" P="0,0" /><P X="490" Y="134" T="16" P="0,0" /><P P="0,0" Y="134" T="16" X="550" /><P X="610" Y="134" T="16" P="0,0" /><P P="0,0" Y="134" T="16" X="670" /><P X="730" Y="134" T="16" P="0,0" /><P P="0,0" Y="134" T="16" X="70" /><P X="130" Y="134" T="16" P="0,0" /><P P="0,0" Y="134" T="16" X="190" /><P X="250" Y="134" T="16" P="0,0" /><P P="0,0" Y="134" T="16" X="310" /></D><O /></Z></C>]]

-- cores das cartas
-- vermelho, azul, amarelo, verde, preto
corInt = {0xFF3232, 0x5365CC, 0xFFD800, 0x73D33B, 1} -- usado para colorir fundos
corStr = {"FF3232", "5365CC", "FFD800", "73D33B", "000000"} -- usado para colorir textos

-- cores de outros elementos
corUno = {corInt[5], 0xffffff, corInt[1], corStr[3]} -- cor do baralho: fundo, borda, tarja, texto
corCarta = {0xffffff, "FFFFFF"} -- detalhes das cartas: borda, símbolo
corVez = {-1, 0xffffff} -- ponteiro da vez: fundo, borda
corFluxo = "32335B" -- cor das setas da mesa
corTimer = corStr[3] -- cor do timer

-- símnolos das cartas
n0 = "0"
n1 = "1"
n2 = "2"
n3 = "3"
n4 = "4"
n5 = "5"
n6 = "6"
n7 = "7"
n8 = "8"
n9 = "9"
rev=">" -- reverter
skip="X" -- pular vez
d2="+2" -- comprar 2
d4="+4" -- comprar 4
wild="*" -- coringa

-- baralho com 108 cartas
cartas = { -- {cor,valor}
	{1,n0},{1,n1},{1,n1},{1,n2},{1,n2},{1,n3},{1,n3},{1,n4},{1,n4},{1,n5},{1,n5},{1,n6},{1,n6},{1,n7},{1,n7},{1,n8},{1,n8},{1,n9},{1,n9},{1,rev},{1,rev},{1,skip},{1,skip},{1,d2},{1,d2},
	{2,n0},{2,n1},{2,n1},{2,n2},{2,n2},{2,n3},{2,n3},{2,n4},{2,n4},{2,n5},{2,n5},{2,n6},{2,n6},{2,n7},{2,n7},{2,n8},{2,n8},{2,n9},{2,n9},{2,rev},{2,rev},{2,skip},{2,skip},{2,d2},{2,d2},
	{3,n0},{3,n1},{3,n1},{3,n2},{3,n2},{3,n3},{3,n3},{3,n4},{3,n4},{3,n5},{3,n5},{3,n6},{3,n6},{3,n7},{3,n7},{3,n8},{3,n8},{3,n9},{3,n9},{3,rev},{3,rev},{3,skip},{3,skip},{3,d2},{3,d2},
	{4,n0},{4,n1},{4,n1},{4,n2},{4,n2},{4,n3},{4,n3},{4,n4},{4,n4},{4,n5},{4,n5},{4,n6},{4,n6},{4,n7},{4,n7},{4,n8},{4,n8},{4,n9},{4,n9},{4,rev},{4,rev},{4,skip},{4,skip},{4,d2},{4,d2},
	{5,wild},{5,wild},{5,wild},{5,wild},{5,d4},{5,d4},{5,d4},{5,d4},
}

-- TEXTOS

txtDraw = "Jogue um %s ou compre %d cartas."
txtSit = "Vá até uma cadeira e aperte espaço para pegar seu lugar!"
txtGameOver = "%s venceu o jogo!"
txtPass = "Passar a vez"
txtWarn = "Volte para sua cadeira!"
txtChoose = "Escolha uma cor"
txtRed = "VERMELHO"
txtBlue = "AZUL"
txtYellow = "AMARELO"
txtGreen = "VERDE"
txtUno = "UNO!"
txtFlawless = "Flawless victory. Terminou sem comprar nenhuma carta."
txtVirada = "De virada. Foi de %d a 0 cartas."
txtDefesa2 = "Bloqueando +2"
txtDefesa4 = "Bloqueando +4"
txtDemorado = "Uma partida que levou %d minutos."
txtCoringa = "Com coringa."
txtConsecutivo = "%s vitórias consecutivas."
txtMencao = "Menção honrosa"
txtNaoJogou = "%s, que não teve chances de jogar."
txtAcumulador = "%s, que ficou com %d cartas na mão."
txt16 = "%s, que comprou 16 cartas de uma vez."

-- VARIÁVEIS DE JOGO

comandos = {"ban", "kick", "new", "start"}
baralho = {}
pilha = {}
jogador = {}
nome = {}
timerTxt = {}
modo = "inicio"
duelo = false
atual = nil
vez = false
sel = true
draw = false
acumulo = 0
acumulo4 = 0
fluxo = 1
tempoJogada = os.time() + tempoStart
tempoInicio = os.time()
consecutivas = {nome="", qtd=0}

tempo = os.time()+1000

-- FUNÇÕES AUXILIARES -- podem funcionar em outros scripts

function split(t,s) -- retorna uma table com a string dividida
	local a={}
	for i,v in string.gmatch(t,string.format("[^%s]+",s or "%s")) do
		table.insert(a,i)
	end
	return a
end

function arrumaNick(p) -- retorna o nick com o formato padrão (inicial maiúscula e restante minúsculo)
  local n = p:sub(1,1) == "+" and 2 or 1
	return p:sub(1,1) == "*" and p or p:sub(1,n):upper() .. p:sub(n+1):lower()
end

function embaralhar(b) -- embaralha uma table recebida
	local novo = {}
	local rand = {}
	for i=1, #b do
		rand[i] = i
	end
	for i=1, #b do
		local r = math.random(#rand)
		table.insert(novo, b[rand[r]])
		table.remove(rand, r)
	end
	return novo
end

function efeitoExplosao(id, x, y, vezes, vel) -- faz uma mini explosão de partículas
	for i=1, vezes do
		tfm.exec.displayParticle(id, x, y, math.random(-vel,vel)/10, math.random(-vel,vel)/10, 0, 0)
	end
end

function apagaText() -- procura textos pra apagar, requer uma table global timerTxt, preenchida com {id=idDaTextArea, p=JogadorAlvo, time=TempoDeDuracao}
	local apagar={}
	for i,v in pairs(timerTxt) do
		if v.time<os.time() then
			table.insert(apagar,i)
			ui.removeTextArea(v.id, v.p)
		end
	end
	for i=1,#apagar do
		timerTxt[apagar[i]]=nil
	end
end

function timerText(i, t, pp) -- auxilia no preenchimento da tabela timerTxt
	table.insert(timerTxt, {id=i, time=os.time()+t, p=pp})
end

-- FUNÇÕES DO SCRIPT

function novoJogo()
	for i=1, 50 do
		ui.removeTextArea(i)
	end
	for i=1, 12 do
		if jogador[i] then
			nome[jogador[i].nome] = nil
			jogador[i] = nil
		end
	end
	ui.removeTextArea(100)
	ui.removeTextArea(2000)
	modo = "inicio"
	tfm.exec.newGame(mapa)
end

function desenhaCarta(i, c, p, x, y)
	ui.addTextArea(i, string.format("\n<p align='center'><font size='23px' color='#%s'>%s", corCarta[2],c[2]), p, x, y, 40, 60, corInt[c[1]], corCarta[1], 1,false)
end

function desenhaBaralho(p)
	ui.addTextArea(401, "", p, 330, 200, 40, 60, corUno[1], corUno[2], 1,false)
	ui.addTextArea(402, "<p align='center'><font size='12px' color='#"..corUno[4].."'>UNO", p, 333, 223, 34, 16, corUno[3], corUno[3], 1,false)
end

function atualizaScore(n, p)
	ui.addTextArea(n, "<p align='center'><font size='8px'>"..jogador[n].nome.."\n<font size='20px'><j>"..(#jogador[n].mao~=1 and #jogador[n].mao or txtUno), p, (n-1)*60+40-20, 115, 100, 60, 0, 0, 0, false)
end

function atualizaMao(p)
	for i=20, 50 do
		ui.removeTextArea(i, p)
	end
	for i, v in pairs(jogador[nome[p]].mao) do
		desenhaCarta(i+20, v, p, 400-(#jogador[nome[p]].mao*25)+50*(i-1), 330)
	end
end

function atualizaFluxo(p)
	defFluxo = {
		"&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;",
		"&lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt; &lt;"
	}
	ui.addTextArea(14, string.format("<p align='center'><font size='20px' color='#"..corFluxo.."'><b>%s", defFluxo[fluxo]), p, 0, 160, 800, 120, 0, 0, 0, false)
end

function atualizaPonteiro(p)
	ui.addTextArea(13, "", p, (vez-1)*60+40, 30, 60, 120, corVez[1], corVez[2], 1, false)
end

function atualizaTimer()
	tempoJogada = os.time() + configTempo
end

function criaJogador(p, n)
	jogador[n] = {nome=p, mao={}, jogadas=0, maiorCompra=0, maximoCartas=numeroCartas,timer=os.time()+2000}
	atualizaScore(n)
	ui.removeTextArea(0, p)
	nome[p] = n
end

function removeJogadorUI(p, n)
	ui.removeTextArea(n)
	jogador[n] = nil
	nome[p] = nil
end

function removeJogador(p, n)
	if n == vez then
		autoPlay()
	end
	for i=1, #jogador[n].mao do
		ui.removeTextArea(i+20, p)
		table.insert(pilha, table.remove(jogador[n].mao))
	end
	removeJogadorUI(p, n)
end

function ordenar(b)
	table.sort(b, function(a, b)
		p = {[n0]=0,[n1]=1,[n2]=2,[n3]=3,[n4]=4,[n5]=5,[n6]=6,[n7]=7,[n8]=8,[n9]=9,[rev]=10,[skip]=11,[d2]=12,[wild]=13,[d4]=14,}
		if a[1] ~= b[1] then
			return a[1] < b[1]
		else
			return p[a[2]] < p[b[2]]
		end
	end)
end

function comprarCartas(p, qtd)
	ui.addTextArea(70+nome[p], "<p align='center'><font size='20px'><bv><b>+"..qtd, nil, (nome[p]-1)*60+40, 145, 60, 60, 0, 0, 0, false)
	timerText(70+nome[p], 2000)
	draw = true
	for i=1, qtd do
		if #baralho == 0 then
			baralho = embaralhar(pilha)
			pilha = {}
		end
		if #jogador[nome[p]].mao < limiteCartas then
			table.insert(jogador[nome[p]].mao, table.remove(baralho))
		end
	end
	ordenar(jogador[nome[p]].mao)
	atualizaMao(p)
	atualizaScore(nome[p])
	if qtd > jogador[nome[p]].maiorCompra and qtd ~= numeroCartas then
		jogador[nome[p]].maiorCompra = qtd
	end
	if #jogador[nome[p]].mao > jogador[nome[p]].maximoCartas then
		jogador[nome[p]].maximoCartas = #jogador[nome[p]].mao
	end
end

function pegaAnterior()
	local n = vez
	repeat
		n = fluxo == 1 and (n == 1 and 12 or n - 1) or (n == 12 and 1 or n + 1)
	until jogador[n]
	return n
end

function pegaProximo()
	local n = vez
	repeat
		n = fluxo == 1 and (n == 12 and 1 or n + 1) or (n == 1 and 12 or n - 1)
	until jogador[n]
	return n
end

function passarVez()
	vez = pegaProximo()
	draw = false
	atualizaPonteiro()
	atualizaTimer()
	ui.removeTextArea(15)
	ui.removeTextArea(16)
	ui.removeTextArea(17)
end

function estaNoLugar(p)
	local x = tfm.get.room.playerList[p].x
	return nome[p] and x > (nome[p]-1)*60+40 and x < (nome[p]-1)*60+100
end

function usaDraw4()
	acumulo4 = acumulo4 + 4
	ui.addTextArea(16, string.format("<p align='center'>"..txtDraw, d4, acumulo4), jogador[vez].nome, 250, 290, 300, 20, 1, 1, 0.4, true)
end

function autoPlay()
	local p = jogador[vez].nome
	n = acumulo > 0 and acumulo or acumulo4 > 0 and acumulo4 or 1
	acumulo = 0
	acumulo4 = 0
	if not draw then
		comprarCartas(p, n)
	end
	passarVez()
	if atual[1] == 5 then
		mudaCor()
		sel = true
		if atual[2] == d4 then
			usaDraw4()
		end
	end
end

function mudaCor(n)
	atual[1] = n or math.random(1,4)
	desenhaCarta(10, atual, nil, 420, 200)
	local b = {21, 23, 24, 22}
	efeitoExplosao(b[atual[1]], 445, 230, 30, 20)
end

function usaSkip()
	efeitoExplosao(35, pegaProximo()*60-50+70, 100, 50, 10)
	passarVez()
	passarVez()
end

function usaReverse()
	fluxo = fluxo == 1 and 2 or 1
	atualizaFluxo()
	for i=20, 780, 10 do
		tfm.exec.displayParticle(3, i, 177, 0, 0, 0, 0)
	end
end

function motivoVitoria(p)
	if consecutivas.nome == p then
		consecutivas.qtd = consecutivas.qtd + 1
	else
		consecutivas.qtd = 1
		consecutivas.nome = p
	end
	local maior = 0
	local nomeMaior = ""
	for i, v in pairs(jogador) do
		if v.maximoCartas > 0 then
			maior = v.maximoCartas
			nomeMaior = v.nome
		end
	end
	if jogador[nome[p]].maiorCompra == 0 then
		return txtFlawless
	elseif acumulo > 0 and atual[2] == d2 then
		return txtDefesa2
	elseif acumulo4 > 0 and atual[2] == d4 then
		return txtDefesa4
	elseif atual[1] == 5 then
		return txtCoringa
	elseif consecutivas.qtd > 1 then
		return string.format(txtConsecutivo, consecutivas.qtd)
	elseif os.time() - tempoInicio > 600000 then
		return string.format(txtDemorado, math.floor((os.time() - tempoInicio)/60000))
	elseif nomeMaior == p and maior > numeroCartas then
		return string.format(txtVirada, maior)
	else
		return ""
	end
end

function mencaoHonrosa(p)
	local mencao = {}
	local maior = 0
	local nomeMaior = ""
	for i, v in pairs(jogador) do
		if v.maximoCartas > 0 then
			maior = v.maximoCartas
			nomeMaior = v.nome
		end
		if v.jogadas == 0 then
			table.insert(mencao, string.format(txtNaoJogou, v.nome))
		end
		if v.maiorCompra == 16 then
			table.insert(mencao, string.format(txt16, v.nome))
		end
	end
	if nomeMaior ~= p and maior >= 20 then
		print(nomeMaior)
		table.insert(mencao, string.format(txtAcumulador, nomeMaior, maior))
	end
	if #mencao > 0 then
		return string.format("<vp>%s\n<n>%s", txtMencao, table.concat(mencao, "\n"))
	else
		return ""
	end
end

-- EVENTOS

function eventNewGame()
	tempo = os.time()+1000
	tfm.exec.setUIMapName(gameName)
	ui.addTextArea(0, "<font size='25px'><p align='center'>"..txtSit, nil, 0, 180, 800, 200, 0, 0, 0, false)
	for i, v in pairs(tfm.get.room.playerList) do
		tfm.exec.bindKeyboard(i, 32, true, true)
		system.bindMouse(i, true)
	end
end

function eventTextAreaCallback(id, p, cmd)
	if id == 15 and nome[p] == vez then
		mudaCor(tonumber(cmd))
		passarVez()
		sel = true
		if atual[2] == d4 then
			acumulo4 = acumulo4 + 4
			ui.addTextArea(16, string.format("<p align='center'>"..txtDraw, d4, acumulo4), jogador[vez].nome, 250, 290, 300, 20, 1, 1, 0.4, true)
		end
		jogador[nome[p]].jogadas = jogador[nome[p]].jogadas + 1
	elseif cmd == "skip" and nome[p] == vez then
		passarVez()
		jogador[nome[p]].jogadas = jogador[nome[p]].jogadas + 1
	end
end

function eventMouse(p, x, y)
	if modo == "start" then
		local xx =  tfm.get.room.playerList[p].x
		if jogador[nome[p]] and y > 325 and y < 400 and estaNoLugar(p) then
			local carta = math.ceil((x+5 - (400 - (#jogador[nome[p]].mao*25)))/50)
			local mao = jogador[nome[p]].mao
			if vez == nome[p] and sel then
				if mao[carta] and (acumulo == 0 or mao[carta][2] == d2) and (acumulo4 == 0 or mao[carta][2] == d4) and (mao[carta][1] == atual[1] or mao[carta][2] == atual[2] or mao[carta][2] == wild or mao[carta][2] == d4) then
					if atual[2] == d4 or atual[2] == wild then
						atual[1] = 5
					else
						jogador[nome[p]].jogadas = jogador[nome[p]].jogadas + 1
					end
					table.insert(pilha, atual)
					atual = table.remove(mao, carta)
					atualizaMao(p)
					desenhaCarta(10000, atual, nil, 420, 200)
					atualizaScore(nome[p])
					if #jogador[nome[p]].mao == 0 then
						local txt = motivoVitoria(p)
						txt = txt .. "\n\n" .. mencaoHonrosa(p)
						ui.addTextArea(13, "", nil, 5, 5, 790, 400, 1, 1, 0.5, false)
						ui.addTextArea(14, string.format("<p align='center'><font size='40px' color='#ffffff'>"..txtGameOver, p).."<font size='20px' color='#FFD800'>\n<b>"..txt, nil, 0, 170, 800, 400, 0, 0, 0, false)
						tfm.exec.setPlayerScore(p, 1, true)
						tempoJogada = os.time() + tempoNew
						modo = "fim"
					else
						if atual[2] == wild or atual[2] == d4 then
							sel = false
							draw = true
							ui.addTextArea(15, string.format("<p align='center'>%s\n<a href='event:1'><font color='#FF3232'>%s</font></a> - <a href='event:2'><font color='#5365CC'>%s</font></a> - <a href='event:3'><font color='#FFD800'>%s</font></a> - <a href='event:4'><font color='#73D33B'>%s</font></a>", txtChoose, txtRed, txtBlue, txtYellow, txtGreen), p, 250, 285, 300, 35, 1, 1, 0.7, true)
						else
							if atual[2] == skip then
								usaSkip()
							elseif atual[2] == rev then
								if duelo then
									usaSkip()
								else
									usaReverse()
									passarVez()
								end
							elseif atual[2] == d2 then
								acumulo = acumulo + 2
								passarVez()
								ui.addTextArea(16, string.format("<p align='center'>"..txtDraw, d2, acumulo), jogador[vez].nome, 250, 290, 300, 20, 1, 1, 0.4, true)
							else
								passarVez()
							end
						end
					end
					for i=1, 10 do
						tfm.exec.displayParticle(3, 445, 230, math.random(-20,20)/10, math.random(-20,20)/10, 0, 0)
					end
				end
			elseif os.time() > jogador[nome[p]].timer and mao[carta] then
				desenhaCarta(nome[p]+20000, mao[carta], nil, (nome[p]-1)*60+45, 30)
				timerText(nome[p]+20000, 1000)
				jogador[nome[p]].timer = os.time()+2000
			end
		elseif x > 325 and x < 375 and y > 195 and y < 245 and not draw and vez == nome[p] and sel then
			if acumulo > 0 or acumulo4 > 0 then
				comprarCartas(p, acumulo > 0 and acumulo or acumulo4)
				acumulo = 0
				acumulo4 = 0
				passarVez()
			else
				comprarCartas(p, 1)
				ui.addTextArea(16, "<p align='center'><a href='event:skip'>"..txtPass, p, 250, 290, 300, 20, 1, 1, 0.7, true)
				draw = true
			end
		end
	end
end

function eventChatCommand(p, cmd)
	local arg = split(cmd, " ")
	if p == adm then
		if arg[1] == "start" and modo == "inicio" then
			atualizaTimer()
			local r = {}
			local numJogadores = 0
			modo = "start"
			tempoInicio = os.time()
			sel = true
			fluxo = 1
			draw = false
			atual = nil
			baralho = embaralhar(cartas)
			pilha = {}
			ui.removeTextArea(0)
			for i, v in pairs(jogador) do
				comprarCartas(v.nome, numeroCartas)
				table.insert(r, i)
				numJogadores = numJogadores + 1
			end
			if numJogadores == 0 then
				eventChatCommand(adm, "new")
				return false
			end
			duelo = #r == 2
			repeat
				table.insert(pilha, atual)
				atual = table.remove(baralho)
			until atual[2] ~= d4 and atual[2] ~= wild and atual[2] ~= d2 and atual[2] ~= skip and atual[2] ~= rev
			desenhaCarta(10000, atual, nil, 420, 200)
			desenhaBaralho()
			vez = r[math.random(#r)]
			atualizaPonteiro()
			atualizaFluxo()
		elseif arg[1] == "new" then
			novoJogo()
		elseif arg[1] == "skip" and modo == "start" then
			autoPlay()
		elseif arg[1] == "ban" and arg[2] and nome[arrumaNick(arg[2])] then
			eventPlayerLeft(arrumaNick(arg[2]))
		end
	end
end

function eventKeyboard(p, t, d, x, y)
	if modo == "inicio" and os.time() > tempo and not nome[p] then
		if x > 55 and x < 85 and not jogador[1] then
			criaJogador(p, 1)
		elseif x > 115 and x < 145 and not jogador[2] then
			criaJogador(p, 2)
		elseif x > 175 and x < 205 and not jogador[3] then
			criaJogador(p, 3)
		elseif x > 235 and x < 265 and not jogador[4] then
			criaJogador(p, 4)
		elseif x > 295 and x < 325 and not jogador[5] then
			criaJogador(p, 5)
		elseif x > 355 and x < 385 and not jogador[6] then
			criaJogador(p, 6)
		elseif x > 415 and x < 445 and not jogador[7] then
			criaJogador(p, 7)
    elseif x > 475 and x < 505 and not jogador[8] then
			criaJogador(p, 8)
    elseif x > 535 and x < 565 and not jogador[9] then
			criaJogador(p, 9)
    elseif x > 595 and x < 625 and not jogador[10] then
			criaJogador(p, 10)
    elseif x > 655 and x < 685 and not jogador[11] then
			criaJogador(p, 11)
    elseif x > 715 and x < 745 and not jogador[12] then
			criaJogador(p, 12)
		end
	end
end

function eventLoop()
	math.randomseed(os.time())
	for i, v in pairs(jogador) do
		if not estaNoLugar(v.nome) then
			ui.addTextArea(100, "<font size='50px' color='#ffffff'><p align='center'>"..txtWarn, v.nome, 5, 325, 790, 80, 0xff0000, 0xff0000, 1, true)
		else
			ui.removeTextArea(100, v.nome)
		end
	end
	if modo == "fim" then
		local b = {0, 1, 2, 4, 9, 11, 13}
		local x, y, id = math.random(800), math.random(400), b[math.random(#b)]
		for i=1, 40 do
			tfm.exec.displayParticle(id, x, y, math.random(-20,20)/10, math.random(-20,20)/10, 0, 0)
		end
		if os.time() > tempoJogada and autoStart then
			tempoJogada = os.time() + tempoStart
			eventChatCommand(adm, "new")
		end
	end
	if modo == "start" then
		if os.time() > tempoJogada then
			jogador[vez].jogadas = jogador[vez].jogadas + 1
			autoPlay()
		elseif tempoJogada - os.time() < 10000 then
			ui.addTextArea(17, "<p align='center'><font size='25px' color='#"..corTimer.."'>"..math.ceil((tempoJogada - os.time())/1000), nil, 350, 210, 90, 100, 0, 0, 0, false)
		else
			ui.removeTextArea(17)
		end
	elseif modo == "inicio" then
		if os.time() > tempoJogada and autoStart then
			atualizaTimer()
			eventChatCommand(adm, "start")
		end
	end
	apagaText()
end

function eventNewPlayer(p)
	if modo == "inicio" then
		ui.addTextArea(0, "<font size='25px'><p align='center'>"..txtSit, p, 0, 180, 800, 200, 0, 0, 0, false)
		tfm.exec.bindKeyboard(p, 32, true, true)
		system.bindMouse(p, true)
	elseif modo == "start" then
		desenhaCarta(10, atual, p, 420, 200)
		desenhaBaralho(p)
		atualizaPonteiro(p)
		atualizaFluxo(p)
	end
	for i, v in pairs(jogador) do
		atualizaScore(i, p)
	end
	tfm.exec.respawnPlayer(p)
	tfm.exec.setUIMapName(gameName)
end

function eventPlayerLeft(p)
	if modo == "inicio" then
		if nome[p] then
			removeJogadorUI(p, nome[p])
		end
	elseif modo == "start" then
		if nome[p] and jogador[nome[p]] then
			removeJogador(p, nome[p])
		end
	end
end

function eventPlayerDied(p)
	tfm.exec.respawnPlayer(p)
end

-- INICIO

tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAfkDeath(true)
for i, v in pairs(comandos) do
	system.disableChatCommandDisplay(v, true)
end
for i, v in pairs(tfm.get.room.playerList) do
	tfm.exec.setPlayerScore(i, 0, false)
end
tfm.exec.newGame(mapa)

--system.newTimer(function()
--	tfm.exec.chatMessage("<j>Quer jogar uno no seu cafofo? Pegue o código dele em http://pastebin.com/raw.php?i=Cqbd3MeN")
--end, 300000, true)