-----------------------------------
-- Parse Confings Functions File --
-- Use Encoding: Windows 1252    --
-----------------------------------

--[[ Read Files ]]--

---Parse "config/classes.txt" to load classes
---@return nil
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
		print("File \"classes.txt\" is successfully loaded.")
	else
		error("Config File \"classes.txt\" is missing!")
	end

	sw.classes:createEmpireList()
	sw.classes:createRepublicList()
end

---Parse "config/admins.txt" to load admins
---@return nil
function sw.loadAdmins()
	local f = io.open(path.."config/admins.txt", "r")
	if (f ~= nil) then
		for line in f:lines() do
			if (string.sub(line, 1, 2) ~= "//") then -- Comment string
				if (tonumber(line) ~= nil) then
					table.insert(sw.admins, tonumber(line)) -- U.S.G.N. ID
				else
					table.insert(sw.admins, line) -- Steam ID
				end
			end
		end
		io.close(f)
		print("File \"admins.txt\" is successfully loaded.")
	else
		print("File \"admins.txt\" is missing!")
	end
end

---Parse "config/adverts.txt" to load adverts
---@return nil
function sw.loadAdverts()
	local f = io.open(path.."config/adverts.txt", "r")
	if (f ~= nil) then
		for line in f:lines() do
			if (string.sub(line, 1, 2) ~= "//") then -- Comment string
				table.insert(sw.adverts, line)
			end
		end
		io.close(f)
		print("File \"adverts.txt\" is successfully loaded.")
	else
		print("File \"adverts.txt\" is missing!")
	end
end