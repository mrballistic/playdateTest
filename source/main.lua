import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

local tick = playdate.resetElapsedTime()
local newTick = 0

-- set up the random seed
math.randomseed(playdate.getSecondsSinceEpoch())

-- i bet that there's a constant in the playdate sdk that would do this for me...
local kScreenBoundsWidth <const> = playdate.display.getWidth()
local kScreenBoundsHeight <const>  = playdate.display.getHeight()

-- bring in the coin class
import "Coin.lua"

local thisX = 100
local thisY = 100
local flip = false

local spriteSpeed = 10

local images = {"img/coin.png", "img/coin-reverse.png"}

local wallImageTop = playdate.graphics.image.new("img/wall-top.png")
local wallImageBottom = playdate.graphics.image.new("img/wall-bottom.png")
local wallImageLeft = playdate.graphics.image.new("img/wall-left.png")
local wallImageRight = playdate.graphics.image.new("img/wall-right.png")
local rightWall = playdate.graphics.sprite.new(wallImageRight)
local leftWall = playdate.graphics.sprite.new(wallImageLeft)

local topWall = playdate.graphics.sprite.new(wallImageTop)
local bottomWall = playdate.graphics.sprite.new(wallImageBottom)

local image = playdate.graphics.image.new(images[1])
local image2 = playdate.graphics.image.new(images[2])
local coin = playdate.graphics.sprite.new(image)
local coinwidth = coin.width/2

local secondCoin = Coin:init(150, 150, 32, 32, images[1], images[2], true)


-- set collision detection on the sprite
coin:setCollideRect( 0, 0, coin:getSize() )
rightWall:setCollideRect( 0, 0, rightWall:getSize() )
leftWall:setCollideRect( 0, 0, leftWall:getSize() )

topWall:setCollideRect( 0, 0, topWall:getSize() )
bottomWall:setCollideRect( 0, 0, bottomWall:getSize() )

-- put it on the stage...
coin:moveTo(100, 100)

rightWall:moveTo(384,120)
leftWall:moveTo(16,120)
topWall:moveTo(200,12.5)
bottomWall:moveTo(200,229)

-- ... literally
rightWall:add()
leftWall:add()

topWall:add()
bottomWall:add()

coin:add()

secondCoin:update(playdate.getElapsedTime())


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

    -- get the crank position, and rotate the sprite
    local deltaCrank = playdate.getCrankChange();
    coin:setRotation(coin:getRotation() + deltaCrank)

end


function playdate.update() 
    gfx.clear()
    playdate.drawFPS()

    coin:moveTo(thisX,thisY)
    coin:update()

    secondCoin:update(playdate.getElapsedTime())

    checkInput()
    
    -- look for collisions
    local collisions = gfx.sprite.allOverlappingSprites()

    if #collisions > 0
    then   
        print('collision!')
        printTable(collisions)
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