-- Jogo da memória
-- Escrito por Ninguem - Data: 21/09/15

-- Tamanho do tabuleiro
-- -- Ponha pelo menos um número par
-- -- Se quiser tamanho aleatório ponha nil
t1, t2 = 6, 5


start = true
tabuleiro = {}
jogador = {}
tempo = os.time()

imagens = {
"0","0l7dha7jwg","0LkiSmJ9MgT4DpEC5G3kIU4tHFVOxpaBzhPYj7XyL9Q","0r52kx7z7e","0WRRxwKhLUgeO8cT5eJ6iQuvAHGolyBrdosj2zCM9U","1","10","11","12","13","14","15","16","17","18","19","1bmdn2xfe3","1wh7Savw9WT0FLBvBW5Fm4QuOL20KPwqqcyWzoC6i0U","2","20","2000","21","2100","2101","2102","2103","2104","22","2200","2201","23","24","25","26","2f20g04h4","2gadpw47O5uaKQC5g5IdztctbQUzrcrp9onTnmdk2cM","2sp1roej2k","2uiUmXA8sIkyPb1c1kJ6w6i7gnHYfMu8Oc5VzUevwcg","3","30dxX8W05XRWo1NmKCcvFOeFYXLxZCS2kraEleDUYg","33ud0ZXci3buO3ymFkNJx1fGf1ueuYmdO67vbi98D0","3ccsbyvhpz","3mz5qd4z2y","3zmln25hyh","4","43pvoouh93","4bozqopqi5","4s0tu2","5","514gqnn1ms","5d6cb9i08b","5i12KDxD08qPGxnCYA0jjaxAVO8xzsQQMJTvkyrNd8","5UTdCOlQm2xAqz8F8c4tBCSe0Gdfxt3fdjbe5gr6yc","5uvk7ird2s","6","699EkXWpCYe3LPlESNYuKqjpa2pgpbiYmDd6kDx8YQ","6lwapv0kox","6nRd8qAGJGLVy9Y2yopFXyxvYTgb3n8nHMeQtQFI","6zl1JiWlG9OCyrriBsMzD0ia5QiF8S9YvAxWG3FnTXA","7","79kw5CwboMEPcKml0GpCcQ2dXPY7ZDOYgUVnMkTpVg","7DIJOtMaacRkhPNjTnlJLvYOPa8Dv08lsVX4tinhg","8","82yuoxjduv","8EpuLts9LEboiuCmmd8youBAVFnZtC4Z3dxaLJ3m4","8lFGMEhoJVfLQcExQqkw82SmkmMAHmJguAfzipw8aBM","8wj5bxfeb1","8zDx58YZBtldvBLf0rliXN92o2yDJoHdLxJnuFQ","9","96Vj8WDHwhZ3IkUCaiuf8PvnkcqMMhQ3XoQ44xo","9ec28u0en9","9hyr75cSjxb2m3AprvOBWxCMX8W8tkSgzbr9ZaU8A","9RKBXtSbzZY7wZNHdHF8MjpTFNc34zReG23B6P6lbA4","a204204204","A6NTejvUde9zWCh5z05WmjYPb3d6jFkFpH1ppsRSXwQ","aHsNLaHZFPjgxmZ8IIsc3jv4pdPbOReP3GXEICQg0","ax87sag23a","bbjuqm7ljl","bexotv9zrh","bkrb1t5hmv","bl4zmmj3me","buPtPjM7hsVWE1JCKmd0MhjbKvhz7tf88Yd581kg","c2ov7ejhie","c402402402c","ce5oxzhglp","Cf4CoL80oRxwiZApBqEVTBhDicMeVQJyQ9fmZfJyDdo","cGdHynPCHroFFrehfxWh4AOJU5djLfH505IHeckRU","ChIbtHOaeAhxGi3KYuK4WBpHO04dIAi7pVPdZVc7zQk","CIgfMrehmiIaj63gwByoxFsOTLtQD1Z3XF8l8f0ps","cmlbqsw9te","COaQkXxqOrRrFZAZWLaAlxJ4abXuXDNEDknW5zNafIE","crlDpPHdSzwpyARMioyU93vqJ5Q7BUfhXxfpk08NX0","ctehds0xye","CZNLOef8kmUFc9dWQ2IZDxcZvst1eojFkaKGPWIT1Y","dmArdOYFrkvaltGstPFMO4JQbZRrXDt4aDZqSPqKYbg","dutgm5orpb","DVdTfS2ik8vUiOzYeTaTjlATGzkcuQTQOKzlHfkkyyc","e0wCR6i1a3zmPBU9We6pd9mVJJmTZaLQpklAR72IsI","E31T4VaUFehRxjZfvuhioGJM2bigkMyad9DD9txAw8","eff81rwlig","EfTGZt5lhyEOspAXNdrTrPNGDTf5MpRCnCcvqt0I","eL7N3SgFpOxR2fYxQOmCBKdv4zIvcdtTCvrmidyJU","ew93duer51","eyod69sgfz","f204f402f","f8s2pte6ir","fBa7AfOL8KuN50mPAo3obAjh5NHb2Gk8PgqOr40VyTk","FD6Q8lJNpiK33vl9dhGiQiBx3f7TmebdNb6cFDQ7g8","fg6l1hqncq","fgKxUeiHLfEMMc4ojwAlEGnxkkHEpmjzhVnN7Yn5XI","fqyzbydjw5","g0os4wr69m","g5patd5hvb","g75ev2twxd","g76y35nbis","GGf0TYFkxA0PcKR3a0q3BEM7eG2Br65roa70raF6ihY","Gm9BAufh8LGzSzBC7aiCTeYHT9DsZRyAOvXmjjNGw","gQVRUSChjplZIhGuyCdz9tHyMdcNYy0BIkdt2ck4hVk","gS9Og2jgByW6TkJNIehtk4YUHdxc5Vl5wWSCaXsUDmM","h3ddnzmlsf","h6eijakwhk","HBqbuRx5ArdoJOz809pZ9HHcTwFXa7jgK74oy04vJI","HNiGEDvZ3aFP45ay5OaNJIwMgxV5HwnItg7PAdR6F2k","HoXki0OskT5VpFNsk6P0p1ZLXJozE5k6LBgM33OE2Y","I01l2fnq2t30SVxZ75CrLj4C7fH96M2klOiHXEFuU","ik83ur9fbd","ip97ba4tk2","ipgudzyogg","J1m295WzjhdWqb81JdtGOSbibUtRXOmq33VJ3kiThc","j5zr4gorvr","jgkh6sfbs8","JoKxhRIk0e0egPZoNKKgESqoeesZ47DwyjH854JUek","JVopemvVaFPQPXJmN5Q9wq8z5eUxVRPViRY7J0njs","k7q2zb9d1b","KfLJIuw1rwwL5lh8YVy6rctDT83ZzE1AxeSyjhyqE","kQepnZAtTQAFXnR4UsMETR7qgN1iKYnV65L0LMCUd0","ks6QIZKaDmufnQMFnvpJESCIDjXd4RtUxzNOdeWxgU","l3oictwye7","LBFpqgn10T1lNSMa9tlITX1yJlfEiMyvqTAgJjrhv4","lbo8tlpcki","LlhMXnHN9S6UYVZuhzXsiHbLkhIsgKb0APw8qG0","lNKtNCA6wr3SLAe5w5jrSuVZPdZUWZFVhjgbaTWKk","m20402","Mhbi91w1V3iG57Y49rl1ThXgkUI784CKSdMB9b9nomU","MoAb5bYEWJO2IpP7k9GYbd8EsDDyMSJiZSC9KVfxqA","mregotuukq","n4ds62s6i1","NbWYiwXhplR1e3rE0riaheqHoVffjYNShK9zdnZZnNI","njk3z9bnlu","nlYqwmGtZIBbnRkQavZGN259NKSWdHNwrcersknpVQ","nmbm1156u1rXEwNBPDWJDRMl0fzyWZwvV95Lp3zHU","npZ0fohuGfeTn519YlaWV4yfKDAzmuyUbH6qmPE0E","o202044","objdeEAPoVMi058bVlYFsJlqjtkGsn1vWFi1CfhINGo","ok0gtd8qeg","OV7erW0FjFAHHcCWji0xEbu42U1vXVJZGxGvHlDHM","ow2bc4rku0","p2ZElXoNCeLEVfuw5LAZgT0DKQ1WEFkESx5Q6TMjeo","p40jBVwJNCAfvLuAOqVioqbHWgdv1sA3QIGcZqdS6fk","P57Gjs4Rw89wQ8isaia3X7N2csoHnQoEZYIHnhqVI","pgiyiw1x1w","pi6op2gp99","pLmduY5bcSARb78P48gA6HKnLuhYKBJe1WFPRkBWQOE","povqgjlxpv","PxItJf9Eygly0F2l0LZav0MgTvU45sGe7jPJWmojgRQ","q2o6jjjxay","q440022","qQN0cBRbFfNQHDSg1h9Dv9yy1ElDzCHZe9Z3p7XZ2o4","qv5qo1hhsz","qWvDSzkpGqkrnreHWCesVDjgjVjosYIbz81RRjQLVy0","QXAaFrcBovyFpUD2a04BKEzLk2lqYLWzp3vFozn2eFI","rjnfFdqMwxsbP15bR2BEXmiR5UuAosGfc5e77NdTc","roKr8DzoyJmoQ1Z6LW8PTMwuEaHsrBirMy3Cs7vynU","S1sAttWNRMg0zs5JQDknD92C4CI5bxTlFPfGNtmRPU","s2IfI5tSvW5ghPeAPyB32iz5OIBYqCULOOOI7sM4","s7n5wfbvti","S8mRUsPdIPhc5LqEfxS1tP5tOwB0NsQVasy0NjVr0","Se18YNs6V6Ss3tp52AcGFaRgUSWpFuBA0yVMGuuqih0","srk29axDzd1shGgH3syRS2TYJoR0iDK2jR9AAi0yWB0","SSA4n5gwcgXygaWpD6bP7rdrDaHTs9BZEjK0L1ZvDz8","ssrC6Y2LaN1XDvl9WLUPSozl6Q3fzWN7nwxKLmuFRyU","StznjnJGNJP3dhEGSNbedjQQxYVn0krJY9VIuNAd4","T2io2PRTj1jLM63s5oQpfq4nY1T2ACt9oPiCaRcZH6c","T54O5XV0bsQskH0Wo6Z1hNdaXQfzu98UQjOc2jfd8","tag_cadeau","tag_citrouille","tag_craie","tag_oeuf","tfzhcj89vi","tgotwx8x3y","To0HmN4L9XTvqRqSsqnDB0J5nQXtldm5QTTCaK1LI","tUyjLYs7vrFi5u1BXwXnthj9okSpFaorOO5aA6Svc","U20ULGn0opswTDwYlFVrONq6oCm3AjenXseHsxNQHEg","u3niod6Bbc7lD7WgVdzCXmIEZz5mBhxYiED6JIbivGo","U6BRlCKgHEyUeAYHikTzaubpNrSbXUsJQBFqGGWyU","v0Pc3IZXqOJpk3Y0KniIUH5RiPgJ4hSXFuq0MJTXUY0","v474yi4mgc","V81O8HKAs9KCjy36B2HVGNNTm18ncjDCxJyOQxG8","VfgZohcF7SrxhlxxOWYtmJ1gH62JEzmcNyOEuejG8","vq1CNJxAUjx3bLe7Mv2I9wmBYOysnaJtVJjJXbo0","VujTCIIiJyysfZCFfYLjcUPOofoCmvB9Cj61rCE","vx5lklum30","wdJNrAOobBistUcMKykHKjRf9SrgoybOuSdPbbK34c","wgvf9w0l76","wJ0oFf8vYpPgqeCfCHKqnIeXZ78pk6JYS6c0KdEOGw","ws9LkVGU3zpCOPexR4BCCiRV6IJ1dRlE191cBSg5A","x4COVjaFPlajsu74QCdz598pn7jwlXuhmn9LS0ErQ","x74leSJzuhbfdpMy16hPAkyjxKBFiD4o3cu6QCk","x8d0y5yovf","xaEL6bbYCHtZwydYAcD8j6iaD6NiFnDH2XTy0bBc6Ro","XhoRVi2Uf6z2s8R379ax6OWWkTpVhfz5UyIgzZUkDhY","XJZCpcfYG6USKPs5pare2slAx7DFXV0k5mtbvASuVXo","xmy573nxwv","y0MsvgYGN2Xnw0L9DDt79TggVUqIRwEApw7Syl938","y5nrBqYGSVgBHqDMMKToBB4YXZPZLRaqCYcUkSPhI","YbUq2DsYDSRwCFImNXm9sNmd0wMlDD0YrqHmFJF8sGs","YX3w9C6eKKB32tlXXJksjgUED752Jw9ybOhDvMiT4","yy5lgdnb3r","z5k6FofFGNqoLIdPVAgJ1gj8A0lgdUACH89XtAkoA","zcr1t92wm8","ZHEjLkXN56Ak5PHKyrMPK9Wgcihh46cht8XioAm6Q","zkhxx0h2bq","ZO3yexm6s3UBwNIMWKd9voJ8h2QU2kHJYJLcKfSKI","ZoJsUWWAjkjGlJ17FLUtjYgo5AhHof2hZvwDFsOmanA","zsoimp88d6"
}

fundos = {
	"x_deadmeat/x_interfaces/x_login.jpg",
	"x_evenements/x_carnaval2014.jpg",
	"x_evenements/x_fondHalloween.jpg",
	"x_evenements/x_fondNowel2013.jpg",
	"x_evenements/x_fondSVa.jpg",
	"x_transformice/x_connexion/x_cimetiere.jpg",
	"x_transformice/x_connexion/x_indi.jpg",
	"x_transformice/x_connexion/x_noel2014.jpg",
	"x_transformice/x_connexion/x_papaque_2015.jpg",
	"x_transformice/x_connexion/x_plage.jpg",
	"x_transformice/x_maps/x_hw2014/x_1.jpg",
	"x_transformice/x_maps/x_hw2014/x_2.jpg",
	"x_transformice/x_maps/x_hw2014/x_3.jpg",
	"x_transformice/x_maps/x_papaques_2015/map1.jpg",
	"x_transformice/x_maps/x_papaques_2015/map2.jpg",
	"x_transformice/x_maps/x_peche2014/x_jungle.jpg",
	"x_transformice/x_maps/x_peche2014/x_montagne.jpg",
	"x_transformice/x_maps/x_peche2014/x_nuages.jpg",
	"x_transformice/x_maps/x_peche2014/x_plage.jpg",
	"x_transformice/x_maps/x_peche2014/x_temple.jpg",
	"x_transformice/x_maps/x_peche2015/map-aventure-1.jpg",
	"x_transformice/x_maps/x_peche2015/map-aventure-2.png",
	"x_transformice/x_maps/x_peche2015/map-aventure-3.jpg",
	"x_transformice/x_maps/x_peche2015/musee-vide.jpg",
	"x_transformice/x_maps/x_rentree2015/map-classe.jpg",
	"x_transformice/x_maps/x_rentree2015/map-proviseur.jpg",
	"x_transformice/x_maps/x_rentree2015/map-sport.jpg",
	"x_transformice/x_salon801/x_bar.jpg",
	"x_transformice/x_salon801/x_jardin1.jpg",
	"x_transformice/x_salon801/x_place.jpg",
}

function split(txt, sep)
	local arg = {}
	for i, v in string.gmatch(txt, string.format("[^%s]+", sep)) do
		table.insert(arg, i)
	end
	return arg
end

function geraTabuleiro(l, h)
	local pecasId = {}
	for i=1, #imagens do
		table.insert(pecasId, i)
	end
	local qtd = (l*h)/2
	local pecasEscolhidas = {}
	for i=1, qtd do
		local rand = math.random(#pecasId)
		table.insert(pecasEscolhidas, pecasId[rand])
		table.insert(pecasEscolhidas, pecasId[rand])
		table.remove(pecasId, rand)
	end
	local tabuleiro = {}
	for i=1, h do
		tabuleiro[i] = {}
		for j=1, l do
			tabuleiro[i][j] = table.remove(pecasEscolhidas, math.random(#pecasEscolhidas))
		end
	end
	return tabuleiro
end

function mapaTabuleiro(tabuleiro)
	local piso = [[<S L="%d" o="6a7495" H="%d" X="%d" Y="%d" T="12" P="0,0,0.3,0.2,0,0,0,0" />]]
	local xml = [[<C><P Ca="" D="%s" /><Z><S>%s<S v="200" L="%d" o="ffffff" H="%d" X="400" Y="200" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="%d" o="0" H="%d" X="%d" Y="%d" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="%d" o="0" H="%d" X="%d" Y="%d" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="%d" o="0" H="%d" X="%d" Y="%d" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="%d" o="0" H="%d" X="%d" Y="%d" T="12" P="0,0,0.3,0.2,0,0,0,0" /></S><D /><O /></Z></C>]]
	local pattern = "x_transformice/x_inventaire/%s.jpg,%d,%d"
	local img = {}
	local yInicio = 200 - #tabuleiro * 26
	local xInicio = 400 - #tabuleiro[1] * 26
	for i, v in pairs(tabuleiro) do
		for j, w in pairs(v) do
			table.insert(img, string.format(pattern, imagens[w], (j-1)*52+xInicio+6, (i-1)*52+yInicio+6))
		end
	end
	table.insert(img, fundos[math.random(#fundos)])
	local bordaHL = #tabuleiro[1]*52+20
	local bordaHH = 12
	local bordaHX = 400
	local bordaHY1 = 200 - (#tabuleiro * 26 +5)
	local bordaHY2 = 200 + (#tabuleiro * 26 +5)
	local bordaVL = 12
	local bordaVH = #tabuleiro*52+20
	local bordaVX1 = 400 - (#tabuleiro[1] * 26 +5)
	local bordaVX2 = 400 + (#tabuleiro[1] * 26 +5)
	local bordaVY = 200
	local pisos = {}
	for i=0, #tabuleiro do
		table.insert(pisos, string.format(piso, bordaHL, bordaHH, bordaHX, bordaHY1+5+i*52))
	end
	for i=0, #tabuleiro[1] do
		table.insert(pisos, string.format(piso, bordaVL, bordaVH, bordaVX1+5+i*52, bordaVY))
	end
	return string.format(xml, table.concat(img, ";"),table.concat(pisos), bordaHL, bordaVH, bordaHL+14, bordaHH, bordaHX, bordaHY1-7, bordaHL+14, bordaHH, bordaHX, bordaHY2+7, bordaVL, bordaVH+14, bordaVX1-7, bordaVY, bordaVL, bordaVH+14, bordaVX2+7, bordaVY)
end

function eventTextAreaCallback(id, p, cmd)
	local arg = split(cmd, " ")
	if start and jogador[p] and arg[1] == "peca" then
		local i = tonumber(arg[2])
		local j = tonumber(arg[3])
		if not jogador[p].clique2 then
			if jogador[p].clique1 and (jogador[p].clique1.i ~= i or jogador[p].clique1.j ~= j) then
				ui.addTextArea(id,"", p, 406 - (#tabuleiro[1] * 26) + (j-1)*52, 209 - (#tabuleiro * 26) + (i-1)*52, 40, 40, -1, 0xffffff, 1, true)
				jogador[p].clique2 = {["i"] = i, ["j"] = j}
			else
				ui.addTextArea(id,"", p, 406 - (#tabuleiro[1] * 26) + (j-1)*52, 209 - (#tabuleiro * 26) + (i-1)*52, 40, 40, -1, 0xffffff, 1, true)
				jogador[p].clique1 = {["i"] = i, ["j"] = j}
			end
		end
		jogador[p].tempo = os.time() + 600
	end
end

function declaraVencedor(p)
	start = false
	victory = true
	intervalo = os.time() + 10000
	ui.addTextArea(0, "", nil, 0, 0, 800, 400, 1, 1, 0.6, true)
	ui.addTextArea(-1, string.format("<p align='center'><font color='#ffffff' size='60px'>%s venceu o jogo!", p), nil, 0, 120, 800, 400, 0, 0, 0, true)
	tfm.exec.setPlayerScore(p, 1, true)
	for i, v in pairs(tabuleiro) do
		for j, w in pairs(v) do
			ui.removeTextArea(i*#v+j)
		end
	end
end

function verificaPares(p)
	local c1 = jogador[p].clique1
	local c2 = jogador[p].clique2
	if start and c1 and c2 and os.time() > jogador[p].tempo then
		if tabuleiro[c1.i][c1.j] == tabuleiro[c2.i][c2.j] then
			local x1 = 406 - (#tabuleiro[1] * 26) + (c1.j-1)*52
			local y1 = 209 - (#tabuleiro * 26) + (c1.i-1)*52
			local x2 = 406 - (#tabuleiro[1] * 26) + (c2.j-1)*52
			local y2 = 209 - (#tabuleiro * 26) + (c2.i-1)*52
			ui.addTextArea(c1.i*#tabuleiro[1]+c1.j,"", p, x1, y1, 40, 40, 0x6a7495, 0x6a7495, 0.9, true)
			ui.addTextArea(c2.i*#tabuleiro[1]+c2.j,"", p, x2, y2, 40, 40, 0x6a7495, 0x6a7495, 0.9, true)
			--ui.removeTextArea(c1.i*#tabuleiro[1]+c1.j, p)
			--ui.removeTextArea(c2.i*#tabuleiro[1]+c2.j, p)
			jogador[p].score = jogador[p].score + 1
			if jogador[p].score >= (#tabuleiro * #tabuleiro[1]) / 2 then
				declaraVencedor(p)
			end
			tfm.exec.setPlayerScore(p, 1, true)
		else
			ui.addTextArea(c1.i*#tabuleiro[1]+c1.j,string.format("<font size='32px' face='Wingdings'><p align='center'><v><a href='event:peca %d %d'>%c", c1.i, c1.j, 118), p, 406 - (#tabuleiro[1] * 26) + (c1.j-1)*52, 209 - (#tabuleiro * 26) + (c1.i-1)*52, 40, 40, 0x324650, 0xffffff, 1, true)
			ui.addTextArea(c2.i*#tabuleiro[1]+c2.j,string.format("<font size='32px' face='Wingdings'><p align='center'><v><a href='event:peca %d %d'>%c", c2.i, c2.j, 118), p, 406 - (#tabuleiro[1] * 26) + (c2.j-1)*52, 209 - (#tabuleiro * 26) + (c2.i-1)*52, 40, 40, 0x324650, 0xffffff, 1, true)
		end
		jogador[p].clique1 = false
		jogador[p].clique2 = false
		tfm.exec.removePhysicObject(1)
	end
end

function eventNewPlayer(p)
	for i, v in pairs(tabuleiro) do
		for j, w in pairs(v) do
			ui.addTextArea(i*#v+j,string.format("<font size='32px' face='Wingdings'><p align='center'><v>%c", 118), p, 406 - (#tabuleiro[1] * 26) + (j-1)*52, 209 - (#tabuleiro * 26) + (i-1)*52, 40, 40, 0x324650, 0xffffff, 1, true)
		end
	end
end

function eventNewGame()
	if start then
		ui.removeTextArea(-1)
		ui.removeTextArea(0)
		tfm.exec.setUIMapName("Jogo da memória")
		for i, v in pairs(tabuleiro) do
			for j, w in pairs(v) do
				ui.addTextArea(i*#v+j,string.format("<font size='32px' face='Wingdings'><p align='center'><v><a href='event:peca %d %d'>%c", i, j, 118), nil, 406 - (#tabuleiro[1] * 26) + (j-1)*52, 209 - (#tabuleiro * 26) + (i-1)*52, 40, 40, 0x324650, 0xffffff, 1, true)
			end
		end
		for p, v in pairs(tfm.get.room.playerList) do
			jogador[p] = {tabuleiro = {}, score = 0, clique1 = false, clique2 = false, tempo = os.time() + 1000}
			for i, v in pairs(tabuleiro) do
				jogador[p].tabuleiro[i] = {}
				for j, w in pairs(v) do
					jogador[p].tabuleiro[i][j] = w
				end
			end
			tfm.exec.setPlayerScore(p, 0, false)
			tfm.exec.killPlayer(p)
		end
	end
end

function eventLoop()
	if start then
		for i, v in pairs(jogador) do
			verificaPares(i)
		end
	elseif victory then
		if os.time() > intervalo then
			victory = false
			start = true
			iniciaJogo(t1, t2)
		end
	end
end

function iniciaJogo(i, j)
	tabuleiro = geraTabuleiro(i or math.random(2,4)*2,j or math.random(1,3)*2)
	start = true
	tfm.exec.newGame(mapaTabuleiro(tabuleiro))
end

tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoScore(true)
iniciaJogo(t1, t2)