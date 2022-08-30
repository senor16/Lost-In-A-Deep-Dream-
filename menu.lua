local composer = require("composer")


local menu = composer.newScene()

function menu:create(event)
    local sceneGroup = self.view



    -- The eyes

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
    local eyes = display.newSprite(sceneGroup, eyesSheet, eyesSequence)
    eyes:setFrame(2)
    eyes.x, eyes.y = 320, 80


    function blinkEyes(event)
        eyes:play()
    end

    timer.performWithDelay(5000, blinkEyes, 0, "blinkEyes")


    local gameTitle =
    display.newText(sceneGroup, "Lost in A Deep Dream", display.contentCenterX, 40, native.systemFont, 30)
    local btnGameplay =
    display.newText(sceneGroup, "Start", display.contentCenterX, display.contentCenterY, native.systemFont, 35)
    local credits =
    display.newText(
        {
            parent = sceneGroup,
            text = "A Summer Slow Jams 2022 : Boss Fight\n\nGame by:\nSesso Kosga\nMatvei M\nand a graphic Artist",
            x = display.contentWidth / 2,
            y = display.contentCenterY + 110,
            font = native.systemFont,
            fontSize = 17,
            width = 300,
            align = "center"
        }
    )

    function onBtnGameplay(event)
        composer.gotoScene(
            "gameplay",
            {
                effect = "fade",
                time = "800"
            }
        )
    end

    btnGameplay:addEventListener("tap", onBtnGameplay)
end

menu:addEventListener("create", menu)

return menu
