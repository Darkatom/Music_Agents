
_sound_path = "/sounds/"
_number_agents = 5
_window_height = love.graphics.getHeight()
_window_width = love.graphics.getWidth()

PRESSED = false
PRESSED_X = 0
PRESSED_Y = 0

function love.load()
         require("canvas_control")
         require("mouse_control")
         require("socket")
         require("slam")

         loadRequirements()

         loadImgs()
         loadSounds()

         setCanvas()

         love.graphics.setBackgroundColor( 196, 223, 153, 255 )
end

function love.update(dt)

         playMessages()

         for i = 1, #AGENTS do
             AGENTS[i]:Update( dt )
         end

         for i = 1, #MESSAGES do
             MESSAGES[i]:Update( dt )
         end

         destroyMessages()
end

function love.draw()
         for i = 1, #MESSAGES do
             MESSAGES[i]:Draw(DRAW_BBOX)
         end

         for i = 1, #AGENTS do
             AGENTS[i]:Draw(DRAW_BBOX)
         end
end

function love.mousepressed(x, y, button)
        if button == 'r' then
           PRESSED = true
           PRESSED_X = x
           PRESSED_Y = y
        end
end

function love.mousereleased(x, y, button)
     local index, note

     if button == 'l' then
        index = selectAgent(x, y)

        if index ~= nil then
           AGENTS[index]:NextNote()
        else
           newAgent("default", x, y)
        end
     elseif button == 'r' then
         --if PRESSED then
         --   print("Doing group")
         --   local xPos = math.min(PRESSED_X, x)
         --   local yPos = math.min(PRESSED_Y, y)
         --   local width = math.max(PRESSED_X, x) - xPos
         --   local height = math.max(PRESSED_Y, y) - yPos
         --   local indexes = selectAreaAgents(xPos, yPos, width, height)

         --   if #indexes > 0 then
         --      newGroup()
         --      for i = 1, #indexes do
         --          GROUPS[GROUP_INDEX]:AddAgents(AGENTS[indexes[i]]:getID())
         --          AGENTS[indexes[i]]:setGroupID(GROUP_INDEX)
         --      end
         --   end

         --   PRESSED = false
         --else
            index = selectAgent(x, y)
            if index ~= nil then
               AGENTS[index]:PreviousNote()
            end
        --end
     end
end

function love.keypressed(key, unicode)
         if key == 'r' then
            setCanvas()
         end
end

function love.keyreleased(key, unicode)
end

function love.focus(f)
end

function love.quit()
end


-- UTILS --

function insideBox (px, py, x, y, wx, wy)
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end

function getDistance( x1, y1, x2, y2 )
   xDiff = x2 - x1
   yDiff = y2 - y1
   return math.sqrt( (xDiff*xDiff) + (yDiff*yDiff) )
end

function getAngle( x1, y1, x2, y2 )
   xDiff = x2 - x1
   yDiff = y2 - y1
   return math.atan2(yDiff, xDiff)
end

function degree2Radian( n )
   return n * (math.pi/180)
end