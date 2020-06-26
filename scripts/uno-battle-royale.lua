ADM = "Ninguem#0095"

HELP = {}

local MAP = "@7579238"

local CONFIG = {
  maxPlayers = 24,
}

local LANG = {
  br = {
    PLAY = "Clique aqui para jogar!",
    PLAYERS = "%/% jogadores",
    PASS = "Passar a vez",
    DRAW = "Comprar carta",
    WINNER = "%s foi o #1!",
    LOST = "Você ficou em #%s",
    WAIT = "Aguarde os outros jogadores",
    SKIPPED = "Você foi pulado!",
    DRAW2 = "Jogue um +2 ou compre %s cartas!",
    DRAW4 = "Jogue um +4 ou compre %s cartas!",
    TIE = "Empate!",
    HELP1 = "Jogue cartas na pilha destacada com o seu nome.",
    HELP2 = "Depois que todos jogarem, os jogadores se movem para próximo espaço no sentido do jogo, como se fosse uma esteira.",
    HELP3 = "Se você ficar com ZERO cartas, todos os adversários comprarão 2 cartas, enquanto você comprará apenas uma.",
    HELP4 = "Quem superar o limite máximo de cartas na mão será eliminado. Vence aquele que for o único sobrevivente. Boa sorte!",
    CLOSE = "Fechar",
    HELP = "Ajuda",
  },
  en = {
    PLAY = "Click here to play!",
    PLAYERS = "%/% players",
    PASS = "Pass turn",
    DRAW = "Draw card",
    WINNER = "%s is #1!",
    LOST = "You get #%s",
    WAIT = "Wait for the other players",
    SKIPPED = "You were skipped!",
    DRAW2 = "Play a +2 or draw %s cards!",
    DRAW4 = "Play a +4 or draw %s cards!",
    TIE = "Tie!",
    HELP1 = "Play cards on the highlighted pile with your name.",
    HELP2 = "After everyone plays, every player will go to the next space, like a treadmill.",
    HELP3 = "If you get ZERO cards, every other player draws 2 cards while you only draw 1.",
    HELP4 = "Whoever exceeds the maximum limit of cards in hand will be eliminated. The sole survivor will be the winner. Good luck!",
    CLOSE = "Close",
    HELP = "Help",
  },
}

TIMER = {
  txt = {},
  img = {},
  obj = {},
  func = {}
}

local ROUND = {}

local SYMBOL = {
  n0 = "<font size='35px'>0",
  n1 = "<font size='35x'>1",
  n2 = "<font size='35px'>2",
  n3 = "<font size='35px'>3",
  n4 = "<font size='35px'>4",
  n5 = "<font size='35px'>5",
  n6 = "<font size='35px'>6",
  n7 = "<font size='35px'>7",
  n8 = "<font size='35px'>8",
  n9 = "<font size='35px'>9",
  draw2 = "<font size='25px'>+2",
  draw4 = "<font size='25px'>+4",
  skip = "<font face='Webdings' size='35px'>&#120;",
  reverse = "<font face='Webdings' size='35px'>&#113;",
  forward = "<font face='Webdings' size='35px'>&#56;",
  pause = "<font face='Webdings' size='35px'>&#59;",
  wild = "<font size='35px'>*",
}

local OFFSET = {
  n0 = -6,
  n1 = -6,
  n2 = -6,
  n3 = -6,
  n4 = -6,
  n5 = -6,
  n6 = -6,
  n7 = -6,
  n8 = -6,
  n9 = -6,
  draw2 = 0,
  draw4 = 0,
  skip = -2,
  reverse = 0,
  wild = 0,
}

local COLOR = {
  red = 0xFF3232,
  blue = 0x5365CC,
  yellow = 0xFFD800,
  green = 0x73D33B,
  black = 0x222222,
}

local POS = {
  [0] = {x=-60, y=95},
  {x=5, y=95},
  {x=70, y=95},
  {x=135, y=95},
  {x=200, y=95},
  {x=265, y=95},
  {x=330, y=95},
  {x=395, y=95},
  {x=460, y=95},
  {x=525, y=95},
  {x=590, y=95},
  {x=655, y=95},
  {x=720, y=95},
  {x=720, y=205},
  {x=655, y=205},
  {x=590, y=205},
  {x=525, y=205},
  {x=460, y=205},
  {x=395, y=205},
  {x=330, y=205},
  {x=265, y=205},
  {x=200, y=205},
  {x=135, y=205},
  {x=70, y=205},
  {x=5, y=205},
  {x=-60, y=205},
}

local DECK = {
  vanilla = {
    -- 108 cartas
    -- 2 cópias de 1 a 9 de cada cor
    -- 2 cópias de draw2 de cada cor
    -- 2 cópias de skip de cada cor
    -- 2 cópias de reverse de cada cor
    -- 1 cópia de 0 de cada cor
    -- 4 cópias de wild
    -- 4 cópias de draw4
    {"red","n0"},
    {"red","n1"},{"red","n2"},{"red","n3"},{"red","n4"},{"red","n5"},{"red","n6"},{"red","n7"},{"red","n8"},{"red","n9"},
    {"red","n1"},{"red","n2"},{"red","n3"},{"red","n4"},{"red","n5"},{"red","n6"},{"red","n7"},{"red","n8"},{"red","n9"},
    {"red","draw2"},{"red","draw2"},{"red","skip"},{"red","skip"},{"red","reverse"},{"red","reverse"},
    {"blue","n0"},
    {"blue","n1"},{"blue","n2"},{"blue","n3"},{"blue","n4"},{"blue","n5"},{"blue","n6"},{"blue","n7"},{"blue","n8"},{"blue","n9"},
    {"blue","n1"},{"blue","n2"},{"blue","n3"},{"blue","n4"},{"blue","n5"},{"blue","n6"},{"blue","n7"},{"blue","n8"},{"blue","n9"},
    {"blue","draw2"},{"blue","draw2"},{"blue","skip"},{"blue","skip"},{"blue","reverse"},{"blue","reverse"},
    {"yellow","n0"},
    {"yellow","n1"},{"yellow","n2"},{"yellow","n3"},{"yellow","n4"},{"yellow","n5"},{"yellow","n6"},{"yellow","n7"},{"yellow","n8"},{"yellow","n9"},
    {"yellow","n1"},{"yellow","n2"},{"yellow","n3"},{"yellow","n4"},{"yellow","n5"},{"yellow","n6"},{"yellow","n7"},{"yellow","n8"},{"yellow","n9"},
    {"yellow","draw2"},{"yellow","draw2"},{"yellow","skip"},{"yellow","skip"},{"yellow","reverse"},{"yellow","reverse"},
    {"green","n0"},
    {"green","n1"},{"green","n2"},{"green","n3"},{"green","n4"},{"green","n5"},{"green","n6"},{"green","n7"},{"green","n8"},{"green","n9"},
    {"green","n1"},{"green","n2"},{"green","n3"},{"green","n4"},{"green","n5"},{"green","n6"},{"green","n7"},{"green","n8"},{"green","n9"},
    {"green","draw2"},{"green","draw2"},{"green","skip"},{"green","skip"},{"green","reverse"},{"green","reverse"},
    {"black","wild"},{"black","wild"},{"black","wild"},{"black","wild"},
    {"black","draw4"},{"black","draw4"},{"black","draw4"},{"black","draw4"}
  },
}

function addImageTimer(u, a, x, y, t, p)
  -- função pronta pra criar imagem e definir seu timer, requer TIMER.img
  -- -- String u: URL da imagem em atelier801.com
  -- -- String a: Alvo da imagem, como em tfm.exec.addImage()
  -- -- Number x: Coordenada x da imagem
  -- -- Number y: Coordenada y da imagem
  -- -- Number t: Tempo de duração da imagem em milissegundos
  -- -- String p: Para quem será exibida a imagem, se NIL será para todos
  -- -- Return: Number (id da imagem para poder ser removida antes do timer)
  local i = tfm.exec.addImage(u, a, x, y, p)
  if i then
    TIMER.img[i] = os.time()+t
  end
  return i
end

function delImagesTimer(tt)
  -- procura imagens pra apagar, requer TIMER.img
  local apagar = {}
  for i, v in pairs(TIMER.img) do
    if tt and tt+10 < os.time() then
      break
    elseif v < os.time() then
      tfm.exec.removeImage(i)
      table.insert(apagar, i)
    end
  end
  for i=1, #apagar do
    TIMER.img[apagar[i]] = nil
  end
end

function addObjectTimer(o, x, y, a, t, vx, vy, g)
  -- função pronta pra criar um objeto e definir seu tempo
  -- -- Number o: id de tipo de objeto
  -- -- Number x: coordenada x de criação
  -- -- Number y: coordenada y de criação
  -- -- Number a: ângulo do objeto
  -- -- Number t: tempo de duração do objeto em milissegundos
  -- -- Number vx: velocidade x do objeto
  -- -- Number vy: velocidade y do objeto
  -- -- Boolean g: true se o objeto é fantasma
  -- -- Return: Number (id do objeto criado para remover manualmente)
  local i = tfm.exec.addShamanObject(o, x, y, a or 0, vx or 0, vy or 0, g)
  TIMER.obj[i] = os.time() + t
  return i
end

function delObjectTimer(tt)
  -- procura objetos pra apagar, requer TIMER.objeto
  local apagar={}
  for i, v in pairs(TIMER.obj) do
    if tt and tt+10 < os.time() then
      break
    elseif v < os.time() then
      tfm.exec.removeObject(i)
      table.insert(apagar, i)
    end
  end
  for i=1, #apagar do
    TIMER.obj[apagar[i]] = nil
  end
end

function addFunctionTimer(f, t, ...)
  -- define uma função e especifica quando deve ser executada
  -- -- Function f: função a ser executada
  -- -- Number t: tempo até ser executado
  -- -- Os próximo valores são parâmetros da função enviada
  table.insert(TIMER.func, {exec=f, time=os.time()+t, arg=table.pack(...)})
end

function execFunctionTimer(tt)
  -- procura por funções para executar
  local apagar={}
  for i, v in pairs(TIMER.func) do
    if tt and tt+10 < os.time() then
      break
    elseif v.time < os.time() then
      v.exec(table.unpack(v.arg or {}))
      table.insert(apagar, i)
    end
  end
  for i=1, #apagar do
    table.remove(TIMER.func, apagar[i])
  end
end

function delTxtTimer(tt)
  -- procura textos pra apagar, requer TIMER.txt
  local apagar = {}
  for i, v in pairs(TIMER.txt) do
    if tt and tt+20 < os.time() then
      break
    elseif v.time < os.time() then
      table.insert(apagar,i)
      ui.removeTextArea(v.id, v.player)
    end
  end
  for i=1, #apagar do
    TIMER.txt[apagar[i]] = nil
  end
end

function nickHashtag(data, doNotNormalize)
  local nickname = data:gmatch('(.-)#[0-9]+$')() or data
  local tag = data:gmatch('#([0-9]+)$')() or '0000'
  nickname = doNotNormalize and nickname or nickname:lower():gsub('%a', string.upper, 1)
  return nickname, tag
end

function nickLength(p)
  local cont = 0
  local tier = {["_"]=3, M=3, m=3, W=3, w=3, i=1, l=1}
  for i=1, #p do
    cont = cont + (tier[p:sub(i,i)] or 2)
  end
  return cont
end

function nickMinifier(p)
  local l = 13
  if nickLength(p) > l then
    local tier = {["_"]=3, M=3, m=3, W=3, w=3, i=1, l=1}
    local cont = 0
    for i=1, #p do
      cont = cont + (tier[p:sub(i,i)] or 2)
      if cont >= l-1 then
        return p:sub(1,i).."."
      end
    end
    return p:sub(1,9).."."
  else
    return p
  end
end

function split(t,s)
  -- retorna uma table com a string dividida
  -- -- String t = texto a ser dividido
  -- -- String s = símbolo de separação (opcional)
	local a={}
	for i,v in string.gmatch(t,string.format("[^%s]+",s or "%s")) do
		table.insert(a,i)
	end
	return a
end

function translate(p, k)
	-- Retorna o texto correspondente à comunidade do jogador fornecido, requer tabela LANG
	-- -- String p = nome de um jogador
	-- -- String k = chave de tradução
	-- -- Return = String
  if p and tfm.get.room.playerList[p] then
    local cmm = tfm.get.room.playerList[p].community
    return LANG[cmm] and LANG[cmm][k] or LANG.en[k] or ("$" .. k)
  else
    return "ERROR!"
  end
end

function shuffleDeck(deck)
  local new = {}
  for i=1, #deck do
    table.insert(new, table.remove(deck, math.random(#deck)))
  end
  return new
end

function showFlow(pass)
  local color = 0
  if pass then
    color = nil
  end
  for i=0, 12 do
    ui.addTextArea(400+i, "<p align='center'><b><font color='#FFD800'>"..(ROUND.flow == "RIGHT" and "&gt;" or "&lt;"), nil, POS[i].x+59, POS[i].y+50, 20, 20, color, color, color)
    if not pass then
      tfm.exec.displayParticle(3, POS[i].x+69, POS[i].y+60)
    end
  end
  for i=13, 25 do
    ui.addTextArea(400+i, "<p align='center'><b><font color='#FFD800'>"..(ROUND.flow == "RIGHT" and "&lt;" or "&gt;"), nil, POS[i].x+59, POS[i].y+50, 20, 20, color, color, color)
    if not pass then
      tfm.exec.displayParticle(3, POS[i].x+69, POS[i].y+60)
    end
  end
end

function showCard(id, card, p, x, y)
  ui.addTextArea(-(id), "", p, x, y, 40, 60, COLOR[card[1]], 0xFFFFFF)
  ui.addTextArea(-(id+100), "\n<p align='center'><font color='#000000'>"..SYMBOL[card[2]], p, x-1, y+OFFSET[card[2]]-1, 40, 60, 0, 0, 0)
  ui.addTextArea(-(id+200), "\n<p align='center'><font color='#000000'>"..SYMBOL[card[2]], p, x-1, y+OFFSET[card[2]]+1, 40, 60, 0, 0, 0)
  ui.addTextArea(-(id+300), "\n<p align='center'><font color='#000000'>"..SYMBOL[card[2]], p, x-2, y+OFFSET[card[2]]+2, 40, 60, 0, 0, 0)
  ui.addTextArea(-(id+400), "\n<p align='center'><font color='#000000'>"..SYMBOL[card[2]], p, x+1, y+OFFSET[card[2]]-1, 40, 60, 0, 0, 0)
  ui.addTextArea(-(id+500), "\n<p align='center'><font color='#000000'>"..SYMBOL[card[2]], p, x+1, y+OFFSET[card[2]]+1, 40, 60, 0, 0, 0)
  ui.addTextArea(-(id+600), "\n<p align='center'><font color='#FFFFFF'>"..SYMBOL[card[2]], p, x, y+OFFSET[card[2]], 40, 60, 0, 0, 0)
end

function removeCard(id, p)
  ui.removeTextArea(-(id), p)
  ui.removeTextArea(-(id+100), p)
  ui.removeTextArea(-(id+200), p)
  ui.removeTextArea(-(id+300), p)
  ui.removeTextArea(-(id+400), p)
  ui.removeTextArea(-(id+500), p)
  ui.removeTextArea(-(id+600), p)
  ui.removeTextArea(-(id+700), p)
end

function showX(n, x, y, p)
  local id = n+20
  ui.addTextArea(-(id), "", p, x, y, 40, 60, -1, 0x214A25)
  ui.addTextArea(-(id+100), "\n<p align='center'><font color='#214A25' size='35px'>X", p, x, y-6, 40, 60, 0, 0, 0)
  ui.removeTextArea(-(id+200), p)
  ui.removeTextArea(-(id+300), p)
  ui.removeTextArea(-(id+400), p)
  ui.removeTextArea(-(id+500), p)
  ui.removeTextArea(-(id+600), p)
  ui.removeTextArea(-(id+700), p)
end

function resetGame()
  ROUND = {
    playing = {},
    chair = {}, -- hand = {card, card, ...}, owner = string,
    game = {}, -- topCard = card, action = boolean, accumulated = {cards = number, allowed = {}}, eliminated = boolean, empty = boolean
    pile = {},
    deck = {},
    mode = "BEGIN",
    flow = "RIGHT",
    limit = 12, -- limite de cartas na mao
    limitCounter = 10,
    time = os.time()+20000,
    passed = 0,
    counter = 24,
  }
  for i=1, 2 do
    ui.removeTextArea(i)
  end
  for i=200, 204 do
    ui.removeTextArea(i)
  end
  for i=1, 12 do
    removeCard(i)
  end
  for i=1, CONFIG.maxPlayers do
    ROUND.chair[i] = {hand = {}, owner = "", penalty = 0}
    ROUND.game[i] = {topCard = {"black","wild"}, action = false, accumulated = false, eliminated = false, empty = true}
    topCard(i)
    showScore(i)
  end
  for i, v in pairs(tfm.get.room.playerList) do
    ui.addTextArea(0, string.format("<p align='center'><font size='14px' color='#ffffff'><a href='event:enter'>%s", translate(i, "PLAY")), i, 300, 360, 200, nil, -1, 0xffffff, 1)
  end
  showFlow()
end

function startGame()
  local cont = 0
  for i, v in pairs(ROUND.game) do
    if not v.empty then
      cont = cont + 1
    end
  end
  if cont < 2 then
    ROUND.time = os.time() + 10000
    return
  end
  ROUND.mode = "START"
  ROUND.counter = 0
  ui.removeTextArea(0)
  for n = 1, 2 do
    for i, v in pairs(DECK.vanilla) do
      table.insert(ROUND.deck, v)
    end
  end
  ROUND.deck = shuffleDeck(ROUND.deck)
  for i, v in pairs(ROUND.game) do
    if v.empty then
      v.eliminated = true
    else
      ROUND.counter = ROUND.counter + 1
    end
  end
  for i, v in pairs(ROUND.game) do
    if not v.eliminated then
      local card = {}
      repeat
        card = table.remove(ROUND.deck)
        table.insert(ROUND.pile, card)
      until card[1] ~= "black"
      v.topCard = card
    end
    topCard(i)
  end
  for i, v in pairs(ROUND.game) do
    if not v.empty then
      drawCard(i, 7)
      showDeck(ROUND.chair[i].owner, 10, 348)
      ui.addTextArea(203, "<p align='center'><font size='10px' color='#366339'>"..translate(ROUND.chair[i].owner, "PASS"), ROUND.chair[i].owner, 705, 360, 80, 18, -1, 0x366339, 1, false)
    end
  end
  ROUND.time = os.time()+10000
  showTimer()
  showFlow()
end

function endGame(p)
  ROUND.mode = "FINAL"
  ui.addTextArea(1, "", nil, 0, 0, 800, 400, 1, 1, 0.7)
  if type(p) == "table" then
    for i, v in pairs(tfm.get.room.playerList) do
      ui.addTextArea(2, "<p align='center'><font color='#FFD800' size='40px'>"..translate(i, "TIE").."\n<font size='20px'>("..table.concat(p, ", ")..")", i, 0, 200, 800, 400, 1, 1, 0)
    end
  else
    for i, v in pairs(tfm.get.room.playerList) do
      ui.addTextArea(2, "<p align='center'><font color='#FFD800' size='40px'>"..string.format(translate(i, "WINNER"), nickHashtag(p)), i, 0, 200, 800, 400, 1, 1, 0)
    end
  end
  ROUND.time = os.time()+10000
end

function showDeck(p, x, y)
	ui.addTextArea(200, "", p, x, y, 40, 60, 0x222222, 0xffffff, 1,false)
	ui.addTextArea(201, "<p align='center'><font size='10px' color='#FFD800'>Draw", p, x+3, y+23, 34, 16, 0xFF3232, 0xFF3232, 1,false)
  ui.addTextArea(202, "<p align='right'><a href='event:draw'>\n\n\n\n\n\n\n\n\n", p, x, y, 40, 60, 0, 0, 0)
end

function drawCard(n, qtd)
  qtd = qtd or 1
  for i=1, qtd do
    if #ROUND.deck == 0 then
      ROUND.deck = shuffleDeck(ROUND.pile)
      ROUND.pile = {}
    end
    if #ROUND.deck == 0 or #ROUND.chair[n].hand > ROUND.limit then
      break
    end
    table.insert(ROUND.chair[n].hand, table.remove(ROUND.deck))
  end
  if #ROUND.chair[n].hand > ROUND.limit then
    eliminate(n)
  else
    sortHand(ROUND.chair[n].hand)
    showHand(n)
    showScore(n)
  end
  showCardsGainned(n, qtd)
end

function showCardsGainned(n, qtd)
  if qtd and qtd ~= 0 then
    local x = POS[n].x+17.5
    local y = POS[n].y-10
    ui.addTextArea(2010+n, string.format("<p align='center'><font size='20px' color='#000000'><b>+%s", qtd), nil, x+1, y+1, 40, nil, 0, 0, 0, false)
    ui.addTextArea(2000+n, string.format("<p align='center'><font size='20px' color='#ffffff'><b>+%s", qtd), nil, x, y, 40, nil, 0, 0, 0, false)
    table.insert(TIMER.txt, {time=os.time()+2000, id=2000+n})
    table.insert(TIMER.txt, {time=os.time()+2000, id=2010+n})
  end
end

function sortHand(hand)
  table.sort(hand, function(a, b)
    if type(a) == "table" and type(b) == "table" then
      local s = {n0=0, n1=1, n2=2, n3=3, n4=4, n5=5, n6=6, n7=7, n8=8, n9=9, skip=10, reverse=11, draw2=12, wild=13, draw4=14}
      local c = {red=0, blue=1, yellow=2, green=3, black=4}
      if a[1] == b[1] then
        return s[a[2]] < s[b[2]]
      else
        return c[a[1]] < c[b[1]]
      end
    end
  end)
end

function enterPlayer(p)
  if ROUND.mode == "BEGIN" and not ROUND.playing[p] then
    local pool = {}
    for i, v in pairs(ROUND.game) do
      if v.empty then
        table.insert(pool, i)
      end
    end
    local rand = pool[math.random(#pool)]
    ROUND.game[rand].empty = false
    ROUND.chair[rand].owner = p
    showScore(rand)
    ROUND.playing[p] = rand
    if #pool == 1 then
      startGame()
    end
  end
end

function topCard(n, p)
  if ROUND.game[n].eliminated or ROUND.mode == "BEGIN" then
    showX(n, POS[n].x+17.5, POS[n].y+30, p)
  else
    showCard(n+20, ROUND.game[n].topCard, p, POS[n].x+17.5, POS[n].y+30)
    if ROUND.game[n].accumulated then      
      ui.addTextArea(-(n+20+700), "\n<p align='center'><font color='#000000'>= +"..ROUND.game[n].accumulated, p, POS[n].x+17.5, POS[n].y+65, 40, 60, 0, 0, 0)
    else
      ui.removeTextArea(-(n+20+700), p)
    end
  end
end

function showScore(n, p)
  local qtd = #ROUND.chair[n].hand
  local name = nickMinifier(nickHashtag(ROUND.chair[n].owner))
  local x = 7.5+POS[n].x
  local y = -10+POS[n].y
  if ROUND.game[n].empty then
    ui.removeTextArea(n+100, p)
  elseif ROUND.game[n].eliminated then
    ui.addTextArea(n+100, string.format("<p align='center'><font color='#000000'>%s", name), p, x, y, 60, nil, 1, 0xFFFFFF, 0)
  elseif qtd == 0 then
    if ROUND.chair[n].pass then
      name = "<j>"..name
    end
    ui.addTextArea(n+100, string.format("<p align='center'>%s\n<font size='12px'><vp>ZERO!", name), p, x, y, 60, nil, 1, 0xFFFFFF, 0)
  elseif qtd == 1 then
    if ROUND.chair[n].pass then
      name = "<j>"..name
    end
    ui.addTextArea(n+100, string.format("<p align='center'>%s\n<font size='12px'><j>UNO!", name), p, x, y, 60, nil, 1, 0xFFFFFF, 0)
  else
    if ROUND.chair[n].pass then
      name = "<j>"..name
    end
    ui.addTextArea(n+100, string.format("<p align='center'>%s\n<n><font size='12px'>%s<font size='8px'>/%s", name, qtd, ROUND.limit), p, x, y, 60, nil, 1, 0xFFFFFF, 0)
  end
  if not p or p ~= ROUND.chair[n].owner then
    ui.addTextArea(0, "", ROUND.chair[n].owner, x-1.5, y+4, 64, 101, -1, 0xFFFFFF, 1)
  end
end

function showHand(n)
  local qtd = #ROUND.chair[n].hand
  for i, v in pairs(ROUND.chair[n].hand) do
    showCard(i, v, ROUND.chair[n].owner, 400-qtd*25+(i-1)*50, 350)
    ui.addTextArea(-(i+700), string.format("<p align='right'><a href='event:play %s'>\n\n\n\n\n\n\n\n\n", i), ROUND.chair[n].owner, 400-qtd*25+(i-1)*50, 350, 40, 60, 0, 0, 0)
  end
  for id=qtd+1, 12 do
      removeCard(id, ROUND.chair[n].owner)
  end
end

function eliminate(n)
  if ROUND and not ROUND.game[n].eliminated then
    for i, v in pairs(ROUND.chair[n].hand) do
      table.insert(ROUND.pile, v)
    end
    ROUND.game[n].eliminated = true
    local pool = {0, 2, 3, 11, 13}
    for i=1, 30 do
      local vx = (math.random()-0.5) * 5
      local vy = (math.random()-0.5) * 5
      local particle = pool[math.random(#pool)]
      tfm.exec.displayParticle(particle, POS[n].x+37.5, POS[n].y+20, vx, vy, 0, 0)
    end
    for i=200, 204 do
      ui.removeTextArea(i, ROUND.chair[n].owner)
    end
    ROUND.counter = ROUND.counter - 1
    showScore(n)
    topCard(n)
    ROUND.chair[n].hand = {}
    showHand(n)
    pass(n)
    ui.addTextArea(1, "<p align='center'><font color='#ffffff' size='25px'>"..string.format(translate(ROUND.chair[n].owner, "LOST"), ROUND.counter), ROUND.chair[n].owner, 5, 348, 790, 50, 0x214A25, 0x214A25, 0.9, true)
  end
end

function canPlayThatCard(n, card, top)
  if ROUND.game[n].accumulated then
    return card[2] == top[2]
  else
    return card[1] == top[1] or card[2] == top[2] or card[1] == "black"
  end
end

function actionCardEffect(x, y, color)
  local fx = {red=13, blue=1, yellow=11, green=9}
  for i=1, 5 do
    local vel = i/5*75
    tfm.exec.displayParticle(fx[color] or 0, x-25, y+vel, -math.random(7,15)/5, (vel-37)/20, 0, 0)
  end
  for i=1, 5 do
    local vel = i/5*75
    tfm.exec.displayParticle(fx[color] or 0, x+25, y+vel, math.random(7,15)/5, (vel-37)/20, 0, 0)
  end
end

function playCard(n, i)
  if canPlayThatCard(n, ROUND.chair[n].hand[i], ROUND.game[n].topCard) then
    print("5")
    local card = table.remove(ROUND.chair[n].hand, i)
    ROUND.game[n].topCard = {card[1], card[2]}
    ROUND.chair[n].played = true
    table.insert(ROUND.pile, card)
    showHand(n)
    showScore(n)
    if EFFECT[ROUND.game[n].topCard[2]] then
      actionCardEffect(POS[n].x+37.5, POS[n].y+25, ROUND.game[n].topCard[1])
      EFFECT[ROUND.game[n].topCard[2]](n)
    else
      for i=1, 5 do
        tfm.exec.displayParticle(3, POS[n].x+37.5, POS[n].y+60, math.random(-20,20)/10, math.random(-20,20)/10, 0, 0)
      end
      pass(n)
    end
    if #ROUND.chair[n].hand == 0 then
      for j, v in pairs(ROUND.chair) do
        v.penalty = v.penalty + (j ~= n and 2 or 1)
      end
      for i=1, 30 do
        local vx = (math.random()-0.5) * 5
        local vy = (math.random()-1) * 10
        tfm.exec.displayParticle(math.random(21, 24), POS[n].x+37.5, POS[n].y+20, vx, vy, 0, 0.1, p)
      end
    end
    topCard(n)
  end
end

EFFECT = {
  skip = function(n)
    ROUND.game[n].skip = true
    pass(n)
  end,
  reverse = function(n)
    if not ROUND.reverse then
      ROUND.flow = ROUND.flow == "RIGHT" and "LEFT" or "RIGHT"
      showFlow()
      ROUND.reverse = true
    end
    pass(n)
  end,
  draw2 = function(n)
    if ROUND.game[n].accumulated then
      ROUND.game[n].accumulated = ROUND.game[n].accumulated + 2
    else
      ROUND.game[n].accumulated = 2
    end
    pass(n)
  end,
  wild = function(n)
    ROUND.chair[n].action = true
    ui.addTextArea(1, "", ROUND.chair[n].owner, 0, 0, 800, 400, 1, 1, 0.6)
    showCard(70, {"red", "wild"}, ROUND.chair[n].owner, 280, 350)
    showCard(71, {"blue", "wild"}, ROUND.chair[n].owner, 345, 350)
    showCard(72, {"yellow", "wild"}, ROUND.chair[n].owner, 410, 350)
    showCard(73, {"green", "wild"}, ROUND.chair[n].owner, 475, 350)
    ui.addTextArea(-(70+700), "<p align='right'><a href='event:color red'>\n\n\n\n\n\n\n\n\n", ROUND.chair[n].owner, 280, 350, 40, 60, 0, 0, 0)
    ui.addTextArea(-(71+700), "<p align='right'><a href='event:color blue'>\n\n\n\n\n\n\n\n\n", ROUND.chair[n].owner, 345, 350, 40, 60, 0, 0, 0)
    ui.addTextArea(-(72+700), "<p align='right'><a href='event:color yellow'>\n\n\n\n\n\n\n\n\n", ROUND.chair[n].owner, 410, 350, 40, 60, 0, 0, 0)
    ui.addTextArea(-(73+700), "<p align='right'><a href='event:color green'>\n\n\n\n\n\n\n\n\n", ROUND.chair[n].owner, 475, 350, 40, 60, 0, 0, 0)
  end,
  draw4 = function(n)
    if ROUND.game[n].accumulated then
      ROUND.game[n].accumulated = ROUND.game[n].accumulated + 4
    else
      ROUND.game[n].accumulated = 4
    end
    ROUND.chair[n].action = true
    ui.addTextArea(1, "", ROUND.chair[n].owner, 0, 0, 800, 400, 1, 1, 0.6)
    showCard(70, {"red", "draw4"}, ROUND.chair[n].owner, 280, 350)
    showCard(71, {"blue", "draw4"}, ROUND.chair[n].owner, 345, 350)
    showCard(72, {"yellow", "draw4"}, ROUND.chair[n].owner, 410, 350)
    showCard(73, {"green", "draw4"}, ROUND.chair[n].owner, 475, 350)
    ui.addTextArea(-(70+700), "<p align='right'><a href='event:color red'>\n\n\n\n\n\n\n\n\n", ROUND.chair[n].owner, 280, 350, 40, 60, 0, 0, 0)
    ui.addTextArea(-(71+700), "<p align='right'><a href='event:color blue'>\n\n\n\n\n\n\n\n\n", ROUND.chair[n].owner, 345, 350, 40, 60, 0, 0, 0)
    ui.addTextArea(-(72+700), "<p align='right'><a href='event:color yellow'>\n\n\n\n\n\n\n\n\n", ROUND.chair[n].owner, 410, 350, 40, 60, 0, 0, 0)
    ui.addTextArea(-(73+700), "<p align='right'><a href='event:color green'>\n\n\n\n\n\n\n\n\n", ROUND.chair[n].owner, 475, 350, 40, 60, 0, 0, 0)
  end,
}

function eventNewGame()
  resetGame()
end

function eventChatCommand(p, cmd)
  local arg = split(cmd, " ")
  if p == ADM then
    if arg[1] == "start" then
      startGame()
    end
  end
end

function pass(n)
  if not ROUND.chair[n].pass then
    ui.removeTextArea(204, ROUND.chair[n].owner) -- passar a vez em branco
    ui.addTextArea(1, "<p align='center'><font color='#ffffff' size='25px'>"..translate(ROUND.chair[n].owner, "WAIT"), ROUND.chair[n].owner, 5, 348, 790, 50, 0x214A25, 0x214A25, 0.9)
    ROUND.chair[n].pass = true
    showScore(n)
    if not ROUND.game[n].eliminated then
      ROUND.passed = ROUND.passed + 1
    end
  end
end

function passTurn()
  if ROUND and not ROUND.pause then
    if ROUND.limit > 3 then
      ROUND.limitCounter = ROUND.limitCounter - 1
      if ROUND.limitCounter == 0 then
        ROUND.limitCounter = 5
        ROUND.limit = ROUND.limit - 1
      end
    end
    for i, v in pairs(ROUND.chair) do
      if #v.hand > ROUND.limit then
        eliminate(i)
      end
    end
    -- caso alguém tenha 0 cartas, todos compram 2 cartas, exceto quem jogou, que comprará apenas 1
    -- também reseta as variáveis de controle
    showFlow(true)
    ROUND.pause = true
    addFunctionTimer(function()
      ROUND.pause = false
      for i, v in pairs(ROUND.chair) do
        if not ROUND.game[i].eliminated then
          if v.penalty ~= 0 then
            drawCard(i, v.penalty)
            v.penalty = 0
          end
          v.played = false
          v.draw = false
          v.pass = false
          v.action = false
          showScore(i)
          ui.removeTextArea(1, v.owner)
        end
      end
      ROUND.reverse = false
      ROUND.passed = 0
      -- cartas trocam de lugar
      if ROUND.counter > 0 then
        local n = nextChair(1)
        local game = ROUND.chair[n]
        local aux = {}
        local c = n
        repeat
          c = nextChair(c)
          aux = ROUND.chair[c]
          ROUND.chair[c] = game
          game = aux
          showScore(c)
        until c == n
      end
      -- verificar se a carta que está em cada um afeta o início de jogo (draw2, draw4 e skip)
      for i, v in pairs(ROUND.game) do
        if not v.eliminated then
          ROUND.playing[ROUND.chair[i].owner] = i
          if v.accumulated then
            if v.topCard[2] == "draw2" then
              ui.addTextArea(1, "<p align='center'>"..string.format(translate(ROUND.chair[i].owner, "DRAW2"), v.accumulated), ROUND.chair[i].owner, 0, 320, 800, nil, 0, 0, 0)
            elseif v.topCard[2] == "draw4" then
              ui.addTextArea(1, "<p align='center'>"..string.format(translate(ROUND.chair[i].owner, "DRAW4"), v.accumulated), ROUND.chair[i].owner, 0, 320, 800, nil, 0, 0, 0)
            end
          elseif v.skip then
            pass(i)
            ui.addTextArea(1, "<p align='center'><font color='#ffffff' size='25px'>"..translate(ROUND.chair[i].owner, "SKIPPED"), ROUND.chair[i].owner, 5, 348, 790, 50, 0x214A25, 0x214A25, 0.9, true)
            v.skip = false
          end
        end
      end
      -- verificar se há apenas 1 jogador para encerrar o jogo
      if ROUND.counter == 1 then
        for i, v in pairs(ROUND.chair) do
          if not ROUND.game[i].eliminated then
            endGame(v.owner)
            break
          end
        end
      elseif ROUND.counter == 0 then
        endGame(ROUND.players)
      else
        ROUND.players = {}
        for i, v in pairs(ROUND.chair) do
          if not ROUND.game[i].eliminated then
            local nickname = nickHashtag(v.owner)
            table.insert(ROUND.players, nickname)
          end
        end
        if ROUND.counter <= 5 then
          ROUND.time = os.time()+5000
          if not ROUND.cloud then
            ROUND.cloud = {}
            tfm.exec.addPhysicObject(0, 400, 530, {height=10, width=3000})
            ROUND.cloud.obj = tfm.exec.addShamanObject(63, 400, 500, 0, 2, 0, false)
            ROUND.cloud.delay = os.time()+5000
            tfm.exec.addImage("15ae8515f11.png", "#"..ROUND.cloud.obj, -1200, -500)
          end
        else
          ROUND.time = os.time()+10000
        end
        showTimer()
        showFlow()
      end
    end, 1000)
  end
end

function nextChair(n)
  local sum = {LEFT = -1, RIGHT = 1}
  local cont = 30
  n = n or 1
  repeat
    n = n + sum[ROUND.flow or "LEFT"]
    n = n > #ROUND.game and 1 or n < 1 and #ROUND.game or n
    cont = cont - 1
    if cont <= 0 then
      n = nil
      break
    end
  until not ROUND.game[n].eliminated
  return n
end

function showTimer()
  if not ROUND.pause and ROUND.time - os.time() <= 5000 then
    local n = math.ceil((ROUND.time - os.time())/1000)
    ui.addTextArea(2, "<p align='center'><font size='30px' color='#000000'>"..n, nil, 1, 301, 800, nil, 1, 1, 0)
    ui.addTextArea(3, "<p align='center'><font size='30px' color='#FFD800'>"..n, nil, 0, 300, 800, nil, 1, 1, 0)
  else
    ui.removeTextArea(2)
    ui.removeTextArea(3)
  end
end

function gameTimer()
  if ROUND then
    if ROUND.mode == "BEGIN" then
      if os.time() > ROUND.time then
        startGame()
      else
        showTimer()
      end
    elseif ROUND.mode == "START" then
      if os.time() > ROUND.time then
        autoPlay()
      else
        showTimer()
      end
    elseif ROUND.mode == "FINAL" then
      if os.time() > ROUND.time then
        tfm.exec.newGame(MAP)
      end
    end
  end
end

function autoPlay()
  for i, v in pairs(ROUND.game) do
    if not v.eliminated and not v.passed then
      if ROUND.chair[i].action then
        local colors = {"red", "blue", "yellow", "green"}
        eventTextAreaCallback(0, ROUND.chair[i].owner, "color "..colors[math.random(#colors)])
      else
        eventTextAreaCallback(0, ROUND.chair[i].owner, "draw")
        eventTextAreaCallback(0, ROUND.chair[i].owner, "pass")
      end
    end
  end
  passTurn()
end

function eventTextAreaCallback(id, p, callback)
  local arg = split(callback, " ")
  if ROUND and ROUND.playing[p] and ROUND.mode == "START" then
    local n = ROUND.playing[p]
    if not ROUND.game[n].eliminated and not ROUND.chair[n].pass then
      if arg[1] == "play" and tonumber(arg[2]) and not ROUND.chair[n].played then
        local card = tonumber(arg[2])
        if ROUND.chair[n].hand[card] then
          playCard(n, card)
        end
      elseif arg[1] == "draw" and not ROUND.chair[n].draw and not ROUND.chair[n].played then
        ROUND.chair[n].draw = true
        if ROUND.game[n].accumulated then
          drawCard(n, ROUND.game[n].accumulated)
          ROUND.game[n].accumulated = false
          ROUND.chair[n].played = true
          topCard(n)
          pass(n)
        else
          drawCard(n)
          ui.addTextArea(204, "<p align='center'><font size='10px' color='#ffffff'><a href='event:pass'>"..translate(ROUND.chair[n].owner, "PASS"), ROUND.chair[n].owner, 705, 360, 80, 18, -1, 0xffffff, 1, false)
        end
      elseif arg[1] == "color" and ROUND.chair[n].action then
        local colors = {red=1, blue=1, yellow=1, green=1}
        if colors[arg[2]] then
          ROUND.game[n].topCard[1] = arg[2]
          topCard(n)
          for i=70, 73 do
            removeCard(i, ROUND.chair[n].owner)
          end
          local particle = {red=21, blue=23, yellow=24, green=22}
          for i=1, 5 do
            tfm.exec.displayParticle(particle[arg[2]], POS[n].x+37.5, POS[n].y+60, math.random(-20,20)/8, math.random(-20,20)/8, 0, 0)
          end
          pass(n)
        end
      elseif arg[1] == "pass" then
        pass(n)
      end
    end
  end
  if arg[1] == "enter" then
    enterPlayer(p)
  elseif arg[1] == "help" then
    if HELP[p] then
      closeHelp(p)
    else
      openHelp(p)
    end
  elseif arg[1] == "close" then
    closeHelp(p)
  end
end

function teleportCloud()
  if ROUND and ROUND.cloud and ROUND.cloud.obj and ROUND.cloud.delay < os.time() and tfm.get.room.objectList[ROUND.cloud.obj] then
    local obj = tfm.get.room.objectList[ROUND.cloud.obj]
    if obj.x < 0 then
      tfm.exec.moveObject(ROUND.cloud.obj, 800, 0.01, true, 0, 2, false)
      ROUND.cloud.delay = os.time() + 5000
    elseif obj.x > 800 then
      tfm.exec.moveObject(ROUND.cloud.obj, -800, 0.01, true, 0, 2, false)
      ROUND.cloud.delay = os.time() + 5000
    end
  end
end

function eventLoop(current, remaining)
  local tt = os.time()
  for i, v in pairs({gameTimer, delTxtTimer, execFunctionTimer, teleportCloud}) do
    if os.time() > tt+10 then
      break
    else
      v(tt)
    end
  end
end

function eventPlayerLeft(p)
  if ROUND and ROUND.playing[p] then
    if ROUND.mode == "BEGIN" then
      local n = ROUND.playing[p]
      ROUND.playing[p] = false
      ROUND.chair[n].owner = ""
      ROUND.game[n].empty = true
      showScore(n)
    elseif ROUND.mode == "START" then
      eliminate(ROUND.playing[p])
    end
  end
end

function eventNewPlayer(p)
  ui.addTextArea(806, "<p align='center'><a href='event:help'>"..translate(p, "HELP"), p, 10, 30, nil, 20, nil, nil, 1, true)
  if ROUND then
    for i=1, CONFIG.maxPlayers do
      showScore(i, p)
      topCard(i, p)
    end
    if ROUND.mode == "BEGIN" then
      ui.addTextArea(0, string.format("<p align='center'><font size='14px' color='#ffffff'><a href='event:enter'>%s", translate(p, "PLAY")), p, 300, 360, 200, nil, -1, 0xffffff, 1)
    end
  end
end

function openHelp(p)
  if HELP[p] then
    for i, v in pairs(HELP[p]) do
      tfm.exec.removeImage(v)
    end
  end
  HELP[p] = {}
  ui.addTextArea(800, "", p, 110, 50, 580, 320, nil, nil, 1, true)
  table.insert(HELP[p], tfm.exec.addImage("1695e57700e.png", "&10", 215, 50, p))
  table.insert(HELP[p], tfm.exec.addImage("1695e578a89.png", "&10", 495, 50, p))
  table.insert(HELP[p], tfm.exec.addImage("1695e57a414.png", "&10", 215, 200, p))
  table.insert(HELP[p], tfm.exec.addImage("1695e57bd8a.png", "&10", 495, 200, p))
  ui.addTextArea(801, "<p align='center'>"..translate(p, "HELP1"), p, 120, 140, 270, nil, 0, 0, 0, true)
  ui.addTextArea(802, "<p align='center'>"..translate(p, "HELP2"), p, 410, 140, 270, nil, 0, 0, 0, true)
  ui.addTextArea(803, "<p align='center'>"..translate(p, "HELP3"), p, 120, 290, 270, nil, 0, 0, 0, true)
  ui.addTextArea(804, "<p align='center'>"..translate(p, "HELP4"), p, 410, 290, 270, nil, 0, 0, 0, true)
  ui.addTextArea(805, "<p align='center'><j><a href='event:close'>[Fechar]", p, 110, 350, 580, nil, 0, 0, 0, true)
end

function closeHelp(p)
  if HELP[p] then
    for i, v in pairs(HELP[p]) do
      tfm.exec.removeImage(v)
    end
  end
  ui.removeTextArea(800, p)
  ui.removeTextArea(801, p)
  ui.removeTextArea(802, p)
  ui.removeTextArea(803, p)
  ui.removeTextArea(804, p)
  ui.removeTextArea(805, p)
  HELP[p] = nil
end

for i, v in pairs(tfm.get.room.playerList) do
  ui.addTextArea(806, "<p align='center'><a href='event:help'>"..translate(i, "HELP"), i, 10, 30, nil, 20, nil, nil, 1, true)
end

tfm.exec.disableAutoShaman()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableAfkDeath()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoScore()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableMinimalistMode()
tfm.exec.disableMortCommand()

tfm.exec.newGame(MAP)