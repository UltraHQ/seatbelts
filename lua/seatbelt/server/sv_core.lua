util.AddNetworkString( "beltcmd" )
util.AddNetworkString( "beltsound1" )
util.AddNetworkString( "beltsound2" )
util.AddNetworkString( "carspeedchime" )
util.PrecacheSound( "strapin.ogg" )
util.PrecacheSound( "openbelt.ogg" )
util.PrecacheSound( "carchime.ogg" )
resource.AddWorkshop( "1922996602" )

-- Precache Sounds (Gmod bug forces me this way)
timer.Simple( 8, function()
Entity( 0 ):EmitSound( "strapin.ogg", 0, 100, 0, CHAN_AUTO )
Entity( 0 ):EmitSound( "openbelt.ogg", 0, 100, 0, CHAN_AUTO )
end )

local delay = Seatbelt.cooldown
local lastOccurance = -delay

-- Add the very important hooks
	
hook.Add ( "PlayerEnteredVehicle", "seatbeltveh", function( ply )
	function speedcheckchime2()
	if ConVarExists("vc_usebeta") then
	timer.Create( "checkcarspeedchime", Seatbelt.checkspeed, 0, speedcheckchime2)
	if ply:GetVehicle():VC_getSpeedKmH() > Seatbelt.chimemph then --getSpeedKmH is actually in mph, wtf?
	net.Start( "carspeedchime" )
	net.Send( ply )
	timer.Remove( "checkcarspeedchime" )
	else return end
	else
	timer.Create( "checkcarspeedchime", Seatbelt.checkspeed, 0, speedcheckchime2)
	if ply:GetVehicle():GetSpeed() > Seatbelt.chimemph then
	net.Start( "carspeedchime" )
	net.Send( ply )
	timer.Remove( "checkcarspeedchime" )
	else return end
	end end
	speedcheckchime2()
end )

hook.Add ( "PlayerLeaveVehicle", "seatbeltveh2", function( ply )
	timer.Remove( "checkcarspeedchime" )
end )

-- Add all serverside commands to game
concommand.Add( "strapin", function( ply )
	local timeElapsed = CurTime() - lastOccurance
	if timeElapsed < delay then return
	else
	net.Start( "beltcmd" )
	net.Send( ply )
	lastOccurance = CurTime()
	end
end )

-- Functions
function donotexitbelt()
	hook.Add( "CanExitVehicle", "noexitwithbelt", function( ply, ent )
	return false
	end )
	
	hook.Add("VC_canSwitchSeat", "dontbreakvcmod", function(ply, ent_from, ent_to) -- VCMod support, yay
	local can = false
	return can
	end )
	
end

-- Receive net messages
net.Receive( "beltsound1", function( len, ply )
	ply:EmitSound( Sound("strapin.ogg" ), ply:GetPos(), -3, CHAN_AUTO, Seatbelt.volume, Seatbelt.range, 0, 100 )
	timer.Remove( "checkcarspeedchime" )
	donotexitbelt()
end )
	
net.Receive( "beltsound2", function( len, ply )
	ply:EmitSound( Sound( "openbelt.ogg" ), ply:GetPos(), -3, CHAN_AUTO, Seatbelt.volume, Seatbelt.range, 0, 100 )
	
	hook.Remove( "CanExitVehicle", "noexitwithbelt" )
	hook.Remove( "VC_canSwitchSeat", "dontbreakvcmod" )
end )