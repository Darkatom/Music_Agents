
function Hand(x, y, button)
    if button == 'l' then
      index = theCanvas:selectAgent(x, y)
      if index ~= nil then
         theCanvas:NextNoteOf( index )
      end
    
    elseif button == 'r' then
      index = theCanvas:selectAgent(x, y)
      if index ~= nil then
         theCanvas:PreviousNoteOf( index )
      end
    end
end

function AddAgent(x, y, button)
   theCanvas:newAgent("default", x, y)
end

function DeleteAggent(x, y, button)  
   local index = theCanvas:selectAgent(x, y)
   if index ~= nil then
      theCanvas:deleteAgent( index )
   end
end