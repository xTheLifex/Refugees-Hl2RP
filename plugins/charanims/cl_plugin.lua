
net.Receive("ixPlayGesture", function()
	local target = net.ReadEntity()
	local animation = net.ReadUInt(32)
	
	target:AddVCDSequenceToGestureSlot(GESTURE_SLOT_VCD, animation, 0, true)
end)
