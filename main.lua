player = {}

function love.load()
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
      player.x = player.x + 250 * dt
    end
  elseif love.keyboard.isDown('a') then
    if player.x > 0 then
      player.x = player.x - 250 * dt
    end
  end
  
end

function love.draw()
  love.graphics.draw(player.current, player.x, player.y)
end
