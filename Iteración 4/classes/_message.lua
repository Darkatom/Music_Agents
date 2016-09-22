
Message = {}
Message.__index = Message

function Message.create( id, sender_id, sender_groupID, dest_id, dest_groupID, message )
   local m = {}
   setmetatable(m, Message)

   local auxSender_index, auxDest_index

   auxSender_index = theCanvas:findAgent(sender_id)
   auxDest_index = theCanvas:findAgent(dest_id)

   m.ID = id

   m.sender = auxSender_index
   m.senderID = theCanvas:getAgent(auxSender_index):getID()
   m.senderGID = sender_groupID

   m.destination = auxDest_index
   m.destinationID = theCanvas:getAgent(auxDest_index):getID()
   m.destinationGID = dest_groupID

   m.x = theCanvas:getAgent(auxSender_index):getXPos()
   m.y = theCanvas:getAgent(auxSender_index):getYPos()

   m.dest_x = theCanvas:getAgent(auxDest_index):getXPos()
   m.dest_y = theCanvas:getAgent(auxDest_index):getYPos()

   m.vel_x = (m.dest_x - m.x)
   m.vel_y = (m.dest_y - m.y)

   m.message = message

   return m
end

function Message:Draw( drawBBox )
   love.graphics.draw(IMGS["message"], self.x, self.y)

   if drawBBox then
      love.graphics.setColor( 0, 0, 0, 255 )
      love.graphics.circle("fill", self.x + _messages_diam/2, self.y + _messages_diam/2, _messages_diam/8, 20)
      love.graphics.line( self.x + _messages_diam/2, self.y + _messages_diam/2, self.dest_x + _agents_instr/2, self.dest_y + _agents_instr/2)
      love.graphics.rectangle("line", self.x, self.y, _messages_diam, _messages_diam)
      love.graphics.setColor( 255, 255, 255, 255 )
   end
end

function Message:Update( dt )
         if (self.x + _messages_diam/2 < self.dest_x + _agents_instr/2)
         or (self.x + _messages_diam/2 > self.dest_x + _agents_instr/2) then
            self.x = self.x + dt*self.vel_x
         end

         if (self.y + _messages_diam/2 < self.dest_y + _agents_instr/2 )
         or (self.y + _messages_diam/2 > self.dest_y + _agents_instr/2 ) then
            self.y = self.y + dt*self.vel_y
         end
end

function Message:UpdateDestinationInfo()
   self.destination = theCanvas:findAgent(self.destinationID)
end

function Message:UpdateSenderInfo()
   self.sender = theCanvas:findAgent(self.senderID)
end

function Message:getXPos()
   return self.x
end

function Message:getYPos()
   return self.y
end

function Message:getID()
   return self.ID
end

function Message:getSenderID()
   return self.senderID
end

function Message:getDestinationID()
   return self.destinationID
end

function Message:getSenderIndex()
   return self.sender
end

function Message:getDestinationIndex()
   return self.destination
end

function Message:getMessage()
   return self.message
end

function Message:getSenderInfo()
   return self.senderID, self.senderGID
end

function Message:setSenderIndex( new_index )
   self.sender = new_index
end

function Message:setSenderInfo( new_sender, new_GID )
   self.senderID = new_sender
   self.senderGID = new_GID
end

function Message:setDestinationInfo( new_dest, new_GID )
   self.destinationID = new_dest
   self.destinationGID = new_GID
end

function Message:getDestinationInfo()
   return self.destination, self.destinationGID
end

function Message:printInfo()
   print("Msg ["..self.ID.."] - CC["..self.x..", "..self.y.."]")
   print("\tFrom: "..self.senderID.." ("..self.senderGID..")")
   print("\tTo: "..self.destinationID.." ("..self.destinationGID..")\n")
end