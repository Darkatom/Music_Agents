
Button = {}
Button.__index = Button

function Button.create( id, x_pos, y_pos, width, height )
   local b = {}
   setmetatable(b, Button)
   
   b.ID = id
   b.x = x_pos
   b.y = y_pos
   b.width = width
   b.height = height
   b.handler = nil
   b.selected = false

   return b
end

function Button:Draw()
   if self.selected then
       love.graphics.draw( IMGS[self.ID.."_selected"], self.x, self.y )
   else
       love.graphics.draw( IMGS[self.ID], self.x, self.y )
   end
end

function Button:wasClicked(x, y)
   return insideBox (x, y, self.x, self.y, self.width, self.height)
end

function Button:setHandler( new_handler )
   self.handler = new_handler
end

function Button:Select( selected )
   self.selected = selected
end

function Button:isSelected()
   return self.selected
end

function Button:printInfo()
   print("Button ID "..self.ID.." - ["..self.x..", "..self.y.."] "..self.width.."x"..self.height)
end