------------------------------------
-- ClassList Class File           --
-- Use Encoding: Windows 1252     --
------------------------------------

-- Class name (Inheritance from List)
sw.ClassList = List:new()

---@class ClassList
function sw.ClassList:new()
    local private = {}
    -- Private properties and methods
        private.empireClasses       = {}
        private.republicClasses     = {}

    local public = {}
    -- Public properties and methods

        ---@param self ClassList
        function public.createEmpireList(self)
            private.empireClasses = self:getByQuery({
                ["affiliation"] = "Empire",
            })
        end

        ---@param self ClassList
        function public.createRepublicList(self)
            private.republicClasses = self:getByQuery({
                ["affiliation"] = "Republic",
            })
        end

        ---@param self ClassList
        ---@param id number
        ---@return Class
        function public.getEmpireClassById(self, id)
            return private.empireClasses[id]
        end

        ---@param self ClassList
        ---@param id number
        ---@return Class
        function public.getRepublicClassById(self, id)
            return private.republicClasses[id]
        end

        ---@param self any
        ---@return table
        function public.getEmpireList(self)
            return private.empireClasses
        end

        ---@param self any
        ---@return table
        function public.getRepublicList(self)
            return private.republicClasses
        end

    setmetatable(public, self)
    self.__index = self; return public
end