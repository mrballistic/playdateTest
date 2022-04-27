import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

local gfx <const> = playdate.graphics

local kScreenBoundsWidth <const> = 400
local kScreenBoundsHeight <const> = 240

local thisX = 100
local thisY = 100
local flip = false

local spriteSpeed = 10

local image = playdate.graphics.image.new("img/coin.png")
local sprite = playdate.graphics.sprite.new(image)
local spritewidth = sprite.width/2

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
        thisX += spriteSpeed
    end

    if(playdate.buttonIsPressed(playdate.kButtonLeft)) 
    then
        thisX -= spriteSpeed
    end

    if(playdate.buttonIsPressed(playdate.kButtonUp)) 
    then
        thisY -= spriteSpeed
    end

    if(playdate.buttonIsPressed(playdate.kButtonDown)) 
    then
        thisY += spriteSpeed
    end

   -- get the crank position, update the y pos of the sprite 
   local deltaCrank = playdate.getCrankChange();
   thisY += deltaCrank

   -- hacky way to keep the sprite on the screen
    if(thisX<spritewidth)
    then   
        thisX = spritewidth
    end

    if(thisX>kScreenBoundsWidth - spritewidth)
    then   
        thisX = kScreenBoundsWidth - spritewidth
    end

    if(thisY<spritewidth)
    then   
        thisY = spritewidth
    end

    if(thisY>kScreenBoundsHeight - spritewidth)
    then   
        thisY = kScreenBoundsHeight - spritewidth
    end


end
