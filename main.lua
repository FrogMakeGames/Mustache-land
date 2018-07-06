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
  player.speed = 300 
  player.current = player.right -- current direction
  
  -- mouse stuff
  mouse = {}
  
  -- block list
  blocks = {}
  blocks.air = love.graphics.newImage('spr/air.png')
  blocks.brick = love.graphics.newImage('spr/brick.png')
  blocks.grass = love.graphics.newImage('spr/grass.png')
  
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
    if player.x < WID - player.current:getWidth()*2 then -- colision
      player.x = player.x + player.speed * dt
    end
  elseif love.keyboard.isDown('a') then
    player.current = player.left -- change direction
    if player.x > 0 then -- colision
      player.x = player.x - player.speed * dt
    end
  end
  
  -- should remove that once physics and a map is added
  if love.keyboard.isDown('w') then
    if player.y > 0 then
      player.y = player.y - player.speed * dt
    end
  elseif love.keyboard.isDown('s') then
    if player.y < HEI - player.current:getHeight()*2 then
      player.y = player.y + player.speed * dt
    end
  end
  
  --block placing
  if mouse.down then
    for i=1,#world do
      -- checking where the click was done
      if (mouse.x>world[i][2] and mouse.x<world[i][2]+32) and (mouse.y>world[i][3] and mouse.y<world[i][3]+32) then
        world[i][1] = blocks.grass
      end
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
