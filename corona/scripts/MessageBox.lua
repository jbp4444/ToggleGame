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

local MessageBox = {}

function MessageBox.new()
	local text = "You Win!!"
	
	dprint( 15, "text=["..text.."]" )
	
	local grp = display.newGroup()
	grp.myType = "message"
	
	local bkgd = display.newRoundedRect( (HALF_WIDTH/2),(HALF_HEIGHT/2), HALF_WIDTH,HALF_HEIGHT, 12 )
	bkgd.strokeWidth = 3
	bkgd:setFillColor(90,90,90)
	bkgd:setStrokeColor(64,100,180)
	grp:insert( bkgd )

	local txt = display.newText( text, (HALF_WIDTH/2),(HALF_HEIGHT/2), 
		HALF_WIDTH,HALF_HEIGHT, 
		native.systemFontBold,16 )
	txt:setTextColor( 255,255,255 )
	grp:insert( txt )
	
	return grp
end

return MessageBox