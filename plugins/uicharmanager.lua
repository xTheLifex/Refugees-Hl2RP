local PLUGIN = PLUGIN
PLUGIN.name = "Offline Character Remove/Blocks/Unblocks"
PLUGIN.author = "Jars"
PLUGIN.contact = "JarssS8#5797"
PLUGIN.description = "Allows staff to remove/block/unblock characters which are or not actively loaded on the server."

ix.lang.AddTable("english", {
    cmdCharRemoveSteamIDDesc = "Open UI for remove player's characters from his SteamID.",
    cmdCharBanSteamIDDesc = "Open UI for ban player's characters from his SteamID.",
    cmdCharUnBanSteamIDDesc = "Open UI for unban player's characters from his SteamID.",
    cmdCharBanSteamIDNoResult = "The SteamID %s has not characters.",
    cmdCharNotBanned = "That character is not banned.",
    cmdCharAlreadyBanned = "That character is already banned.",
    cmdCharCorrectlyBanned = "The character %s was successfully banned.",
    cmdCharCorrectlyUnBanned = "The character %s was successfully unbanned.",
    cmdCharColumnName = "Name",
    cmdCharColumnCharacterID = "Character ID",
    cmdCharColumnSteamID = "SteamID",
    cmdCharIDNotMatch = "The character ID do not match.",
    cmdCharCancelButton = "Cancel",
    cmdCharSuccessfullyAction = "The action %s was successfully on the character %s.",
    cmdCharTittleAction = "%s Character",
    cmdCharTextOnInput = "Put here the character ID.",
    cmdCharConfirmationText = "If you want to %s the character with name %s type his CharacterID for ensuring you action.",
    cmdCharPlayerIsConnected = "The player is charged on the server right now, ban the character first or ask the user to change his character.",
    cmdCharNotLineSelected = "You must select a line.",
    cmdCharBlockText = "Block",
    cmdCharUnBlockText = "Unblock",
    cmdCharRemoveText = "Remove",
    
})

PLUGIN.ActionEnum = {
    REMOVE = 1,
    BLOCK = 2,
    UNBLOCK = 3,
}

function PLUGIN:IsCharacterLoaded(charId)
    return ix.char.loaded[charId]:GetPlayer():GetCharacter():GetID() == tonumber(charId)
end

function PLUGIN:GetCharactersBySteamID(client, steamID64, callback)
    local query = mysql:Select("ix_characters")
    query:Select("id")
    query:Where("schema", Schema.folder)
    query:Where("steamID", steamID64)

    query:Callback(function(result)
        if result then
            if #result > 0 then
                callback(result)
            else
                client:NotifyLocalized("cmdCharBanSteamIDNoResult", util.SteamIDFrom64(steamID64))
            end
        else
            client:NotifyLocalized("cmdCharBanSteamIDNoResult", util.SteamIDFrom64(steamID64))
        end
    end)

    query:Execute()
end

ix.command.Add("CharRemoveBySteamID", {
    description = "@cmdCharRemoveSteamIDDesc",
    privilege = "Remove one character from SteamID",
    superAdminOnly = true,
    arguments = {ix.type.string,},
    OnRun = function(self, client, steamID)
        local steamID64 = util.SteamIDTo64(steamID)

        PLUGIN:GetCharactersBySteamID(client, steamID64, function(charactersIds)
            net.Start("CharactersActionList")
            net.WriteInt(PLUGIN.ActionEnum.REMOVE, 4) -- Remove action
            net.WriteTable(charactersIds)
            net.Send(client)
        end)
    end
})

ix.command.Add("CharBlockBySteamID", {
    description = "@cmdCharBanSteamIDDesc",
    privilege = "Block one character from SteamID",
    superAdminOnly = true,
    arguments = {ix.type.string,},
    OnRun = function(self, client, steamID)
        local steamID64 = util.SteamIDTo64(steamID)

        PLUGIN:GetCharactersBySteamID(client, steamID64, function(charactersIds)
            net.Start("CharactersActionList")
            net.WriteInt(PLUGIN.ActionEnum.BLOCK, 4) -- Block action
            net.WriteTable(charactersIds)
            net.Send(client)
        end)
    end
})

ix.command.Add("CharUnBlockBySteamID", {
    description = "@cmdCharUnBanSteamIDDesc",
    privilege = "UnBlock one character from SteamID",
    superAdminOnly = true,
    arguments = {ix.type.string,},
    OnRun = function(self, client, steamID)
        local steamID64 = util.SteamIDTo64(steamID)

        PLUGIN:GetCharactersBySteamID(client, steamID64, function(charactersIds)
            net.Start("CharactersActionList")
            net.WriteInt(PLUGIN.ActionEnum.UNBLOCK, 4) -- UnBlock action
            net.WriteTable(charactersIds)
            net.Send(client)
        end)
    end
})

if CLIENT then
    local CharactersAction

    local function CharactersActionList()
        local action = net.ReadInt(4)
        local charactersIds = net.ReadTable()

        if IsValid(CharactersAction) then
            CharactersAction:Remove()
        end

        CharactersAction = vgui.Create("DFrame")
        CharactersAction:SetSize(450, 245)
        CharactersAction:SetPos((ScrW() / 2) - 150, (ScrH() / 2) - 100)
        local actionText = ""
        local netString = ""

        if action == PLUGIN.ActionEnum.BLOCK then
            actionText = L("cmdCharBlockText")
            netString = "ixCharacterBlock"
        elseif action == PLUGIN.ActionEnum.UNBLOCK then
            actionText = L("cmdCharUnBlockText")
            netString = "ixCharacterUnblock"
        elseif action == PLUGIN.ActionEnum.REMOVE then
            actionText = L("cmdCharRemoveText")
            netString = "ixCharacterDelete"
        end

        CharactersAction:SetTitle(L("cmdCharTittleAction", actionText))
        CharactersAction:MakePopup()
        local pnl = vgui.Create("DPanel", CharactersAction)
        pnl.Paint = function() end
        pnl:SetTall(20)
        pnl:Dock(BOTTOM)
        CharactersAction.Rank = vgui.Create("DLabel", pnl)
        CharactersAction.Rank:Dock(LEFT)
        CharactersAction.Rank:SetTall(20)
        CharactersAction.Rank:SetWide(150)
        CharactersAction.Rank:SetText("")
        CharactersAction.Updated = vgui.Create("DLabel", pnl)
        CharactersAction.Updated:Dock(RIGHT)
        CharactersAction.Updated:SetTall(150)
        CharactersAction.Updated:SetText("")
        CharactersAction.List = vgui.Create("DListView", CharactersAction)
        local List = CharactersAction.List
        List:Dock(FILL)
        List:AddColumn(L("cmdCharColumnSteamID"))
        List:AddColumn(L("cmdCharColumnCharacterID"))
        List:AddColumn(L("cmdCharColumnName"))
        List:AddLine("", "Loading...")
        List:OnRequestResize(List.Columns[1], 100)
        List:OnRequestResize(List.Columns[2], 10)
        List:OnRequestResize(List.Columns[3], 100)

        if #charactersIds > 0 then
            CharactersAction.List:Clear()
        end

        for i = 1, #charactersIds do
            local char = ix.char.loaded[tonumber(charactersIds[i].id)]

            if action == PLUGIN.ActionEnum.BLOCK and char:GetData("banned", false) ~= true then
                CharactersAction.List:AddLine(char:GetPlayer():SteamID(), tonumber(char:GetID()), char:GetName())
            elseif action == PLUGIN.ActionEnum.UNBLOCK and char:GetData("banned", false) then
                CharactersAction.List:AddLine(char:GetPlayer():SteamID(), tonumber(char:GetID()), char:GetName())
            elseif action == PLUGIN.ActionEnum.REMOVE then
                CharactersAction.List:AddLine(char:GetPlayer():SteamID(), tonumber(char:GetID()), char:GetName())
            end
        end

        CharactersAction.RemoveButton = vgui.Create("DButton", pnl)
        CharactersAction.RemoveButton:Dock(LEFT)
        CharactersAction.RemoveButton:SetTall(20)
        CharactersAction.RemoveButton:SetWide(150)
        CharactersAction.RemoveButton:SetText(string.upper(actionText))

        -- Defines what should happen when the label is clicked
        function CharactersAction.RemoveButton:DoClick()
            local _, line = CharactersAction.List:GetSelectedLine()
            if not CharactersAction.List:GetSelectedLine() or not line then
                LocalPlayer():NotifyLocalized("cmdCharNotLineSelected")
            else
                local charId = line:GetColumnText(2)

                if PLUGIN:IsCharacterLoaded(charId) then
                    LocalPlayer():NotifyLocalized("cmdCharPlayerIsConnected")
                else
                    RequestConfirmation(actionText, charId, netString)
                end
            end
        end
    end

    function RequestConfirmation(actionText, charId, netString)
        Derma_StringRequest(L("cmdCharTittleAction", actionText), L("cmdCharConfirmationText", string.lower(actionText), ix.char.loaded[charId]:GetName()), L("cmdCharTextOnInput"), function(text)
            if tonumber(text) == charId then
                net.Start(netString)
                net.WriteUInt(charId, 32)
                net.SendToServer()
                LocalPlayer():NotifyLocalized("cmdCharSuccessfullyAction", string.lower(actionText), ix.char.loaded[charId]:GetName())
                CharactersAction:Remove()
            else
                LocalPlayer():NotifyLocalized("cmdCharIDNotMatch")
            end
        end, nil, actionText, L("cmdCharCancelButton"))
    end

    net.Receive("CharactersActionList", CharactersActionList)
else
    util.AddNetworkString("CharactersActionList")
    util.AddNetworkString("ixCharacterBlock")
    util.AddNetworkString("ixCharacterUnBlock")

    local function CharactersBlock(len, ply)
        local charId = net.ReadUInt(32)
        local character = ix.char.loaded[charId]

        if not character:GetData("banned", false) then
            character:SetData("banned", true)
            character:Save()
            ply:NotifyLocalized("cmdCharCorrectlyBanned", character:GetID())
        else
            ply:NotifyLocalized("cmdCharAlreadyBanned")
        end
    end

    net.Receive("ixCharacterBlock", CharactersBlock)

    local function CharactersUnBlock(len, ply)
        local charId = net.ReadUInt(32)
        local character = ix.char.loaded[charId]

        if character and character:GetData("banned", false) then
            character:SetData("banned", nil)
            ply:NotifyLocalized("cmdCharCorrectlyUnBanned", character:GetID())
        else
            ply:NotifyLocalized("cmdCharNotBanned")
        end
    end

    net.Receive("ixCharacterUnBlock", CharactersUnBlock)
end