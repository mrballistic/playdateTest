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
local coin = playdate.graphics.sprite.new(image)
local coinwidth = coin.width/2

-- set collision detection on the sprite
coin:setCollideRect( 0, 0, coin:getSize() )

-- put it on the stage...
coin:moveTo(100, 100)

-- ... literally
coin:add()

-- change the sprite out
function flipSprite()
    if(flip)
    then
        coin:setImage(image)
        flip=false
    else
        coin:setImage(image2)
        flip=true
    end
end

-- get the button actions/update the xy coord of the sprite
function checkInput()
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
        flipSprite()
    end

    -- get the crank position, update the y pos of the sprite 
    local deltaCrank = playdate.getCrankChange();
    thisY += deltaCrank

end


function playdate.update() 
    gfx.clear()
    playdate.drawFPS()

    coin:moveTo(thisX,thisY)
    coin:update()

    checkInput()
    
    -- look for collisions
    local collisions = gfx.sprite.allOverlappingSprites()

    if #collisions > 0
    then   
        flipSprite()
    end

    -- hacky way to keep the sprite on the screen
    if(thisX<coinwidth)
    then   
        thisX = coinwidth
    end

    if(thisX>kScreenBoundsWidth - coinwidth)
    then   
        thisX = kScreenBoundsWidth - coinwidth
    end

    if(thisY<coinwidth)
    then   
        thisY = coinwidth
    end

    if(thisY>kScreenBoundsHeight - coinwidth)
    then   
        thisY = kScreenBoundsHeight - coinwidth
    end

end