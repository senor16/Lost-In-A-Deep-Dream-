--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:02ba546a5d81a83fcc0cd27cc297a9fe:eb818f90a0bd7227cfe358fb476bfa70:ab8e412f595eba92bd7db2c5e3d4cee5$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- DnN_BossEyes_0001
            x=1,
            y=1,
            width=256,
            height=32,

        },
        {
            -- DnN_BossEyes_0002
            x=259,
            y=1,
            width=256,
            height=32,

        },
    },

    sheetContentWidth = 516,
    sheetContentHeight = 34
}

SheetInfo.frameIndex =
{

    ["DnN_BossEyes_0001"] = 1,
    ["DnN_BossEyes_0002"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
