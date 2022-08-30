--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:3656074e837143092d9f4ca3cae203d6:d0603ab5eed4614b3f689b362076f31d:17bc765ec03793a3ba367bc341912ed9$
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
            -- DnN_Enemy_Attack_0013
            x=0,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Attack_0014
            x=64,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Attack_0015
            x=128,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Idle_0001
            x=192,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Idle_0002
            x=256,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Idle_0003
            x=320,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Idle_0004
            x=384,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Move_0005
            x=448,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Move_0006
            x=512,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Move_0007
            x=576,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Move_0008
            x=640,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Move_0009
            x=704,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Move_0010
            x=768,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Move_0011
            x=832,
            y=0,
            width=64,
            height=64,

        },
        {
            -- DnN_Enemy_Move_0012
            x=896,
            y=0,
            width=64,
            height=64,

        },
    },

    sheetContentWidth = 960,
    sheetContentHeight = 64
}

SheetInfo.frameIndex =
{

    ["DnN_Enemy_Attack_0013"] = 1,
    ["DnN_Enemy_Attack_0014"] = 2,
    ["DnN_Enemy_Attack_0015"] = 3,
    ["DnN_Enemy_Idle_0001"] = 4,
    ["DnN_Enemy_Idle_0002"] = 5,
    ["DnN_Enemy_Idle_0003"] = 6,
    ["DnN_Enemy_Idle_0004"] = 7,
    ["DnN_Enemy_Move_0005"] = 8,
    ["DnN_Enemy_Move_0006"] = 9,
    ["DnN_Enemy_Move_0007"] = 10,
    ["DnN_Enemy_Move_0008"] = 11,
    ["DnN_Enemy_Move_0009"] = 12,
    ["DnN_Enemy_Move_0010"] = 13,
    ["DnN_Enemy_Move_0011"] = 14,
    ["DnN_Enemy_Move_0012"] = 15,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
