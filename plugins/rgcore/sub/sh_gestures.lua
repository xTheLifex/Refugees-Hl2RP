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
      [HITGROUP_GEAR] = {"flinchgutgest1", "flinchgutgest2"},
      [HITGROUP_LEFTARM] = {"flinchlarmgest"}
   }

   local aTableCP = {
      [32] = {"flinch1", "flinch2"},
      [HITGROUP_HEAD] = {"flinch_head1", "flinch_head2"},
      [HITGROUP_LEFTARM] = {"flinch_leftarm1"},
      [HITGROUP_RIGHTARM] = {"flinch_rightarm1"},
      [HITGROUP_STOMACH] = {"flinch_stomach1", "flinch_stomach2"},
      [36] = {"flinch_back1"} -- SPECIAL: HIT FROM BEHIND
   }

   local gTableOTA = {
      [32] = {"flinch_gesture"},
      [HITGROUP_HEAD] = {"flinchheadgest"},
      [HITGROUP_STOMACH] = {"flinchgutgest"},
      [HITGROUP_GEAR] = {"flinchgutgest"},
      [HITGROUP_LEFTARM] = {"flinchlarmgest"},
      [HITGROUP_RIGHTARM] = {"flinchrarmgest"}
   }

   local aTableOTA = {
      [32] = {"flinchsmall"},
      [HITGROUP_HEAD] = {"flinchhead"},
      [HITGROUP_GEAR] = {"flinchgut"},
      [HITGROUP_STOMACH] = {"flinchgut"},
      [HITGROUP_CHEST] = {"flinchchest"},
      [34] = {"flinchbig"} -- SPECIAL: ALOT OF DAMAGE
   }

   -- Flinching 
   function PLUGIN:DoDamageFlinch(ply, hitgroup, dmginfo) 
      local attacker = dmginfo:GetAttacker()
      if (IsValid(ply) and ply:IsPlayer()) then
         local char = ply:GetCharacter()
         local rgcore = ix.plugin.Get("rgcore")

         local class = ix.anim.GetModelClass(char:GetModel())
         local headshot = false
         local specialAnims = false
         local behind = false
         local big = false

         if (hitgroup == HITGROUP_HEAD) then headshot = true end
         local attackerAim = Angle(0,0,0)
         local plyAim = ply:GetAimVector().y
         local diff = 90
         
         if (attacker and attacker.GetAimVector) then
            attackerAim = attacker:GetAimVector().y
            diff = math.AngleDifference(attackerAim, plyAim)
         end
         

         

         if (ply:IsWepRaised()) then
            if ((math.random(10) == 1)) then
               specialAnims = true
            end
         end

         if (math.deg(math.Round(diff)) <= 35) then
            behind = true   
         end

         if (dmginfo:GetDamage() > 50) then
            big = true
         end

         if (dmginfo:IsDamageType(DMG_BUCKSHOT)) then
            if (math.random(1,4) == 1) then
               big = true
            end
         end


         -- SPECIAL NON-GESTURE ANIMATIONS
         if (specialAnims) then
            -- Those animations require almost always for the player to stand still 
            -- and have a weapon raised
            if (CLIENT) then return end
            if (class == "metrocop") then
               -- METROPOLICE ANIMATIONS HERE
               local sequences = aTableCP[hitgroup] or aTableCP[32]
               if (behind) then sequences = aTableCP[36] or aTableCP[hitgroup] or aTableCP[32] end -- BEHIND ANIM
               local sequence = sequences[math.random(#sequences)]

               if (sequence) then
                  ply:ForceSequence(sequence)
               end
            elseif (class == "overwatch") then
               -- OVERWATCH ANIMATIONS HERE
               local sequences = aTableOTA[hitgroup] or aTableOTA[32]
               if (big) then sequences = aTableOTA[34] or aTableOTA[hitgroup] or aTableOTA[32] end -- BIG ANIM
               local sequence = sequences[math.random(#sequences)]

               if (sequence) then
                  ply:ForceSequence(sequence, function() ply:SetNetVar("canShoot", true) end)
               end
            else
               -- DEFAULT ANIMATIONS HERE
            end
         else -- GESTURE ANIMATIONS
            if (class == "metrocop") then
               -- METROPOLICE GESTURE ANIMATIONS HERE
               local sequences = gTableCP[hitgroup] or gTableCP[32]
               local sequence = sequences[math.random(#sequences)]
               if (sequence) then
                  gesture = ply:GetSequenceActivity(ply:LookupSequence(sequence))
                  self:DoPlayerGesture(ply, gesture, GESTURE_SLOT_FLINCH, headshot)
               end
            elseif (class == "overwatch") then
               -- OVERWATCH GESTURE ANIMATIONS HERE
               local sequences = gTableOTA[hitgroup] or gTableOTA[32]
               local sequence = sequences[math.random(#sequences)]
               if (sequence) then
                  gesture = ply:GetSequenceActivity(ply:LookupSequence(sequence))
                  self:DoPlayerGesture(ply, gesture, GESTURE_SLOT_FLINCH, headshot)
               end
            else
               -- DEFAULT GESTURE ANIMATIONS HERE
            end
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

      if (soundEnabled and ply:IsCombine() and headshot) then
         ply:EmitSound("player/bhit_helmet-1.wav")
      end

      ply:AnimRestartGesture( slot, gesture, true )
   end )
end