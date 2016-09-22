
Agent = {}
Agent.__index = Agent

function Agent.create( id, group_id, x_pos, y_pos, note)
   local a = {}
   setmetatable(a, Agent)

   a.ID = id
   a.groupID = group_id
   a.note = note

   a.x = x_pos
   a.y = y_pos
   
   a.pitchMin = 0.2
   a.pitchMax = 1

   a.rate = 500
   a.sending = false

   return a
end

function Agent:Draw( drawBBox )
   
   love.graphics.draw(IMGS["agent"], self.x - _agents_radius, self.y - _agents_radius)
   love.graphics.setColor( 0, 0, 0, 255 )
   love.graphics.print(_sound_index[self.note], self.x - _agents_radius/4, self.y - _agents_radius/3, 0, 1, 1, 0 )
   love.graphics.setColor( 255, 255, 255, 255 )

   if drawBBox then
      love.graphics.rectangle("line", self.x - _agents_radius, self.y - _agents_radius, self.radius*2, _agents_radius*2)
   end
end

function Agent:Update( dt )
         if not self.sending and math.random(1, self.rate) == math.floor(self.rate/2) then
                self:sendMessage()
         end
end

function Agent:NextNote()
         self.note = self.note + 1
         if self.note > #_sound_index then
            self.note = 1
         end
end

function Agent:PreviousNote()
         self.note = self.note - 1
         if self.note < 1 then
            self.note = #_sound_index
         end
end


function Agent:sendMessage()
         local destIndex = theCanvas:pickRandomAgent( self.ID, self.groupID )

         if destIndex ~= nil then
            self.sending = true

            local pitch = math.random() + math.random(self.pitchMin, self.pitchMax)
            theCanvas:newMessage( self.ID, self.groupID, destIndex, pitch )
         end

end

function Agent:hasCollided( x, y, w, h )
    if h == nil then h = w end
    return insideBox (x - w, y - h,
                      self.x - _agents_radius, self.y - _agents_radius,
                      _agents_radius*2, _agents_radius*2)
end

function Agent:addReceived( index )
   table.insert(self.received, index)
end

function Agent:setSending( send )
   -- print( "Agent -\n\tIndex "..self.ID.." turned sending to "..tostring(self.sending))
   self.sending = send
end

function Agent:getID()
   return self.ID
end

function Agent:getGroupID()
   return self.groupID
end

function Agent:setGroupID( new_GID )
   print("GID "..self.groupID.." -> "..new_GID)
   self.groupID = new_GID
end

function Agent:getNote()
   return _sound_index[self.note]
end

function Agent:getXPos()
   return self.x
end

function Agent:getYPos()
   return self.y
end

function Agent:getInfo()
   return self.ID, self.groupID
end

function Agent:getRadius()
   return self.radius
end

function Agent:printInfo()
   print("Agent -\n\tID "..self.ID.." - Group: " .. self.groupID .." - CC["..self.x..", "..self.y.."]\n\t Note: "..self.note.."\n")
end
