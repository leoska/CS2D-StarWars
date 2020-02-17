--------------------------------
-- Class Class File           --
-- Use Encoding: Windows 1252 --
--------------------------------

-- Class name
sw.Class = {}

---@class Class
function sw.Class:new(stats)
    local public = {}
        -- public properties and methods
        public.id              = 0
        public.name            = stats[1]
        public.affiliation     = stats[2]
        public.type            = stats[3]
        public.health          = stats[4]
        public.barrier         = stats[5]
        public.speed           = stats[6]
        public.items           = stats[7]
        public.skin            = stats[8]

    setmetatable(public, self)
    self.__index = self; return public
end