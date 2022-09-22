ix.config.Add("experimentalModeVC", false, "This won't always work as expected!!! Adjusts voice command texts to \"fit\" to the rest of the text. If the text continues after a voice command it will remove the end symbol etc.", nil, {category = PLUGIN.name})
ix.config.Add("separatorVC", "|", "Separator symbol between voice commands and text. Leave empty for using spaces as separator. (Using spaces might cause unforseen consequences, 10-8 Standing By will not be recognized, instead it will use the 10-8 voice command and then play the Standing By voice command.", nil, {category = PLUGIN.name})
ix.config.Add("radioVCAllow", true, "Allow voice commands to be used on the radio. This will playback the voice commands on all the recevers.", nil, {category = PLUGIN.name})
ix.config.Add("radioVCVolume", 60, "Sets the volume, radio voice commands are played back for receivers. This is lower than normal as it's coming through a radio.", nil, {category = PLUGIN.name, data = {min = 0, max = 200}})
ix.config.Add("radioVCClientOnly", false, "If set to true, radio voice commands receivers will hear the voice commands only clientside, so nobody around them can hear it.", nil, {category = PLUGIN.name})

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
local ADJUST_SOUND = SoundDuration("npc/metropolice/pain1.wav") > 0 and "" or "../../hl2/sound/"
local function EmitQueuedSoundsPitched(entity, sounds, delay, spacing, volume, pitch)
    -- Let there be a delay before any sound is played.
	delay = delay or 0
	spacing = spacing or 0.1

	-- Loop through all of the sounds.
	for k, v in ipairs(sounds) do
		local postSet, preSet = 0, 0

		-- Determine if this sound has special time offsets.
		if (istable(v)) then
			postSet, preSet = v[2] or 0, v[3] or 0
			v = v[1]
		end

        --TODO: Fix the bug properly?
        --I dont think this changes much
        postSet = 0
        preSet = 0

        local _pitch = 100
        if (istable(pitch)) then
            _pitch = pitch[k]
        end

        if (_pitch and isnumber(_pitch)) then
            _pitch = math.Clamp(_pitch, 70, 180)
        end

		-- Get the length of the sound.
		local length = SoundDuration(ADJUST_SOUND..v)-0.075
		-- If the sound has a pause before it is played, add it here.
		delay = delay + preSet

		-- Have the sound play in the future.
		timer.Simple(delay, function()
			-- Check if the entity still exists and play the sound.
			if (IsValid(entity)) then
				entity:EmitSound(v, volume, _pitch)
			end
		end)
        
		-- Add the delay for the next sound.
		delay = delay + length + postSet + spacing
	end

	-- Return how long it took for the whole thing.
	return delay
end


if (CLIENT) then
    netstream.Hook("PlayQueuedSound", function(entity, sounds, delay, spacing, volume, pitch)
        entity = entity or LocalPlayer()
    
        EmitQueuedSoundsPitched(entity, sounds, delay, spacing, volume, pitch)
    end)
end


if (SERVER) then
    local PLUGIN = PLUGIN
    PLUGIN.TempStored = PLUGIN.TempStored or {}

    -- if no separator then just seperate at spaces
    local function GetVoiceCommands(text, class, separator)
        local strings = string.Explode(separator or " ", text)
        local finaltable = {}
        local usedkeys = {}

        for k, v in ipairs(strings) do
            if usedkeys[k] then continue end
            local pitch = 100
            v = string.Trim(v)

            local pChar = string.find(v, "#")
            if (pChar) then
                local sPitch = string.sub(v, pChar, pChar+3)
                v = string.gsub(v, sPitch, "")
                sPitch = string.sub(sPitch,2,-1)

                local nPitch = tonumber(sPitch)
                if (nPitch) then
                    pitch = nPitch
                else
                    pitch = 100
                end
            end


            local info = Schema.voices.Get(class, v)

            if !info then
                if !separator then
                    local combiner
                    local temp = {}

                    for i = k, #strings do
                        combiner = combiner and combiner .. " " .. strings[i] or strings[i]

                        info = Schema.voices.Get(class, combiner)

                        temp[i] = true

                        if info then
                            usedkeys = temp
                            break
                        end
                    end
                end
            end

            if (info) then info.pitch = pitch or 100 end
            table.insert(finaltable, !info and {text = v, pitch = pitch or 100} or table.Copy(info))
        end
        return finaltable
    end

    local function ExperimentalFormatting(stringtabl)
        local carry
        -- carry like in mathematical equations :)
        -- the point of the carry is to move question marks or exclamation marks to the end of the text
        for k, v in ipairs(stringtabl) do
            local before, after = stringtabl[k - 1] and k - 1, stringtabl[k + 1] and k + 1

            -- if we are not a voice command, check if we have someone before us, cuz if we do and they are a voice command than only they can have the carry symbol set
            if !v.sound then
                if before and carry and stringtabl[before].sound and string.sub(stringtabl[before].text, #stringtabl[before].text, #stringtabl[before].text) != "," then
                    local text = stringtabl[before].text
                    stringtabl[before].text = string.SetChar(text, #text, carry)
                    carry = nil
                end
                -- we only want voice commands to be corrected
                continue
            end

            -- if there is a string before us adjust the casing of our first letter according to the before's symbol
            if before then
                local sub = string.sub(stringtabl[before].text, #stringtabl[before].text, #stringtabl[before].text)
                local case = string.lower(string.sub(v.text, 1, 1))

                if sub == "!" or sub == "." or sub == "?" then
                    case = string.upper(string.sub(v.text, 1, 1))
                end

                v.text = string.SetChar(v.text, 1, case)
            end

            -- if there is a string after us adjust our symbol to their casing. if they are a vc always adjust to comma, if they are not, check if the message starts with a lower casing letter, indicating a conntinuation of the sentence
            if after then
                local firstletterafter = string.sub(stringtabl[after].text, 1, 1)
                local endsub = string.sub(v.text, #v.text, #v.text)

                if stringtabl[after].sound or string.match(firstletterafter, "%l") then
                    if endsub == "!" or endsub == "." or endsub == "?" then
                        v.text = string.SetChar(v.text, #v.text, ",")
                        if stringtabl[after].sound and endsub != "." then
                            carry = carry == nil and endsub or carry
                        end
                    end
                end
            end

            -- we are a vc so we can also set the carry to us
            if carry then
                if !after then
                    v.text = string.SetChar(v.text, #v.text, carry) 
                    carry = nil
                    continue
                end
            end
        end
        return stringtabl
    end

    function Schema:PlayerMessageSend(speaker, chatType, text, anonymous, receivers, rawText)
        local rgcore = ix.plugin.Get("rgcore")
        if (rgcore) then
            rgcore:PlayerMessageSend(speaker, chatType, text, anonymous, receivers, rawText)
        end
        
        local separator = ix.config.Get("separatorVC", nil) != "" and ix.config.Get("separatorVC", nil) or nil

        if chatType == "ic" or chatType == "w" or chatType == "y" or chatType == "dispatch" or (ix.config.Get("radioVCAllow", true) and chatType == "radio") then
            local class = self.voices.GetClass(speaker)

            for k, v in pairs(class) do
                local texts = GetVoiceCommands(rawText, v, separator)
                local isGlobal = false
                local completetext
                local sounds = {}
                local pitchdata = {}
                if ix.config.Get("experimentalModeVC", false) == true then
                    texts = ExperimentalFormatting(texts)
                end
                for k2, v2 in ipairs(texts) do
                    if v2.sound then
                        if v2.global then
                            isGlobal = true
                        end
                        table.insert(sounds, v2.sound)
                        table.insert(pitchdata, v2.pitch or 100)
                    end

                    local volume = isGlobal and 0 or 80
                    if chatType == "w" then
                        volume = 60
                    elseif chatType == "y" then
                        volume = 150
                    end

                    completetext = completetext and completetext .. " " .. v2.text or v2.text

                    if k2 == #texts then
                        if table.IsEmpty(sounds) then break end

                        if (speaker:Team() == FACTION_MPF) then
                            sounds = {"NPC_MetroPolice.Radio.On", unpack(sounds)}
                            pitchdata = {100, unpack(pitchdata)}
                        elseif (speaker:Team() == FACTION_OTA) then
                            sounds = {"OverwatchRadio.On", unpack(sounds)}
                            pitchdata = {100, unpack(pitchdata)}
                        end

                        if speaker:IsCombine() and !isGlobal then
                            speaker.bTypingBeep = nil
                            if (speaker:Team() == FACTION_MPF) then
                                table.insert(sounds, "NPC_MetroPolice.Radio.Off")
                                table.insert(pitchdata, 100)
                            elseif(speaker:Team() == FACTION_OTA) then
                                table.insert(sounds, "OverwatchRadio.Off")
                                table.insert(pitchdata, 100)
                            end
                        end

                        local _ = !isGlobal and EmitQueuedSoundsPitched(speaker, sounds, nil, nil, volume, pitchdata) or netstream.Start(nil, "PlayQueuedSound", nil, sounds, nil, nil, volume, pitchdata)

                        if chatType == "radio" then
                            volume = ix.config.Get("radioVCVolume", 60)
                            if ix.config.Get("radioVCClientOnly", false) == true then
                                netstream.Start(receivers, "PlayQueuedSound", nil, sounds, nil, nil, volume)
                            else
                                for k3, v3 in pairs(receivers) do
                                    if v3 == speaker then continue end
                                    EmitQueuedSoundsPitched(v3, sounds, nil, nil, volume, pitchdata)
                                end
                            end
                        end

                        text = completetext

                        goto exit
                    end
                end
            end

            ::exit::

            PLUGIN.TempStored[CurTime()] = text

            if speaker:IsCombine() then
                if chatType != "radio" then
                    return string.format("<:: %s ::>", text)
                end
            end
            return text
        end

        -- this isnt optimal but it works
        if chatType == "radio_eavesdrop" then
            if PLUGIN.TempStored[CurTime()] then
                text = PLUGIN.TempStored[CurTime()]
                PLUGIN.TempStored[CurTime()] = nil
            end
        end
        return text
    end
end