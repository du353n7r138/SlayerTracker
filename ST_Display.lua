local ST = SlayerTracker

---------------------------------------------------------------------------
-- CREATE GUI
---------------------------------------------------------------------------
function ST.CreateGuiElements()
    ST.PARENT = WINDOW_MANAGER:CreateTopLevelWindow(ST.NAME .. "_PARENT")
    ST.PARENT:SetDimensions(ST.SV.iconSize, ST.SV.iconSize)
    ST.PARENT:SetClampedToScreen(true)
    ST.PARENT:SetMovable(not ST.SV.isLocked)
    ST.PARENT:SetMouseEnabled(not ST.SV.isLocked)
    ST.PARENT:SetHidden(true)

    ST.PARENT:SetHandler("OnMoveStop", function()
        ST.SV.offsetX = ST.PARENT:GetLeft()
        ST.SV.offsetY = ST.PARENT:GetTop()
    end)

    -- BACKGROUND / BORDER
    ST.BG = WINDOW_MANAGER:CreateControl("$(parent)_BG", ST.PARENT, CT_BACKDROP)
    ST.BG:SetAnchor(TOPLEFT, ST.PARENT, TOPLEFT)
    ST.BG:SetDimensions(ST.SV.iconSize, ST.SV.iconSize)
    ST.BG:SetEdgeTexture("", 1, 1, ST.SV.edgeThickness, 0)
    ST.BG:SetCenterColor(unpack(ST.SV.ColorIdle))
    ST.BG:SetEdgeColor(0, 0, 0, 1)
    ST.BG:SetHidden(not ST.SV.isShowBackground)

    -- ICON
    ST.ICON = WINDOW_MANAGER:CreateControl("$(parent)_ICON", ST.PARENT, CT_TEXTURE)
    ST.ICON:SetAnchor(CENTER, ST.PARENT, CENTER)
    local innerSize = math.max(1, ST.SV.iconSize - (ST.SV.borderThickness * 2))
    ST.ICON:SetDimensions(innerSize, innerSize)
    ST.ICON:SetTexture(GetAbilityIcon(ST.MAJOR_SLAYER_ICON))
    ST.ICON:SetHidden(not ST.SV.isShowBackground)
    ST.ICON:SetDesaturation(ST.SV.iconDesaturation / 100)

    -- TIMER
    ST.DURATION = WINDOW_MANAGER:CreateControl("$(parent)_DURATION", ST.PARENT, CT_LABEL)
    ST.DURATION:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
    ST.DURATION:SetVerticalAlignment(TEXT_ALIGN_CENTER)
    ST.UpdateTimerPosition()

    -- UPTIME PERCENTAGE
    ST.UPTIME_LABEL = WINDOW_MANAGER:CreateControl("$(parent)_UPTIME", ST.PARENT, CT_LABEL)
    ST.UPTIME_LABEL:SetColor(unpack(ST.SV.textColorUptime))
    ST.UPTIME_LABEL:SetAnchor(TOPLEFT, ST.PARENT, TOPLEFT, 7, 3)

    ST.UpdateFonts()
end

---------------------------------------------------------------------------
-- TIMER POSITION
---------------------------------------------------------------------------
function ST.UpdateTimerPosition()
    ST.DURATION:ClearAnchors()
    ST.DURATION:SetAnchor(CENTER, ST.PARENT, CENTER, 0, ST.SV.offsetYTimer)
end

---------------------------------------------------------------------------
-- FONT STYLE AND SIZE
---------------------------------------------------------------------------
function ST.UpdateFonts()
    local style = ST.SV.isThickOutline and "thick-outline" or "soft-shadow-thick"
    ST.DURATION:SetFont("$(BOLD_FONT)|" .. ST.SV.fontSizeTimer .. "|" .. style)
    ST.UPTIME_LABEL:SetFont("$(BOLD_FONT)|" .. ST.SV.fontSizeUptime .. "|" .. style)
end

---------------------------------------------------------------------------
-- DEFAULT POSITION
---------------------------------------------------------------------------
function ST.SetDefaultPosition()
    ST.PARENT:ClearAnchors()
    ST.PARENT:SetAnchor(CENTER, GuiRoot, CENTER, 0, ST.Default.offsetY)
    ST.SV.offsetX = ST.PARENT:GetLeft()
    ST.SV.offsetY = ST.PARENT:GetTop()
end