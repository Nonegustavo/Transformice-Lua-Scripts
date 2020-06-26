-- Four in a row
-- Escrito por Ninguem -- Data: 03/10/2015

adm = "Ninguem#0095" -- coloque seu nickname aqui para usar o comando !new, que inicia uma nova partida
tempoDaJogada = 20000
cor = {0x2285b6, 0xff4747}

code = [[<C><P Ca="" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="3000" o="171226" X="400" c="3" Y="385" T="12" H="30" /><S P="0,0,0.3,0,0,0,0,0" L="360" o="28203e" X="400" c="4" Y="300" T="12" H="10" /><S H="10" L="360" o="28203e" X="400" c="4" Y="250" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S H="10" L="360" o="28203e" X="400" c="4" Y="150" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="360" o="28203e" X="400" c="4" Y="100" T="12" H="10" /><S P="0,0,0.3,0.2,0,0,0,0" L="360" o="28203e" X="400" c="4" Y="200" T="12" H="10" /><S H="10" L="360" o="28203e" X="400" c="4" Y="50" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="10" o="2d2642" X="225" c="2" Y="200" T="12" H="310" /><S H="310" L="10" o="2d2642" X="275" c="2" Y="200" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="10" o="2d2642" X="325" c="2" Y="200" T="12" H="310" /><S H="310" L="10" o="2d2642" X="375" c="2" Y="200" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="10" o="2d2642" X="425" c="2" Y="200" T="12" H="310" /><S H="310" L="10" o="2d2642" X="475" c="2" Y="200" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="10" o="2d2642" X="525" c="2" Y="200" T="12" H="310" /><S H="310" L="10" o="2d2642" X="575" c="2" Y="200" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="3000" o="171226" X="400" N="" Y="23" T="12" H="10" /><S P="0,0,0.3,0.2,0,0,0,0" L="400" o="2285b6" X="200" N="" Y="23" T="12" H="10" /><S L="400" o="ff4747" X="600" H="10" N="" Y="23" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S H="10" L="360" o="2d2642" X="400" c="4" Y="350" T="12" P="0,0,0.3,0,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="100" o="171226" X="720" Y="300" T="12" H="200" /><S L="100" o="171226" X="80" H="200" Y="300" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S X="126" L="160" H="10" lua="3333" Y="290" T="%d" P="0,0,%f,%f,90,0,0,0" /><S H="10" L="160" X="674" lua="4444" Y="290" T="%d" P="0,0,%f,%f,-90,0,0,0" /><S H="30" L="60" X="80" c="3" Y="192" T="14" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="60" H="30" c="3" Y="192" T="14" X="720" /><S L="20" o="171226" H="10" X="122" Y="205" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="20" o="171226" X="678" Y="205" T="12" H="10" /></S><D><P C="2a2244" Y="0" T="34" X="0" P="0,0" /><P C="2285b6,bde8f3,faf1b3" Y="332" T="14" P="0,0" X="-87" /><P C="2285b6" Y="200" T="19" X="80" P="0,0" /><P C="ff4747,bde8f3,faf1b3" Y="324" T="14" X="887" P="0,0" /><P C="ff4747" Y="200" T="19" P="0,0" X="720" /><P C="555d77" Y="389" T="131" X="400" P="1,0" /><P C="ff4747,bde8f3,faf1b3" Y="350" T="14" P="1,0" X="895" /><P C="ff4747,bde8f3,faf1b3" Y="180" T="14" X="892" P="1,0" /><P C="2285b6,bde8f3,faf1b3" Y="350" T="14" X="-95" P="1,0" /><P C="2285b6,bde8f3,faf1b3" Y="180" T="14" X="-95" P="1,0" /><P C="2285b6,bde8f3,faf1b3" Y="164" T="14" P="0,0" X="-88" /><P C="ff4747,bde8f3,faf1b3" Y="157" T="14" P="0,0" X="883" /><DS Y="343" X="400" /><P C="fdfdfd" Y="-30" T="90" X="400" P="0,0" /></D><O /></Z></C>]]
--code = "@6281248" -- versão com tela e menos wj

piso = {
  {id=0, f=0.3, r=0.2},
  {id=2, f=0.5, r=2},
  {id=3, f=0.5, r=999999},
  {id=4, f=20, r=0.2},
  {id=5, f=0.3, r=0.2},
  {id=6, f=0.3, r=0.2},
  {id=7, f=0.1, r=0.2},
  {id=10, f=0.3, r=0},
  {id=11, f=0.05, r=0.1}
}

modo = "inicio"
vez = 1
jogador = {}
tabela = {}
intervalo = os.time()+2000
tempoFim = os.time()
tempoMapa = os.time() + 3000
tempoJogada = os.time() + 15000
obj = 0
matar = ""
penalidade = {}
tabela = {}
for i=1, 7 do
  tabela[i] = {}
    for j=1, 6 do
      tabela[i][j] = 0
    end
  end

function novaTabela()
  for i=1, 7 do
    for j=1, 6 do
      tabela[i][j] = 0
    end
  end
end

function exibeNome(i)
  ui.addTextArea(i, "<p align='center'><j>"..jogador[i], nil, (i==1) and 20 or 660, 220, 120, 30, 0, 0, 0, true)
end

function eventNewPlayer(p)
  tfm.exec.bindKeyboard(p, 32, true, true)
  penalidade[p] = penalidade[p] or 0
end

function eventNewGame()
  modo = "inicio"
  novaTabela()
  tempoMapa = os.time() + 3000
  jogador[1] = nil
  jogador[2] = nil
  ui.addTextArea(1, "<p align='center'><vp>[espaço]", nil, 20, 220, 120, 30, 0, 0, 0, true)
  ui.addTextArea(2, "<p align='center'><vp>[espaço]", nil, 660, 220, 120, 30, 0, 0, 0, true)
  ui.removeTextArea(3)
  ui.removeTextArea(4)
  tfm.exec.addPhysicObject(8000, 0, 0, {type=14, miceCollision=false})
  tfm.exec.setUIMapName("Four in a row")
  jogador = {}
  for i, v in pairs(tfm.get.room.playerList) do
    system.bindMouse(i, false)
    tfm.exec.setNameColor(i, 0xC2C2CA)
    eventNewPlayer(i)
  end
  --for i, v in pairs(penalidade) do
  --  if v > 0 and tfm.get.room.uniquePlayers > 6 then
  --    tfm.exec.chatMessage("<r>Você ficará "..v.." partidas sem jogar.", i)
  --    penalidade[i] = v-1
  --    tfm.exec.killPlayer(i)
  --  end
  --end
end

function eventKeyboard(p, t, d, x, y)
  if modo == "inicio" and os.time() > tempoMapa and not tfm.get.room.playerList[p].isDead then
    if x > 50 and x < 110 and not jogador[1] then
      jogador[1] = p
      system.bindMouse(p, true)
      exibeNome(1)
      tfm.exec.setNameColor(p, cor[1])
    elseif x > 690 and x < 750 and not jogador[2] then
      jogador[2] = p
      system.bindMouse(p, true)
      exibeNome(2)
      tfm.exec.setNameColor(p, cor[2])
    end
    if jogador[1] and jogador[2] then
      modo = "partida"
      tempoJogada = tempoDaJogada + os.time()
      vez = math.random(1,2)
      tfm.exec.removeObject(obj)
      obj = tfm.exec.addShamanObject(57, vez == 1 and 80 or 720, 50, 0, 0, 0, true)
    end
  end
end

function linhaVertical(p)
  local p1, p2 = {}, {}
  for i=1, 7 do
    for j=1, 3 do
      if tabela[i][j] == p and tabela[i][j+1] == p and tabela[i][j+2] == p and tabela[i][j+3] == p then
        p1 = {i, j}
        p2 = {i, j+3}
        return p1, p2
      end
    end
  end
end

function linhaHorizontal(p)
  local p1, p2 = {}, {}
  for i=1, 4 do
    for j=1, 6 do
      if tabela[i][j] == vez and tabela[i+1][j] == p and tabela[i+2][j] == p and tabela[i+3][j] == p then
        p1 = {i, j}
        p2 = {i+3, j}
        return p1, p2
      end
    end
  end
end

function linhaDiagonal1(p)
  local p1, p2 = {}, {}
  for i=1, 4 do
    for j=1, 3 do
      if tabela[i][j] == vez and tabela[i+1][j+1] == p and tabela[i+2][j+2] == p and tabela[i+3][j+3] == p then
        p1 = {i, j}
        p2 = {i+3, j+3}
        return p1, p2
      end
    end
  end
end

function linhaDiagonal2(p)
  local p1, p2 = {}, {}
  for i=4, 7 do
    for j=1, 3 do
      if tabela[i][j] == p and tabela[i-1][j+1] == p and tabela[i-2][j+2] == p and tabela[i-3][j+3] == p then
        p1 = {i, j}
        p2 = {i-3, j+3}
        return p1, p2
      end
    end
  end
end

function verificaVitoria(p)
  local p1, p2 = false, false
  if linhaVertical(p) then
    p1, p2 = linhaVertical(p)
  elseif linhaHorizontal(p) then
    p1, p2 = linhaHorizontal(p)
  elseif linhaDiagonal1(p) then
    p1, p2 = linhaDiagonal1(p)
  elseif linhaDiagonal2(p) then
    p1, p2 = linhaDiagonal2(p)
  end
  if p1 and p2 then
    modo = "fim"
    tempoFim = os.time() + 10000
    local x1 = 200+p1[1]*50
    local y1 = 375-p1[2]*50
    local x2 = 200+p2[1]*50
    local y2 = 375-p2[2]*50
    tfm.exec.addJoint(8000, 8000, 8000, {point1=x1..","..y1, point2=x2..","..y2, color=cor[p], line=4, foreground=true})
    tfm.exec.setPlayerScore(jogador[p], 1, true)
    ui.addTextArea(3, "", nil, 0, 0, 800, 400, 1, 1, 0.3, true)
    ui.addTextArea(4, string.format("<p align='center'><font color='#ffffff' size='60px'>%s venceu o jogo!", jogador[p]), nil, 0, 120, 800, 400, 0, 0, 0, true)
    penalidade[jogador[1]] = vez == 1 and 1 or 3
    penalidade[jogador[2]] = vez == 1 and 3 or 1
  end
  intervalo = os.time()+2000
end

function semJogada()
  for i=1, 7 do
    if tabela[i][6] == 0 then
      return false
    end
  end
  return true
end

function verificaEmpate()
  if modo == "partida" then
    if semJogada() then
      ui.addTextArea(3, "", nil, 0, 0, 800, 400, 1, 1, 0.3, true)
      ui.addTextArea(4, string.format("<p align='center'><font color='#ffffff' size='60px'>Empate"), nil, 0, 120, 800, 400, 0, 0, 0, true)
      penalidade[jogador[1]] = 2
      penalidade[jogador[2]] = 2
      modo = "fim"
      tempoFim = os.time() + 10000
    end
  end
end

function passaVez()
  vez = vez == 1 and 2 or 1
  tfm.exec.removeObject(obj)
  obj = tfm.exec.addShamanObject(57, vez == 1 and 80 or 720, 50, 0, 0, 0, true)
  tempoJogada = os.time() + tempoDaJogada
end

function autoPlay()
  local pool = {}
  for i=1, 7 do
    if tabela[i][6] == 0 then
      table.insert(pool, i)
    end
  end
  eventMouse(jogador[vez], 200+pool[math.random(#pool)]*50, 0)
end

function eventChatCommand(p, cmd)
  if p == adm and cmd == "new" then
    modo = "inicio"
    local e = math.random(#piso)
    tfm.exec.newGame(string.format(code, piso[e].id, piso[e].f, piso[e].r, piso[e].id, piso[e].f, piso[e].r))
  end
end

function eventMouse(p, x, y)
  if modo == "partida" then
    if jogador[vez] == p and os.time() > intervalo then
      local xx = math.ceil((x - 225)/50)
      if tabela[xx] then
        if tabela[xx][1] == 0 then
          tabela[xx][1] = vez
          tfm.exec.addPhysicObject(xx*6+1+2000, 200 + (xx * 50), 350, {type=14, miceCollision=false})
          tfm.exec.addPhysicObject(xx*6+1+1000, 200 + (xx * 50), 50, {type=13, width=19, mass=999999, color=cor[vez], dynamic=true, miceCollision=false, foreground=true})
          verificaVitoria(vez)
          verificaEmpate()
          passaVez()
        elseif tabela[xx][2] == 0 then
          tabela[xx][2] = vez
          tfm.exec.addPhysicObject(xx*6+2+2000, 200 + (xx * 50), 300, {type=14, miceCollision=false})
          tfm.exec.addPhysicObject(xx*6+2+1000, 200 + (xx * 50), 50, {type=13, width=19, mass=999999, color=cor[vez], dynamic=true, miceCollision=false, foreground=true})
          verificaVitoria(vez)
          verificaEmpate()
          passaVez()
        elseif tabela[xx][3] == 0 then
          tabela[xx][3] = vez
          tfm.exec.addPhysicObject(xx*6+3+2000, 200 + (xx * 50), 250, {type=14, miceCollision=false})
          tfm.exec.addPhysicObject(xx*6+3+1000, 200 + (xx * 50), 50, {type=13, width=19, mass=999999, color=cor[vez], dynamic=true, miceCollision=false, foreground=true})
          verificaVitoria(vez)
          verificaEmpate()
          passaVez()
        elseif tabela[xx][4] == 0 then
          tabela[xx][4] = vez
          tfm.exec.addPhysicObject(xx*6+4+2000, 200 + (xx * 50), 200, {type=14, miceCollision=false})
          tfm.exec.addPhysicObject(xx*6+4+1000, 200 + (xx * 50), 50, {type=13, width=19, mass=999999, color=cor[vez], dynamic=true, miceCollision=false, foreground=true})
          verificaVitoria(vez)
          verificaEmpate()
          passaVez()
        elseif tabela[xx][5] == 0 then
          tabela[xx][5] = vez
          tfm.exec.addPhysicObject(xx*6+5+2000, 200 + (xx * 50), 150, {type=14, miceCollision=false})
          tfm.exec.addPhysicObject(xx*6+5+1000, 200 + (xx * 50), 50, {type=13, width=19, mass=999999, color=cor[vez], dynamic=true, miceCollision=false, foreground=true})
          verificaVitoria(vez)
          verificaEmpate()
          passaVez()
        elseif tabela[xx][6] == 0 then
          tabela[xx][6] = vez
          tfm.exec.addPhysicObject(xx*6+6+2000, 200 + (xx * 50), 100, {type=14, miceCollision=false})
          tfm.exec.addPhysicObject(xx*6+6+1000, 200 + (xx * 50), 50, {type=13, width=19, mass=999999, color=cor[vez], dynamic=true, miceCollision=false, foreground=true})
          verificaVitoria(vez)
          verificaEmpate()
          passaVez()
        end
      end
    end
  end
end

function eventPlayerLeft(p)
  if jogador[1] == p or jogador[2] == p then
    modo = "fim"
    tempoFim = os.time() + 10000
  end
end

function eventLoop(current, remaining)
  if modo == "fim" and os.time() > tempoFim then
    eventChatCommand(adm, "new")
  elseif modo == "partida" then
    if os.time() > tempoJogada then
      autoPlay()
    end
  end
end
for i, v in pairs(tfm.get.room.playerList) do
  tfm.exec.setPlayerScore(i, 0, false)
end
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoNewGame(true)
e = math.random(#piso)
tfm.exec.newGame(string.format(code, piso[e].id, piso[e].f, piso[e].r, piso[e].id, piso[e].f, piso[e].r))

--system.newTimer(function()
--	tfm.exec.chatMessage("<rose>o evento is coming...")
--	system.newTimer(system.exit, 1000, false)
--end, 60000*20, false)