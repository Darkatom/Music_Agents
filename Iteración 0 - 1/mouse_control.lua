
function newGroup()
         GROUP_INDEX = GROUP_INDEX + 1
         table.insert(GROUPS, Group.create(GROUP_INDEX))
end

function newAgent( groupID, x, y )
          note = math.floor(math.random (1, #_sound_index))
          AGENT_INDEX = AGENT_INDEX + 1
          table.insert(AGENTS, Agent.create(AGENT_INDEX, groupID, x, y, note))
          AGENTS[AGENT_INDEX]:printInfo()
end

function selectAgent(x, y)
   local index = 1

   while index <= #AGENTS and not AGENTS[index]:hasCollided(x, y, 0, 0) do
      index = index + 1
   end

   if index <= #AGENTS then
      return index
   end

   return nil
end

function selectAreaAgents(x, y, width, height)
   local indexes = {}

   for i = 1, #AGENTS do
      if AGENTS[i]:hasCollided(x, y, width, height) then
         table.insert(indexes, i)
      end
   end

   return indexes
end