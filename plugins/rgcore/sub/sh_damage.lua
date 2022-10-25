function PLUGIN:DoDamageScaling(ply, hitgroup, dmginfo)
   if (!ply) then return end
   local char = ply:GetCharacter()
   local attacker = dmginfo:GetAttacker()
   if (attacker:IsPlayer()) then
      dmginfo:ScaleDamage( 4 )
   end

   if (hitgroup == HITGROUP_HEAD) then
      if (attacker:IsPlayer()) then
         dmginfo:ScaleDamage( 7 )
      else
      dmginfo:ScaleDamage( 4 )
      end

      if (ply:IsCombine()) then
         dmginfo:ScaleDamage(0.5)
      end

      if (char:GetFaction() == FACTION_OTA) then
         dmginfo:ScaleDamage(0.15)
      end
   end
end