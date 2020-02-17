--------------------------------
-- Support Functions File 	  --
-- Use Encoding: Windows 1252 --
--------------------------------

---@param t string
---@param b string
---@return table
function string.split(t, b)
	local cmd = {}
	local match = "[^%s]+"

	if (type(b) == "string") then
		match = "[^"..b.."]+"
	end

	for word in string.gmatch(t, match) do
		table.insert(cmd, word)
	end

	return cmd
end

---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
function Distance(x1, y1, x2, y2)
	return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

---@param child any
---@param parent any
function Extended(child, parent)
    setmetatable(child,{__index = parent})
end

function sw.msg2(id, color, text)
	msg2(id, string.format(sw.colors[color]..""..text))
end

--[[ Read Files ]]--

function sw.loadClasses()
	local f = io.open(path.."config/classes.txt", "r")
	local line = 0

	-- Create List of Classes Controller
	sw.classes = sw.ClassList:new()

	if (f ~= nil) then
		for strValue in f:lines() do
			line = line + 1
			if (string.sub(strValue, 1, 2) ~= "//") then -- Comment string
				if (string.sub(strValue, 1, 6) == "#class") then
					local stats = sw.getStatsFromLine(line, strValue)

					if (sw.checkClassValues(stats, line)) then
						local class = sw.Class:new(stats)
						class.id = sw.classes:length() + 1
						sw.classes:insert(class)
					end
				end
			end
		end
		io.close(f)
	else
		error("Config File \"classes.txt\" is missing!")
	end

	sw.classes:createEmpireList()
	sw.classes:createRepublicList()
end

--[[ Secondary functions ]]--

---@param line number
---@param strValue string
---@return table
function sw.getStatsFromLine(line, strValue)
	local loadString = string.split(strValue, ":")
	local stats = {}

	if (#loadString < 8) then
		error('One or more parameter(s) is missing! File [classes.txt], string ['..line..']')
	end

	for i = 2, 9 do
		if (loadString[i] ~= nil) then
			-- Remove begin and end spaces
			local value = loadString[i]:match( "^%s*(.-)%s*$" )
			if (i == 8) then -- Items
				table.insert(stats, string.split(value, ","))
			elseif ((i < 5) or (i == 9)) then
				table.insert(stats, tostring(value))
			else
				table.insert(stats, tonumber(value))
			end
		end
	end
	return stats
end

---@param stats table
---@return boolean
function sw.checkClassValues(stats, line)
	for _, class in ipairs(sw.classes:getList()) do
		if (stats[1] == class.name) then
			error('This name is already exists! File [classes.txt], string ['..line..']')
		end
	end

	if ((stats[2] ~= "Empire") and (stats[2] ~= "Republic")) then
		error('incorrect affiliation! File [classes.txt], string ['..line..']')
	end

	return true
end

--[[ Menu Render ]]--

---@param id number
---@param button number
function sw.renderMenuClasses(id, button)
	local player 			= sw.players[id]
	local page 				= player:getPage()
	local affiliation 		= player:getAffiliation()
	local classId			= button + (7 * page)
	local class				= nil
	if ((button > 0) and (button < 8)) then
		if (affiliation == "Empire") then
			class = sw.classes:getEmpireClassById(classId)
		elseif (affiliation == "Republic") then
			class = sw.classes:getRepublicClassById(classId)
		end

		player:setClass(class)
		sw.msg2(id, "darkOrange", string.format("Your Class After The Next Spawn Will Be %s", class.name))
	end

	if (page == 0) then
	elseif(page > 0) then
	end
end

--[[ Menu Functions ]]--

---@param id number
---@param page number
function sw.menuHeroes(id, page)
	local player 			= sw.players[id]
	local affiliation 		= player:getAffiliation()
	local body_menu 		= ""
	local startPos			= 1 + (7 * page)
	local endPos			= startPos + 7
	local classList			= nil

	if (affiliation == "Empire") then
		classList 			= sw.classes:getEmpireList()
	else
		classList 			= sw.classes:getRepublicList()
	end

	for i = startPos, endPos do
		if (i <= #classList) then
			body_menu = body_menu..""..classList[i].name.."|"..classList[i].type..","
		else
			body_menu = body_menu..","
		end
	end

	if (page == 0) then
		body_menu = body_menu.."Back|Main Menu"
	else
		body_menu = body_menu.."Back|Previous Page"
	end

	if (endPos < #classList) then
		body_menu = body_menu..",Next|Next Page"
	end

	menu(id, "Choose Your Class Page "..(page + 1).."@b,"..body_menu)
end