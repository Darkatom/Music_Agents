
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

   a.volumen = 1

   a.pitchMin = 0.2
   a.pitchMax = 1

   a.rate = 500
   a.sending = false

   return a
end

function Agent:Draw( drawBBox )

   love.graphics.draw(IMGS["agent"], self.x, self.y)
   love.graphics.draw(IMGS[_instr_index[self.instrument]], self.x, self.y)

   love.graphics.draw(IMGS["agent_mod"], self.x + _agents_instr - _agents_mod/2 , self.y - _agents_mod/2)                 -- Note
   love.graphics.draw(IMGS["agent_mod"], self.x + _agents_instr - _agents_mod/2 , self.y + _agents_instr - _agents_mod/2) -- Message type
   love.graphics.draw(IMGS["agent_mod"], self.x - _agents_mod/2 , self.y - _agents_mod/2)                                 -- Pitch Min/Max
   love.graphics.draw(IMGS["agent_mod"], self.x - _agents_mod/2 , self.y + _agents_instr - _agents_mod/2)                 -- Volumen

   love.graphics.setColor( 0, 0, 0, 255 )
   love.graphics.print(_sound_index[self.note], self.x + _agents_instr - _agents_mod/3 , self.y - _agents_mod/4 , 0, 1, 1, 0 )
   love.graphics.print(self.pitchMax          , self.x - _agents_mod/3 + 2              , self.y - _agents_mod/3 - 2, 0, 0.8, 0.8, 0 )

   love.graphics.line( self.x - _agents_mod/2 + 2, self.y - _agents_mod/11 + 2, self.x + _agents_mod/2 - 2, self.y - _agents_mod/11 + 2 )

   love.graphics.print(self.pitchMin          , self.x - _agents_mod/3 + 2              , self.y - _agents_mod/11 + 2, 0, 0.8, 0.8, 0 )
   love.graphics.print(self.volumen           , self.x - _agents_mod/3 , self.y + _agents_instr - _agents_mod/4 , 0, 1, 1, 0 )


   if drawBBox then
      local x, y = love.mouse.getPosition()
      if self:hasCollided(x, y, 0, 0) then
          love.graphics.circle("fill", self.x + _agents_instr/2, self.y + _agents_instr/2, _agents_instr/8, 20)
          love.graphics.rectangle("line", self.x - _agents_mod/2, self.y - _agents_mod/2, _agents_width, _agents_height) -- General BBox

          if self:hasCollided_Note(x, y) then
             love.graphics.rectangle("line", self.x + _agents_instr - _agents_mod/2 , self.y - _agents_mod/2, _agents_mod, _agents_mod) -- Instrument BBox
          end

          if self:hasCollided_Instrument(x, y) then
             love.graphics.rectangle("line", self.x, self.y, _agents_instr, _agents_instr) -- Instrument BBox
          end

          if self:hasCollided_Volumen(x, y) then
             love.graphics.rectangle("line", self.x - _agents_mod/2 , self.y + _agents_instr - _agents_mod/2, _agents_mod, _agents_mod)
          end
          
          if self:hasCollided_PitchMax(x, y) then
             love.graphics.rectangle("line", self.x - _agents_mod/2 , self.y - _agents_mod/2, _agents_mod, _agents_mod/2)
          end

          if self:hasCollided_PitchMin(x, y) then
             love.graphics.rectangle("line", self.x - _agents_mod/2 , self.y - _agents_mod/8 + 2, _agents_mod, _agents_mod/2)
          end
          
          if self:hasCollided_MessageType(x, y) then
             love.graphics.rectangle("line", self.x + _agents_instr - _agents_mod/2 , self.y + _agents_instr - _agents_mod/2, _agents_mod, _agents_mod)
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


-- // AGENT FUNCTIONS // --

function Agent:sendMessage()
         local destIndex = theCanvas:pickRandomAgent( self.ID, self.groupID )

         if destIndex ~= nil then
            self.sending = true

            local pitch = self.pitchMin
            if self.pitchMin ~= self.pitchMax then
               pitch = math.random() + math.random(self.pitchMin, self.pitchMax)
            end
            theCanvas:newMessage( self.ID, self.groupID, destIndex, pitch )
         end

end


-- // NEXT & PREVIOUS // --

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

function Agent:AddVolume( addVolume )
	self.volumen = self.volumen + addVolume
	if self.volumen >= 5 then
	   self.volumen = 2
        elseif self.volumen <= 0 then
           self.volumen = 0
        end
end

function Agent:AddPitchMin( addPitch )
	self.pitchMin = self.pitchMin + addPitch
	if self.pitchMin >= self.pitchMax then
	   self.pitchMin = self.pitchMax
        elseif self.pitchMin <= 0 then
           self.pitchMin = 0
        end
end

function Agent:AddPitchMax( addPitch )
	self.pitchMax = self.pitchMax + addPitch
	if self.pitchMax >= 3 then
	   self.pitchMax = 3
        elseif self.pitchMax <= self.pitchMin then
           self.pitchMax = self.pitchMin
        end
end

function Agent:NextMessageType()

end

function Agent:PreviousMessageType()

end


-- // GETs // --

function Agent:getID()
   return self.ID
end

function Agent:getGroupID()
   return self.groupID
end

function Agent:getInfo()
   return self.ID, self.groupID
end

function Agent:getXPos()
   return self.x
end

function Agent:getYPos()
   return self.y
end

function Agent:getInstrument()
   return self.instrument
end

function Agent:getNote()
   return self.note
end

function Agent:getVolumen()
	return self.volumen
end

function Agent:getPitchMin()
	return self.pitchMin
end

function Agent:getPitchMax()
	return self.pitchMax
end

function Agent:isSending()
	return self.sending
end


-- // SETs // --

function Agent:setGroupID( new_GID )
   print("GID "..self.groupID.." -> "..new_GID)
   self.groupID = new_GID
end

function Agent:setXPos( x )
   self.x = x
end

function Agent:setYPos( y )
   self.y = y
end

function Agent:setSending( send )
   self.sending = send
end


-- // COLLISION DETECTION // --

function Agent:hasCollided( x, y, w, h )
    return CollideBBoxS (self.x, self.y - _agents_mod/2, _agents_width, _agents_height, x, y, w, h) or
           insideBox (x, y, self.x - _agents_mod/2, self.y - _agents_mod/2, _agents_width, _agents_height)
end

function Agent:hasCollided_Instrument( x, y )
    return insideBox (x, y, self.x, self.y, _agents_instr, _agents_instr)
end

function Agent:hasCollided_Note( x, y )
    return insideBox (x, y, self.x + _agents_instr - _agents_mod/2 , self.y - _agents_mod/2, _agents_mod, _agents_mod)
end

function Agent:hasCollided_Volumen( x, y )
    return insideBox (x, y, self.x - _agents_mod/2 , self.y + _agents_instr - _agents_mod/2, _agents_mod, _agents_mod)
end

function Agent:hasCollided_PitchMax( x, y )
    return insideBox (x, y, self.x - _agents_mod/2 , self.y - _agents_mod/2, _agents_mod, _agents_mod/2)
end

function Agent:hasCollided_PitchMin( x, y )
    return insideBox (x, y, self.x - _agents_mod/2 , self.y - _agents_mod/8 + 2, _agents_mod, _agents_mod/2)
end

function Agent:hasCollided_MessageType( x, y )
    return insideBox (x, y, self.x + _agents_instr - _agents_mod/2 , self.y + _agents_instr - _agents_mod/2, _agents_mod, _agents_mod)
end


-- // INFO // --

function Agent:printInfo()
   print("Agent -\n\tID "..self.ID.." - Group: " .. self.groupID .." - CC["..self.x..", "..self.y.."]")
   print("\tInstrument: ".._instr_index[self.instrument].." - Note: ".._sound_index[self.note].."\n")
end
