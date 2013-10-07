--
--   Copyright 2013 John Pormann
--
--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.
--

local storyboard = require( "storyboard" )
local widget = require( "widget" )

local scene = storyboard.newScene()


-- Called when the scene's view does not exist:
function scene:createScene( event )
	dprint( 10, "createScene-SplashScreen" )

	local group = self.view

	local btnsheet = graphics.newImageSheet( "assets/buttonsheet.png", {
		width = 128,
		height = 128,
		numFrames = 2
	})
	self.btnsheet = btnsheet

	local function getSprite( n )
		-- start with the "off" frame
		local seqData = {
		    name="offon",
		    start=1,
		    count=2,
		    time=300,
		    loopCount = 1
		}
		local sprite = display.newSprite( btnsheet, seqData )
		return sprite
	end
	
	local sprite1 = getSprite( 1 )
	group:insert( sprite1 )
	self.sprite1 = sprite1
	
	local sprite2 = getSprite( 2 )
	group:insert( sprite2 )
	self.sprite2 = sprite2

	local sprite3 = getSprite( 3 )
	group:insert( sprite3 )
	self.sprite3 = sprite3

end

function scene:cancelTween( obj )
	if( obj.tween ~= nil ) then
		transition.cancel( obj.tween )
		obj.tween = nil
	end
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	dprint( 10, "createScene-SplashScreen" )

	local group = self.view

	local sprite1 = self.sprite1
	local sprite2 = self.sprite2
	local sprite3 = self.sprite3
	
	sprite1.x = display.contentWidth * 0.50
	sprite1.y = display.contentHeight * 0.25
	sprite2.x = display.contentWidth * 0.50
	sprite2.y = display.contentHeight * 0.50
	sprite3.x = display.contentWidth * 0.50
	sprite3.y = display.contentHeight * 0.75
	
	sprite1:play()
	timer.performWithDelay( 300, function(e)
		sprite2:play()
	end )
	timer.performWithDelay( 600, function(e)
		sprite3:play()
	end )

	timer.performWithDelay( 1000, function(e)
		storyboard.gotoScene( "scripts.MainScreen" )
	end )

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	dprint( 10, "createScene-SplashScreen" )

	local group = self.view

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

	-----------------------------------------------------------------------------

	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)

	-----------------------------------------------------------------------------

end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene
