listaPontos = {}
listaModos = {"ativaSequencia", "ativaBomba"}
mapas = {"@5451839", "@5445849", "@6599901", "@6682692", "@6599901", "@6399897", "@6399005", "@6399011", "@6682692", "@6688767", "@6688796", "@6688811", "@4307527", "@3988493", "@6688829", "@6688837", "@3878013"}
mode = "ativaSequencia"

img = {
		bauFechado = "154ee86870c.png",
		bauAberto = "154ef4078f5.png",
		bomba = "154ef5a69e1.png",
		correto = "154ef5cd11e.png",
		numero = {
			"154ee7ce559.png", "154ee7ea99e.png", "154ee7fe9d5.png", "154ee81e97c.png", "154ee835835.png",
			"154ee83cb70.png", "154ee8451a1.png", "154ee84f2fb.png", "154ee8588a8.png",
		},
	}

function ativaSequencia()
	dadosJogo = {}
	listaJogadores = {}
	tfm.exec.newGame(mapas[math.random(#mapas)])
end

function ativaBomba()
	dadosJogo = {}
	listaJogadores = {}
	tfm.exec.newGame(mapas[math.random(#mapas)])
end

function eventNewGame()
  if mode == "ativaSequencia" then
    if tfm.get.room.xmlMapInfo then
      local qtd = math.random(4,9)
      local pontos = coletaPontos(tfm.get.room.xmlMapInfo.xml)
      dadosJogo.listaPontos = sorteiaPontos(pontos, qtd)
      for i, v in pairs(tfm.get.room.playerList) do
        system.bindKeyboard(i, 32, true, true)
        listaJogadores[i] = {
          score = 1,
          bausColetados = {},
          imgBau = {},
          imgNumero = {},
          delayBotao = os.time() + 3000
        }
        for j=1, qtd do
          listaJogadores[i].imgBau[j] = tfm.exec.addImage(img.bauFechado, "_100", dadosJogo.listaPontos[j].x-20, dadosJogo.listaPontos[j].y-20, i)
          listaJogadores[i].imgNumero[j] = tfm.exec.addImage(img.numero[j], "!100", dadosJogo.listaPontos[j].x-15, dadosJogo.listaPontos[j].y-10, i)
        end
      end
    end
  elseif mode == "ativaBomba" then
    if tfm.get.room.xmlMapInfo then
      local qtd = math.random(8,15)
      local pontos = coletaPontos(tfm.get.room.xmlMapInfo.xml)
      dadosJogo.listaPontos = sorteiaPontos(pontos, qtd)
      maximo = 0
      for i, v in pairs(dadosJogo.listaPontos) do
        v.correto = math.random(1,2) == 1
        if v.correto then
          maximo = maximo + 1
        end
      end
      for i, v in pairs(tfm.get.room.playerList) do
        system.bindKeyboard(i, 32, true, true)
        listaJogadores[i] = {
          score = 0,
          bausColetados = {},
          imgBau = {},
          imgIcone = {},
          delayBotao = os.time() + 3000
        }
        for j=1, qtd do
          listaJogadores[i].imgBau[j] = tfm.exec.addImage(img.bauFechado, "_100", dadosJogo.listaPontos[j].x-20, dadosJogo.listaPontos[j].y-20, i)
          local icone = dadosJogo.listaPontos[j].correto and img.correto or img.bomba
          listaJogadores[i].imgIcone[j] = tfm.exec.addImage(icone, "!100", dadosJogo.listaPontos[j].x-15, dadosJogo.listaPontos[j].y-10, i)
        end
      end
    end
  end
end

function eventKeyboard(p, t, d, x, y)
  if mode == "ativaSequencia" then
    local player = listaJogadores[p]
    if player and player.delayBotao < os.time() then
      player.delayBotao = os.time() + 500
      local coord = dadosJogo.listaPontos[player.score]
      if coord and x > coord.x-20 and x < coord.x+20 and y > coord.y-20 and y < coord.y+20 then
        if player.score == 1 then
          for i, v in pairs(player.imgNumero) do
            tfm.exec.removeImage(v)
            if i>1 then
              for j=1, 10 do
                tfm.exec.displayParticle(3, dadosJogo.listaPontos[i].x, dadosJogo.listaPontos[i].y, math.random(-10,10)/10, math.random(-10,10)/10, 0, 0.01, p)
              end
            end
          end
        end
        for j=1, 20 do
          tfm.exec.displayParticle(11, coord.x, coord.y, math.random(-10,10)/10, math.random(-15,0)/10, 0, 0.01, p)
        end
        tfm.exec.removeImage(player.imgBau[player.score])
        player.imgBau[player.score] = tfm.exec.addImage(img.bauAberto, "_100", coord.x-20, coord.y-20, p)
        player.score = player.score + 1
        if player.score > #dadosJogo.listaPontos then
          tfm.exec.giveCheese(p)
          tfm.exec.playerVictory(p)
        end
      else
        for i=1, 5 do
          tfm.exec.displayParticle(13, x, y, math.random(-5,5)/10, math.random(-5,5)/10, 0, 0, p)
        end
      end
    end
  elseif mode == "ativaBomba" then
    local player = listaJogadores[p]
    if player and player.delayBotao < os.time() and not tfm.get.room.playerList[p].isDead then
      player.delayBotao = os.time() + 500
      local bau = false
      for i, v in pairs(dadosJogo.listaPontos) do
        if x > v.x-20 and x < v.x+20 and y > v.y-20 and y < v.y+20 then
          bau = i
          break
        end
      end
      if bau and not player.bausColetados[bau] then
        if dadosJogo.listaPontos[bau].correto then
          if player.score == 0 then
            for i, v in pairs(player.imgIcone) do
              tfm.exec.removeImage(v)
              if i>1 then
                for j=1, 10 do
                  tfm.exec.displayParticle(3, dadosJogo.listaPontos[i].x, dadosJogo.listaPontos[i].y, math.random(-10,10)/10, math.random(-10,10)/10, 0, 0.01, p)
                end
              end
            end
          end
          local coord = dadosJogo.listaPontos[bau]
          for j=1, 20 do
            tfm.exec.displayParticle(11, coord.x, coord.y, math.random(-10,10)/10, math.random(-15,0)/10, 0, 0.01, p)
          end
          tfm.exec.removeImage(player.imgBau[bau])
          player.imgBau[bau] = tfm.exec.addImage(img.bauAberto, "_100", coord.x-20, coord.y-20, p)
          player.score = player.score + 1
          player.bausColetados[bau] = true
          if player.score >= maximo then
            tfm.exec.giveCheese(p)
            tfm.exec.playerVictory(p)
          end
        else
          tfm.exec.killPlayer(p)
          for i=1, 10 do
            tfm.exec.displayParticle(3, x, y, math.random(-40,40)/10, math.random(-40,40)/10, 0, 0, nil)
          end
          for i=1, 20 do
            tfm.exec.displayParticle(0, x, y, math.random(-40,40)/10, math.random(-40,40)/10, 0, 0, nil)
          end
          for i=1, 20 do
            tfm.exec.displayParticle(11, x, y, math.random(-40,40)/10, math.random(-40,40)/10, 0, 0, nil)
          end
          for i, v in pairs(dadosJogo.listaPontos) do
            if not v.correto then
              listaJogadores[p].imgIcone[i] = tfm.exec.addImage(img.bomba, "!100", v.x-15, v.y-10, p)
            end
          end
        end
      else
        for i=1, 5 do
          tfm.exec.displayParticle(13, x, y, math.random(-5,5)/10, math.random(-5,5)/10, 0, 0, p)
        end
      end
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

function eventLoop(current, remaining)
	if remaining < 0 or todosMortos() then
		novoJogo()
	end
end

function sorteiaPontos(list, n)
	local newList = {}
	local pool = {}
	for i=1, #list do
		table.insert(pool, i)
	end
	for i=1, n do
		table.insert(newList, list[table.remove(pool, math.random(#pool))])
	end
	return newList
end

function coletaPontos(xml)
	local str = xml:match("<O>(.-)</O>") or ""
	local list = {}
	for v in str:gmatch("<O (.-)/>") do
		if v:match('C="(.-)"') == "15" then
			table.insert(list, {
				x = tonumber(v:match('X="(.-)"')),
				y = tonumber(v:match('Y="(.-)"'))
			})
		end
	end
	return list
end

function novoJogo()
  mode = listaModos[math.random(#listaModos)]
  _G[mode]()
end

tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()
--tfm.exec.disableAutoTimeLeft()
novoJogo()