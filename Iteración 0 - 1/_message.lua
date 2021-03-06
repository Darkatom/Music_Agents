
Message = {}
Message.__index = Message

function Message.create( id, sender_id, sender_groupID, dest_id, dest_groupID, message )
   local m = {}
   setmetatable(m, Message)

   local auxSender_index, auxDest_index

   auxSender_index = findAgent(sender_id)
   auxDest_index = findAgent(dest_id)

   m.ID = id

   m.sender = auxSender_index
   m.senderID = AGENTS[auxSender_index]:getID()
   m.senderGID = sender_groupID

   m.destination = auxDest_index
   m.destinationID = AGENTS[auxDest_index]:getID()
   m.destinationGID = dest_groupID

   m.x = AGENTS[auxSender_index]:getXPos()
   m.y = AGENTS[auxSender_index]:getYPos()

   m.dest_x = AGENTS[auxDest_index]:getXPos()
   m.dest_y = AGENTS[auxDest_index]:getYPos()

   m.vel_x = (m.dest_x - m.x)
   m.vel_y = (m.dest_y - m.y)

   m.message = message

   return m
end

function Message:Draw( drawBBox )
   -- love.graphics.circle("fill", self.x, self.y, self.radius, self.segments)
   love.graphics.draw(IMGS["message"], self.x - _messages_radius, self.y - _messages_radius)

   if drawBBox then
      love.graphics.rectangle("line", self.x - _messages_radius, self.y - _messages_radius, _messages_radius*2, _messages_radius*2)
   end
end

function Message:Update( dt )
         if (self.x < self.dest_x - _agents_radius/10 or self.x > self.dest_x + _agents_radius/10) then
            self.x = self.x + dt*self.vel_x
         end

         if (self.y < self.dest_y - _agents_radius/10 or self.y > self.dest_y + _agents_radius/10) then
            self.y = self.y + dt*self.vel_y
         end

         if AGENTS[self.destination]:hasCollided( self.x, self.y, _messages_radius ) then
              table.insert(DESTROY_MESSAGES, self.ID)
              -- print("Msg ["..self.ID.."] is going to be destroyed.")
         end
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
   print("Msg ["..self.ID.."] - CC["..self.x..", "..self.y.."] - From: "..self.senderID.." "..self.senderGID.." - To: "..self.destinationID.." "..self.destinationGID)
end