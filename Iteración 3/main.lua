
theCanvas = {}

_number_agents = 5
_window_height = nil
_window_width = nil

PRESSED = false
PRESSED_X = 0
PRESSED_Y = 0

function love.load()
         require("socket")
         require("slam")
         require("handlers")

         require("classes/_canvas")
         require("classes/_gui")
         require("classes/_button")

         require("classes/_agent")
         require("classes/_group")
         require("classes/_message")

         require("img")
         require("sound")

         math.randomseed(socket.gettime()*10000)

         _window_height = love.graphics.getHeight()
         _window_width = love.graphics.getWidth()

         loadImgs()
         loadSounds()

         theCanvas = Canvas.create()
         theCanvas:setCanvas()
         theCanvas:setDrawBBox(false)

         theGUI = GUI.create()
         theGUI:loadButtons()

         love.graphics.setBackgroundColor( 196, 223, 153, 255 )
end

function love.update(dt)
         theCanvas:Update(dt)
end

function love.draw()
         theCanvas:Draw()
         theGUI:Draw()
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

     if not theGUI:selectButton(x, y) then
        theGUI:handleButton(x, y, button)
     end
end

function love.keypressed(key, unicode)
     if key == 'r' then
        theCanvas:setCanvas()
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

function CollideBBoxS (x1, y1, w1, h1, x2, y2, w2, h2)
         return (math.abs(x1 - x2) * 2 < (w1 + w2)) and (math.abs(y1 - y2) * 2 < (h1 + h2))
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