--------------------------------
-- Player Class File          --
-- Use Encoding: Windows 1252 --
--------------------------------

-- Class name
sw.Player = {}

---@class Player
function sw.Player:new(id)
    local private = {}
        -- Private properties and methods
        private.id          = id        -- Id player
        private.health      = 0         -- Current Health Points
        private.maxhealth   = 0         -- Max Health Points
        private.barrier     = 0         -- Current Barrier Points
        private.maxbarrier  = 0         -- Max Barrier Points
        private.speed       = 0         -- Speed
        private.class       = nil       -- Ref of class
        private.alive       = false     -- Alive or dead?
        private.affiliation = ""        -- Affiliation
        private.page        = 0         -- Current Page for menu
        
    local public = {}
        -- Public properties and methods

        ---@destructor
        function public.destructor()
        end

        ---@getter
        ---@return number
        function public.getHealth()
            return private.health
        end

        ---@return number
        function public.getPage()
            return private.page
        end

        ---@return string
        function public.getAffiliation()
            return private.affiliation
        end

        ---@param self Player
        ---@param affiliation string
        function public.setAffiliation(self, affiliation)
            private.affiliation = affiliation
        end

        ---@param self Player
        ---@param class Class
        function public.setClass(self, class)
            if (class ~= nil) then
                private.class = class
            else
                error('Assignment error with nil object. Player ID: ['..private.id..']')
            end
        end

        ---@param laser Laser
        function public.hit(self, laser)
            if (laser == nil) then
                error('Parameter laser is missing (a nil value)')
            end

            if (private.alive) then
                local laserStats = laser:getStats()
                local damage, performer = laserStats.damage, laserStats.performer

                if (private.barrier > 0) then
                    if (private.barrier <= damage) then
                        damage = damage - private.barrier
                        private.barrier = 0
                    else
                        private.barrier = private.barrier - damage
                        damage = 0
                    end
                end

                if (damage > 0) then
                    private.health = private.health - damage

                    if (private.health <= 0) then
                        self:die(performer)
                    end
                end

                laser:soundHitting()
            else
                error('Cannot hit an not alive player. Player ID: ['..private.id..']')
            end

            self:updateHUD()
        end

        ---@param self Player
        ---@param performer any
        function public.die(self, performer)
            parse('killplayer '..private.id)

            private.alive       = false
            private.health      = 0
            private.barrier     = 0
            private.speed       = 0

            self:updateHUD()
        end

        ---@return nil
        function public.spawn(self)
            if (private.alive) then
                error('Player already alive! Player ID: ['..private.id..']')
            else
                private.maxhealth   = 100
                private.alive       = true
                private.health      = private.maxhealth or 100
                private.barrier     = 25
                private.speed       = 0
            end

            self:updateHUD()
        end

        function public.updateHUD(self)
            local col1, col2, col3, col4 = "©128255000", "©000255000", "©255255255", "©128166255"
            local wpos, hpos = player(private.id, "screenw"), player(private.id, "screenh")
            local x, y = 0, 0
            x = wpos / 2 - 65
            y = hpos - 120

            if (private.barrier > 0) then
                parse(string.format("hudtxt2 %d %d \"%s\" %d %d %d", private.id, 11, col1.."Health: "..private.health..""..col3.."("..col4..""..private.barrier..""..col3..")"..col1.."/"..private.maxhealth, x, y, 0))
            else
                parse(string.format("hudtxt2 %d %d \"%s\" %d %d %d", private.id, 11, col1.."Health: "..private.health.."/"..private.maxhealth, x, y, 0))
            end

            self:updateHpBar()
        end

        function public.updateHpBar(self)
            local str1, str2 = "", ""
            local col1, col2, col3 = "©255255255", "©128255000", "©000128255"
            local wpos, hpos = player(private.id, "screenw"), player(private.id, "screenh")
            for i = 1, (math.ceil(private.health / 5)) do
                str1 = str1.."|"
            end
            for i = 1, (math.ceil(private.barrier / 5)) do
                str2 = str2.."|"
            end
            parse(string.format("hudtxt2 %d %d \"%s\" %d %d %d", private.id, 12, col1.."["..col2..""..str1..""..col3..""..str2..""..col1.."]", wpos / 2 - 65, hpos - 90, 0))
        end

    setmetatable(public, self)
    self.__index = self; return public
end