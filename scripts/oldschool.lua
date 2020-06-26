xmlLoaded=false
tfm.exec.disableAutoShaman(true)
 
function eventNewGame()
        if not xmlLoaded then
                if tfm.get.room.currentMap:find("@")~=nil then
                        xml=tfm.get.room.xmlMapInfo.xml
                        author=tfm.get.room.xmlMapInfo.author
                        mapCode=tfm.get.room.xmlMapInfo.mapCode
                        tfm.exec.disableAutoShaman(false)
                        tfm.exec.newGame(xmlModifier(xml))
                        xmlLoaded=true
                        tfm.exec.setUIMapName("<v>"..author)
                else
                        tfm.exec.newGame()
                end
        else
                tfm.exec.disableAutoShaman(true)
                xmlLoaded=false
        end
end
 
function xmlModifier(xml)
        xml = xml:gsub('<P[^>]+T="[^>]+"[^>]+>','')
        xml = xml:gsub('T="(%d+)"', function(a) if a=='5' or a=='6' or a=='7' or a=='10' or a=='11' then return 'T="0"' else return 'T="'..a..'"' end end)
        xml = xml:gsub('F="(.-)"','')
        tfm.exec.disableAllShamanSkills(true)
        return xml
end
 
tfm.exec.newGame()