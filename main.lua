---brysons reaction game

local background = display.newImageRect( "assets/download.jpg", 570, 570 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.id = "background" 

reaction = display.newText( "Brysons reaction game", 160, 265, native.systemFont, 30 )
reaction:setFillColor( 1, 1, 1 )

local physics = require( "physics" )
physics.start()

halfW = display.contentWidth*0.5
halfH = display.contentHeight*0.5

score = 0
scoreText = display.newText(score, halfW, 10)

local function balloonTouched(event)
    if ( event.phase == "began" ) then
        Runtime:removeEventListener( "enterFrame", event.self )
        event.target:removeSelf()
        score = score + 1
        scoreText.text = score
    end
end

local function bombTouched(event)
    if ( event.phase == "began" ) then
        Runtime:removeEventListener( "enterFrame", event.self )
        event.target:removeSelf()
        score = math.floor(score * 0.5)
        scoreText.text = score
    end
end

local function offscreen(self, event)
    if(self.y == nil) then
        return
    end
    if(self.y > display.contentHeight + 50) then
        Runtime:removeEventListener( "enterFrame", self )
        self:removeSelf()
    end
end

local function addNewBalloonOrBomb()

    local startX = math.random(display.contentWidth*0.1,display.contentWidth*0.9)
    if(math.random(1,5)==1) then
        
        local bomb = display.newImageRect( "assets/mine.png", 75, -150)
        bomb.x = math.random (0,400)
        bomb.y = display.contentCenterY-210

        physics.addBody( bomb )
        bomb.enterFrame = offscreen
        Runtime:addEventListener( "enterFrame", bomb )
        bomb:addEventListener( "touch", bombTouched )
    else
    
        local balloon = display.newImageRect( "assets/mine.png", 75, -150)
        balloon.x = math.random (0,320)
        balloon.y = display.contentCenterY-210
        physics.addBody ( balloon )
        balloon.enterFrame = offscreen
        Runtime:addEventListener( "enterFrame", balloon )
        balloon:addEventListener( "touch", balloonTouched )
    end
end




addNewBalloonOrBomb()


timer.performWithDelay( 1000, addNewBalloonOrBomb, 0 )