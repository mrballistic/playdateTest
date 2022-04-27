import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

local gfx <const> = playdate.graphics

local thisX = 100
local thisY = 100
local flip = false

local myText = ""

local image = playdate.graphics.image.new("img/coin.png")
local sprite = playdate.graphics.sprite.new(image)

sprite:moveTo(100, 100)
sprite:add()





function playdate.update() 
    gfx.clear()
    playdate.drawFPS()

    sprite:moveTo(thisX,thisY)
    sprite:update()

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

   local degrees = playdate.getCrankChange();

  -- playdate.graphics.drawText(degrees, 100, 150)


   thisY += degrees

    -- sprite:image.drawScaled(thisX, thisY, degrees)




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
