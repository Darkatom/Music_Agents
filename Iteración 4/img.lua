
IMGS = {}

_agents_width = nil
_agents_height = nil
_agents_note = nil
_agents_instr = nil
_messages_diam = nil

function loadImgs()
         IMGS["agent"] = love.graphics.newImage("imgs/agent_img.png")
         IMGS["agent_mod"] = love.graphics.newImage("imgs/agent_mod_img.png")

         IMGS["message"] = love.graphics.newImage("imgs/msg_img.png")

         IMGS["button"] = love.graphics.newImage("imgs/button_base.png")
         IMGS["button_selected"] = love.graphics.newImage("imgs/button_base_selected.png")

         IMGS["hand"] = love.graphics.newImage("imgs/hand_img.png")
         IMGS["hand_selected"] = love.graphics.newImage("imgs/hand_selected_img.png")

         IMGS["addAgent"] = love.graphics.newImage("imgs/addAgent_img.png")
         IMGS["addAgent_selected"] = love.graphics.newImage("imgs/addAgent_selected_img.png")

         IMGS["deleteAgent"] = love.graphics.newImage("imgs/deleteAgent_img.png")
         IMGS["deleteAgent_selected"] = love.graphics.newImage("imgs/deleteAgent_selected_img.png")
         
         for i = 1, #_instr_index do
            IMGS[_instr_index[i]] = love.graphics.newImage("imgs/".._instr_index[i].."_instr.png")
         end

         _agents_instr = IMGS["agent"]:getWidth()
         _agents_mod = IMGS["agent_mod"]:getWidth()
         _agents_width = _agents_instr + _agents_mod
         _agents_height = _agents_instr + _agents_mod
         _messages_diam = IMGS["message"]:getWidth()

end
