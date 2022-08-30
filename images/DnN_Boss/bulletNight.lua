--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:e6d3ded41685cbce10275454bad9857d:ffc4b28ff0e3c323acecd2d2a1015bff:30bfd657e303c753eed5e2df75caa0b8$
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
            -- DnN_BossNightmareProjectile_HitFX_0001
            x=0,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossNightmareProjectile_HitFX_0002
            x=32,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossNightmareProjectile_HitFX_0003
            x=64,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossNightmareProjectile_HitFX_0004
            x=96,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossNightmareProjectile_HitFX_0005
            x=128,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossNightmareProjectile_HitFX_0006
            x=160,
            y=0,
            width=32,
            height=32,

        },
        {
            -- DnN_BossNightmareProjectile_HitFX_0007
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

    ["DnN_BossNightmareProjectile_HitFX_0001"] = 1,
    ["DnN_BossNightmareProjectile_HitFX_0002"] = 2,
    ["DnN_BossNightmareProjectile_HitFX_0003"] = 3,
    ["DnN_BossNightmareProjectile_HitFX_0004"] = 4,
    ["DnN_BossNightmareProjectile_HitFX_0005"] = 5,
    ["DnN_BossNightmareProjectile_HitFX_0006"] = 6,
    ["DnN_BossNightmareProjectile_HitFX_0007"] = 7,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
