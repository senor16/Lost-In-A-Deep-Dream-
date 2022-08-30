--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:41ca43f88f85d95322c43cc5da6045d1:1de7b6421b0cebcbaa27aa7e5649be69:75e5f0377d493af113472aa679193bcd$
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
            -- DnN_Player_Climb_0017
            x=0,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Climb_0018
            x=112,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Climb_0019
            x=224,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Climb_0020
            x=336,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Climb_0021
            x=448,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Climb_0022
            x=560,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Idle_0001
            x=672,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Idle_0002
            x=784,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Idle_0003
            x=896,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Idle_0004
            x=1008,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Run_0005
            x=1120,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Run_0006
            x=1232,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Run_0007
            x=1344,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Run_0008
            x=1456,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Run_0009
            x=1568,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Run_0010
            x=1680,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Run_0011
            x=1792,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Run_0012
            x=1904,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Shoot_0014
            x=2016,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Shoot_0015
            x=2128,
            y=0,
            width=112,
            height=64,

        },
        {
            -- DnN_Player_Shoot_0016
            x=2240,
            y=0,
            width=112,
            height=64,

        },
    },

    sheetContentWidth = 2352,
    sheetContentHeight = 64
}

SheetInfo.frameIndex =
{

    ["DnN_Player_Climb_0017"] = 1,
    ["DnN_Player_Climb_0018"] = 2,
    ["DnN_Player_Climb_0019"] = 3,
    ["DnN_Player_Climb_0020"] = 4,
    ["DnN_Player_Climb_0021"] = 5,
    ["DnN_Player_Climb_0022"] = 6,
    ["DnN_Player_Idle_0001"] = 7,
    ["DnN_Player_Idle_0002"] = 8,
    ["DnN_Player_Idle_0003"] = 9,
    ["DnN_Player_Idle_0004"] = 10,
    ["DnN_Player_Run_0005"] = 11,
    ["DnN_Player_Run_0006"] = 12,
    ["DnN_Player_Run_0007"] = 13,
    ["DnN_Player_Run_0008"] = 14,
    ["DnN_Player_Run_0009"] = 15,
    ["DnN_Player_Run_0010"] = 16,
    ["DnN_Player_Run_0011"] = 17,
    ["DnN_Player_Run_0012"] = 18,
    ["DnN_Player_Shoot_0014"] = 19,
    ["DnN_Player_Shoot_0015"] = 20,
    ["DnN_Player_Shoot_0016"] = 21,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
