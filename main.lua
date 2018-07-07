--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
function love.load()
  colors = require 'util/lovecolors' -- small script for colors
  
  WID = love.graphics.getWidth()
  HEI = love.graphics.getHeight()
  
  love.graphics.setDefaultFilter('linear','nearest') -- filter for scaling
  
  -- initializing the player
  player = {}
  player.right = love.graphics.newImage('spr/mus0.png')
  player.left = love.graphics.newImage('spr/mus10.png')
  player.x = WID/2 -- init
  player.y = HEI/2 -- init
  player.speed = 200 
  player.current = player.right -- current direction
  
  player.gravity = -500
  player.jump_height = -300
  -- in most cases: player.gravity > player.jump_height
  player.y_velocity = 0
  player.ground = HEI-player.current:getHeight()*2 -- nice little colision at the end
  
  -- mouse stuff 
  mouse = {}
  
  -- block list
  blocks = {}
  blocks.air = love.graphics.newImage('spr/air.png')
  blocks.brick = love.graphics.newImage('spr/brick.png')
  blocks.grass = love.graphics.newImage('spr/grass.png')
  blocks.dirt = love.graphics.newImage('spr/dirt.png')
  
   --[[ initializing the world:
  
  this will create a 2 dimentionl array that holds
  the type of a block, and it's x and y coordinates like so:
  world = {
    {air, x, y},
    {air, x, y},
    ... }
    
  --]] 
  world = {}
  i=1
  for x=0,WID-32,32 do
    for y=0,HEI-32,32 do
      world[i] = {blocks.air, x, y} -- initialize w/ 'air blocks'
      i = i + 1
    end
  end
  
end
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
function love.update(dt)
  
  -- exit the game
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end
  
  -- player movements
  if love.keyboard.isDown('d') then
    player.current = player.right -- change direction
    if player.x < WID - player.current:getWidth()*2 then -- right colision
      player.x = player.x + player.speed * dt
    end
  elseif love.keyboard.isDown('a') then
    player.current = player.left -- change direction
    if player.x > 0 then -- left colision
      player.x = player.x - player.speed * dt
    end
  end
  
  -- jumping
  if love.keyboard.isDown('w') then
    if player.y_velocity == 0 then -- checks if the player's on the ground
      player.y_velocity = player.jump_height
    end
  end
  if player.y_velocity ~= 0 then -- checks if the player's in the air
    player.y = player.y + player.y_velocity * dt
    player.y_velocity = player.y_velocity - player.gravity * dt
  end
  if player.y > player.ground then 
    player.y_velocity = 0
    player.y = player.ground
  end
  
  
  -- block placing
  if mouse.down then
    for i=1,#world do
      -- checking where the click was done
      if (mouse.x>world[i][2] and mouse.x<world[i][2]+32) and (mouse.y>world[i][3] and mouse.y<world[i][3]+32) then
        if i > 1 then
          if world[i-1][1]==blocks.grass or world[i-1][1]==blocks.dirt then
            world[i][1]=blocks.dirt
          else
            world[i][1]=blocks.grass
          end
        else
          world[i][1]=blocks.grass
        end
      end
    end
  -- world reset
  elseif love.keyboard.isDown('r') then
    for i=1,#world do
      world[i][1]=blocks.air
    end
  end
  
end
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--  
function love.draw()
  love.graphics.clear(colors.RGB(140,230,250)) -- cls + background
  
  --test grid--
  for i=0, WID, 32 do
    love.graphics.line(i,0,i,HEI)
  end
  for i=0, HEI, 32 do
    love.graphics.line(0,i,WID,i)
  end
  --test--]]
  
  -- draw the blocks at their positions
  for i=1,#world do
    love.graphics.draw(world[i][1], world[i][2], world[i][3])
  end
  
  -- draw player
  love.graphics.draw(player.current, player.x, player.y, 0, 2,2)
  
  -- cursor position
  mouse.x, mouse.y = love.mouse.getPosition()
  mouse.down = love.mouse.isDown(1)
end 
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
