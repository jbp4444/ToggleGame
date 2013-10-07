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

local Game = {}

function Game.new()
	local game = display.newGroup()
	game.id = "game"

	local MessageBox = require("scripts.MessageBox")
		
	-- variables

	-- timer for transitions
	local timer_obj
	local timer_is_running = false
	
	-- constants
	
	-- functions
	
	local function touchHandler( event )
		dprint( 7, "processButton phase=" .. event.phase )
		if event.phase == "began" then
			dprint( 7, "touch at "..event.x..","..event.y)
			target = event.target
			if( target == nil ) then
				-- this is a click on the background
				dprint( 7, "  target=nil" )
			else
				-- some object was touched
				local type = target.myType
				if( type == nil ) then
					-- not sure what this is
					dprint( 7, "  type=nil" )
				elseif( type == "button" ) then
					dprint( 7, "  target="..target.myType..","..target.myId )
					-- toggle for the pressed button happens automatically
					local btn  = game.btn
					local mask = btn[ target.myId ].mask
					for c=1,9 do
						if( mask[c] == 1 ) then
							if( btn[c].isOn ) then
								btn[c]:setState( { isOn=false } )
							else
								btn[c]:setState( { isOn=true } )
							end
						end
					end
					
				else
					-- not sure what this is
					dprint( 7, "  target=(unknown)" )
				end
			end
		end
		
		-- for any touch event that we see here, check if this is a "win"
		local c = 0
		local btn = game.btn
		for i=1,9 do
			if( btn[i].isOn == true ) then
				c = c + 1
			end
		end
		if( c == 9 ) then
			gameOver()
		end

		return true
	end

	function cancelMessage()
		dprint( 7, "cancelMessage" )
		if( game.msgBox ~= nil ) then
			game:remove( game.msgBox ) 
			game.msgBox = nil
		end
		timer.cancel( timer_obj )
		timer_is_running = false
	end

	function cancelTimer()
		dprint( 7, "cancelTimer" )
		cancelMessage()
		storyboard.gotoScene( "scripts.MainScreen" )
	end
	
	function gameOver()
		dprint( 7, "Game Over" )
		local msg = MessageBox.new()
		game:insert( msg )
		game.msgBox = msg
		msg:addEventListener( "touch", function()
			return true
			end
		)
		timer_is_running = true
		timer_obj = timer.performWithDelay( 700, function()
			cancelTimer()
			end
		)
	end
	
	function game:startGame()
		dprint( 7, "startGame - max-t="..settings.maxToggle )
		-- initialize the screen
		local btnsheet = graphics.newImageSheet( "assets/buttonsheet.png", {
			width = 128,
			height = 128,
			numFrames = 12
		})
		game.btnsheet = btnsheet
		
		local function getButton()
			local btn = widget.newSwitch( {
				sheet = btnsheet,
				style = "checkbox",
				frameOn = settings.colormap*2 + 1,
				frameOff = settings.colormap*2 + 2,
				width = 100,
				height = 100,
				initialSwitchState = false,
				onPress = touchHandler
				
			} )
			btn.myType = "button"
			--btn:setReferencePoint( display.TopLeftReferencePoint )
			game:insert( btn )
			return btn
		end

		local c = 1
		local btn = {}
		for y=1,3 do
			for x=1,3 do
				btn[c] = getButton()
				btn[c].myId = c
				btn[c].x = 100*(x-2) + display.contentWidth*0.50
				btn[c].y = 100*(y-2) + display.contentHeight*0.33
				btn[c].mask = {}
				c = c + 1
			end
		end
		game.btn = btn

		-- set masks for each button
		-- TODO: should probably check that every button has at least two mask entries
		local flag = 1
		while( flag == 1 ) do
			for c=1,9 do
				local mask = btn[c].mask
				for cc=1,9 do
					mask[cc] = 0
				end
				for cc=1,settings.maxToggle do
					local ii = math.random( 1,9 )
					if( ii == c ) then
						-- skip it
					else
						mask[ii] = 1
					end
				end 
			end
			-- TODO: check mask entries
			flag = 0
		end
		
		-- calculate initial state
		for c=1,9 do
			if( math.random( 0, 1 ) == 1 ) then
				btn[c]:setState( { isOn=true } )
			else
				btn[c]:setState( { isOn=false } )
			end
		end
		
		--Runtime:addEventListener("touch", handleTouch )
	end
	
	return game
end

return Game