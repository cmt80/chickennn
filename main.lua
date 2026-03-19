--game where animals fall from top player clicks
--before hit the bottom
--game ends when animal hits bottom

function love.load()
    love.graphics.setBackgroundColor(0.3, 0.5, 0.7)
  chickenFace = love.graphics.newImage("chicken.png")
  backgroundImage = love.graphics.newImage("bg.png")
  --setting image for powerup
  powerupImage = love.graphics.newImage("power.png")

  chickenFallSpeed = 80
  --powerup object
  powerup = {x = 500, y = 500, width = powerupImage:getWidth(), height = powerupImage:getHeight()}

  --in seconds
  powerupTime = 0 
  -- if powerup isnt clicked in 3 seconds, it'll move
  powerupDelay = 3  

  math.randomseed(os.time())
  math.random(); math.random(); math.random()
  startx = {math.random(0, love.graphics.getWidth() - chickenFace:getWidth()), 
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),  
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),  
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()), 
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth())}
  starty = {0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2)}
end

-------------------------------------------------
--MOUSE PRESS
--1 = left, 2 = right, 3 = middle wheel
-------------------------------------------------
function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    --print("left mouse clicked")
    for i, v in ipairs(startx) do
      --if the mouse x and y is within the boundary of a chicken picture
      if x >= startx[i] and x <= startx[i] + chickenFace:getWidth() and y >= starty[i] and y <= starty[i] + chickenFace:getHeight() then
        --print("in bounds")
        math.randomseed(os.time())
        math.random(); math.random(); math.random()
        --reset its y value (go back to the top)
        starty[i] = math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2) * -1
      end
    end
  end

  -- if the powerup has been clicked by player
  if x >= powerup.x and x <= powerup.x + powerup.width and y >= powerup.y and y <= powerup.y + powerup.height then

    -- make "chickens" fall faster
    chickenFallSpeed = chickenFallSpeed + 60

    -- then move it to a random spot
    powerup.x = math.random(0, love.graphics.getWidth() - powerup.width)
    powerup.y = math.random(0, love.graphics.getHeight() - powerup.height)
  end
end

-------------------------------------------------
--UPDATE
-------------------------------------------------
function love.update(dt)
  for i, v in ipairs(starty) do
    --if chicken hits the bottom of the screen, lua quits (we lose)
    if starty[i] + chickenFace:getHeight() >= love.graphics.getHeight() then
      --print("over the edge")
      love.event.quit()
    end
    --chickens move down 
    starty[i] = starty[i] + chickenFallSpeed * dt
  end

    -- if the 3 seconds runs out, move the powerup somewhere else
    powerupTime = powerupTime + dt
    if powerupTime >= powerupDelay then
        powerup.x = math.random(0, love.graphics.getWidth() - powerup.width)
        powerup.y = math.random(0, love.graphics.getHeight() - powerup.height)
        powerupTime = 0
    end


end

-------------------------------------------------
--DRAW
-------------------------------------------------
function love.draw()
  love.graphics.draw(backgroundImage, 0, 0)
  --draw each chicken at their respective x and y
  for i, v in ipairs(startx) do
    love.graphics.draw(chickenFace, startx[i], starty[i])
  end
  -- draw powerup
  love.graphics.draw(powerupImage, powerup.x, powerup.y)
end