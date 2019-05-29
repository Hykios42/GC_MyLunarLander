io.stdout:setvbuf('no')

local Lander = {}
Lander.x = 0
Lander.y = 0
Lander.angle = 270
Lander.vx = 0
Lander.vy = 0
Lander.speed = 1
Lander.engineOn = false
Lander.imgEngine = love.graphics.newImage("/images/engine.png")
Lander.img = love.graphics.newImage("/images/ship.png")


function shipMovement(dt)
  if love.keyboard.isDown("right") then
      Lander.angle = Lander.angle + (90 * dt)
      if Lander.angle > 360 then Lander.angle = 0 end
  end   
  if love.keyboard.isDown("left") then
      Lander.angle = Lander.angle - (90 * dt)
      if Lander.angle < 0 then Lander.angle = 360 end
  end
  if love.keyboard.isDown("up") then
    Lander.engineOn = true
    local angle_radian = math.rad(Lander.angle)
    local force_x = math.cos(angle_radian) * (Lander.speed * dt)
    local force_y = math.sin(angle_radian) * (Lander.speed * dt)
    Lander.vx = Lander.vx + force_x
    Lander.vy = Lander.vy + force_y
  else
    Lander.engineOn = false
  end
  Lander.vy = Lander.vy + (0.6 * dt)

  if math.abs(Lander.vx) > 1 then
    if Lander.vx > 0 then
      Lander.vx = 1
    else 
      Lander.vx = -1
    end
  end
  if math.abs(Lander.vy) > 1 then
    if Lander.vy > 0 then
      Lander.vy = 1
    else
      Lander.vy = -1
    end
  end
end
    
function velocity(dt)
      Lander.x = Lander.x + Lander.vx 
      Lander.y = Lander.y + Lander.vy
  end

function love.load()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()
    
    Lander.x = largeur/2
    Lander.y = hauteur/2
end

function love.update(dt)
    velocity(dt)
    shipMovement(dt)
end

function myPrint()
    local sDebug = "Angle:"
    sDebug = sDebug.." angle= "..tostring(Lander.angle)
    sDebug = sDebug.." vx= "..tostring(Lander.vx);
    sDebug = sDebug.." vy= "..tostring(Lander.vy);
    love.graphics.print(sDebug, 0, 0)
    
end

function love.draw()
    love.graphics.draw(Lander.img, Lander.x, Lander.y, 
      math.rad(Lander.angle), 1, 1, Lander.img:getWidth()/2, Lander.img:getHeight()/2)
    
  if Lander.engineOn == true then
    love.graphics.draw(Lander.imgEngine, Lander.x, Lander.y, 
      math.rad(Lander.angle), 1, 1, Lander.imgEngine:getWidth()/2, Lander.imgEngine:getHeight()/2)
  end
  myPrint()
end