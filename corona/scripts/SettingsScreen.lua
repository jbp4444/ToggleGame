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

local function onStepPress( event )
	local tgt = event.target
	
	if( event.phase == "increment" ) then
		settings.maxToggle = settings.maxToggle + 1
    elseif( event.phase == "decrement" ) then
		settings.maxToggle = settings.maxToggle - 1
    end
	scene.stepTxt.text = "Max T = "..settings.maxToggle

	return true
end
local function onStepPress2( event )
	local tgt = event.target
	
	if( event.phase == "increment" ) then
		settings.colormap = settings.colormap + 1
    elseif( event.phase == "decrement" ) then
		settings.colormap = settings.colormap - 1
    end
	scene.clrTxt.text = "Cmap = "..settings.colormap

	return true
end

local function processButton( event )
	if( event.target == scene.backBtn ) then
		storyboard.gotoScene( "scripts.MainScreen" )
		return true
	end
	return false
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	dprint( 10, "createScene-SettingsScreen" )
	local group = self.view
	
	local y = 20
	
	-- stepper for max num neighbors that can be toggled
	-- default is set in main.lua:  settings.maxToggle
	local stepTxt = display.newText( "Max T = "..settings.maxToggle, 20,y,
		native.systemFont, 20 )
	group:insert( stepTxt )
	self.stepTxt = stepTxt
	local stepWgt = widget.newStepper({
		left = 140,
		top  = y,
		width = 40,
		height = 20,
		initialValue = settings.maxToggle,
		minimumValue = 0,
		maximumValue = 9,
		onPress = onStepPress
	})
	group:insert( stepWgt )
	self.stepWgt = stepWgt

	y = y + 30
	
	-- stepper for max num neighbors that can be toggled
	-- default is set in main.lua:  settings.maxToggle
	local clrTxt = display.newText( "Cmap = "..settings.colormap, 20,y,
		native.systemFont, 20 )
	group:insert( clrTxt )
	self.clrTxt = clrTxt
	local clrWgt = widget.newStepper({
		left = 140,
		top  = y,
		width = 40,
		height = 20,
		initialValue = settings.colormap,
		minimumValue = 1,
		maximumValue = 9,
		onPress = onStepPress2
	})
	group:insert( clrWgt )
	self.clrWgt = clrWgt

	local backBtn = widget.newButton( {
			width  = display.contentWidth * 0.75,
			height = 100,
			left = display.contentWidth*0.125,
			top = display.contentHeight - 105,
			label  = "Back",
			onPress = processButton
	})
	backBtn:setReferencePoint( display.TopLeftReferencePoint )
	group:insert( backBtn )
	self.backBtn = backBtn
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	dprint( 10, "enterScene-SettingsScreen" )
	
	local group = self.view

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	dprint( 10, "exitScene-SettingsScreen" )

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
