function PLUGIN:PlayerFootstep(client, position, foot, soundName, volume)
	local factionTable = ix.faction.Get(client:Team())

    if (client:Crouching()) then
        return true
    end

	if (factionTable.runSounds and client:IsRunning()) then
        if (factionTable.runSounds[foot]) then
            client:EmitSound(factionTable.runSounds[foot])
            return true
        end
	end

    if (factionTable.walkSounds and !client:IsRunning()) then
        if (factionTable.walkSounds[foot]) then
            client:EmitSound(factionTable.walkSounds[foot])
            return true
        end
    end

	client:EmitSound(soundName)
	return true
end