--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:56850fb96342065d5beb65b76b4f473c:a1f37baaa604f1e4b44df2ba85097ddf:17bc765ec03793a3ba367bc341912ed9$
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
            -- DnN_BossDreamForm_Attack_0005
            x=0,
            y=0,
            width=125,
            height=112,

            sourceX = 3,
            sourceY = 13,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossDreamForm_Attack_0006
            x=125,
            y=0,
            width=133,
            height=112,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossDreamForm_IdleMove_0001
            x=258,
            y=0,
            width=125,
            height=112,

            sourceX = 3,
            sourceY = 13,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossDreamForm_IdleMove_0002
            x=383,
            y=0,
            width=133,
            height=110,

            sourceX = 0,
            sourceY = 18,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossDreamForm_IdleMove_0003
            x=516,
            y=0,
            width=133,
            height=112,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossDreamForm_IdleMove_0004
            x=649,
            y=0,
            width=125,
            height=112,

            sourceX = 3,
            sourceY = 13,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossNightmareForm_Attack_0005
            x=774,
            y=0,
            width=125,
            height=112,

            sourceX = 3,
            sourceY = 13,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossNightmareForm_Attack_0006
            x=899,
            y=0,
            width=133,
            height=112,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossNightmareForm_IdleMove_0001
            x=1032,
            y=0,
            width=125,
            height=112,

            sourceX = 3,
            sourceY = 13,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossNightmareForm_IdleMove_0002
            x=1157,
            y=0,
            width=133,
            height=110,

            sourceX = 0,
            sourceY = 18,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossNightmareForm_IdleMove_0003
            x=1290,
            y=0,
            width=133,
            height=112,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 133,
            sourceHeight = 128
        },
        {
            -- DnN_BossNightmareForm_IdleMove_0004
            x=1423,
            y=0,
            width=125,
            height=112,

            sourceX = 3,
            sourceY = 13,
            sourceWidth = 133,
            sourceHeight = 128
        },
    },

    sheetContentWidth = 1548,
    sheetContentHeight = 112
}

SheetInfo.frameIndex =
{

    ["DnN_BossDreamForm_Attack_0005"] = 1,
    ["DnN_BossDreamForm_Attack_0006"] = 2,
    ["DnN_BossDreamForm_IdleMove_0001"] = 3,
    ["DnN_BossDreamForm_IdleMove_0002"] = 4,
    ["DnN_BossDreamForm_IdleMove_0003"] = 5,
    ["DnN_BossDreamForm_IdleMove_0004"] = 6,
    ["DnN_BossNightmareForm_Attack_0005"] = 7,
    ["DnN_BossNightmareForm_Attack_0006"] = 8,
    ["DnN_BossNightmareForm_IdleMove_0001"] = 9,
    ["DnN_BossNightmareForm_IdleMove_0002"] = 10,
    ["DnN_BossNightmareForm_IdleMove_0003"] = 11,
    ["DnN_BossNightmareForm_IdleMove_0004"] = 12,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
