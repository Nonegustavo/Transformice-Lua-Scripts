image = {"15ef8a9af77.png","15ef8aaa9c6.png","15ef8ab01f6.png","15ef8abd01f.png","15ef8ac0c82.png","15ef8ac9b50.png","15ef8accd61.png","15ef8ad03ec.png","15ef8ad2e52.png","15ef8ad5ba3.png","15ef8ad8721.png","15ef8add6f9.png"}
--image = {"f01vYls.png","1uYSSl9.png","EwIle2P.png","AyByOFD.png","QQBEDLC.png","xLG4k3N.png","LiRkMUm.png","WBkZwKE.png","YuE4kKU.png","lTSo9SL.png","2GcDbSQ.png","HQU6jUc.png"}
image2 = {"ONIfKBb.png","yPXrs0r.png","2KjGHlb.png","begI4NH.png","K32ta5f.png","Dv2U72x.png","xwTa8NL.png","BJij5zD.png","4pR5Nu2.png","wH5VRfl.png","4x7XYBf.png","Rz86ckm.png"}
--rato = {"abE0j0k.png", "qT8ibjQ.png", "uzjOgja.png", "HoIsMbt.png"}
rato = {"DND6ayY.png","5mSCFyR.png","DiyYcfu.png","0b5wSAN.png","dHO1vHz.png","XvIYHwt.png","ElBLzWY.png","1ty9AiR.png","gylz4T3.png","9ky5p2T.png","NVWpXWw.png","RSTmiyo.png","VgbMNxB.png","6VOd83F.png","Ff3O6m6.png","7JKqhqE.png","Oe6cg14.png","Mfoa3mA.png","fnyDLuw.png","uNJ6KuF.png","5JVKiRr.png","XuYKBQq.png","1RWrj7j.png","SlA8l4Z.png"}
--image = {"DND6ayY.png","5mSCFyR.png","DiyYcfu.png","0b5wSAN.png","dHO1vHz.png","XvIYHwt.png","ElBLzWY.png","1ty9AiR.png","gylz4T3.png","9ky5p2T.png","NVWpXWw.png","RSTmiyo.png","VgbMNxB.png","6VOd83F.png","Ff3O6m6.png","7JKqhqE.png","Oe6cg14.png","Mfoa3mA.png","fnyDLuw.png","uNJ6KuF.png","5JVKiRr.png","XuYKBQq.png","1RWrj7j.png","SlA8l4Z.png"}
backgrounds = {'Ws74lpH.jpg','rVba0tw.png','gOsSufX.png','T42YgBB.png'}
mapa = {110,111,112,113}
tfm.exec.disableAutoNewGame(true)
shaman = ""
jogador={}
poca={}
for i, v in pairs(tfm.get.room.playerList) do
	jogador[i] = false
end

function addpoca(X, Y)
	table.insert(poca, {x=X, y=Y})
end

function eventPlayerDied(p)
	if tfm.get.room.playerList[p].y < 390 then
		tfm.exec.addImage(image[math.random(#image)], "?1", tfm.get.room.playerList[p].x - 40, tfm.get.room.playerList[p].y - 50, nil)
		tfm.exec.addImage(image[math.random(#image)], "?1", tfm.get.room.playerList[p].x - 60, tfm.get.room.playerList[p].y - 50, nil)
		tfm.exec.addImage(image[math.random(#image)], "?1", tfm.get.room.playerList[p].x - 50, tfm.get.room.playerList[p].y - 40, nil)
		tfm.exec.addImage(image[math.random(#image)], "?1", tfm.get.room.playerList[p].x - 50, tfm.get.room.playerList[p].y - 60, nil)
		addpoca(tfm.get.room.playerList[p].x - 40, tfm.get.room.playerList[p].y - 50)
	end
	jogador[p] = false
end

function todosMortos()
	for i, v in pairs(tfm.get.room.playerList) do
		if not v.isDead then
			return false
		end
	end
	return true
end

function eventNewGame()
	tfm.exec.addImage(backgrounds[math.random(#backgrounds)], "?0", 0, 0, nil)
	for i=1, #poca do
		table.remove(poca)
	end
	for i, v in pairs(tfm.get.room.playerList) do
		if v.isShaman then
			tfm.exec.setPlayerScore(i, 0, false)
			shaman = i
		else
			--tfm.exec.addImage(rato[math.random(#rato)], "%"..i, -20, -25, nil)
			--tfm.exec.addImage(rato[math.random(#rato)], "%"..i, -50, -50, nil)
		end
		jogador[i] = false
		tfm.exec.setNameColor(i, 0x5555ff)
	end
	
end
num = false

function eventChatCommand(p, cmd)
	if cmd == "help" or cmd == "ajuda" then
		tfm.exec.chatMessage("<r>Nada poderá ajudar você.", p)
	else
		tfm.exec.chatMessage("<j>Comando inválido. Digite !help para ajuda.", p)
	end
end

function sujo(p)
	for i, v in pairs(poca) do
		if tfm.get.room.playerList[p].x > v.x and tfm.get.room.playerList[p].x < v.x+40 and tfm.get.room.playerList[p].y > v.y and tfm.get.room.playerList[p].y < v.y+40 then
			return true
		end
	end
	return false
end

function eventLoop(current, remaining)
	--if num < 3 then
	--	verm = true
	--else
	--	verm = false
	--end
	--if verm then
	--	ui.addTextArea(0, "", shaman, -1500, -1500, 4500, 4500, 0xff0000, 0, 0.3, true)
	--else
	--	ui.addTextArea(0, "", shaman, -1500, -1500, 4500, 4500, 0xaa0000, 0, 0.3, true)
	--end
	if todosMortos() or remaining < 0 then
		tfm.exec.newGame("#10")
	else
		for i, v in pairs(tfm.get.room.playerList) do
			if sujo(i) and current > 3000 then
				jogador[i] = true
			end
			if jogador[i] then
				tfm.exec.addImage(image[math.random(#image)], "?1", tfm.get.room.playerList[i].x - 50, tfm.get.room.playerList[i].y - 50, nil)
				tfm.exec.setNameColor(i, 0xaa0000)
			end
		end
	end
end

function eventNewPlayer(p)
	jogador[p] = false
end

function eventPlayerLeft(p)
	jogador[p] = nil
end

tfm.exec.newGame("#10")