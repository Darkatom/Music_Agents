
Canvas = {}
Canvas.__index = Canvas

function Canvas.create()
   local c = {}
   setmetatable(c, Canvas)

   c.DrawBbox = false

   c.Agents = {}
   c.Groups = {}
   c.Messages = {}

   c.DestroyMessages = {}
   c.ToPlay = {}

   c.MessageIndex = 0
   c.AgentIndex = 0
   c.GroupIndex = 0

   return c
end

function Canvas:Update( dt )
         self:playMessages()

         for i = 1, #self.Agents do
             self.Agents[i]:Update( dt )
         end

         for i = 1, #self.Messages do
             self.Messages[i]:Update( dt )
         end

         self:destroyMessages()
end

function Canvas:Draw()
         for i = 1, #self.Messages do
             self.Messages[i]:Draw(self.DrawBbox)
         end

         for i = 1, #self.Agents do
             self.Agents[i]:Draw(self.DrawBbox)
         end
end

function Canvas:setCanvas()
     self.DrawBbox = false

     self.Agents = {}
     self.Groups = {}
     self.Messages = {}

     self.DestroyMessages = {}
     self.ToPlay = {}

     self.MessageIndex = 0
     self.AgentIndex = 0
     self.GroupIndex = 0

     for i = 1, _number_agents do
         local x = math.random(50, _window_width-50)
         local y = math.random(50, _window_height-50)
         self:newAgent( "default", x, y )
     end

     self.AgentIndex = #self.Agents
end


-- // ADDING // --

function Canvas:newAgent( groupID, x, y )
        local colliding = self:collidesAgent(x, y)
        while colliding ~= nil and x >= 0 and x <= _window_width and y >= 0 and y <= _window_height do
           x = self.Agents[colliding]:getXPos() - _agents_radius*2
           y = self.Agents[colliding]:getYPos() + _agents_radius*2
           colliding = self:collidesAgent(x, y)
        end

        if x >= 0 and x <= _window_width and y >= 0 and y <= _window_height then
        	note = math.floor(math.random (1, #_sound_index))
        	self.AgentIndex = self.AgentIndex + 1
        	table.insert(self.Agents, Agent.create(self.AgentIndex, groupID, x, y, note))
        	self.Agents[#self.Agents]:printInfo()
	end
end

function Canvas:deleteAgent( index )
         local groupID = self.Agents[index]:getGroupID()
         local ID = self.Agents[index]:getID()
         local toDestroy = {}

         table.remove(self.Agents, index)
         
         if groupID ~= "default" then
            self.Groups[groupID]:RemoveAgent(ID)
            if self.Groups[groupID]:noAgents() then
               table.remove(self.Groups, groupID)
            end
         end
         
         for i = 1, #self.Messages do
             msg = self.Messages[i]
             if msg:getDestinationID() == ID then
                table.insert(toDestroy, i)
             else
                if msg:getSenderID() == ID then
                   self.Messages[i]:setSenderIndex(nil)
                else
                   self.Messages[i]:UpdateSenderInfo()
                end
                self.Messages[i]:UpdateDestinationInfo()
             end
         end
         
         for i = 1, #toDestroy do
            table.remove(self.Messages, toDestroy[i])
         end
end

function Canvas:newMessage( senderID, senderGID, destIndex, pitch )
	self.MessageIndex = self.MessageIndex + 1

	local message = Message.create( self.MessageIndex, senderID, senderGID, self.Agents[destIndex]:getID(), self.Agents[destIndex]:getGroupID(), pitch )
	message:printInfo()

	table.insert(self.Messages, message)
end

function Canvas:newGroup()
	self.GroupIndex = self.GroupIndex + 1
	table.insert(self.Groups, Group.create(self.GroupIndex))
end


-- // MESSAGE TREATMENT // --

function Canvas:playMessages()
   if #self.ToPlay > 0 then
        SOUNDS[self.ToPlay[1].playSound]:setPitch(self.ToPlay[1].playPitch)
        SOUNDS[self.ToPlay[1].playSound]:setVolume(self.ToPlay[1].playVolume)
        SOUNDS[self.ToPlay[1].playSound]:play()
        table.remove(self.ToPlay, 1)
   end
end

function Canvas:destroyMessages()
         local pos, msg

         for i = 1, #self.Messages do
             msg = self.Messages[i]
             if self.Agents[msg:getDestinationIndex()]:hasCollided( msg:getXPos(), msg:getYPos(), _messages_radius ) then
                table.insert(self.DestroyMessages, msg:getID())
                -- print("Msg ["..self.ID.."] is going to be destroyed.")
              end
         end


         for i = 1, #self.DestroyMessages do
             pos = 1
             while pos <= #self.Messages and self.Messages[pos]:getID() ~= self.DestroyMessages[i] do
                   pos = pos + 1
             end
             if pos <= #self.Messages then
                -- print("Msg ["..MESSAGES[pos]:getIdentifier().."] has been destroyed.")

                local msg = {}

                msg.playSound = self.Agents[ self.Messages[pos]:getDestinationIndex() ]:getNote()
                msg.playPitch = self.Messages[pos]:getMessage()
                msg.playVolume = _messages_radius/10
                table.insert(self.ToPlay, msg)

                if self.Messages[pos]:getSenderIndex() ~= nil then
                    self.Agents[ self.Messages[pos]:getSenderIndex() ]:setSending(false)
                end
                table.remove(self.Messages, pos)
             end
         end
end


-- // PICK, SELECT, FIND // --

function Canvas:pickRandomAgent( myID, groupID )
    local index = nil

    if groupID == "default" and #self.Agents > 0 then
       index = math.random(1, #self.Agents)

       while self.Agents[index]:getID() == myID do
            index = math.random(1, #self.Agents)
       end

    elseif #self.Groups[groupID].agents > 1 then
       index = math.random(1, #self.Groups[groupID].agents)

       while self.Groups[groupID].agents[index] == self.ID do
            index = math.random(1, #self.Groups[groupID].agents)
       end
    
    end

    return index
end

function Canvas:selectAgent(x, y)
   local index = 1

   while index <= #self.Agents and not self.Agents[index]:hasCollided(x, y, 0, 0) do
      index = index + 1
   end

   if index <= #self.Agents then
      return index
   end

   return nil
end

function Canvas:selectAreaAgents(x, y, width, height)
   local indexes = {}

   for i = 1, #self.Agents do
      if self.Agents[i]:hasCollided(x, y, width, height) then
         table.insert(indexes, i)
      end
   end

   return indexes
end

function Canvas:findAgent( id )
         local index = 1

         while index <= #self.Agents and self.Agents[index]:getID() ~= id do
               index = index + 1
         end

         if index <= #self.Agents then
            return index
         end

         return nil
end

function Canvas:findAgentGroup( id )
         local index
         for key, value in pairs(self.Groups) do
            index = self.Groups[key]:searchAgent( id )
            if index ~= nil then
               return key, index
            end
         end

         return nil
end

function Canvas:collidesAgent(x, y)
    local index = 1

    while index <= #self.Agents and not self.Agents[index]:hasCollided(x, y, 0, 0) do
       index = index + 1
    end

    if index <= #self.Agents then
       return index
    end
    
    return nil
end


-- // GETs & SETs // --

function Canvas:getAgent( index )
   return self.Agents[index]
end

function Canvas:getNextMessageID()
         self.MessageIndex = self.MessageIndex + 1
         return self.MessageIndex
end

function Canvas:getNextAgentID()
         self.AgentIndex = self.AgentIndex + 1
         return self.AgentIndex
end

function Canvas:getNextGroupID()
         self.GroupIndex = self.GroupIndex + 1
         return self.GroupIndex
end


-- // INTERFACE // --

function Canvas:NextNoteOf( index )
         self.Agents[index]:NextNote()
end

function Canvas:PreviousNoteOf( index )
         self.Agents[index]:PreviousNote()
end