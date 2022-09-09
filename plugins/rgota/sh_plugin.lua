PLUGIN.name = "Refugees - Overwatch Module"
PLUGIN.description = "The Refugees OTA module, contains features related to the combine overwatch."
PLUGIN.author = "TheLife"
PLUGIN.maxLength = 512

sound.Add({
    name = "OverwatchRadio.On",
    channel = CHAN_STATIC,
    volume = 1,
    level = 60,
    sound = {
        "npc/combine_soldier/vo/on1.wav",
        "npc/combine_soldier/vo/on2.wav"
    }
})

sound.Add({
    name = "OverwatchRadio.Off",
    channel = CHAN_STATIC,
    volume = 1,
    level = 60,
    sound = {
        "npc/combine_soldier/vo/off1.wav",
        "npc/combine_soldier/vo/off2.wav",
        "npc/combine_soldier/vo/off3.wav"
    }
})


if (CLIENT) then
    return
end

function PLUGIN:PlayerMessageSend(speaker, chatType, text, anonymous, receivers, rawText)
	if (chatType == "ic" or chatType == "w" or chatType == "y" or chatType == "dispatch" or chatType == "radio") then
		local class = Schema.voices.GetClass(speaker)

		for k, v in ipairs(class) do
			local info = Schema.voices.Get(v, rawText)

			if (info) then
				local volume = 80

				if (chatType == "w") then
					volume = 60
				elseif (chatType == "y") then
					volume = 150
				end

				if (info.sound) then
					if (info.global) then
						netstream.Start(nil, "PlaySound", info.sound)
					else
						local sounds = {info.sound}

						if (speaker:IsCombine()) then
							speaker.bTypingBeep = nil

							if (speaker:Team() == FACTION_MPF) then
								sounds = {"NPC_MetroPolice.Radio.On", info.sound, "NPC_MetroPolice.Radio.Off"}
							else
								sounds = {"OverwatchRadio.On", info.sound, "OverwatchRadio.Off"}
							end
						end


						ix.util.EmitQueuedSounds(speaker, sounds, nil, nil, volume)
					end
				end

				if (speaker:IsCombine()) then
					return string.format("<:: %s ::>", info.text)
				else
					return info.text
				end
			end
		end

		if (speaker:IsCombine()) then
			return string.format("<:: %s ::>", text)
		end
	end
end

netstream.Hook("PlayerChatTextChanged", function(client, key)
	if (client:IsCombine() and !client.bTypingBeep
	and (key == "y" or key == "w" or key == "r" or key == "t")) then
		if (client:Team() == FACTION_MPF) then
			client:EmitSound("NPC_MetroPolice.Radio.On")
		else
			client:EmitSound("OverwatchRadio.on")
		end

		client.bTypingBeep = true
	end
end)

netstream.Hook("PlayerFinishChat", function(client)
	if (client:IsCombine() and client.bTypingBeep) then
		if (client:Team() == FACTION_MPF) then
			client:EmitSound("NPC_MetroPolice.Radio.Off")
		else
			client:EmitSound("OverwatchRadio.Off")
		end

		client.bTypingBeep = nil
	end
end)