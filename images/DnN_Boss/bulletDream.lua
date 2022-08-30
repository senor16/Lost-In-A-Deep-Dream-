--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:45dcc6f7080bc5d4213719cd90efeacf:3d087b4cd00803248d6f816cc31ab8c8:b85ca9e48366a39ba08226c689878516$
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
            -- DnN_BossDreamProjectile_HitFX_0001
            x=0,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossDreamProjectile_HitFX_0002
            x=32,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossDreamProjectile_HitFX_0003
            x=64,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossDreamProjectile_HitFX_0004
            x=96,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossDreamProjectile_HitFX_0005
            x=128,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossDreamProjectile_HitFX_0006
            x=160,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossDreamProjectile_HitFX_0007
            x=192,
            y=0,
            width=32,
            height=32,

        },
    },

    sheetContentWidth = 224,
    sheetContentHeight = 32
}

SheetInfo.frameIndex =
{

    ["DnN_BossDreamProjectile_HitFX_0001"] = 1,
    ["DnN_BossDreamProjectile_HitFX_0002"] = 2,
    ["DnN_BossDreamProjectile_HitFX_0003"] = 3,
    ["DnN_BossDreamProjectile_HitFX_0004"] = 4,
    ["DnN_BossDreamProjectile_HitFX_0005"] = 5,
    ["DnN_BossDreamProjectile_HitFX_0006"] = 6,
    ["DnN_BossDreamProjectile_HitFX_0007"] = 7,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
