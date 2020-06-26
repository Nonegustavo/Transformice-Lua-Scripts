tfm.exec.disableAutoScore()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableAfkDeath()
system.disableChatCommandDisplay()

MAP = "@7708164"

LANG = {
	br = {
		WIN = "%s venceu!",
		HELP1 = "Cada jogador, na sua vez, posiciona uma peça no tabuleiro.",
		HELP2 = "A partir do terceiro turno, você pode mover as suas peças pelo tabuleiro.",
		HELP3 = "Cada peça se move de uma forma diferente. Além disso, você pode mover uma peça sua para uma casa ocupada por uma peça inimiga para capturá-la.",
		HELP4 = "Peças capturadas são colocadas de volta na base e elas podem ser colocadas em qualquer lugar vazio do tabuleiro, assim como no começo do jogo.",
		HELP5 = "A torre pode se mover verticalmente ou horizontalmente, quantos espaços quiser.",
		HELP6 = "O bispo pode se mover na diagonal quantos espaços quiser.",
		HELP7 = "O cavalo se move em formato de L (1 espaço para um lado e 2 para o outro)",
		HELP8 = "Já o peão pode se mover apenas numa direção, uma casa de cada vez. É sempre a direção oposta a do jogador que posicionou a peça.",
		HELP9 = "Se o peão alcançar o outro lado do tabuleiro, ele passa a se mover para o lado oposto.",
		HELP10 = "Peões NÃO podem capturar peças que estão na frente dele! Ele apenas pode capturar peças que estão na diagonal.",
		HELP11 = "Vence o jogo aquele que conseguir formar uma linha, coluna ou diagonal usando as 4 peças!",
		CLOSE = "Fechar",
		NEXT = "Avançar",
		PREVIOUS = "Voltar",
	},
	en = {
		WIN = "%s won!",
		HELP1 = "Each player, in turn, places a piece on the board.",
		HELP2 = "From the third turn, you can move your pieces around the board.",
		HELP3 = "Each piece moves in a different way. In addition, you can move a piece of yours to a square occupied by an enemy piece to capture it.",
		HELP4 = "Captured pieces are placed back on the base and they can be placed anywhere empty on the board, just like at the beginning of the game.",
		HELP5 = "The rook can move vertically or horizontally, as many spaces as you want.",
		HELP6 = "The bishop can move diagonally as many spaces as you want.",
		HELP7 = "The knight moves in an L shape (1 space to one side and 2 to the other)",
		HELP8 = "The pawn can only move in one direction, one square at a time. It is always the opposite direction of the player who positioned the piece.",
		HELP9 = "If the pawn reaches the other side of the board, it can move to the opposite side.",
		HELP10 = "Pawns CANNOT capture pieces that are in front of him! It can only capture pieces that are diagonal.",
		HELP11 = "Whoever manages to form a line, column or diagonal using the 4 pieces wins the game!",
		CLOSE = "Close",
		NEXT = "Next",
		PREVIOUS = "Previous",
	},
}

function translate(k)
	-- Retorna o texto correspondente à comunidade do jogador fornecido, requer tabela LANG
	-- -- String p = nome de um jogador
	-- -- Return = String
  local cmm = tfm.get.room.community
	cmm = LANG[cmm] and cmm or "en"
	return LANG[cmm] and LANG[cmm][k] or LANG.en[k] or ("$" .. k)
end

window = {
  w = {},
  open = function(p, id, ...)
    local w = window.w
    if p and id and w[id] and not window.isOpened(p, id) then
      w[id].player[p] = {}
      w[id].player[p].fixed = w[id].player[p].fixed or w[id].open(p, id, ...)
      w[id].player[p].dynamic = w[id].player[p].dynamic or (w[id].update and w[id].update(p, id, ...))
    end
  end,
  close = function(p, id)
    local w = window.w
    if p and id and w[id] and w[id].player[p] then
      if w[id].player[p].fixed then
        for i, v in pairs(w[id].player[p].fixed.img or {}) do
          tfm.exec.removeImage(v)
        end
        for i, v in pairs(w[id].player[p].fixed.txt or {}) do
          ui.removeTextArea(v, p)
        end
      end
      if w[id].player[p].dynamic then
        for i, v in pairs(w[id].player[p].dynamic.img or {}) do
          tfm.exec.removeImage(v)
        end
        for i, v in pairs(w[id].player[p].dynamic.txt or {}) do
          ui.removeTextArea(v, p)
        end
      end
      w[id].player[p] = nil
    end
  end,
  update = function(p, id, ...)
    local w = window.w
    if p and id and w[id] and w[id].player[p] then
      if w[id].update then
        if w[id].player[p].dynamic then
          for i, v in pairs(w[id].player[p].dynamic.img or {}) do
            tfm.exec.removeImage(v)
          end
          for i, v in pairs(w[id].player[p].dynamic.txt or {}) do
            ui.removeTextArea(v, p)
          end
          w[id].player[p].dynamic = nil
        end
       w[id].player[p].dynamic = w[id].update(p, id, ...)
      else
        window.close(p, id)
        window.open(p, id, ...)
      end
    end 
  end,
  isOpened = function(p, id)
    local w = window.w
    return w[id] and w[id].player[p] and true or false
  end,
  create = function(id, func, func2)
    local w = window.w
    if w[id] then
      for i, v in pairs(w[id].player) do
        window.close(i, id)
      end
    end
    if id and func then
      w[id] = {
        open = func,
        update = func2,
        player = {}
      }
    end
  end
}

PIECE = {
	pawn = {
		move = function(board, piece)
			local x = piece.x + piece.side
			local choices = {}
			-- próximo espaço livre?
			if board[x][piece.y].piece == "none" then
				table.insert(choices, {['x']=x, y=piece.y})
			end
			-- diagonais ocupadas por inimigos?
			if board[x][piece.y-1]
			and board[x][piece.y-1].piece ~= "none"
			and board[x][piece.y-1].n ~= piece.n then
				table.insert(choices, {['x']=x, y=piece.y-1})
			end
			if board[x][piece.y+1]
			and board[x][piece.y+1].piece ~= "none"
			and board[x][piece.y+1].n ~= piece.n then
				table.insert(choices, {['x']=x, y=piece.y+1})
			end
			return choices
		end,
		img = {"1718fc908d5.png", "1718fcaddc5.png"},
		pos = {x = 0, y = 0}
	},
	rook = {
		move = function(board, piece)
			local choices = {}
			local test = {{x=0, y=-1}, {x=0, y=1}, {x=1, y=0}, {x=-1, y=0}}
			-- testar para cada lado
			for _, v in pairs(test) do
				for i=1, 3 do
					-- está no tabuleiro?
					if board[piece.x+v.x*i] and board[piece.x+v.x*i][piece.y+v.y*i] then
						-- espaço vazio?
						if board[piece.x+v.x*i][piece.y+v.y*i].piece == "none" then
							table.insert(choices, {x=piece.x+v.x*i, y=piece.y+v.y*i})
						-- espaço ocupado por inimigo?
						elseif board[piece.x+v.x*i][piece.y+v.y*i].n ~= piece.n then
							table.insert(choices, {x=piece.x+v.x*i, y=piece.y+v.y*i})
							break
						else
							break
						end
					else
						break
					end
				end
			end
			return choices
		end,
		img = {"1718fc92eab.png", "1718fcb0aaf.png"},
		pos = {x = 80, y = 0}
	},
	bishop = {
		move = function(board, piece)
			local choices = {}
			local test = {{x=-1, y=-1}, {x=-1, y=1}, {x=1, y=-1}, {x=1, y=1}}
			-- testar para cada lado
			for _, v in pairs(test) do
				for i=1, 3 do
					-- está no tabuleiro?
					if board[piece.x+v.x*i] and board[piece.x+v.x*i][piece.y+v.y*i] then
						-- espaço vazio?
						if board[piece.x+v.x*i][piece.y+v.y*i].piece == "none" then
							table.insert(choices, {x=piece.x+v.x*i, y=piece.y+v.y*i})
						-- espaço ocupado por inimigo?
						elseif board[piece.x+v.x*i][piece.y+v.y*i].n ~= piece.n then
							table.insert(choices, {x=piece.x+v.x*i, y=piece.y+v.y*i})
							break
						else
							break
						end
					else
						break
					end
				end
			end
			return choices
		end,
		img = {"1718fc94f75.png", "1718fcb28ca.png"},
		pos = {x = 0, y = 80}
	},
	knight = {
		move = function(board, piece)
			local choices = {}
			local test = {
				{x=-1, y=-2}, {x=-1, y=2},
				{x=1, y=-2}, {x=1, y=2},
				{x=-2, y=-1}, {x=-2, y=1},
				{x=2, y=-1}, {x=2, y=1}
			}
			-- para cada possibilidade
			for _, v in pairs(test) do
				-- espaço vazio ou pelo menos ocupado por inimigo?
				if board[piece.x+v.x] and board[piece.x+v.x][piece.y+v.y] 
				and (board[piece.x+v.x][piece.y+v.y].piece == "none"
				or board[piece.x+v.x][piece.y+v.y].n ~= piece.n) then
					table.insert(choices, {x=piece.x+v.x, y=piece.y+v.y})
				end
			end
			return choices
		end,
		img = {"1718fc97423.png", "1718fcb46da.png"},
		pos = {x = 80, y = 80}
	},
}

ROUND = {
}

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

function setRound()
	ui.removeTextArea(0)
	ui.removeTextArea(1)
	ui.removeTextArea(2)
	ROUND = {}
	-- 4 linhas, 4 colunas
	ROUND.time = 0
	ROUND.turn = math.random(2)
	ROUND.images = {}
	ROUND.board = {}
	ROUND.state = "WAIT"
	for i=1, 4 do
		ROUND.board[i] = {}
		for j=1, 4 do
			ROUND.board[i][j] = {piece = "none", x=i, y=j}
		end
	end
	ROUND.player = {
		{
			name = "",
			color = 0x98E2EB,
			img = "1718fdb3b8d.png",
			sit = false,
			select = false,
			choices = false,
			piece = {
				pawn = false,
				rook = false,
				bishop = false,
				knight = false
			},
		},
		{
			name = "",
			color = 0xFEB1FC,
			img = "1718fdb8336.png",
			sit = false,
			select = false,
			choices = false,
			piece = {
				pawn = false,
				rook = false,
				bishop = false,
				knight = false
			},
		},
	}
	tfm.exec.newGame(MAP)
	for i, v in pairs(tfm.get.room.playerList) do
		eventNewPlayer(i)
	end
end

function playerSit(name, chair)
	if ROUND.state ~= "WAIT" or ROUND.player[chair].sit then 
		return false
	end
	ROUND.player[chair].name = name
	ROUND.player[chair].sit = true
	tfm.exec.setNameColor(name, ROUND.player[chair].color)
	tfm.exec.addImage(ROUND.player[chair].img, "$"..name, -12, -95)
	if ROUND.player[1].sit and ROUND.player[2].sit then
		startGame()
	end
end

function drawPieces(p)
	if not p then
		for i, v in pairs(ROUND.images) do
			tfm.exec.removeImage(v)
		end
		ROUND.images = {}
	end
	for i=1, 2 do
		for j, v in pairs(PIECE) do
			local x = (-550 + i * 580) + v.pos.x
			local y = 40 + v.pos.y
			if ROUND.player[i].piece[j] then
				x = 160 + ROUND.player[i].piece[j].x * 80
				y = -40 + ROUND.player[i].piece[j].y * 80
			end
			table.insert(ROUND.images, tfm.exec.addImage(v.img[i], "_1000", x, y, p))
		end
	end
end

function updateLink(n)
	removeLink(n)
	local id = 1
	for i, v in pairs(PIECE) do
		local x = (-550 + n * 580) + v.pos.x
		local y = 40 + v.pos.y
		if ROUND.player[n].piece[i] then
			x = 160 + ROUND.player[n].piece[i].x * 80
			y = -40 + ROUND.player[n].piece[i].y * 80
		end
		if not ROUND.player[n].piece[i] or ROUND.time > 6 then
			if i == ROUND.player[n].select then
				addSquare(id, ROUND.player[n].color, ROUND.player[n].name, x, y, 80, 80)
				id = id + 1
			end
			addLink(id, "select "..i, ROUND.player[n].name, x, y, 80, 80)
			id = id + 1
		end
	end
	if ROUND.player[n].select then
		for i, v in pairs(ROUND.player[n].choices) do
			local x = 160 + v.x * 80
			local y = -40 + v.y * 80
			local txt = string.format("move %s %s %s", ROUND.player[n].select, v.x, v.y)
			if ROUND.board[v.x][v.y].piece == "none" then
				addSquare(id,0xf0a78e, ROUND.player[n].name, x+20, y+20, 40, 40)
			else
				addSquare(id,0xf0a78e, ROUND.player[n].name, x, y, 80, 80)
			end
			id = id + 1
			addLink(id, txt, ROUND.player[n].name, x, y, 80, 80)
			id = id + 1
		end
	end
end

function removeLink(n)
	for i=1, 40 do
		ui.removeTextArea(i, ROUND.player[n].name)
	end
end

function addLink(id, cmd, p, x, y, width, height)
	ui.addTextArea(id, "<p align='right'><a href='event:"..cmd.."'> "..string.rep("\n", math.ceil(height/20)), p, x+5, y+5, width-10, height-10, 0, 0, 0, false)
end

function addSquare(id, color, p, x, y, width, height)
	ui.addTextArea(id, "", p, x+5, y+5, width-10, height-10, -1, color, 1, false)
end

function effect(x1, y1, x2, y2)
  --local fx = {red=13, blue=1, yellow=11, green=9, black=1}
  --local color = fx[ROUND.topCard.card[1]]
	x1 = 200 + x1 * 80
	y1 = 0 + y1 * 80
	x2 = 200 + x2 * 80
	y2 = 0 + y2 * 80
	
	local xmax = x2 - x1
	local ymax = y2 - y1
  local dist = math.ceil(math.sqrt(math.pow(xmax,2)+math.pow(ymax,2))/10)
  local qtd = dist
  for i=0, qtd do
    local x = x1 + xmax*(i/qtd)
    local y = y1 + ymax*(i/qtd)
    tfm.exec.displayParticle(0, x+math.random(-8,8), y+math.random(-8,8), 0, 0, 0, 0, nil)
  end
end

function explosion(id, x, y, vezes, vel)
  -- faz uma mini explosão de partículas
  -- -- Number id = id das partículas
  -- -- Number x = coordenada x do centro
  -- -- Number y = coordenada y do centro
  -- -- Number vezes = número de partículas
  -- -- Number vel = velocidade máxima
	x = 200 + x * 80
	y = 0 + y * 80
  for i=1, vezes do
    tfm.exec.displayParticle(id, x, y, math.random(-vel,vel)/10, math.random(-vel,vel)/10, 0, 0)
	end
end

function selectPiece(n, piece)
	if ROUND.player[n].select == piece then
		deselect(n)
		return false
	end
	
	if ROUND.player[n].piece[piece] then
		ROUND.player[n].choices = PIECE[piece].move(ROUND.board, ROUND.board[ROUND.player[n].piece[piece].x][ROUND.player[n].piece[piece].y])
	else
		ROUND.player[n].choices = emptySpaces()
	end
	ROUND.player[n].select = piece
	updateLink(n)
end

function emptySpaces()
	local choices = {}
	for i=1, 4 do
		for j=1, 4 do
			if ROUND.board[i][j].piece == "none" then
				table.insert(choices, {x=i, y=j})
			end
		end
	end
	return choices
end

function deselect(n)
	ROUND.player[n].select = false
	updateLink(n)
end

function movePiece(n, piece, x, y)
	if ROUND.player[n].select ~= piece then
		return false
	end
	local ok = false
	for i, v in pairs(ROUND.player[n].choices) do
		if v.x == x and v.y == y then
			ok = true
			break
		end
	end
	if not ok then
		return false
	end
	
	killPiece(x, y)
	if ROUND.player[n].piece[piece] then
		ROUND.board[ROUND.player[n].piece[piece].x][ROUND.player[n].piece[piece].y].piece = "none"
		ROUND.board[ROUND.player[n].piece[piece].x][ROUND.player[n].piece[piece].y].n = false
		effect(ROUND.player[n].piece[piece].x, ROUND.player[n].piece[piece].y, x, y)
	else
		explosion(0, x, y, 10, 20)
	end
	ROUND.board[x][y].player = ROUND.player[n].name
	ROUND.board[x][y].piece = piece
	ROUND.board[x][y].n = n
	if piece == "pawn" then
		if ROUND.player[n].piece[piece] then
			if x == 4 then
				ROUND.board[x][y].side = -1
			elseif x == 1 then
				ROUND.board[x][y].side = 1
			else
				ROUND.board[x][y].side = ROUND.board[ROUND.player[n].piece[piece].x][ROUND.player[n].piece[piece].y].side
			end
		else
			if x == 4 then
				ROUND.board[x][y].side = -1
			elseif x == 1 then
				ROUND.board[x][y].side = 1
			else
				ROUND.board[x][y].side = n == 1 and 1 or -1
			end
		end
	end
	ROUND.player[n].piece[piece] = {['x']=x, ['y']=y}
	ROUND.player[n].select = false
	removeLink(n)
	local win = isWin(n, x, y)
	if win then
		endGame(ROUND.player[n].name, win, ROUND.player[n].color)
	else
		passTurn()
	end
end

function killPiece(x, y)
	local piece = ROUND.board[x][y].piece
	local n = ROUND.board[x][y].n
	if piece == "none" then
		return false
	end
	explosion(3, x, y, 10, 20)
	ROUND.player[n].piece[piece] = false
	ROUND.board[x][y].piece = "none"
end

function passTurn()
	drawPieces()
	ROUND.turn = ROUND.turn == 2 and 1 or 2
	ROUND.time = ROUND.time + 1
	tfm.exec.addPhysicObject(1, 400, 35, {type=12, width=320, height=10, color=ROUND.player[ROUND.turn].color, groundCollision=false, miceCollision=false})
	updateLink(ROUND.turn)
end

function startGame()
	ROUND.state = "PLAY"
	passTurn()
end

function isWin(n, x, y)
	local h = 0
	local v = 0
	local d1 = 0
	local d2 = 0
	for i=1, 4 do
		if ROUND.board[i][y].n == n then
			h = h + 1
		end
	end
	if h == 4 then
		return {{x=1, y=y}, {x=4, y=y}}
	end
	for i=1, 4 do
		if ROUND.board[x][i].n == n then
			v = v + 1
		end
	end
	if v == 4 then
		return {{x=x, y=1}, {x=x, y=4}}
	end
	for i=1, 4 do
		if ROUND.board[i][i].n == n then
			d1 = d1 + 1
		end
	end
	if d1 == 4 then
		return {{x=1, y=1}, {x=4, y=4}}
	end
	for i=1, 4 do
		if ROUND.board[i][5-i].n == n then
			d2 = d2 + 1
		end
	end
	if d2 == 4 then
		return {{x=1, y=4}, {x=4, y=1}}
	end
end

function endGame(p, win, color)
	win[1].x = 200 + win[1].x * 80
	win[1].y = 0 + win[1].y * 80
	win[2].x = 200 + win[2].x * 80
	win[2].y = 0 + win[2].y * 80
	tfm.exec.addJoint(8000, 1, 1, {point1=win[1].x..","..win[1].y, point2=win[2].x..","..win[2].y, color=color, line=4, foreground=true})
	ui.addTextArea(0, "", nil, 0, 0, 800, 400, 1, 1, 0.3)
	ui.addTextArea(1, string.format("<p align='center'><font size='30px' color='#%x'>"..translate("WIN"), color, p), nil, 0, 180, 800, nil, 0, 0, 0)
	drawPieces()
	ROUND.state = "END"
	ROUND.timer = os.time() + 10000
end

function eventNewPlayer(p)
	if ROUND.state == "PLAY" then
		drawPieces(p)
	end
	ui.addTextArea(-1, "<p align='center'><a href='event:help 1'>?", p, 5, 20, 20)
	system.bindKeyboard(p, 32, true, true)
	system.bindKeyboard(p, 3, true, true)
	tfm.exec.respawnPlayer(p)
end

function eventPlayerDied(p)
	tfm.exec.respawnPlayer(p)
end

function eventPlayerRespawn(p)
	for i=1, 2 do
		if ROUND.player[i].name == p then
			tfm.exec.setNameColor(p, ROUND.player[i].color)
			tfm.exec.addImage(ROUND.player[i].img, "$"..p, -12, -95)
			break
		end
	end
end

function eventPlayerLeft(p)
	for i=1, 2 do
		if ROUND.player[i].name == p then
			setRound()
			break
		end
	end
end

function eventKeyboard(p, k, d, x, y)
	if x > 40 and x < 80 then
		playerSit(p, 1)
	elseif x > 720 and x < 760 then
		playerSit(p, 2)
	end
end

function eventTextAreaCallback(id, p, cmd)
	local arg = split(cmd, " ")
	if arg[1] == "select" then
		selectPiece(ROUND.turn, arg[2])
	elseif arg[1] == "move" then
		movePiece(ROUND.turn, arg[2], tonumber(arg[3]), tonumber(arg[4]))
	elseif arg[1] == "help" then
		if window.isOpened(p, "HELP") then
			window.update(p, "HELP", arg[2] and tonumber(arg[2]) or 1)
		else
			window.open(p, "HELP", arg[2] and tonumber(arg[2]) or 1)
		end
	elseif arg[1] == "close" then
		window.close(p, "HELP")
	end
end

function eventLoop(current, remaining)
	if ROUND.state == "END" then
		if os.time() > ROUND.timer then
			setRound()
			return false
		end
		ui.addTextArea(2, string.format("<p align='center'><font size='30px'><j>%s", math.floor((ROUND.timer-os.time())/1000)), nil, 0, 40, 800, nil, 0, 0, 0)
	end
end

window.create("HELP", function(p, id, page)
  local x = 150
  local y = 50
  local width = 500
  local height = 320
  -- janela
	ui.addTextArea(100, "", p, x, y, width, height, 0x573926, 0x573926, alpha, true)
	ui.addTextArea(101, "", p, x+1, y+1, width-2, height-2, 0x8a583c, 0x8a583c, alpha, true)
	ui.addTextArea(102, "", p, x+3, y+3, width-6, height-6, 0x2b1f19, 0x2b1f19, alpha, true)
	ui.addTextArea(103, "", p, x+4, y+4, width-8, height-8, 0xc191c, 0xc191c, alpha, true)
	ui.addTextArea(104, "", p, x+5, y+5, width-10, height-10, 0x2d5a61, 0x2d5a61, alpha, true)
	ui.addTextArea(105, "", p, x+5, y+6, width-10, height-12, 0x142b2e, 0x142b2e, alpha, true)
  -- botão fechar
  ui.addTextArea(106, "", p, x+8, y+height-22, width-16, 13, 0x7a8d93, 0x7a8d93, alpha, true)
	ui.addTextArea(107, "", p, x+9, y+height-21, width-16, 13, 0xe1619, 0xe1619, alpha, true)
	ui.addTextArea(108, "", p, x+9, y+height-21, width-17, 12, 0x314e57, 0x314e57, alpha, true)
	ui.addTextArea(109, "<p align='center'>"..translate("CLOSE"), p, x+9, y+height-24, width-17, nil, 0x314e57, 0x314e57, 0, true)
  ui.addTextArea(120, "<p align='right'><a href='event:close'> ", p, x+9, y+height-24, width-17, nil, 0, 0, 0, true)
  -- título da janela
  --ui.addTextArea(119, "<p align='center'><font size='25px'><j><b>"..translate(p, "RULES"), p, x+10, y+10, width-20, nil, 0, 0, 0, true)
  -- bordas
	local imageId = {}
	table.insert(imageId, tfm.exec.addImage("155cbe97a3f.png", "&1", x-7, (y+height)-22, p))
	table.insert(imageId, tfm.exec.addImage("155cbe99c72.png", "&1", x-7, y-7, p))
	table.insert(imageId, tfm.exec.addImage("155cbe9bc9b.png", "&1", (x+width)-20, (y+height)-22, p))
	table.insert(imageId, tfm.exec.addImage("155cbea943a.png", "&1", (x+width)-20, y-7, p))
  return {txt={100,101,102,103,104,105,106,107,108,109,120},img=imageId}
end,
function(p, id, page)
  local x = 150
  local y = 50
  local width = 500
  local height = 320
  local key = {"HELP1", "HELP2", "HELP3", "HELP4", "HELP5", "HELP6", "HELP7", "HELP8", "HELP9", "HELP10", "HELP11"}
	local imageHelp = {"17194c20880.png", "17194c23104.png", "17194c24f4c.png", "17194c26ccc.png", "17194c289fe.png", "17194c2b3fc.png", "17194c2d003.png", "17194c2e9da.png", "17194c303ba.png", "17194c3223d.png", "17194c3400a.png"}
  if page > 1 then
    -- botão de voltar
    local y = y - 25
    ui.addTextArea(110, "", p, x+8, y+height-22, width/2-16, 13, 0x7a8d93, 0x7a8d93, alpha, true)
    ui.addTextArea(111, "", p, x+9, y+height-21, width/2-16, 13, 0xe1619, 0xe1619, alpha, true)
    ui.addTextArea(112, "", p, x+9, y+height-21, width/2-17, 12, 0x314e57, 0x314e57, alpha, true)
    ui.addTextArea(113, string.format("<p align='center'>%s", translate("PREVIOUS")), p, x+9, y+height-24, width/2-17, nil, 0x314e57, 0x314e57, 0, true)
    ui.addTextArea(121, string.format("<p align='right'><a href='event:help %s'> ", page-1), p, x+9, y+height-24, width/2-17, nil, 0, 0, 0, true)
  end
  if page < #key then
    -- botão de avançar
    local y = y - 25
    ui.addTextArea(114, "", p, x+8+width/2, y+height-22, width/2-16, 13, 0x7a8d93, 0x7a8d93, alpha, true)
    ui.addTextArea(115, "", p, x+9+width/2, y+height-21, width/2-16, 13, 0xe1619, 0xe1619, alpha, true)
    ui.addTextArea(116, "", p, x+9+width/2, y+height-21, width/2-17, 12, 0x314e57, 0x314e57, alpha, true)
    ui.addTextArea(117, string.format("<p align='center'>%s", translate("NEXT")), p, x+9+width/2, y+height-24, width/2-17, nil, 0x314e57, 0x314e57, 0, true)
    ui.addTextArea(122, string.format("<p align='right'><a href='event:help %s'> ", page+1), p, x+9+width/2, y+height-24, width/2-17, nil, 0, 0, 0, true)
  end
	local imageId = {}
	table.insert(imageId, tfm.exec.addImage(imageHelp[page], "&1", x+20, y+20, p))
  ui.addTextArea(118, "<p align='center'>"..translate(key[page]), p, x+20, y+225, width-40, nil, 0, 0, 0, true)
  return {txt={110,111,112,113,114,115,116,117,118,121,122},img=imageId}
end)

setRound()