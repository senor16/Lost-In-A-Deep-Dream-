local composer = require("composer")
local gameover = composer.newScene()

function gameover:create(event)
    print("Game Over")
    local sceneGroup = self.view
    local textWin = "Congratulations"
    local textLost = "Game Over"

    -- The eyes

    local eyesInfo = require("images.DnN_Boss.eyes")
    local eyesSheet = graphics.newImageSheet("images/DnN_Boss/eyes.png", eyesInfo:getSheet())
    local eyesSequence = {
        {
            name = "win",
            frames = { 1, 1, 2 },
            time = 3000,
            loopCount = 1,
            loopDirection = "forward"
        },
        {
            name = "lost",
            frames = { 2, 2, 1 },
            time = 3000,
            loopCount = 1,
            loopDirection = "forward"
        },
    }
    local eyes = display.newSprite(sceneGroup, eyesSheet, eyesSequence)
    eyes:setFrame(2)
    eyes.x, eyes.y = 320, 80

    local btnmenu =
    display.newText(
        sceneGroup,
        "Back to Menu",
        display.contentCenterX,
        display.contentCenterY,
        native.systemFont,
        30
    )


    local status =
    display.newText(
        {
            text = "",
            parent = sceneGroup,
            x = display.contentCenterX,
            y = 120,
            font = native.systemFont,
            fontSize = 30
        }
    )
    if event.params then
        if (event.params.win) then
            status.text = textWin
            eyes:setSequence("win")
        else
            status.text = textLost
            eyes:setSequence("lost")
            display.remove(btnmenu)
        end
    end
    eyes:play()



    local gameTitle =
    display.newText(sceneGroup, "Lost in A Deep Dream", display.contentCenterX, 30, native.systemFont, 30)

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

    function onBtnMenu(event)
        composer.gotoScene(
            "gameplay",
            {
                effect = "fade",
                time = "2000"
            }
        )
    end

    btnmenu:addEventListener("tap", onBtnMenu)
end

gameover:addEventListener("create", gameover)

return gameover
