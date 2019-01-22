------------------------------------------------------------------
-------------- Generic GetFrame with caching ---------------------
------------------------------------------------------------------
-- GetFrames(target)
--  return table of all frames for unit=target or {}
--
-- GetFrame(target)
--  return one frame for unit=target or nil
--  unitframe addon priority is defined with `frame_priority`
--  if it can't find a priority patterns, it select a random matching frame

-- full credit to @asakawa and @buds https://wago.io/GetFrameGeneric

local frame_priority = {
    -- raid frames
    [1] = "^Vd1", -- vuhdo
    [2] = "^Healbot", -- healbot
    [3] = "^GridLayout", -- grid
    [4] = "^Grid2Layout", -- grid2
    [5] = "^ElvUF_RaidGroup", -- elv
    [6] = "^oUF_bdGrid", -- bdgrid
    [7] = "^oUF.*raid", -- generic oUF
    [8] = "^LimeGroup", -- lime
    [9] = "^SUFHeaderraid", -- suf
    [10] = "^CompactRaid", -- blizz
    -- party frames
    [11] = "^SUFHeaderparty", --suf
    [12] = "^ElvUF_PartyGroup", -- elv
    [13] = "^oUF.*party", -- generic oUF
    [14] = "^PitBull4_Groups_Party", -- pitbull4
    [15] = "^CompactParty", -- blizz
    -- player frame
    [16] = "^SUFUnitplayer",
    [17] = "^PitBull4_Frames_Player",
    [18] = "^ElvUF_Player",
    [19] = "^oUF.*player",
    [20] = "^PlayerFrame",
}

WA_GetFramesCache = WA_GetFramesCache or {}
if not WA_GetFramesCacheListener then
    WA_GetFramesCacheListener = CreateFrame("Frame")
    local f = WA_GetFramesCacheListener
    f:RegisterEvent("PLAYER_REGEN_DISABLED")
    f:RegisterEvent("PLAYER_REGEN_ENABLED")
    f:RegisterEvent("GROUP_ROSTER_UPDATE")
    f:SetScript("OnEvent", function(self, event, ...)
        WA_GetFramesCache = {}
    end)
end

local function GetFrames(target)
    local function FindButtonsForUnit(frame, target)
        local results = {}
        if type(frame) == "table" and not frame:IsForbidden() then
            local type = frame:GetObjectType()
            if type == "Frame" or type == "Button" then
                for _,child in ipairs({frame:GetChildren()}) do
                    for _,v in pairs(FindButtonsForUnit(child, target)) do
                        tinsert(results, v)
                    end
                end
            end
            if type == "Button" then
                local unit = frame:GetAttribute('unit')
                if unit and frame:IsVisible() and frame:GetName() then
                    WA_GetFramesCache[frame] = unit
                    if UnitIsUnit(unit, target) then
                        tinsert(results, frame)
                    end
                end
            end
        end
        return results
    end
    
    if not UnitExists(target) then
        if type(target) == "string" and target:find("Player") then
            target = select(6,GetPlayerInfoByGUID(target))
        else
            target = target:gsub(" .*", "")
            if not UnitExists(target) then
                return {}
            end
        end
    end
    
    local results = {}
    for frame, unit in pairs(WA_GetFramesCache) do
        if UnitIsUnit(unit, target) then
            if frame:GetAttribute('unit') == unit then
                tinsert(results, frame)
            else
                results = {}
                break
            end
        end
    end
    
    return #results > 0 and results or FindButtonsForUnit(UIParent, target)
end

local isElvUI = IsAddOnLoaded("ElvUI")
local function WhyElvWhy(frame)
    if isElvUI and frame and frame:GetName():find("^ElvUF_") and frame.Health then
        return frame.Health
    else
        return frame
    end
end


function aura_env.GetFrame(target)
    local frames = GetFrames(target)
    if not frames then return nil end
    for i=1,#frame_priority do
        for _,frame in pairs(frames) do
            if (frame:GetName()):find(frame_priority[i]) then
                return WhyElvWhy(frame)
            end
        end
    end
    return WhyElvWhy(frames[1])
end


-- print("***********")
-- local target  = "player"
-- print("* first frame in priority list :")
-- local frame = GetFrame(target)
-- if frame then
--    --print(WeakAuras.ShowGlowOverlay(frame))
--    print(frame:GetName())
-- end

-- print("* all frames :")
-- local frames = GetFrames(target)
-- for _,frame in pairs(frames) do
--    --print(WeakAuras.ShowGlowOverlay(frame))
--    print(frame:GetName())   
-- end