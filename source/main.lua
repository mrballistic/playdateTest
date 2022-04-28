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

local images = {"img/coin.png", "img/coin-reverse.png"}

local image = playdate.graphics.image.new(images[1])
local image2 = playdate.graphics.image.new(images[2])
local sprite = playdate.graphics.sprite.new(image)
local spritewidth = sprite.width/2

-- set collision detection on the sprite
sprite:setCollideRect( 0, 0, sprite:getSize() )

-- put it on the stage...
sprite:moveTo(100, 100)

-- ... literally
sprite:add()

function playdate.update() 
    gfx.clear()
    playdate.drawFPS()

    sprite:moveTo(thisX,thisY)
    sprite:update()

    -- look for collisions
    local collisions = gfx.sprite.allOverlappingSprites()

  --  if collisions.length > 0
  --  then   

  --  end

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

    -- invert the image when the "A" button is pressed
    if(playdate.buttonJustPressed(playdate.kButtonA))
    then
        if(flip)
        then
            sprite:setImage(image)
            flip=false
        else
            sprite:setImage(image2)
            flip=true
        end
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