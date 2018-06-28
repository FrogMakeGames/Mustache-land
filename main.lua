player = {}

function love.load()
  colors = require 'util/lovecolors'
  
  WID = love.graphics.getWidth()
  HEI = love.graphics.getHeight()
  
  player.right = love.graphics.newImage('spr/charmustachesprite.png')
  player.left = love.graphics.newImage('spr/charmustachesprite2.png')
  player.x = WID/2
  player.y = HEI/2
  player.current = player.right
end

function love.update(dt)
  if love.keyboard.isDown('d') then
    if player.x < WID - player.current:getWidth() then
      player.x = player.x + 200 * dt
    end
  elseif love.keyboard.isDown('a') then
    if player.x > 0 then
      player.x = player.x - 200 * dt
    end
  end
  
  if love.keyboard.isDown('w') then
    if player.y > 0 then
      player.y = player.y - 200 * dt
    end
  elseif love.keyboard.isDown('s') then
    if player.y < HEI - player.current:getHeight() then
      player.y = player.y + 200 * dt
    end
  end
  
  
end

function draw_back()
  love.graphics.setColor(colors.RGB(140,230,250))
  love.graphics.rectangle('fill',0,0,WID,HEI)
  love.graphics.setColor(colors.black)
end
  
function love.draw()
  draw_back()
  love.graphics.draw(player.current, player.x, player.y)
end
