--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:a301d38f0a9c742ba278ae12e3033bbc:922f47336017eb3f3cfb3032654cb1b2:a5e6b4c07d8741dfeed47844bad65cbc$
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
            -- DnN_EnemyProjectile_HitFX_0001
            x=0,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_EnemyProjectile_HitFX_0002
            x=32,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_EnemyProjectile_HitFX_0003
            x=64,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_EnemyProjectile_HitFX_0004
            x=96,
            y=0,
            width=32,
            height=32,

        },
    },

    sheetContentWidth = 128,
    sheetContentHeight = 32
}

SheetInfo.frameIndex =
{

    ["DnN_EnemyProjectile_HitFX_0001"] = 1,
    ["DnN_EnemyProjectile_HitFX_0002"] = 2,
    ["DnN_EnemyProjectile_HitFX_0003"] = 3,
    ["DnN_EnemyProjectile_HitFX_0004"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
