import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/object"

local gfx <const> = playdate.graphics
local function emptyFunc()end

-- i bet that there's a constant in the playdate sdk that would do this for me...
local kScreenBoundsWidth <const> = playdate.display.getWidth()
local kScreenBoundsHeight <const>  = playdate.display.getHeight()

class("Coin").extends(gfx.sprite)

function Coin:init(_x, _y, _height, _width, _img1, _img2,  collide)
    self.x = _x
    self.y = _y

    self.width = _width
    self.height = _height

    local filename = playdate.graphics.image.new(_img1)
    self.image = playdate.graphics.sprite.new(filename)

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the coin can move in two dimensions
    self.dy = math.random(-100, 100)
    self.dx = math.random(-80, 100) 

    if(collide)
    then
        self.image:setCollideRect( 0, 0, self.image:getSize() )
    end

    --self.image:setBackgroundDrawingCallback(myBG)
    self.image:moveTo(self.x,self.y)
    self.image.update()
    self.image:add()
    self:reset()

    return self

end

--[[

    Place the coin in the middle of the screen and set an initial velocity to it

]]
function Coin:reset()
    self.x = kScreenBoundsWidth / 2 - self.width/2
    self.y = kScreenBoundsHeight / 2 - self.width/2
    self.dy = math.random(-100, 100)
    self.dx = math.random(-80, 100) 
end

--[[

    Apply deltaTime to the velocity of the coin

]]
function Coin:update(dt)
    self.x = self.x - self.dx * dt
    self.y = self.y - self.dy * dt

  --  self.image:moveTo(self.x, self.y)
end

function Coin:handleCollision()
    self.dy = self.dy * -1
    self.dx = self.dx * -1
end