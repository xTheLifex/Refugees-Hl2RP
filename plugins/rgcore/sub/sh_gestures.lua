--[[
 
   ____       __                              _   _ _     ____  ____  ____  
  |  _ \ ___ / _|_   _  __ _  ___  ___  ___  | | | | |   |___ \|  _ \|  _ \ 
  | |_) / _ \ |_| | | |/ _` |/ _ \/ _ \/ __| | |_| | |     __) | |_) | |_) |
  |  _ <  __/  _| |_| | (_| |  __/  __/\__ \ |  _  | |___ / __/|  _ <|  __/ 
  |_| \_\___|_|  \__,_|\__, |\___|\___||___/ |_| |_|_____|_____|_| \_\_|    
                       |___/                                                
 
    ____           _                         ____            _                 
   / ___| ___  ___| |_ _   _ _ __ ___  ___  / ___| _   _ ___| |_ ___ _ __ ___  
  | |  _ / _ \/ __| __| | | | '__/ _ \/ __| \___ \| | | / __| __/ _ \ '_ ` _ \ 
  | |_| |  __/\__ \ |_| |_| | | |  __/\__ \  ___) | |_| \__ \ ||  __/ | | | | |
   \____|\___||___/\__|\__,_|_|  \___||___/ |____/ \__, |___/\__\___|_| |_| |_|
                                                   |___/                       
 
]]
-- + Adjustments to damage

ix.option.Add("hearHeadshotSound", ix.type.bool, true, {
   category = "appearance"
})

ix.lang.AddTable("english", {
   optHearHeadshotSound = "Hear CSS Headshot sounds for CP/OTA"
})




if (SERVER) then
   util.AddNetworkString( "RGDoGesture" )
   -- Flinch Gesture Tables
   local gTableCP = {
      [32] = {"flinch_gesture"}, -- DEFAULT
      [HITGROUP_HEAD] = {"flinchheadgest1", "flinchheadgest2"},
      [HITGROUP_STOMACH] = {"flinchgutgest1", "flinchgutgest2"},
      [HITGROUP_LEFTARM] = {"flinchlarmgest"}
   }

   -- Flinching 
   function PLUGIN:DoDamageFlinch(ply, hitgroup, dmginfo) 
      local attacker = dmginfo:GetAttacker()
      if (IsValid(ply) and ply:IsPlayer()) then
         local char = ply:GetCharacter()
         local rgcore = ix.plugin.Get("rgcore")

         local class = ix.anim.GetModelClass(char:GetModel())
         local headshot = false
         if (hitgroup == HITGROUP_HEAD) then headshot = true end

         if (class == "metrocop") then
            -- METROPOLICE ANIMATIONS HERE
            local sequences = gTableCP[hitgroup] or gTableCP[32]
            local sequence = sequences[math.random(#sequences)]
            if (sequence) then
               gesture = ply:GetSequenceActivity(ply:LookupSequence(sequence))
               self:DoPlayerGesture(ply, gesture, GESTURE_SLOT_FLINCH, headshot)
            end
         else
            -- DEFAULT ANIMATIONS HERE
         end

      end
   end

   function PLUGIN:DoPlayerGesture(ply, gesture, slot, headshot)
      if (!IsValid( ply )) then return end
      if (!gesture) then return end
      local slot = slot or GESTURE_SLOT_FLINCH
      local headshot = headshot or false

      net.Start("RGDoGesture")
      net.WriteEntity(ply)
      net.WriteInt(gesture, 16)
      net.WriteInt(slot, 16)
      net.WriteBool(headshot)
      net.Broadcast()
   end

end

if (CLIENT) then
   net.Receive( "RGDoGesture", function(len)
      local ply = net.ReadEntity()
      local gesture = net.ReadInt(16)
      local slot = net.ReadInt(16) 
      local headshot = net.ReadBool()
      if (!IsValid( ply )) then return end

      local soundEnabled = ix.option.Get("hearHeadshotSound", true)

      if (soundEnabled and ply:IsCombine()) then
         ply:EmitSound("player/bhit_helmet-1.wav")
      end

      ply:AnimRestartGesture( slot, gesture, true )
   end )
end