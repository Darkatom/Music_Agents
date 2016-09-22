
DRAW_BBOX = false

AGENTS = {}
GROUPS = {}
MESSAGES = {}

DESTROY_MESSAGES = {}
TO_PLAY = {}

MESSAGE_INDEX = 0
AGENT_INDEX = 0
GROUP_INDEX = 0

function loadRequirements()
         require("_agent")
         require("_group")
         require("_message")
         require("img")
         require("sound")

         math.randomseed(socket.gettime()*10000)
end


function setCanvas()
    AGENTS = {}
    GROUPS = {}
    MESSAGES = {}
    
    DESTROY_MESSAGES = {}
    TO_PLAY = {}
    
    MESSAGE_INDEX = 0
    AGENT_INDEX = 0
    GROUP_INDEX = 0

    for i = 1, _number_agents do
       local x = math.random(50, _window_width-50)
       local y = math.random(50, _window_height-50)
       newAgent( "default", x, y )
    end
    
    AGENT_INDEX = #AGENTS
end

function playMessages()
   if #TO_PLAY > 0 then
        SOUNDS[TO_PLAY[1].playSound]:setPitch(TO_PLAY[1].playPitch)
        SOUNDS[TO_PLAY[1].playSound]:setVolume(TO_PLAY[1].playVolume)
        SOUNDS[TO_PLAY[1].playSound]:play()
        table.remove(TO_PLAY, 1)
   end
end


function destroyMessages()
         local pos
         for i = 1, #DESTROY_MESSAGES do
             pos = 1
             while pos <= #MESSAGES and MESSAGES[pos]:getID() ~= DESTROY_MESSAGES[i] do
                   pos = pos + 1
             end
             if pos <= #MESSAGES then
                -- print("Msg ["..MESSAGES[pos]:getIdentifier().."] has been destroyed.")

                local msg = {}

                msg.playSound = AGENTS[ MESSAGES[pos]:getDestinationIndex() ]:getNote()
                msg.playPitch = MESSAGES[pos]:getMessage()
                msg.playVolume = _messages_radius/10
                table.insert(TO_PLAY, msg)

                AGENTS[ MESSAGES[pos]:getSenderIndex() ]:setSending(false)
                table.remove(MESSAGES, pos)
             end
         end
end

function findAgent( id )
         local index = 1

         while index <= #AGENTS and AGENTS[index]:getID() ~= id do
               index = index + 1
         end

         if index <= #AGENTS then
            return index
         end

         return nil
end

function findAgentGroup( identifier )
         local index
         for key, value in pairs(GROUPS) do
            index = GROUPS[key]:searchAgent( identifier )
            if index ~= nil then
               return key, index
            end
         end

         return nil
end