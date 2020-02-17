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
minutes         = 0
seconds         = 0
sw.admins       = {} -- Admins
sw.maps         = {} -- Maps
sw.lasers       = {} -- Lasers
sw.players      = {} -- Players
sw.classes      = {} -- Classes
sw.colors       = {  -- Colors
    ["red"]         = "©255000000",
    ["green"]       = "©000255000",
    ["blue"]        = "©000000255",
    ["orange"]      = "©255165000",
    ["cyan"]        = "©000255255",
    ["magenta"]     = "©255000255",
    ["white"]       = "©255255255",
    ["yellow"]      = "©255255000",
    ["darkOrange"]  = "©255140000",
    ["hotPink"]     = "©255105180",
    ["violet"]      = "©238130238",
}


--[[ Dofiles ]]--
path = "sys/lua/starwars/"
-- Configs
dofile(path.."config/settings.cfg")
dofile(path.."config/config.cfg")
-- Secondary functions
dofile(path.."core/funcs.lua")
-- Classes
dofile(path.."core/list.lua")
dofile(path.."core/class.lua")
dofile(path.."core/classList.lua")
dofile(path.."core/player.lua")
dofile(path.."core/laser.lua")
-- Basic functions
dofile(path.."core/basic.lua")


--[[ Addhooks ]]--
addhook("join",             "sw.join")
addhook("leave",            "sw.leave")
addhook("attack",           "sw.attack")
addhook("always",           "sw.always")
addhook("serveraction",     "sw.serveraction")
addhook("spawn",            "sw.spawn")
addhook("hit",              "sw.hit")
addhook("menu",             "sw.menu")


print(_VERSION)
print(os.date("%X", os.time()))
parse("restart")
