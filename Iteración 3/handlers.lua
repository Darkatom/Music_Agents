
function Hand(x, y, button)
    local index, agent
    if button == 'l' then
      index = theCanvas:selectAgent(x, y, 0, 0)
      print(index)
      if index ~= nil then
         agent = theCanvas:getAgent(index)
         
         if agent:hasCollided_Note(x, y) then
            theCanvas:NextNoteOf( index )

         elseif agent:hasCollided_Instrument(x, y) then
            theCanvas:NextInstrumentOf( index )
         end
      end
    
    elseif button == 'r' then
      index = theCanvas:selectAgent(x, y, 0, 0)
      if index ~= nil then
         agent = theCanvas:getAgent(index)
         
         if agent:hasCollided_Note(x, y) then
            theCanvas:PreviousNoteOf( index )

         elseif agent:hasCollided_Instrument(x, y) then
            theCanvas:PreviousInstrumentOf( index )
         end
      end
    end
end

function AddAgent(x, y, button)
   theCanvas:newAgent("default", x - _agents_width/2, y - _agents_height/2)
end

function DeleteAggent(x, y, button)
   local index = theCanvas:selectAgent(x, y, 0, 0)
   if index ~= nil then
      theCanvas:deleteAgent( index )
   end
end