--------------------------------
-- List Class File            --
-- Use Encoding: Windows 1252 --
--------------------------------

-- Class name
List = {}

---@class List
function List:new()
    local private = {}
    -- Private properties and methods
        private.list    = {}

    local public = {}
    -- Public properties and methods

        ---@param self List
        ---@param item any
        ---@param position number
        function public.insert(self, item, position)
            if ((position ~= nil) and (type(position) == "number")) then
                table.insert(private.list, position, item)
            else
                table.insert(private.list, item)
            end
        end

        ---@param self List
        ---@param id number
        ---@return any
        function public.get(self, id)
            return private.list[id]
        end

        ---@param self List
        ---@return table
        function public.getList(self)
            return private.list
        end

        ---@param self List
        ---@param params table
        ---@return table
        function public.getByQuery(self, params)
            local result = {}
            for _, item in pairs(private.list) do
                local access = true
                for param, value in pairs(params) do
                    if (item[param] == nil) then
                        error('Parameter ['..param..'] is missing in items in list!')
                    elseif (item[param] ~= value) then
                        access = false
                        break
                    end
                end

                if (access) then table.insert(result, item) end
            end
            return result
        end

        ---@param self List
        ---@param position number
        function public.remove(self, position)
            if ((position ~= nil) and (type(position) == "number")) then
                table.remove(private.list, position)
            else
                table.remove(private.list)
            end
        end

        ---@param self List
        ---@return number
        function public.length(self)
            return #private.list
        end


    setmetatable(public, self)
    self.__index = self; return public
end