
IMGS = {}

_agents_radius = 20
_messages_radius = 5

function loadImgs()
         IMGS["agent"] = love.graphics.newImage("imgs/agent_img.png")
         IMGS["message"] = love.graphics.newImage("imgs/msg_img.png")

         IMGS["button"] = love.graphics.newImage("imgs/button_base.png")
         IMGS["button_selected"] = love.graphics.newImage("imgs/button_base_selected.png")

         IMGS["hand"] = love.graphics.newImage("imgs/hand_img.png")
         IMGS["hand_selected"] = love.graphics.newImage("imgs/hand_selected_img.png")

         IMGS["addAgent"] = love.graphics.newImage("imgs/addAgent_img.png")
         IMGS["addAgent_selected"] = love.graphics.newImage("imgs/addAgent_selected_img.png")

         IMGS["deleteAgent"] = love.graphics.newImage("imgs/deleteAgent_img.png")
         IMGS["deleteAgent_selected"] = love.graphics.newImage("imgs/deleteAgent_selected_img.png")

end
