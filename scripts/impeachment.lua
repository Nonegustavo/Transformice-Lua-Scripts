_sim = 0
_nao = 0

jogador = {}

function atualizaImpeachment(p)
	ui.addTextArea(0, "", p, 5, 10, 790, 20, 0xff3333, 0xff3333, 1, true)
	if _sim+_nao > 0 then
		ui.addTextArea(1, "", p, 5, 10, 790*(_sim/(_sim+_nao)), 20, 0x33ff33, 0x33ff33, 1, true)
	else
		ui.addTextArea(1, "", p, 5, 10, 790*0.5, 20, 0x33ff33, 0x33ff33, 1, true)
	end
	ui.addTextArea(2, "<font size='15px' color='#33ff33'>SIM: ".._sim, p, 0, 40, 100, nil, 0, 0, 0, true)
	ui.addTextArea(3, "<p align='right'><font size='15px' color='#ff3333'>NÃO: ".._nao, p, 700, 40, 100, nil, 0, 0, 0, true)
end

function eventPlayerWon(p)
	local txt = {"impeachment?", "impitma?", "impich?", "empitman?", "emptim?", "imptimão?"}
	ui.addPopup(0, 1, "<p align='center'><font size='20px'>"..txt[math.random(#txt)], p, 300, 200, 200, true)
end

function eventPopupAnswer(id, p, msg)
	if msg == "yes" then
		_sim = _sim + 1
		jogador[p] = "sim"
	else
		_nao = _nao + 1
		jogador[p] = "nao"
	end
	atualizaImpeachment()
end

function eventPlayerRespawn(p)
	if jogador[p] then
		tfm.exec.setNameColor(p, jogador[p] == "sim" and 0x33ff33 or 0xff3333)
	end
end

function eventNewGame()
	for i, v in pairs(jogador) do
		if v == "sim" then
			tfm.exec.setNameColor(i, 0x33ff33)
		else
			tfm.exec.setNameColor(i, 0xff3333)
		end
	end
end

function eventNewPlayer(p)
	atualizaImpeachment(p)
end

atualizaImpeachment()