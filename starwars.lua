-------------------------------------------
-- Star Wars v0.0.0 by leoska			 --
-- Use Encoding: Windows 1252            --
-------------------------------------------
-- Credits:					--
-- 1. leoska (Author)		--
-- Special for CS2D			--
------------------------------

--[[ Namespaces (Tables) ]]--
sw = {}


--[[ Global Values ]]--
minutes = 0
seconds = 0
sw.lasers = {} -- Lasers
sw.players = {} -- Players


--[[ Dofiles ]]--
path = "sys/lua/starwars/"
dofile(path.."config/settings.cfg")
dofile(path.."core/player.lua")
dofile(path.."core/basic.lua")


--[[ Addhooks ]]--
addhook("join", "sw.join")
addhook("leave", "sw.leave")


print(_VERSION)
print(os.date("%X", os.time()))
parse("restart")
