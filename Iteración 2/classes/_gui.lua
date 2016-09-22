
GUI = {}
GUI.__index = GUI

function GUI.create( )
   local g = {}
   setmetatable(g, GUI)
   
   g.x = 0
   g.y = 0
   g.width = 0
   g.height = 0

   g.buttons = {}
   g.selectedButton = nil

   return g
end

function GUI:loadButtons( )

     local butNames, total, b_width, b_height, x, y, third_part, gap
     
     butNames = { "hand", "addAgent", "deleteAgent" } --, "addGroup", "deleteGroup" }

     total = #butNames
     b_width = 40
     b_height = 40

     x = 3

     third_part = _window_height / 3
     gap = third_part / total
     
     if gap >= b_height then
        gap = gap - b_height
        y = math.floor(third_part)
     else
        y = math.floor( third_part - gap/2 )
        gap = 0
     end

     for i = 1, total do
        self.buttons[butNames[i]] = Button.create( butNames[i], x, y + (b_height + gap)*(i-1), b_width, b_height)
        self.buttons[butNames[i]]:printInfo()
     end

     self.x = x
     self.y = y
     self.width = b_width
     self.height = (b_height + gap)*total
     
     print(self.x.." "..self.y.." "..self.width.." "..self.height)


     self.buttons["hand"]:setHandler(Hand)
     self.buttons["addAgent"]:setHandler(AddAgent)
     self.buttons["deleteAgent"]:setHandler(DeleteAggent)
     --self.buttons["addGroup"]:setHandler( )
     --self.buttons["deleteGroup"]:setHandler( )

     self.buttons["hand"]:Select(true)
     
     self.selectedButton = "hand"
end

function GUI:Draw()
   for key, value in pairs(self.buttons) do
      self.buttons[key]:Draw()
   end
end

function GUI:selectButton(x, y)
   if insideBox (x, y, self.x, self.y, self.width, self.height) then
       local selected = nil
       for key, value in pairs(self.buttons) do
          if self.buttons[key]:wasClicked(x, y) then
             selected = key
          end
       end
    
       if selected ~= nil and selected ~= self.selectedButton then
          self.buttons[selected]:Select(true)
          self.buttons[self.selectedButton]:Select(false)
          self.selectedButton = selected
          return true
       end
   end
   
   return false
end

function GUI:handleButton(x, y, button)
   self.buttons[self.selectedButton].handler(x, y, button)
end
