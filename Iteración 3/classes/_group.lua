Group = {}
Group.__index = Group

function Group.create( id )
   local g = {}
   setmetatable(g, Group)

   g.ID = id
   g.agents = {}

   return g
end

function Group:Draw( drawBBox )
        if self.identifier ~= "default" then
            love.graphics.setColor(255, 0, 0, 150)
            love.graphics.rectangle( "fill", self.x, self.y, self.width, self.height)
            love.graphics.setColor(255, 255, 255, 255)
        end

        for i = 1, #self.agents do
             self.agents[i]:Draw( drawBBox )
        end
end

function Group:Update( dt )
        for i = 1, #self.agents do
             self.agents[i]:Update( dt )
        end
end

function Group:searchAgent( identifier )  -- Returns index of Agent by identifier
         local i = 1
         while i <= #self.agents and self.agents[i]:getIdentifier() ~= identifier do
               i = i + 1
         end

         if i <= #self.agents then
            return i
         end

         return nil
end

function Group:clickedAgent(x, y)
         local i = 1
         while i <= #self.agents and not self.agents[i]:hasCollided( x, y, 0, 0 ) do
               i = i + 1
         end

         if i <= #self.agents then
            return i
         end

         return nil
end

function Group:getSelectedAgents(x, y, width, height)
         local selected = {}
         local indexes = {}
         for i = 1, #self.agents do
             if insideBox (self.agents[i]:getXPos(), self.agents[i]:getYPos(), x, y,width, height) then
                table.insert(selected, self.agents[i])
                table.insert(indexes, i)
             end
         end
         return selected, indexes
end

function Group:getID()
         return self.ID
end

function Group:setIdentifier( new_id )
         self.identifier = new_id
end

function Group:getAgent( id )

         local index = 1

         while index <= #self.agents and self.agents[index]:getID() ~= id do
               index = index + 1
         end
         
         if index <= #self.agents then
            return self.agents[index]
         end
         
         return nil
end

function Group:AddAgent( new_agent )
         new_agent:printInfo()
         table.insert(self.agents, new_agent)
end

function Group:RemoveAgent( old_agent_ID )
         table.remove(self.agents, old_agent_ID )
end

function Group:AddAgents( agent_list)
         for i = 1, #agent_list do
            self:AddAgent(agent_list[i])
         end
end

function Group:RemoveAgents( agent_index_list )
         for i = 1, #agent_index_list do
            self:RemoveAgent(agent_index_list[i])
         end
end

function Group:noAgents()
   return #self.agents < 1
end