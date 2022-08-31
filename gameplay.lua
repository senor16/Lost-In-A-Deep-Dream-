local composer = require("composer")
local gameplay = composer.newScene()
local tiled = require("com.ponywolf.ponytiled")
local physics = require("physics")
local json = require "json"
local widget = require("widget")
local eyes
local world = nil

--physics.setDrawMode("hybrid")

physics.start()
physics.setGravity(0, 40)
local mapData = nil
local map = nil
local listEnemies = {}
local boss = {}
local backgroundMusicChannel
local backgroundMusic
local playerHitSound
local PlayerBulletSound
local player = nil
local playerWalkSound
local playerPhysics = {}
local playerShapeLeft = nil
local playerShapeRight = nil
local enemyHitSound
local enemyDieSound
local bossDieSound
local bulletHitWallSound

local world


local worldWidth
local screenWidth

function onAnimation(event)
    local element = event.target
    if element.type == "boss" then
        if event.phase == "ended" then
            if element.mode == "dream" then
                element:setSequence("idleDream")
            else
                element:setSequence("idleNight")
            end
            element:play()
        end
    else
        if event.phase == "ended" then
            element:setSequence("idle")
            element:play()
        end
    end
end

-- The enemies
-- Enemies animation
local enemyAnimInfo = require("images.DnN_Enemy.animation")
local enemyAnimSheet = graphics.newImageSheet("images/DnN_Enemy/animation.png", enemyAnimInfo:getSheet())
local enemyAnimSequence = {
    {
        name = "hurt",
        frames = { 2, 1 },
        time = 150,
        loopCount = 1,
        loopDirection = "forward"
    },
    {
        name = "idle",
        start = 4,
        count = 4,
        time = 550,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "move",
        start = 8,
        count = 8,
        time = 550,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "attack",
        start = 2,
        count = 2,
        time = 550,
        loopCount = 1,
        loopDirection = "forward"
    }
}

function loadEnemies()
    local enemies = map:listTypes("normalEn")
    for num, enemy in pairs(enemies) do
        local enemyAnim = display.newSprite(world, enemyAnimSheet, enemyAnimSequence)
        enemyAnim.x = -200

        local x,
        y = enemy.x, enemy.y
        display.remove(enemy)
        enemy = enemyAnim
        enemy.type = "normalEn"
        enemy.x,
            enemy.y = x, y
        enemy:setSequence("idle")
        enemy:play()

        enemy:addEventListener("sprite", onAnimation)

        enemy.isFixedRotation = true
        local enemyShape = { -10, -20, -10, 32, 10, -20, 10, 32 }
        physics.addBody(enemy, { forward = 0, friction = .2, shape = enemyShape })
        enemy.energie = 10
        enemy.gravityScale = 3.5


        local function enemyListener(en)
            display.remove(en)
        end

        function enemy:hurt(p)
            self.energie = self.energie - p
            if self.energie <= 0 then
                audio.play(enemyDieSound)
                transition.to(enemy, { time = 300, alpha = 0, onComplete = enemyListener })
            else
                audio.play(enemyHitSound)
            end
        end

        local function enemyShoot(event)
            local enemy = listEnemies[event.source.params.id]
            if enemy == nil or player.dead then
                timer.cancel(event.source)
            else
                if math.abs(player.x - enemy.x) <= 300 then
                    enemy:setSequence("attack")
                    enemy:play()
                    local dir = 1
                    if enemy.x > player.x then
                        dir = -1
                    end

                    addBullet(enemy.x + (enemy.width / 2) * dir, enemy.y, dir, "player", "normalEn")
                end
            end

        end

        enemy.shootTimer = timer.performWithDelay(1000, enemyShoot, 0)
        enemy.shootTimer.params = { id = num }

        table.insert(listEnemies, enemy)
    end
end

function setPlayerCollisionShape(pShape)
    physics.removeBody(player)
    playerPhysics = { friction = 0, density = 1, bounce = 0.1, shape = pShape }
    physics.addBody(player, playerPhysics)
    player.isFixedRotation = false
    player:setLinearVelocity(0, 0)
end

function updateWorld()
    if worldWidth >= screenWidth then
        if player.x < worldWidth - screenWidth / 2 and player.x > screenWidth / 2 then
            world.x = -player.x + screenWidth / 2
        elseif player.x >= worldWidth - screenWidth / 2 then
            world.x = -(worldWidth - screenWidth)
        else
            world.x = 0
        end

    end
end

function gameplay:create(event)
    world = self.view
    print("Gameplay")
    -- Load music
    backgroundMusic = audio.loadStream("audio/background.ogg")
    playerHitSound = audio.loadSound("audio/PlayerHit.ogg")
    PlayerBulletSound = audio.loadSound("audio/PlayerBullet.ogg")
    playerWalkSound = {
        handle = audio.loadSound("audio/PlayerWalk.ogg"),
        channel = 0
    }
    enemyDieSound = audio.loadSound("audio/EnemyDie.ogg")
    bossDieSound = audio.loadSound("audio/BossDeath.ogg")
    enemyHitSound = audio.loadSound("audio/EnemyHit.ogg")
    bulletHitWallSound = audio.loadSound("audio/BulletWall.ogg")


    -- Load a map from a lua export
    display.setDefault("magTextureFilter", "nearest")
    display.setDefault("minTextureFilter", "nearest")
    local mapData = json.decodeFile(system.pathForFile("maps/tiles/map.json", system.ResourceDirectory)) -- load from json export
    map = tiled.new(mapData, "maps/tiles")

    worldWidth = map.designedWidth
    screenWidth = display.contentWidth

    local walls = map:listTypes("wall")
    for num, obj in pairs(walls) do
        physics.addBody(obj, "static", { bounce = 0.2, density = 1, friction = 0 })
        world:insert(obj)
    end

    local decor = map:listTypes("decor")
    for num, obj in pairs(decor) do
        world:insert(obj)
    end

    local hud = map:listTypes("hud")
    for num, obj in pairs(hud) do
        obj.anchorX = 0
        world:insert(obj)
    end




    -- The player
    -- The player animation

    local animationInfo = require("images.DnN_Player.animation")
    local animationSheet = graphics.newImageSheet("images/DnN_Player/animation.png", animationInfo:getSheet())
    local animationSequence = {
        {
            name = "idle",
            start = 7,
            count = 4,
            time = 550,
            loopCount = 0,
            loopDirection = "forward"
        },
        {
            name = "shoot",
            start = 21,
            count = 1,
            time = 250,
            loopCount = 1,
            loopDirection = "forward"
        },
        {
            name = "run",
            start = 11,
            count = 8,
            time = 650,
            loopCount = 0,
            loopDirection = "forward"
        }
    }
    local playerAnimation = display.newSprite(world, animationSheet, animationSequence)
    playerAnimation.x = -200
    -- Set up the player
    player = map:findObject("player")
    local x = player.x
    local y = player.y
    display.remove(player)
    player = playerAnimation
    player.x = x
    player.y = y
    player:setSequence("idle")
    player:play()
    player.energy = 24
    player.dead = false
    function player:hurt(pV)
        player.energy = player.energy - pV

        if player.energy >= 12 then
            hud[#hud].width = (player.energy - 12) * hud[#hud].width / 12
        else
            hud[#hud - 1].width = (player.energy) * hud[#hud - 1].width / 12
        end
        audio.play(playerHitSound)
        if player.energy <= 4 then
            player.dead = true
            local function listener(object)
                audio.fadeOut({ channel = backgroundMusicChannel, time = 3000 })
                audio.stop()
                world:insert(eyes)
                composer.gotoScene(
                    "gameover",
                    {
                        effect = "fade",
                        time = "800",
                        params = { win = false }

                    }
                )
            end

            transition.to(player, { time = 800, alpha = 0, onComplete = listener })
        end
    end

    player:addEventListener("sprite", onAnimation)

    playerShapeRight = {
        -player.width / 2 + 18,
        -player.height / 2 + 10,
        -player.width / 2 + 18,
        player.height / 2,
        0,
        -player.height / 2 + 10,
        0,
        player.height / 2
    }
    playerShapeLeft = {
        0,
        -player.height / 2 + 10,
        0,
        player.height / 2,
        35,
        -player.height / 2 + 10,
        35,
        player.height / 2
    }

    playerPhysics = { friction = 0, density = 1, bounce = 0.1, shape = playerShapeRight }
    physics.addBody(player, playerPhysics)
    player.vx = 180
    player.vy = 450
    player.isFixedRotation = false
    player:setLinearVelocity(0, 0)


    -- The listEnemies
    loadEnemies()
    -- The eyes
    -- The eyes
    eyes = map:findObject("eyes")
    local x, y = eyes.x, eyes.y - 20
    display.remove(eyes)
    local eyesInfo = require("images.DnN_Boss.eyes")
    local eyesSheet = graphics.newImageSheet("images/DnN_Boss/eyes.png", eyesInfo:getSheet())
    local eyesSequence = {
        {
            name = "idle",
            frames = { 2, 1 },
            time = 400,
            loopCount = 1,
            loopDirection = "forward"
        },
    }
    eyes = display.newSprite(eyesSheet, eyesSequence)
    eyes:setFrame(2)
    eyes.x, eyes.y = x, y

    function blinkEyes(event)
        eyes:play()
    end

    timer.performWithDelay(5000, blinkEyes, 0, "blinkEyes")


    -- The boss
    boss = map:findObject("boss")

    if boss then
        -- The player animation

        local bossAnimInfo = require("images.DnN_Boss.animation")
        local bossAnimSheet = graphics.newImageSheet("images/DnN_Boss/animation.png", bossAnimInfo:getSheet())
        local bossAnimSequence = {
            {
                name = "idleDream",
                start = 3,
                count = 3,
                time = 700,
                loopCount = 0,
                loopDirection = "forward"
            },

            {
                name = "attackDream",
                start = 1,
                count = 2,
                time = 350,
                loopCount = 1,
                loopDirection = "forward"
            },
            {
                name = "idleNight",
                start = 9,
                count = 4,
                time = 700,
                loopCount = 0,
                loopDirection = "forward"
            },
            {
                name = "attackNight",
                start = 7,
                count = 2,
                time = 350,
                loopCount = 1,
                loopDirection = "forward"
            }
        }
        local bossAnimation = display.newSprite(world, bossAnimSheet, bossAnimSequence)
        bossAnimation.x = -200
        local x,
        y = boss.x, boss.y
        display.remove(boss)


        boss = bossAnimation
        boss:setSequence("attackDream")
        boss:play()
        boss.x,
            boss.y = x, y

        local bossShape = { -45, -35, -45, 60, 45, -35, 45, 60 }
        physics.addBody(boss, { forward = 0, density = 5, friction = .2, shape = bossShape })
        boss.isFixedRotation = true
        boss.mode = "dream"
        boss.type = "boss"


        boss.maxEnergy = 50
        boss.energy = boss.maxEnergy
        boss.gravityScale = 3
        function boss:hurt(p)

            eyes:play()
            self.energy = self.energy - p
            if self.mode == "dream" and self.energy <= self.maxEnergy / 3 then
                self.mode = "night"
                self:setSequence("idleNight")
                self:play()
            end
            if self.energy <= 0 then
                audio.play(bossDieSound)
                local function listener(object)
                    display.remove(object)
                    audio.fadeOut({ channel = backgroundMusicChannel, time = 3000 })
                    audio.stop()
                    composer.gotoScene(
                        "gameover",
                        {
                            effect = "fade",
                            time = "2000",
                            params = { win = true }
                        }
                    )
                end

                transition.to(boss, { time = 2000, alpha = 0, onComplete = listener })
                transition.to(eyes, { time = 2000, alpha = 0, onComplete = listener })
                eyes:setFrame(1)
                timer.cancel("blinkEyes")
            else
                audio.play(enemyHitSound)
            end
        end

        boss:addEventListener("sprite", onAnimation)

        local function bossShoot(event)
            if boss.x == nil or player.dead then
                timer.cancel(event.source)
            else
                if math.abs(player.x - boss.x) <= 400 then
                    if boss.mode == "dream" then
                        boss:setSequence("attackDream")
                    else
                        boss:setSequence("attackNight")
                    end
                    boss:play()
                    local dir = 1
                    if boss.x > player.x then
                        dir = -1
                    end
                    addBullet(boss.x + (boss.width / 2 - 10) * dir, boss.y + boss.height / 4 - 8, dir, "player", "boss")
                end
            end
        end

        boss.shootTimer = timer.performWithDelay(1000, bossShoot, 0)
    end


end

function gameplay:show(event)
    if event.phase == "will" then
        backgroundMusicChannel = audio.play(backgroundMusic, { loops = -1, fadein = 5000, onComplete = onMusicComplete })
        audio.setMaxVolume(0.3, { channel = backgroundMusicChannel })
    end
end

gameplay:addEventListener("create", gameplay)
gameplay:addEventListener("show", gameplay)

function addBullet(pX, pY, pDir, pTarget, pFrom)
    local bullet
    if pTarget == "player" then
        if pFrom == "boss" then
            if boss.mode == "night" then
                local bulletAnimInfo = require("images.DnN_Boss.bulletNight")
                local bulletAnimSheet = graphics.newImageSheet("images/DnN_Boss/bulletNight.png",
                    bulletAnimInfo:getSheet())
                local bulletAnimSequence = {
                    {
                        name = "explode",
                        frames = { 1, 2, 3, 4, 5, 6, 7, 7, 7 },
                        time = 350,
                        loopCount = 1,
                        loopDirection = "forward"
                    },
                }
                bullet = display.newSprite(world, bulletAnimSheet, bulletAnimSequence)
            else
                local bulletAnimInfo = require("images.DnN_Boss.bulletDream")
                local bulletAnimSheet = graphics.newImageSheet("images/DnN_Boss/bulletDream.png",
                    bulletAnimInfo:getSheet())
                local bulletAnimSequence = {
                    {
                        name = "explode",
                        frames = { 1, 2, 3, 4, 5, 6, 7, 7 },
                        time = 150,
                        loopCount = 1,
                        loopDirection = "forward"
                    },
                }
                bullet = display.newSprite(world, bulletAnimSheet, bulletAnimSequence)
            end
        else
            local bulletAnimInfo = require("images.DnN_Enemy.bullet")
            local bulletAnimSheet = graphics.newImageSheet("images/DnN_Enemy/bullet.png", bulletAnimInfo:getSheet())
            local bulletAnimSequence = {
                {
                    name = "explode",
                    frames = { 1, 2, 3, 4, 4, 4 },
                    time = 200,
                    loopCount = 1,
                    loopDirection = "forward"
                },
            }
            bullet = display.newSprite(world, bulletAnimSheet, bulletAnimSequence)
        end

    else
        local bulletAnimInfo = require("images.DnN_Player.bullet")
        local bulletAnimSheet = graphics.newImageSheet("images/DnN_Player/bullet.png", bulletAnimInfo:getSheet())
        local bulletAnimSequence = {
            {
                name = "explode",
                frames = { 1, 2, 3, 4, 5, 5, 5 },
                time = 150,
                loopCount = 1,
                loopDirection = "forward"
            },
        }
        bullet = display.newSprite(world, bulletAnimSheet, bulletAnimSequence)
    end
    local function onBulletAnimation(event)
        local element = event.target
        if event.phase == "ended" then
            -- Remove the bullet when it's animation is over
            display.remove(element)
        end

    end

    bullet:addEventListener("sprite", onBulletAnimation)
    bullet.x = pX
    bullet.y = pY
    bullet.target = pTarget
    local bulletOutline = graphics.newOutline(2, "images/DnN_Player/DnN_PlayerBullet_HitFX_0001.png")
    physics.addBody(bullet, "dynamic", { forward = 0, friction = 0, outline = bulletOutline })
    bullet.gravityScale = 0
    bullet.isBullet = true

    bullet.isFixedRotation = true
    bullet:setLinearVelocity(pDir * 400, 0)

    function onBulletCollision(self, event)
        bullet:play()
        -- Check if bullet hits a wall

        if event.other == player then
            if self.target == "player" then
                -- Handle when the player is hit
                player:setSequence("hurt")
                player:play()
                player:hurt(.5)
            end
        elseif event.other.type == "normalEn" or event.other.type == "boss" then
            -- Handle when an enemy is hit
            event.other:setSequence("hurt")
            event.other:play()
            event.other:hurt(1)

        else
            local channel = audio.play(bulletHitWallSound)
            audio.setVolume(.5, { channel = channel })
        end
    end

    bullet.collision = onBulletCollision
    bullet:addEventListener("collision")
end

-- Handle events
local function onKeyEvent(event)
    -- Move the player
    local vx,
    vy = player:getLinearVelocity()

    if event.keyName == "d" or event.keyName == "right" then
        if event.phase == "down" then
            if not audio.isChannelPlaying(playerWalkSound.channel) then
                playerWalkSound.channel = audio.play(playerWalkSound.handle, { loop = -1 })
            end
            if player.xScale < 0 then
                setPlayerCollisionShape(playerShapeRight)
                player.xScale = 1
                player.x = player.x + 36
            end

            player:setLinearVelocity(player.vx, vy)
            if player.sequence ~= "run" then
                player:setSequence("run")
                player:play()
            end

        else
            if audio.isChannelPlaying(playerWalkSound.channel) then
                audio.stop(playerWalkSound.channel)
            end
            player:setLinearVelocity(0, vy)
            player:pause()
        end
    end

    if event.keyName == "a" or event.keyName == "left" then
        if event.phase == "down" then
            if not audio.isChannelPlaying(playerWalkSound.channel) then
                playerWalkSound.channel = audio.play(playerWalkSound.handle, { loop = -1 })
            end
            if player.xScale > 0 then
                setPlayerCollisionShape(playerShapeLeft)
                player.xScale = -1
                player.x = player.x - 36
            end

            player:setLinearVelocity(-player.vx, vy)

            if player.sequence ~= "run" then
                player:setSequence("run")
                player:play()
            end
        else
            if audio.isChannelPlaying(playerWalkSound.channel) then
                audio.stop(playerWalkSound.channel)
            end
            player:setLinearVelocity(0, vy)
            player:pause()
        end
    end


    if event.keyName == "w" or event.keyName == "up" and player.y > 10 and vy <= 5 then
        if event.phase == "down" then
            local vx, vy = player:getLinearVelocity()
            player:setLinearVelocity(vx, -player.vy)
        else
            --player:setLinearVelocity(vx, 0)
        end
    end

    -- Shoot at listEnemies
    if event.keyName == "space" and event.phase == "down" then
        addBullet(player.x + (player.width / 2 - 5) * player.xScale, player.y, player.xScale, "enemies", "player")
        player:setSequence("shoot")
        audio.play(PlayerBulletSound)
        player:play()

    end

    if event.keyName == "escape" then
        audio.fadeOut({ channel = backgroundMusicChannel, time = 3000 })
        audio.stop()
        composer.gotoScene(
            "menu",
            {
                effect = "fade",
                time = "2000"
            }
        )
    end

    return false
end

function update()

    if player.energy > 0 then
        player.rotation = 0
        -- Prevent the player from leaving the screen
        local vx,
        vy = player:getLinearVelocity()

        -- Put the idle animation when the player is in idle state
        if not player.isPlaying then
            player:setSequence("idle")
            player:play()
        end
    end
    -- Update the boss
    if boss.x ~= nil then
        if math.abs(boss.x - player.x) <= 70 then
            boss:setLinearVelocity(0, 0)
        elseif math.abs(boss.x - player.x) <= 400 then
            local dir = -1
            if (boss.x < player.x) then
                dir = 1
            end
            boss:setLinearVelocity(90 * dir, 0)
        end
    end

    for k = #listEnemies, 1, -1 do
        if listEnemies[k].x ~= nil then
            local enemy = listEnemies[k]
            enemy.rotation = 0
            if math.abs(enemy.x - player.x) <= 70 then
                enemy:setLinearVelocity(0, 0)
                enemy:setSequence("idle")
                enemy:play()
            elseif math.abs(enemy.x - player.x) <= 300 then
                local dir = -1
                if (enemy.x < player.x) then
                    dir = 1
                end
                enemy:setLinearVelocity(60 * dir, 0)
                if enemy.sequence ~= "move" then
                    enemy:setSequence("move")
                    enemy:play()
                end
            end
        else
            table.remove(listEnemies, k)
        end
    end
    updateWorld()
end

Runtime:addEventListener("enterFrame", update)
Runtime:addEventListener("key", onKeyEvent)
return gameplay
