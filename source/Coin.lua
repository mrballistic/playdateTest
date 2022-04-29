import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"
import "CoreLibs/object"

local gfx <const> = playdate.graphics
local function emptyFunc()end

class("Coin").extends(gfx.sprite)

function Coin:init(x, y, img1, img2)
    self.x = x
    self.y = y
    self.image1 = img1
    self.image2 = img2
    self.width = x
    self.height = y

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the coin can move in two dimensions
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100)
end

--[[

    Place the coin in the middle of the screen and set an initial velocity to it

]]
function Coin:reset()
    self.x = kScreenBoundsWidth / 2 - self.width/2
    self.y = kScreenBoundsHeight / 2 - self.width/2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[

    Apply deltaTime to the velocity of the coin

]]
function Coin:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end