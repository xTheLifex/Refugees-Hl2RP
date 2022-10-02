
AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Forcefield"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.PhysgunDisabled = true
ENT.bNoPersist = true

ENT.whitelist = {}
ENT.whitelist["npc_combine_s"]  			=	true
ENT.whitelist["npc_metropolice"]  			=	true
ENT.whitelist["npc_rollermine"]  			=	true
ENT.whitelist["npc_stalker"]  				=	true
ENT.whitelist["npc_strider"]  				=	true
ENT.whitelist["npc_cscanner"]  				=	true
ENT.whitelist["npc_turret_floor"]  			=	true
ENT.whitelist["npc_clawscanner"]  			=	true
ENT.whitelist["npc_helicopter"]  			=	true
ENT.whitelist["npc_turret_ceiling"]  		=	true
ENT.whitelist["npc_combine_camera"]  		=	true
ENT.whitelist["npc_combinedropship"]  		=	true
ENT.whitelist["npc_hunter"]  				=	true
ENT.whitelist["npc_combinegunship"]  		=	true
ENT.whitelist["npc_rp_combine_s"]  			=	true
ENT.whitelist["npc_rp_metropolice"]  		=	true


function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Mode")
	self:NetworkVar("Entity", 0, "Dummy")
end

local MODE_ALLOW_ALL = 1
local MODE_ALLOW_CID = 2
local MODE_ALLOW_NONE = 3

if (SERVER) then
	function ENT:SpawnFunction(client, trace)
		local angles = (client:GetPos() - trace.HitPos):Angle()
		angles.p = 0
		angles.r = 0
		angles:RotateAroundAxis(angles:Up(), 270)

		local entity = ents.Create("ix_forcefield")
		entity:SetPos(trace.HitPos + Vector(0, 0, 40))
		entity:SetAngles(angles:SnapTo("y", 90))
		entity:Spawn()
		entity:Activate()

		Schema:SaveForceFields()
		return entity
	end

	hook.Add("ShouldCollide", "ix_forcefields2", function(a, b) 
		local forcefield
		local ent

		if (IsValid(a) and a:GetClass() == "ix_forcefield") then
			forcefield = a
			ent = b
		elseif (IsValid(b) and b:GetClass() == "ix_forcefield") then
			forcefield = b
			ent = a
		end

		if (forcefield:GetMode() == 1) then
			return false
		end

		local whitelist = forcefield.whitelist
		if (whitelist) then
			if ((whitelist[ent:GetName()] == true) or (whitelist[ent:GetClass()] == true)) then
				return false
			end
		end

	end)

    hook.Add("InitializedPlugins", "ixForcefieldSetup", function() 
        timer.Simple(5, function()  -- Wait a bit for everything to be properly loaded.
            for _, v in ipairs(ents.FindByClass("ix_forcefield")) do
                v:HammerSetup()
            end
        end)
    end)

    hook.Add("PostCleanupMap", "ixAutoCleanup", function() 
		for _, v in ipairs(ents.FindByClass("ix_forcefield")) do
			v:HammerSetup()
		end
    end)

	function ENT:HammerSetup()
		if (self.hammer) then
			if (self.hammer.mode) then
				self:SetMode(self.hammer.mode)
			end
			if (self.hammer.parents) then
				self.syncparents = ents.FindByName(self.hammer.parents)
			end
		end
	end

	function ENT:KeyValue(k, value)
		self.hammer = self.hammer or {}
		// Output: OnDenyUse - fires when user fails to use forcefield.
		if (k == "OnDenyUse") then
			self:StoreOutput(k,value)
		end
		// The default forcefield mode for this forcefield
		// 1 - Disabled
		// 2 - Only with valid CID
		// 3 - Only Combine
		if (k == "mode") then
			self.hammer.mode = tonumber(value) or 1
		end
		// If this forcefield has input enabled or not
		// 0 - Ignore player input
		// 1 - Accept player input
		if (k == "enabled") then
			self.enabled = tobool(value)
		end
		// Other forcefields to sync with.
		if (k == "parents") then
			self.hammer.parents = value
		end
	end

	function ENT:AcceptInput(input, ent, caller, data)
		local input = string.lower(input)
		if (input == "setmode") then
			local n = tonumber(data)
			if (n) then
				self:SetMode(n)
			end
			return true
		end
		if (input == "addtowhitelist") then
			self.whitelist[data] = true
			return true
		end
		if (input == "removefromwhitelist") then
			self.whitelist[data] = nil
			return true
		end
		if (input == "enableuse" or input == "enable") then
			self.enabled = true
		end
		if (input == "disableuse" or input == "disable") then
			self.enabled = false
		end

	end

	function ENT:Initialize()
		self:SetModel("models/props_combine/combine_fence01b.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:PhysicsInit(SOLID_VPHYSICS)

		local data = {}
			data.start = self:GetPos() + self:GetRight() * -16
			data.endpos = self:GetPos() + self:GetRight() * -480
			data.filter = self
		local trace = util.TraceLine(data)

		local angles = self:GetAngles()
		angles:RotateAroundAxis(angles:Up(), 90)

		self.dummy = ents.Create("prop_physics")
		self.dummy:SetModel("models/props_combine/combine_fence01a.mdl")
		self.dummy:SetPos(trace.HitPos)
		self.dummy:SetAngles(self:GetAngles())
		self.dummy:Spawn()
		self.dummy.PhysgunDisabled = true
		self:DeleteOnRemove(self.dummy)

		local verts = {
			{pos = Vector(0, 0, -25)},
			{pos = Vector(0, 0, 150)},
			{pos = self:WorldToLocal(self.dummy:GetPos()) + Vector(0, 0, 150)},
			{pos = self:WorldToLocal(self.dummy:GetPos()) + Vector(0, 0, 150)},
			{pos = self:WorldToLocal(self.dummy:GetPos()) - Vector(0, 0, 25)},
			{pos = Vector(0, 0, -25)}
		}

		self:PhysicsFromMesh(verts)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		self:SetCustomCollisionCheck(true)
		self:EnableCustomCollisions(true)
		self:SetDummy(self.dummy)

		physObj = self.dummy:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		self:SetMoveType(MOVETYPE_NOCLIP)
		self:SetMoveType(MOVETYPE_PUSH)
		self:MakePhysicsObjectAShadow()
		self:SetMode(MODE_ALLOW_ALL)
	end

	function ENT:StartTouch(entity)
		if (!self.buzzer) then
			self.buzzer = CreateSound(entity, "ambient/machines/combine_shield_touch_loop1.wav")
			self.buzzer:Play()
			self.buzzer:ChangeVolume(0.8, 0)
		else
			self.buzzer:ChangeVolume(0.8, 0.5)
			self.buzzer:Play()
		end

		self.entities = (self.entities or 0) + 1
	end

	function ENT:EndTouch(entity)
		self.entities = math.max((self.entities or 0) - 1, 0)

		if (self.buzzer and self.entities == 0) then
			self.buzzer:FadeOut(0.5)
		end
	end

	function ENT:OnRemove()
		if (self.buzzer) then
			self.buzzer:Stop()
			self.buzzer = nil
		end

		if (!ix.shuttingDown and !self.ixIsSafe) then
			Schema:SaveForceFields()
		end
	end

	local MODES = {
		{
			function(client)
				return false
			end,
			"Off."
		},
		{
			function(client)
				local character = client:GetCharacter()

				if (character and character:GetInventory() and !character:GetInventory():HasItem("cid")) then
					return true
				else
					return false
				end
			end,
			"Only allow with valid CID."
		},
		{
			function(client)
				return true
			end,
			"Never allow citizens."
		}
	}

	function ENT:Use(activator)
		if (!self.enabled) then return end

		local sync = false
		if (self.hammer) then
			if (self.hammer.opmode) then
				if (self.hammer.opmode == 1) then return end
				if (self.hammer.opmode == 2) then sync = true end
			end
		end

		local powered = true
		if (self.generator) then
			for _, g in ipairs(self.generator) do
				
			end
		end

		if ((self.nextUse or 0) < CurTime()) then
			self.nextUse = CurTime() + 1.5
		else
			return
		end

		if (!powered) then
			return
		end

		if (activator:IsCombine()) then
			self:SetMode(self:GetMode() + 1)

			if (self:GetMode() > #MODES) then
				self:SetMode(1)

				self:SetSkin(1)
				self.dummy:SetSkin(1)
				self:EmitSound("npc/turret_floor/die.wav")
			else
				self:SetSkin(0)
				self.dummy:SetSkin(0)
			end

			if (sync and self.syncparents) then
				
			end

			self:EmitSound("buttons/combine_button5.wav", 140, 100 + (self:GetMode() - 1) * 15)
			activator:ChatPrint("Changed barrier mode to: "..MODES[self:GetMode()][2])

			Schema:SaveForceFields()
		else
			self:EmitSound("buttons/combine_button3.wav")
		end
	end

	hook.Add("ShouldCollide", "ix_forcefields", function(a, b)
		local client
		local entity

		if (a:IsPlayer()) then
			client = a
			entity = b
		elseif (b:IsPlayer()) then
			client = b
			entity = a
		end

		if (IsValid(entity) and entity:GetClass() == "ix_forcefield") then
			if (IsValid(client)) then
				if (client:IsCombine() or client:Team() == FACTION_ADMIN) then
					return false
				end

				local mode = entity:GetMode() or 1

				return istable(MODES[mode]) and MODES[mode][1](client)
			else
				return entity:GetMode() != 4
			end
		end
	end)
else
	local SHIELD_MATERIAL = ix.util.GetMaterial("effects/combineshield/comshieldwall3")

	function ENT:Initialize()
		local data = {}
			data.start = self:GetPos() + self:GetRight()*-16
			data.endpos = self:GetPos() + self:GetRight()*-480
			data.filter = self
		local trace = util.TraceLine(data)

		self:EnableCustomCollisions(true)
		self:PhysicsInitConvex({
			vector_origin,
			Vector(0, 0, 150),
			trace.HitPos + Vector(0, 0, 150),
			trace.HitPos
		})
	end

	function ENT:Draw()
		self:DrawModel()

		if (self:GetMode() == 1) then
			return
		end

		local angles = self:GetAngles()
		local matrix = Matrix()
		matrix:Translate(self:GetPos() + self:GetUp() * -40)
		matrix:Rotate(angles)

		render.SetMaterial(SHIELD_MATERIAL)

		local dummy = self:GetDummy()

		if (IsValid(dummy)) then
			local vertex = self:WorldToLocal(dummy:GetPos())
			self:SetRenderBounds(vector_origin, vertex + self:GetUp() * 150)

			cam.PushModelMatrix(matrix)
				self:DrawShield(vertex)
			cam.PopModelMatrix()

			matrix:Translate(vertex)
			matrix:Rotate(Angle(0, 180, 0))

			cam.PushModelMatrix(matrix)
				self:DrawShield(vertex)
			cam.PopModelMatrix()
		end
	end

	function ENT:DrawShield(vertex)
		mesh.Begin(MATERIAL_QUADS, 1)
			mesh.Position(vector_origin)
			mesh.TexCoord(0, 0, 0)
			mesh.AdvanceVertex()

			mesh.Position(self:GetUp() * 190)
			mesh.TexCoord(0, 0, 3)
			mesh.AdvanceVertex()

			mesh.Position(vertex + self:GetUp() * 190)
			mesh.TexCoord(0, 3, 3)
			mesh.AdvanceVertex()

			mesh.Position(vertex)
			mesh.TexCoord(0, 3, 0)
			mesh.AdvanceVertex()
		mesh.End()
	end
end