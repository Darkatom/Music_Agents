
Agent = {}
Agent.__index = Agent

function Agent.create( id, group_id, x_pos, y_pos, instrument, note)
   local a = {}
   setmetatable(a, Agent)

   a.ID = id
   a.groupID = group_id
   a.instrument = instrument
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

   love.graphics.draw(IMGS["agent"], self.x, self.y)
   love.graphics.draw(IMGS[_instr_index[self.instrument]], self.x, self.y)
   love.graphics.draw(IMGS["agent_note"], self.x + _agents_instr/2, self.y - _agents_note/2)

   love.graphics.setColor( 0, 0, 0, 255 )
   love.graphics.print(_sound_index[self.note], self.x + 2*_agents_instr/3, self.y - _agents_note/4, 0, 1, 1, 0 )

   if drawBBox then
      local x, y = love.mouse.getPosition()
      if self:hasCollided(x, y, 0, 0) then
          love.graphics.circle("fill", self.x + _agents_instr/2, self.y + _agents_instr/2, _agents_instr/8, 20)
          love.graphics.rectangle("line", self.x, self.y - _agents_note/2, _agents_width, _agents_height) -- General BBox

          if self:hasCollided_Note(x, y) then
             love.graphics.rectangle("line", self.x + _agents_instr/2, self.y - _agents_note/2, _agents_note, _agents_note) -- Instrument BBox
          end
          if self:hasCollided_Instrument(x, y) then
             love.graphics.rectangle("line", self.x, self.y, _agents_instr, _agents_instr) -- Instrument BBox
          end
      end
   end
   love.graphics.setColor( 255, 255, 255, 255 )
end

function Agent:Update( dt )
         if not self.sending and math.random(1, self.rate) == math.floor(self.rate/2) then
                self:sendMessage()
         end
end

function Agent:NextInstrument()
         self.instrument = self.instrument + 1
         if self.instrument > #_instr_index then
            self.instrument = 1
         end
end

function Agent:PreviousInstrument()
         self.instrument = self.instrument - 1
         if self.instrument < 1 then
            self.instrument = #_instr_index
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
    return CollideBBoxS (self.x, self.y - _agents_note/2, _agents_width, _agents_height, x, y, w, h) or
           insideBox (x, y, self.x, self.y - _agents_note/2, _agents_width, _agents_height)
end

function Agent:hasCollided_Instrument( x, y )
    return insideBox (x, y, self.x, self.y, _agents_instr, _agents_instr)
end

function Agent:hasCollided_Note( x, y )
    return insideBox (x, y, self.x + _agents_instr/2, self.y - _agents_note/2, _agents_note, _agents_note)
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

function Agent:getInstrument()
   return self.instrument
end

function Agent:getNote()
   return self.note
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
   print("Agent -\n\tID "..self.ID.." - Group: " .. self.groupID .." - CC["..self.x..", "..self.y.."]")
   print("\tInstrument: ".._instr_index[self.instrument].." - Note: ".._sound_index[self.note].."\n")
end
