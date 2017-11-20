-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Connor Quinlan
-- Date: Nov 17, 2017
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene

-- create logo image
local logo

local jungleSounds = audio.loadSound("Sounds/animals144.mp3")
local jungleSoundsChannel

-- Flags
local moveDone = false
local moveBackDone = false

-- Counters
local rotationCount = 0

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the logo
local function MoveLogo()

    if (moveDone == false) then --rot by 32 is 1.5 secs for 4 rot
        logo.rotation = logo.rotation + 30
        rotationCount = rotationCount + 1

        if (logo.height > 20) then
            logo.width = logo.width - 20
            logo.height = logo.height - 20
        end

        if (rotationCount == 48) then
            moveDone = true
            print "Move Done"
        end

    else

        if (moveBackDone == false) then
            logo.rotation = logo.rotation + 30
            rotationCount = rotationCount + 1

            if (logo.height < display.contentHeight) then
                logo.width = logo.width + 20
                logo.height = logo.height + 20
            end

            if (rotationCount == 96) then
                moveBackDone = true
                print "Move Back Done"
            end

        else
            -- Remove Listener
            Runtime:removeEventListener("enterFrame", MoveLogo)
        end

    end
end

-- The function that will go to the main menu 
local function gotoMainMenu()

    -- Pre-Setting Transition Options
    local transitionOptions = (
    {
        effect = "zoomOutIn",
        time = 1000
    })

    -- Creating Transition function
    composer.gotoScene( "main_menu", transitionOptions )

end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
logo = display.newImageRect("Images/CompanyLogo.png", 1024, 768)
logo.x = display.contentWidth/2
logo.y = display.contentHeight/2
logo.rotation = 0

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        jungleSoundsChannel = audio.play(jungleSounds )

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveLogo)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 4000, gotoMainMenu)          
        
    end

    -- Associating display objects with this scene 
    sceneGroup:insert( logo )

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(jungleSoundsChannel)

    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
