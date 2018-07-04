function love.load()
  colors = require 'util/lovecolors' -- small script for colors
  
  WID = love.graphics.getWidth()
  HEI = love.graphics.getHeight()
  
  love.graphics.setDefaultFilter('linear','nearest') -- filter for scaling
  
  -- initializing the player
  player = {}
  player.right = love.graphics.newImage('spr/mus0.png')
  player.left = love.graphics.newImage('spr/mus10.png')
  player.x = WID/2
  player.y = HEI/2
  player.speed = 300
  player.current = player.right -- current direction
  
  -- initializing the world
  world = {}
  i=1
  for x=0,WID,32 do
    for y=0,HEI,32 do
      world[i] = {0, x, y}
      i = i + 1
    end
  end
end

function love.update(dt)
  -- exiting the game
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
  
  if love.keyboard.isDown('w') then
    if player.y > 0 then
      player.y = player.y - player.speed * dt
    end
  elseif love.keyboard.isDown('s') then
    if player.y < HEI - player.current:getHeight()*2 then
      player.y = player.y + player.speed * dt
    end
  end
end

  
function love.draw()
  love.graphics.clear(colors.RGB(140,230,250)) -- cls + background
  
  --test--
  for i=0, WID, 32 do
    love.graphics.line(i,0,i,HEI)
  end
  for i=0, HEI, 32 do
    love.graphics.line(0,i,WID,i)
  end  
  
  for 
  --test--
  
  love.graphics.draw(player.current, player.x, player.y, 0, 2,2)
end