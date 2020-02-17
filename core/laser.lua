--------------------------------
-- Laser Class File           --
-- Use Encoding: Windows 1252 --
--------------------------------

-- Class name
sw.Laser = {}

---@class Laser
function sw.Laser:new()
    local private = {}
        -- Private properties and methods
        private.damage      = 0
        private.weapon      = 0
        private.performer   = 0
        private.rot         = 0
        private.x           = 0
        private.y           = 0
        private.imgid       = 0
        private.lightid     = 0
        private.incx        = 0
        private.incy        = 0
        private.angle       = 0
        private.stamp       = 0

    local public = {}
        -- Public properties and methods

        ---@param id number
        function public.initialize(self, id)
            local px        = player(id, "x")
            local py        = player(id, "y")
            local pr        = math.rad(player(id, "rot") - 90)
            local incx      = math.cos(pr)
            local incy      = math.sin(pr)
            local imgx      = px + (incx * 20)
            local imgy      = py + (incy * 20)
            local wpn       = player(id, "weapontype")
            local dmg       = itemtype(wpn, "dmg")
        
            local img       = image("gfx/sprites/laserbeam1.bmp", 0, 0, 1)
            local light     = image("gfx/sprites/flare4.bmp", imgx, imgy, 1)
        
            if (player(id, "team") == 1) then
                imagecolor(img, 255, 0, 0)
                imagecolor(light, 255, 0, 0)
            elseif (player(id, "team") == 2) then
                imagecolor(img, 0, 0, 255)
                imagecolor(light, 0, 0, 255)
            end
        
            imagescale(img, 0.1, 0.8)
            imageblend(img, 1)
            imageblend(light, 1)
            imagealpha(light, 0.2)
            imagepos(img, imgx, imgy, player(id, "rot"))

            private.damage      = dmg
            private.weapon      = wpn
            private.performer   = id
            private.imgid       = img
            private.lightid     = light
            private.x           = imgx
            private.y           = imgy
            private.incx        = incx
            private.incy        = incy
            private.rot         = player(id, "rot")
            private.angle       = pr
            private.stamp       = os.time()
        end

        ---@destructor
        function public.destructor(self)
            freeimage(private.imgid)
            freeimage(private.lightid)
        end

        ---@return number
        function public.getPerformer(self)
            return private.performer
        end

        ---@return number, number
        function public.getPosition(self)
            return private.x, private.y
        end

        ---@return boolean
        function public.checkTileCollision(self)
            local tilex     = math.floor(private.x / 32)
            local tiley     = math.floor(private.y / 32)
            local result    = false

            if (tile(tilex, tiley, "wall")) then
                result = true
            end

            return result
        end

        ---@return boolean
        function public.checkLiveTime(self)
            local timeNow   = os.time()
            local result    = false

            if ((timeNow - private.stamp) > sw_laser_livetime) then
                result = true
            end

            return result
        end

        ---@return nil
        function public.laserMove(self)
            private.x = private.x + private.incx * 32
            private.y = private.y + private.incy * 32

            tween_move(private.imgid, sw_laser_speed, private.x, private.y, private.rot)
            tween_move(private.lightid, sw_laser_speed, private.x, private.y)
        end

        ---@return table
        function public.getStats(self)
            return {
                ["damage"]      = private.damage,
                ["weapon"]      = private.weapon,
                ["performer"]   = private.performer
            }
        end

        function public.soundHitting(self)
        end

    setmetatable(public, self)
    self.__index = self; return public
end