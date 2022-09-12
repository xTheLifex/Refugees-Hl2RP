function PLUGIN:DoDamageScaling(ply, hitgroup, dmginfo)
    if (!ply) then return end
    local attacker = dmginfo:GetAttacker()
    
    if (hitgroup == HITGROUP_HEAD) then
        if (attacker:IsPlayer()) then
           dmginfo:ScaleDamage( 12 ) -- Only lethalize headshots from players.
        end
    
        if (ply:IsCombine()) then
           dmginfo:ScaleDamage(0.5)
        end
    
        if (char:GetFaction() == FACTION_OTA) then
           dmginfo:ScaleDamage(0.5)
        end
     end
end