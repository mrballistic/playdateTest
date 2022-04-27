import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

local gfx <const> = playdate.graphics

local thisX = 100
local thisY = 100
local flip = false

local image = playdate.graphics.image.new("img/coin.png")
local sprite = playdate.graphics.sprite.new(image)

sprite:moveTo(100, 100)
sprite:add()

function playdate.update() 
    gfx.clear()
    playdate.drawFPS()

    sprite:moveTo(thisX,thisY)
    sprite:update()

    -- get the button actions/update the xy coord of the sprite
    if(playdate.buttonIsPressed(playdate.kButtonRight)) 
    then
        thisX += 10
    end

    if(playdate.buttonIsPressed(playdate.kButtonLeft)) 
    then
        thisX -= 10
    end

    if(playdate.buttonIsPressed(playdate.kButtonUp)) 
    then
        thisY -= 10
    end

    if(playdate.buttonIsPressed(playdate.kButtonDown)) 
    then
        thisY += 10
    end

   -- get the crank position, update the y pos of the sprite 
   local degrees = playdate.getCrankChange();
   thisY += degrees

   -- hacky way to keep the sprite on the screen
    if(thisX<16)
    then   
        thisX = 16
    end

    if(thisX>384)
    then   
        thisX = 384
    end

    if(thisY<16)
    then   
        thisY = 16
    end

    if(thisY>224)
    then   
        thisY = 224
    end


end
