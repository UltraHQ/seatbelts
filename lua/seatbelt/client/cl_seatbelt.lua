util.PrecacheSound( "strapin.ogg" )
util.PrecacheSound( "openbelt.ogg" )
util.PrecacheSound( "carchime.ogg" )

-- Credits to MysteryPancake for this Keybind code.
-- I did not do that code myself, I got it from his github.
local FirstPressed = false

hook.Add( "Think", "CallBinding", function()
	local cache = input.IsButtonDown( Seatbelt.key )
	if cache and FirstPressed then
		RunConsoleCommand( "strapin" )
	end
	FirstPressed = not cache
end )
-- https://github.com/MysteryPancake/GMod-Binding


-- Needed for the animation
local function inQuad( fraction, beginning, change )
    return change * ( fraction ^ 2 ) + beginning
end

function carchime()
EmitSound( Sound( "carchime.ogg" ), LocalPlayer():GetPos(), -1, CHAN_AUTO, Seatbelt.chimevolume, 150, 0, 100 )
end 

hook.Add( "OnEntityCreated", "gofixbelt", function( ply )

hook.Remove( "OnEntityCreated", "gofixbelt" )

hook.Add( "Think", "plyinvehic", function()
if LocalPlayer():InVehicle() then
seatcode()
hook.Remove( "Think", "plyinvehic" )
else return end
end )
end )

function seatcode()

-- Carchime timer
net.Receive( "carspeedchime", function()
timer.Create( "carchimeloop", 1, 0, carchime)
end )

-- Seatbelt function
function seatbelt()

local seatframe = vgui.Create( "DFrame" )
seatframe:SetSize( ScrW()/12, ScrW()/12 ) -- Also set image size
seatframe:AlignBottom( 300 )
seatframe:AlignLeft( 150 )
seatframe:SetDraggable( false )
seatframe:ShowCloseButton( false )
seatframe:SetTitle( "" )
seatframe.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
end

local anim = Derma_Anim( "EaseInQuad", seatframe, function( pnl, anim, delta, data )
    pnl:SetPos( inQuad( delta, ScrW()-ScrW()-ScrW()+ScrW()/1.09, ScrW()*0.13 ), ScrH()/1.7 )
end )
anim:Start( Seatbelt.strapin )
seatframe.Think = function( self )
    if anim:Active() then
        anim:Run()
    end
end

function hidebeltanim()

timer.Simple( 2, function()
seatframe:Close()
end )

local anim = Derma_Anim( "EaseInQuad", seatframe, function( pnl, anim, delta, data )
    pnl:SetPos( inQuad( delta, ScrW()-ScrW()-ScrW()+ScrW()/1.09+ScrW()*0.13, ScrW()-ScrW()-ScrW() ), ScrH()/1.7 )
end )
anim:Start( Seatbelt.unstrap )
seatframe.Think = function( self )
    if anim:Active() then
        anim:Run()
    end
end

end

local seatimage = vgui.Create( "DImage", seatframe )
seatimage:SetSize( ScrW()/12, ScrW()/12 )
seatimage:SetImage( Seatbelt.logo )

function belthide()
	if seatframe:IsVisible() then
	hidebeltanim()
	timer.Remove( "carchimestart" )
	timer.Remove( "carchimeloop" )
	hook.Remove( "Think", "plyinvehic2" )
	hook.Add( "Think", "plyinvehic", function()
	if LocalPlayer():InVehicle() then
	seatcode()
	hook.Remove( "Think", "plyinvehic" )
	else return end
	end )
	end
end

hook.Add( "Think", "plyinvehic2", function()
if LocalPlayer():InVehicle() then 
return else
belthide()
end
end )

net.Receive( "beltcmd", function()
	if seatframe:IsVisible() and LocalPlayer():InVehicle() then
	hidebeltanim()
	net.Start( "beltsound1" )
	net.SendToServer()
	timer.Remove( "carchimestart" )
	timer.Remove( "carchimeloop" )
	else if LocalPlayer():InVehicle() then seatbelt()
	net.Start( "beltsound2" )
	net.SendToServer()
	timer.Create( "carchimeloop", 1, 0, carchime)
	else return end
	end
end )

end

seatbelt()
end
