--Characters are 50x50 px
--Levels are 999x399 px

--Default settings (current ones are for testing)
--Speed = 150

function love.load()

  --Misc variables
  allowSprint = true
  characterDialogue = 0
  --images
  player = {img = nil}
  area = {img = nil}
  character = {img = nil}

  playerRight = love.graphics.newImage('assets/xright.png')
  playerLeft = love.graphics.newImage('assets/xleft.png')
  areaPortals = love.graphics.newImage('assets/Portals.png')
  characterRandom = love.graphics.newImage('assets/Character test.png')

  player.img = playerRight
  area.img = areaPortals
  character.img = characterRandom

  --Preloading
  player = { x = 30, y = love.graphics.getHeight() - player.img:getHeight() - 30, speed = 150, img = player.img }
  area = { x = 0, y = 0, img = area.img }
  character = { x = love.graphics.getWidth() - character.img:getWidth() - 30, y = love.graphics.getHeight() - character.img:getHeight() - 30, img = character.img }

end

function love.keyreleased(lshift)--Sprint ending

  if lshift == lshift then
    player.speed = 150
  end

end

function love.update(dt)

  --Quitting
  if love.keyboard.isDown('escape') then
    love.event.quit()
  end

  --Movement
  --Character img turning
  if love.keyboard.isDown('left') then
    player.img = playerLeft
  elseif love.keyboard.isDown('right') then
    player.img = playerRight
  end
  --Movement
  if love.keyboard.isDown('left') and player.x > 30 then
    player.x = player.x - (player.speed * dt)
  elseif love.keyboard.isDown('right') and player.x < (love.graphics.getWidth() - character.img:getWidth() - player.img:getWidth() - 30) then
    player.x = player.x + (player.speed * dt)
  end
  --Sprinting
  if love.keyboard.isDown('lshift') and allowSprint then
    player.speed = 300
  end
  --Wall glitch fixing
  if player.x < 30 then
    player.x = 30
  elseif player.x > (love.graphics.getWidth() - player.img:getWidth() - 30) then
    player.x = (love.graphics.getWidth() - player.img:getWidth() - 30)
  end

  --Character Dialogue (WIP)
  if player.x == (love.graphics.getWidth() - character.img:getWidth() - player.img:getWidth() - 50) and love.keyboard.isDown('space') and area.img == areaPortals then
    characterDialogue = 1
  end

end

function love.draw()

  love.graphics.draw(area.img, area.x, area.y)
  love.graphics.draw(player.img, player.x, player.y)
  love.graphics.draw(character.img, character.x, character.y)

  --Character Dialogue drawing (WIP)
  if characterDialogue == 1 then
    love.graphics.print('Hello!', (love.graphics.getWidth() - character.img:getWidth() - 30), (love.graphics.getHeight() - character.img:getHeight() - 50))
  end

end
