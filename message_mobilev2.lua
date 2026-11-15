local function fitHuybypassDialog(scale, desktopScale)
    if not game:GetService("UserInputService").TouchEnabled then
        scale.Scale = desktopScale
        return
    end
local panel = scale.Parent
    if not panel or not panel.Parent then return end
local scroll = panel.Parent
    if scroll.Name ~= "HuybypassDialogViewport" then
        scroll = Instance.new("ScrollingFrame")
        scroll.Name = "HuybypassDialogViewport"
        scroll.Size = UDim2.fromScale(1, 1)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.ScrollingDirection = Enum.ScrollingDirection.Y
        scroll.ScrollBarThickness = 4
        scroll.ScrollBarImageColor3 = Color3.fromRGB(113, 176, 214)
        scroll.Parent = panel.Parent
        panel.Parent = scroll
        panel.AnchorPoint = Vector2.zero
    end
local viewport = scroll.AbsoluteSize
    if viewport.X < 1 or viewport.Y < 1 then return end
local width, height = panel.Size.X.Offset, panel.Size.Y.Offset
    local factor = math.min(1, (viewport.X - 24) / width)
    scale.Scale = math.max(0.1, factor)
    local scaledHeight = height * scale.Scale
    scroll.CanvasSize = UDim2.fromOffset(0, math.max(viewport.Y, scaledHeight + 24))
    scroll.ScrollingEnabled = scaledHeight + 24 > viewport.Y
    panel.Position = UDim2.fromOffset(math.max(12, (viewport.X - width * scale.Scale) / 2),
        math.max(12, (viewport.Y - scaledHeight) / 2))
end
local ec={betaApproved={},customPrefixes={}}

function ec.namePrefix(p)
local prefix=ec.customPrefixes[p.UserId]
if type(prefix)=="string"and prefix~=""then return prefix.." "end
return ec.betaApproved[p.UserId]and "[👾Beta] "or ""
end

function ec.betaUsername(p)
return ec.namePrefix(p).."@"..p.Name
end
do
local player=game:GetService("Players").LocalPlayer
local runService=game:GetService("RunService")
local gui=Instance.new("ScreenGui")
gui.Name="HuybypassModeSelect" gui.ResetOnSpawn=false gui.IgnoreGuiInset=true gui.DisplayOrder=1001
local event=Instance.new("BindableEvent")
local connections={}
local finished=false local choice
local function create(kind,parent,props)
local object=Instance.new(kind)
for key,value in pairs(props)do object[key]=value end
if kind=="TextButton" and object.BackgroundTransparency<1 then
local edge=Instance.new("UIStroke")edge.ApplyStrokeMode=Enum.ApplyStrokeMode.Border edge.Color=Color3.fromRGB(134,185,227)edge.Transparency=0.68 edge.Parent=object
local sheen=Instance.new("UIGradient")sheen.Rotation=85 sheen.Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromRGB(193,205,225))sheen.Parent=object
end
object.Parent=parent return object
end
local function round(object,radius)create("UICorner",object,{CornerRadius=UDim.new(0,radius)})end
local backdrop=create("Frame",gui,{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.fromRGB(3,7,14),BackgroundTransparency=0.15,BorderSizePixel=0,Active=true})
local panel=create("Frame",backdrop,{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(460,400),BackgroundColor3=Color3.fromRGB(12,19,32),BorderSizePixel=0})round(panel,18)
create("UIStroke",panel,{Color=Color3.fromRGB(115,173,218),Transparency=0.4,Thickness=1})
local scale=create("UIScale",panel,{Scale=1})
local function label(text,y,height,size,color)
return create("TextLabel",panel,{Text=text,Position=UDim2.fromOffset(26,y),Size=UDim2.fromOffset(408,height),BackgroundTransparency=1,TextColor3=color,TextSize=size,Font=Enum.Font.GothamMedium,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left})
end
label("vibe coded slop",22,22,12,Color3.fromRGB(146,220,188))
label("Choose your HUYBYPASS",55,34,24,Color3.fromRGB(236,243,255)).Font=Enum.Font.GothamBold
local function finish(value)
if finished then return end
finished=true choice=value event:Fire()
end
local function button(text,y,color,value)
local object=create("TextButton",panel,{Text=text,Position=UDim2.fromOffset(26,y),Size=UDim2.fromOffset(408,66),BackgroundColor3=color,BorderSizePixel=0,TextColor3=Color3.fromRGB(245,249,255),TextSize=20,Font=Enum.Font.GothamBold,AutoButtonColor=true})
round(object,12)
connections[#connections+1]=object.Activated:Connect(function()finish(value)end)
end
button("HUYBYPASS",104,Color3.fromRGB(34,110,151),"normal")
label("Movement, Huybypass-Sense, suits, emotes and tricks.",178,36,14,Color3.fromRGB(168,190,215))
button("HUYBYPASS HVH",222,Color3.fromRGB(151,48,69),"hvh")
label("Everything above, plus combat, Sentry, Bring and Void Hide.",296,44,14,Color3.fromRGB(168,190,215))
label("Choose a mode each time you launch.",348,22,12,Color3.fromRGB(128,151,176))
local close=create("TextButton",panel,{Text="×",Position=UDim2.new(1,-44,0,10),Size=UDim2.fromOffset(34,34),BackgroundTransparency=1,TextSize=28,TextColor3=Color3.fromRGB(179,196,219)})
connections[#connections+1]=close.Activated:Connect(function()finish(nil)end)
connections[#connections+1]=gui.Destroying:Connect(function()finish(nil)end)
local function resize()
local camera=workspace.CurrentCamera
if camera then fitHuybypassDialog(scale,math.clamp(math.min((camera.ViewportSize.X-24)/460,(camera.ViewportSize.Y-24)/400),0.25,1))end
end
connections[#connections+1]=runService.RenderStepped:Connect(resize)
resize()gui.Parent=player:WaitForChild("PlayerGui")
if not finished then event.Event:Wait()end
for _,connection in ipairs(connections)do connection:Disconnect()end
gui:Destroy()event:Destroy()
if choice~="normal"and choice~="hvh"then return end
ec.mode=choice ec.hvh=choice=="hvh"
end
local bo=game:GetService("Players")local bw=game:GetService("UserInputService")local ae=game:GetService("RunService")local aA=game:GetService("TweenService")local dK=game:GetService("Debris")local dq=game:GetService("Lighting")local cV=game:GetService("ReplicatedStorage")local aa={PullKey=Enum.KeyCode.R,ClimbKey=Enum.KeyCode.LeftControl,GlideKey=Enum.KeyCode.Space,GoofyKey=Enum.KeyCode.B,TutorialKey=Enum.KeyCode.F1,SettingsKey=Enum.KeyCode.F2,EmoteWebEnabled=true,EmoteWebRange=45,EmoteWebShootTime=0.12,EmoteWebAirHeight=28,SenseNameRange=0,SenseScaleNear=40,SenseScaleFar=240,SenseMinScale=0.55,ExtraSounds=true,CueMasterVolume=0.7,CueMaxVoices=8,CueSoundIds={},SenseMaxContacts=16,SenseMaxArrows=6,SenseScanHz=10,SenseRadarRange=180,SenseLabelRange=140,SensePulseInterval=3,FilamentFX=true,NativeChatEnabled=true,NativeChatKey=Enum.KeyCode.J,VFXQuality=1.0,VFXAdaptive=true,VFXMaxParts=180,VFXCullDistance=200,RingSegments=24,CinematicHUD=true,TutorialEnabled=true,TutorialSeenAttribute="HuybypassTutorialDisplayed",ReducedMotion=false,MaxCameraFOV=103,CollisionRadius=1.15,MinimumTrickTime=0.32,WebKey=Enum.KeyCode.E,JumpKey=Enum.KeyCode.Q,DashKey=Enum.KeyCode.F,SuitKey=Enum.KeyCode.P,CrouchKey=Enum.KeyCode.H,TrickToggleKey=Enum.KeyCode.L,CustomTrickEmoteId=101850735665464,CustomTrickLooped=false,GoofyEmoteId=130036645941791,GlideEmoteId=84987692225451,GlideSpeed=130,GlideSink=8,GlideHoldDelay=0.35,EmoteSoundId="rbxassetid://5186668658",GoofySounds={{id="rbxasset://sounds/uuhhh.mp3",speed=1.65},{id="rbxassetid://5410086218",speed=1},{id="rbxassetid://88398743920756",speed=1},{id="rbxassetid://4702564143",speed=1},{id="rbxassetid://117474766162043",speed=1},},EmoteKey=Enum.KeyCode.M,EmoteId=125783279336153,EmoteLooped=true,DanceKey=Enum.KeyCode.N,DanceEmoteId=128103469933871,DanceLooped=true,LinearVelocityMaxForce=math.huge,MaxWebDistance=250,MinWebDistance=8,AllowAirWeb=true,AirWebDistance=90,WebShootTime=0.08,WebWidth=0.12,WebColor=Color3.fromRGB(255,255,255),WalkSpeed=28,JumpPower=75,ClimbEnabled=true,ClimbGrabDistance=4.5,ClimbReach=4,ClimbOffset=1.35,ClimbSpeed=26,ClimbRegrabDelay=0.35,ClimbJumpOut=55,ClimbJumpUp=45,ClimbMantleUp=32,ClimbMantleForward=16,ClimbBodyFollowsCamera=true,ClimbTurnSpeed=8,ClimbUpBias=0.5,ClimbSideWeight=0.5,ClimbAnimSpeed=2.6,ClimbTorsoTwist=1,CrawlEmoteUpright=true,CrawlEmoteTurn=0,CrawlEmoteLift=1.0,GroundCrawl=true,ClimbGroundOffset=1.6,ClimbGroundSpeed=24,ClimbOuterCornerTime=0.32,ClimbCornerDist=3.0,AutoHandSide=false,HandSideDeadzone=4,DefaultHandSide="left",SwingSteeringEnabled=true,SwingCameraSteering=true,SwingCameraTurnRate=75,SwingInputTurnRate=140,SwingBoost=75,SwingSoftCap=95,SwingMaxSpeed=125,SwingOverspeedDrag=120,SwingUpswingAssist=0.6,ReelSpeed=18,MinRopeLength=12,ReleaseBoost=1.3,ReleaseUpBoost=34,ReleaseUpFromSpeed=0.15,SlingshotBonus=0.2,ReleaseMinSpeed=60,ReleaseSlowLift=30,MomentumKeep=0.98,FirstSwingSpeed=45,FirstSwingForward=40,FirstSwingLift=25,SwingTiltAmount=0.6,MaxSwingTilt=75,SwingFaceVelocity=true,LaunchPull=45,LaunchLift=40,BigJumpForward=54,BigJumpUp=52.5,BigJumpArc=0.1,ChargeTime=2,MaxChargeMultiplier=10,BigJumpCooldown=1.5,DiveMinCharge=0.35,ChargePitchRise=0.25,ChargeShake=0.25,BaseFOV=70,FOVMaxSpeed=140,FOVSpeedBoost=28,FOVSwingBonus=6,FOVChargeZoom=12,FOVShootKick=8,FOVSmooth=6,CameraRoll=3.5,SpeedBlur=0.85,SpeedBlurStart=90,SpeedLines=true,SpeedLinesStart=80,SpeedLineCount=10,Trails=true,TrailMinSpeed=35,TrailLifetime=0.19,TrailColor=Color3.fromRGB(255,255,255),TrailTransparency=0.35,FlipTime=0.75,SwingReleaseDive=true,SwingDiveMinFall=0,SoftLandHeight=8,HardLandHeight=30,HardLandMinSpeed=50,SoftLandTime=0.3,HardLandTime=1.0,HardLandStun=0.45,ShakeStrength=1.2,ShakeTime=0.4,DashSpeed=130,DashTime=0.5,DashRolls=2,DashExitSpeed=0.55,DashCooldown=1.2,DashFOVKick=20,PullMaxDistance=300,PullMinDistance=12,PullSpeed=125,PullMaxTime=1.8,PullCooldown=0.5,PullShootTime=0.07,PullStopDistance=1.6,PullExitSpeed=0.55,PullExitLift=14,PullFOVKick=22,HuybypassSense=true,SenseKey=Enum.KeyCode.T,SenseRange=0,SenseColor=Color3.fromRGB(255,40,40),SenseScreenTint=0.82,SenseSoundId="",WebSoundId="rbxassetid://4919529864",ChargeSoundId="rbxassetid://140576516515813",ChargeSoundLoop=false,DashSoundId="rbxassetid://126862391298039",LandSoundId="rbxassetid://107674019694824",LaunchSoundId="rbxassetid://107186792435302",LaunchSoundVolume=1,WebSoundVolume=1,ChargeSoundVolume=1,DashSoundVolume=1,LandSoundVolume=1,IdleStance=false,IdleStanceDelay=3,IdleRepeat=false,WebCheckTime=4.5,WebCheckPalmTwist=0,IdleExtraFidgets=false,IdleFidgetTime=4,IdleFidgetPause=5,CrouchHand="right",CrouchHandAngle=66,AimAssistRadius=6,Afterimages=false,GhostColor=Color3.fromRGB(170,210,255),GhostFade=0.35,GhostInterval=0.12,SpeedRing=true,SpeedRingSpeed=130,SpeedHop=false,SpeedHopUp=14,SpeedHopForward=18,GroundCracks=true,WebStrands=true,WebSplat=true,WebRetract=true,ReplicatePoses=false,ReplicateRate=15,ReplicateRemoteName="HuybypassPoseEvent",Toasts=true,Debug=false,SwingAnimationId="",SwingEmoteId=112715269711746,SwingEmoteLooped=true,FallEmoteId=103375257049580,FallEmoteLooped=true,ChargeEmoteId=136529674847495,ChargeEmoteLooped=true,LaunchEmoteId=103375257049580,LaunchEmoteLooped=true,LandEmoteId=116259237042171,LandEmoteLooped=false,CrawlEmoteId=76348568458914,CrawlEmoteLooped=true,DashEmoteId=134624712364333,DashEmoteLooped=false,TrickFrontflipEmoteId=113366984029463,TrickBackflipEmoteId=95132818337498,TrickSideflipEmoteId=75860050404805,TrickSpinEmoteId=109850286119063,}
local root
local U={d=true,a=false,k=true,M=true,e=0,bg={},bt=0,aS={},w={},aQ=0,C=1,co=1/60,anchorCache={},bH=nil,br=CFrame.new(),bD=nil,T=nil,bs=0,}

function U.b(dv,callback)local c=dv:Connect(callback)U.bg[c]=true
U.bt+=1
if U.bt>64 then
U.bt=0
for old in pairs(U.bg)do
if old.Connected then U.bt+=1 else U.bg[old]=nil end
end
end
return c
end

function U.z()U.bC=(U.bC or 0)+1
return U.bC
end

function U.bX(bT,generation,ownerRoot,ownerHum)return U.f()and U.d and U.a and U.k and not bw:GetFocusedTextBox()and U.bC==bT and U.e==generation
and root==ownerRoot and ownerRoot~=nil and ownerRoot.Parent~=nil
and not ownerRoot.Anchored and ownerHum~=nil and ownerHum.Parent~=nil
and ownerHum.Health>0 and not ownerHum.Sit
end
local player=bo.LocalPlayer
do
local bi=player:FindFirstChild("HuybypassControllerLifecycle")if bi then
if not bi:IsA("BindableFunction")then return end
local ok,stopped=pcall(function()return bi:Invoke()end)if not ok or not stopped then return end
end
U.at=Instance.new("BindableFunction")U.at.Name="HuybypassControllerLifecycle"U.at.OnInvoke=function()if not U.bw then return false end
U.bw()return true
end
U.at.Parent=player
end
local aq=Instance.new("Folder")aq.Name="LocalWebs"aq.Parent=workspace
local bs=Instance.new("ScreenGui")bs.Name="HuybypassCharge"bs.ResetOnSpawn=false
bs.IgnoreGuiInset=true
bs.Parent=player:WaitForChild("PlayerGui")local al=Instance.new("Frame")al.Size=UDim2.fromOffset(260,14)al.AnchorPoint=Vector2.new(0.5,1)al.Position=UDim2.new(0.5,0,1,-70)al.BackgroundColor3=Color3.fromRGB(15,15,15)al.BackgroundTransparency=0.3
al.BorderSizePixel=0
al.Visible=false
al.Parent=bs
Instance.new("UICorner",al).CornerRadius=UDim.new(0,7)local aL=Instance.new("Frame")aL.Size=UDim2.fromScale(0,1)aL.BackgroundColor3=Color3.fromRGB(220,30,30)aL.BorderSizePixel=0
aL.Parent=al
Instance.new("UICorner",aL).CornerRadius=UDim.new(0,7)U.E=Instance.new("TextLabel")U.E.BackgroundTransparency=1
U.E.Position=UDim2.new(0,0,0,-24)U.E.Size=UDim2.new(1,0,0,20)U.E.Font=Enum.Font.GothamBold
U.E.TextSize=12
U.E.TextColor3=Color3.fromRGB(245,225,210)U.E.Text=""U.E.Parent=al
local bN=Instance.new("ScreenGui")bN.Name="HuybypassToast"bN.ResetOnSpawn=false
bN.IgnoreGuiInset=true
bN.Parent=player:WaitForChild("PlayerGui")local ao=Instance.new("TextLabel")ao.AnchorPoint=Vector2.new(0.5,1)ao.Position=UDim2.new(0.5,0,1,-110)ao.Size=UDim2.fromOffset(300,30)ao.BackgroundColor3=Color3.fromRGB(15,15,15)ao.BackgroundTransparency=1
ao.BorderSizePixel=0
ao.Font=Enum.Font.GothamMedium
ao.TextSize=16
ao.TextColor3=Color3.new(1,1,1)ao.TextTransparency=1
ao.Text=""ao.Parent=bN
Instance.new("UICorner",ao).CornerRadius=UDim.new(0,8)local cE=0
function U.h(text)if not aa.Toasts then return end
cE+=1
local my=cE
ao.Text=text
ao.BackgroundTransparency=0.35
ao.TextTransparency=0
task.delay(1.4,function()if my~=cE or not U.d or not ao.Parent then return end
aA:Create(ao,TweenInfo.new(0.4),{BackgroundTransparency=1,TextTransparency=1}):Play()end)end
local ba=Instance.new("BlurEffect")ba.Name="HuybypassSpeedBlur"ba.Size=0
ba.Parent=dq
local bd={lines={},edges={}}U.aa={bs,bN}do
local old=player.PlayerGui:FindFirstChild("HuybypassKeybinds")if old then old:Destroy()end
end

function U.ui(kind,parent,props)local object=Instance.new(kind)for key,value in pairs(props or{})do object[key]=value end
if kind=="TextButton" and object.BackgroundTransparency<1 then
local edge=Instance.new("UIStroke")edge.ApplyStrokeMode=Enum.ApplyStrokeMode.Border edge.Color=Color3.fromRGB(134,185,227)edge.Transparency=0.68 edge.Parent=object
local sheen=Instance.new("UIGradient")sheen.Rotation=85 sheen.Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromRGB(193,205,225))sheen.Parent=object
end
object.Parent=parent
return object
end

function U.g(object,radius)return U.ui("UICorner",object,{CornerRadius=UDim.new(0,radius)})end

function U.i(parent,text,size,pos,area)return U.ui("TextLabel",parent,{BackgroundTransparency=1,BorderSizePixel=0,Text=text,Font=Enum.Font.GothamMedium,TextColor3=Color3.fromRGB(224,234,247),TextSize=size,TextXAlignment=Enum.TextXAlignment.Left,Position=pos,Size=area,})end

function U.bj(parent,color,inset,length)local hh={}for _,p in ipairs({Vector2.new(0,0),Vector2.new(1,0),Vector2.new(0,1),Vector2.new(1,1)})do
for axis=1,2 do
local gQ=U.ui("Frame",parent,{AnchorPoint=p,Position=UDim2.new(p.X,(p.X==0 and 1 or-1)*inset,p.Y,(p.Y==0 and 1 or-1)*inset),Size=UDim2.fromOffset(axis==1 and length or 2,axis==1 and 2 or length),BorderSizePixel=0,BackgroundColor3=color,BackgroundTransparency=0.32,})U.g(gQ,1)table.insert(hh,gQ)end
end
return hh
end
do
al.Size=UDim2.fromOffset(280,10)al.BackgroundColor3=Color3.fromRGB(10,17,29)al.BackgroundTransparency=0.12
U.ui("UIStroke",al,{Color=Color3.fromRGB(110,151,187),Thickness=1,Transparency=0.55})U.ui("UIGradient",aL,{Color=ColorSequence.new(Color3.fromRGB(255,142,104),Color3.new(1,1,1))})U.bj(al,Color3.fromRGB(167,220,255),-5,10)for i=1,9 do
U.ui("Frame",al,{Position=UDim2.fromScale(i/10,0),Size=UDim2.new(0,1,1,0),BackgroundColor3=Color3.fromRGB(8,14,25),BackgroundTransparency=0.45,BorderSizePixel=0,ZIndex=2})end
end
if aa.SpeedLines then
local bF=Instance.new("ScreenGui")bF.Name="HuybypassSpeedLines"table.insert(U.aa,bF)bF.ResetOnSpawn=false
bF.IgnoreGuiInset=true
bF.DisplayOrder=-5
bF.Parent=player:WaitForChild("PlayerGui")for i=1,aa.SpeedLineCount*2 do
local f=Instance.new("Frame")f.AnchorPoint=Vector2.new(0.5,0.5)f.BackgroundColor3=(math.random()<0.35)and Color3.fromRGB(190,225,255)or Color3.new(1,1,1)f.BorderSizePixel=0
f.BackgroundTransparency=1
f.Visible=false
f.Parent=bF
local g=Instance.new("UIGradient")g.Rotation=90
g.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.5,0),NumberSequenceKeypoint.new(1,1),})g.Parent=f
bd.lines[i]={frame=f,p=math.random(),a=math.random()*math.pi*2,s=0.7+math.random()*0.6}end
local fO={{Vector2.new(0,0),UDim2.new(0,0,0,0),UDim2.new(1,0,0.22,0),90},{Vector2.new(0,1),UDim2.new(0,0,1,0),UDim2.new(1,0,0.22,0),270},{Vector2.new(0,0),UDim2.new(0,0,0,0),UDim2.new(0.14,0,1,0),0},{Vector2.new(1,0),UDim2.new(1,0,0,0),UDim2.new(0.14,0,1,0),180},}for _,d in ipairs(fO)do
local e=Instance.new("Frame")e.AnchorPoint=d[1]e.Position=d[2]e.Size=d[3]e.BackgroundColor3=Color3.fromRGB(215,235,255)e.BorderSizePixel=0
e.BackgroundTransparency=1
e.Visible=false
e.Parent=bF
local g=Instance.new("UIGradient")g.Rotation=d[4]g.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1),})g.Parent=e
table.insert(bd.edges,e)end
end

function U.cG(dt,speed)local ag=workspace.CurrentCamera
if#bd.lines==0 or not ag then return end
local aS=aa.ReducedMotion and 0 or math.clamp((speed-aa.SpeedLinesStart)/100,0,1)local be=aS*aS
local bl=Vector2.new(0.5,0.48)if root and speed>1 then
local db=ag:WorldToViewportPoint(ag.CFrame.Position+root.AssemblyLinearVelocity.Unit*80)if db.Z>0 then
bl=Vector2.new(math.clamp(db.X/math.max(1,ag.ViewportSize.X),0.3,0.7),math.clamp(db.Y/math.max(1,ag.ViewportSize.Y),0.3,0.65))end
end
for _,e in ipairs(bd.edges)do
e.Visible=be>0.01
e.BackgroundTransparency=1-0.12*be
end
local cJ=ag.ViewportSize
for i,l in ipairs(bd.lines)do
local f=l.frame
f.Visible=be>0.01 and i<=math.floor(#bd.lines*U.C)if f.Visible then
l.p=(l.p+dt*(0.8+be*2.4)*l.s)%1
local radius=0.28+0.48*l.p
local dx,dy=math.cos(l.a)*radius*cJ.X,math.sin(l.a)*radius*cJ.Y
f.Position=UDim2.fromOffset(bl.X*cJ.X+dx,bl.Y*cJ.Y+dy)f.Rotation=math.deg(math.atan2(dy,dx))+90
f.Size=UDim2.fromOffset(1.1+be,16+115*be*l.p)f.BackgroundTransparency=1-0.55*be*math.sin(math.pi*l.p)end
end
end
local senseOn,an,sensePing=false,0,0
local senseSound
local bv={}
local ap,aH
U.c={contacts={},nextScan=0,nextPulse=0,damage=0,lastHealth=nil}

function U.I(parent,text,size,color)local label=Instance.new("TextLabel")label.BackgroundTransparency=1
label.Font=Enum.Font.GothamMedium
label.TextSize=size
label.Text=text
label.Active=false
label.RichText=false
label.TextColor3=color or Color3.new(1,1,1)label.Parent=parent
return label
end

function U.dT()ap=Instance.new("ScreenGui")ap.Name="HuybypassSense"ap.ResetOnSpawn=false
ap.IgnoreGuiInset=true
ap.DisplayOrder=3
ap.Enabled=false
ap.Parent=player:WaitForChild("PlayerGui")table.insert(U.aa,ap)aH=Instance.new("Frame")aH.Size=UDim2.fromScale(1,1)aH.BackgroundColor3=aa.SenseColor
aH.BackgroundTransparency=1
aH.BorderSizePixel=0
aH.Parent=ap
U.c.edges={}for _,side in ipairs({"top","bottom","left","right"})do
local bP=Instance.new("Frame")bP.BorderSizePixel=0
bP.BackgroundColor3=aa.SenseColor
bP.BackgroundTransparency=1
bP.Size=(side=="top"or side=="bottom")and UDim2.new(1,0,0,36)or UDim2.new(0,36,1,0)bP.AnchorPoint=Vector2.new(side=="right"and 1 or 0,side=="bottom"and 1 or 0)bP.Position=UDim2.fromScale(bP.AnchorPoint.X,bP.AnchorPoint.Y)bP.Parent=ap
local gL=Instance.new("UIGradient")gL.Rotation=({top=90,bottom=270,left=0,right=180})[side]gL.Transparency=NumberSequence.new(0,1)gL.Parent=bP
table.insert(U.c.edges,bP)end
local radar=Instance.new("Frame")radar.Name="ContactRadar"radar.AnchorPoint=Vector2.new(1,1)radar.Position=UDim2.new(1,-20,1,-28)radar.Size=UDim2.fromOffset(156,156)radar.BackgroundColor3=Color3.fromRGB(9,14,23)radar.BackgroundTransparency=0.25
radar.BorderSizePixel=0
radar.Parent=ap
Instance.new("UICorner",radar).CornerRadius=UDim.new(1,0)local eo=Instance.new("UIStroke")eo.Thickness=1.2
eo.Transparency=0.3
eo.Color=aa.SenseColor
eo.Parent=radar
U.c.radar=radar
for _,scale in ipairs({0.45,0.75})do
local ring=Instance.new("Frame")ring.AnchorPoint=Vector2.new(0.5,0.5)ring.Position=UDim2.fromScale(0.5,0.5)ring.Size=UDim2.fromScale(scale,scale)ring.BackgroundTransparency=1
ring.Parent=radar
Instance.new("UICorner",ring).CornerRadius=UDim.new(1,0)local eO=Instance.new("UIStroke")eO.Color=Color3.fromRGB(130,165,190)eO.Transparency=0.78
eO.Parent=ring
end
local bl=U.I(radar,"▲",14)bl.AnchorPoint=Vector2.new(0.5,0.5)bl.Position=UDim2.fromScale(0.5,0.5)bl.Size=UDim2.fromOffset(18,18)local eq=U.I(radar,"SENSE",11,Color3.fromRGB(255,190,180))eq.Position=UDim2.new(0,0,0,-22)eq.Size=UDim2.new(1,0,0,20)U.c.status=eq
local gy=U.I(radar,tostring(aa.SenseRadarRange).." STUD RADAR",9,Color3.fromRGB(180,200,215))gy.Position=UDim2.new(0,0,1,3)gy.Size=UDim2.new(1,0,0,14)end
if aa.HuybypassSense then U.dT()end

function U.aO(p)local e=bv[p]if not e then return end
for _,gS in pairs({e.hl,e.bb,e.dot,e.arrow,e.arrowName})do gS:Destroy()end
bv[p]=nil
end

function U.aL()for p in pairs(bv)do U.aO(p)end
table.clear(U.c.contacts)end
U.b(bo.PlayerRemoving,U.aO)function U.cK(distance)local gX=math.max(0,aa.SenseScaleNear)local hT=math.max(gX+1,aa.SenseScaleFar)local fN=math.clamp(aa.SenseMinScale,0.35,1)local t=math.clamp((math.max(0,distance)-gX)/(hT-gX),0,1)local eT=t*t*(3-2*t)return 1-(1-fN)*eT
end

function U.dr(current,target,dt)if not current then return target end
return current+(target-current)*(1-math.exp(-math.max(0,dt)*10))end

function U.dB(health,maximum)local function valid(n)return type(n)=="number"and n==n and n>=0
end
if not valid(health)or not valid(maximum)then return"—/—",0 end
if maximum==math.huge then
local text=health==math.huge and"∞"or string.format("%.0f",math.floor(health+0.5))return text.."/∞",health==math.huge and 1 or 0
end
if maximum<=0 then return"0/0",0 end
local value=math.min(health,maximum)local gq=value>0 and math.max(1,math.floor(value+0.5))or 0
return string.format("%.0f/%.0f",gq,math.max(1,math.floor(maximum+0.5))),math.clamp(value/maximum,0,1)end

function U.cN(distance,health,maximum)local hp,ratio=U.dB(health,maximum)local hx=math.max(0,math.floor(distance+0.5))return string.format("%.0f studs • HP %s",hx,hp),ratio
end

function U.cI(p,char)local head=char:FindFirstChild("Head")or char:FindFirstChild("HumanoidRootPart")if not head then return nil end
local hl=Instance.new("Highlight")hl.Name="HuybypassSenseContact"hl.Adornee=char
hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
hl.FillTransparency,hl.OutlineTransparency=1,1
hl.Parent=aq
local bb=Instance.new("BillboardGui")bb.Name="HuybypassSenseTag"bb.Adornee=head
bb.AlwaysOnTop=true
bb.Enabled=false
bb.Size=UDim2.fromOffset(280,96)bb.MaxDistance=math.huge
bb.StudsOffset=Vector3.new(0,3,0)bb.LightInfluence=0
bb.Parent=ap
local card=Instance.new("Frame")card.Name="ScaledContactCard"card.BackgroundTransparency=1
card.AnchorPoint=Vector2.new(0.5,1)card.Position=UDim2.fromScale(0.5,1)card.Size=UDim2.fromOffset(280,96)card.Parent=bb
local scale=Instance.new("UIScale")scale.Name="DistanceScale"scale.Scale=0.55
scale.Parent=card
local backing=Instance.new("Frame")backing.BackgroundColor3=Color3.fromRGB(7,12,22)backing.ZIndex=1
backing.BackgroundTransparency=0.32
backing.BorderSizePixel=0
backing.Size=UDim2.fromScale(1,1)backing.Parent=card
Instance.new("UICorner",backing).CornerRadius=UDim.new(0,6)local dC=U.I(card,p.DisplayName,18)dC.Font=Enum.Font.GothamBold
dC.ZIndex=2
dC.Size=UDim2.new(1,-12,0,24)dC.Position=UDim2.fromOffset(6,3)dC.TextStrokeTransparency=0.18
local dW=U.I(card,ec.betaUsername(p),13,Color3.fromRGB(185,218,245))dW.ZIndex=2
dW.Position=UDim2.fromOffset(6,27)dW.Size=UDim2.new(1,-12,0,19)dW.TextStrokeTransparency=0.3
local eL=U.I(card,"",14,Color3.fromRGB(210,235,255))eL.ZIndex=2
eL.Position=UDim2.fromOffset(0,48)eL.Size=UDim2.new(1,0,0,20)eL.TextStrokeTransparency=0.3
local status=U.I(card,"",10,Color3.fromRGB(170,200,225))status.Name="ContactStatus"status.ZIndex=2
status.Position=UDim2.fromOffset(0,69)status.Size=UDim2.new(1,0,0,16)for _,label in ipairs({dC,dW,eL,status})do
label.TextTruncate=Enum.TextTruncate.AtEnd
end
local healthBack=Instance.new("Frame")healthBack.ZIndex=2
healthBack.BorderSizePixel=0
healthBack.BackgroundColor3=Color3.fromRGB(30,35,45)healthBack.Position=UDim2.new(0.25,0,1,-7)healthBack.Size=UDim2.new(0.5,0,0,3)healthBack.Parent=card
local health=Instance.new("Frame")health.ZIndex=3
health.BorderSizePixel=0
health.Size=UDim2.fromScale(1,1)health.Parent=healthBack
local dot=Instance.new("Frame")dot.Size=UDim2.fromOffset(6,6)dot.AnchorPoint=Vector2.new(0.5,0.5)dot.BorderSizePixel=0
dot.Parent=U.c.radar
Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)local arrow=U.I(ap,"▲",20)arrow.AnchorPoint=Vector2.new(0.5,0.5)arrow.Size=UDim2.fromOffset(28,28)arrow.Visible=false
local arrowName=U.I(ap,"",11)arrowName.AnchorPoint=Vector2.new(0.5,0.5)arrowName.Size=UDim2.fromOffset(160,32)arrowName.TextWrapped=true
arrowName.TextStrokeTransparency=0.2
arrowName.Visible=false
return{char=char,head=head,hl=hl,bb=bb,name=dC,user=dW,backing=backing,card=card,scale=scale,status=status,tagScale=nil,player=p,dist=eL,health=health,healthBack=healthBack,dot=dot,arrow=arrow,arrowName=arrowName}end

function U.dD()U.aL()U.c.nextScan,U.c.nextPulse,U.c.damage=0,0,0
U.c.lastHealth=nil
if ap then ap.Enabled=false end
end

function U.cM()if not ap then return end
senseOn=not senseOn
sensePing=1
U.c.nextScan,U.c.nextPulse=0,0
if senseSound then senseSound:Play()elseif U.p then U.p(senseOn and"senseOn"or"senseOff")end
end

function U.db(now)U.c.nextScan=now+1/aa.SenseScanHz
if not root or not root.Parent then U.aL()return end
local bB={}for _,p in ipairs(bo:GetPlayers())do
if p~=player and p.Character then
local char=p.Character
local hb,hum=char:FindFirstChild("HumanoidRootPart"),char:FindFirstChildOfClass("Humanoid")if hb and hum and hum.Health>0 then
local distance=(hb.Position-root.Position).Magnitude
if aa.SenseRange<=0 or distance<=aa.SenseRange then
table.insert(bB,{player=p,char=char,root=hb,hum=hum,distance=distance})end
end
end
end
table.sort(bB,function(a,b)if a.distance==b.distance then return a.player.UserId<b.player.UserId end
return a.distance<b.distance
end)local hn={}table.clear(U.c.contacts)local params=U.ab()for i=1,math.min(aa.SenseMaxContacts,#bB)do
local c=bB[i]local p=c.player
local e=bv[p]if e and(e.char~=c.char or not e.head.Parent)then U.aO(p)e=nil end
if not e then e=U.cI(p,c.char)bv[p]=e end
if e then
hn[p]=true
local aE=c.root.Position-root.Position
local af=U.O(aE,Vector3.zero)local closing=-(c.root.AssemblyLinearVelocity-root.AssemblyLinearVelocity):Dot(af)local eB=player.Team~=nil and p.Team==player.Team and not p.Neutral and not player.Neutral
local de=c.distance<60 and closing>18
local blocked=aE.Magnitude>0.1 and workspace:Raycast(root.Position,aE,params)e.color=eB and Color3.fromRGB(105,230,195)or de and Color3.fromRGB(255,183,85)or Color3.fromRGB(170,215,255)e.distance,e.targetRoot=c.distance,c.root
e.targetHum=c.hum
e.dist.Text,e.hp=U.cN(c.distance,c.hum.Health,c.hum.MaxHealth)e.status.Text=string.format("%s • %s",eB and"TEAM"or de and"APPROACHING"or"NEARBY",blocked and"OCCLUDED"or"CLEAR")e.closing=closing
table.insert(U.c.contacts,e)end
end
for p in pairs(bv)do if not hn[p]then U.aO(p)end end
U.c.total=#bB
end

function U.de(localPosition)local xy=Vector2.new(localPosition.X,-localPosition.Y)if localPosition.Z>0 then
xy=Vector2.new(localPosition.X,math.max(math.abs(localPosition.Y),0.65))end
return xy.Magnitude>0.01 and xy.Unit or Vector2.new(0,1)end

function U.cO(dt)if not ap then return end
local now=os.clock()local char=player.Character
local hum=U.a and char and char:FindFirstChildOfClass("Humanoid")if hum then
if U.c.lastHealth and hum.Health<U.c.lastHealth then
U.c.damage=math.clamp((U.c.lastHealth-hum.Health)/math.max(1,hum.MaxHealth)*4,0.15,1)if U.aZ and senseOn then U.aZ(true)end
end
U.c.lastHealth=hum.Health
end
U.c.damage*=math.exp(-dt*4)an+=((senseOn and U.a and 1 or 0)-an)*(1-math.exp(-dt*9))sensePing=math.max(0,sensePing-dt*1.5)if an<0.01 and not senseOn then
if ap.Enabled then U.aL()ap.Enabled=false end
return
end
if not U.a or not root then ap.Enabled=false return end
ap.Enabled=true
if now>=U.c.nextScan then U.db(now)end
if senseOn and now>=U.c.nextPulse then
U.c.nextPulse=now+aa.SensePulseInterval
if U.aZ then U.aZ(false)end
end
local pulse=aa.ReducedMotion and 0 or math.max(sensePing,math.exp(-(now%1.8)*6)*0.22)aH.BackgroundTransparency=1-math.clamp(an*(0.018+U.c.damage*0.06),0,0.1)for _,bP in ipairs(U.c.edges)do
bP.BackgroundTransparency=1-math.clamp(an*(0.1+pulse*0.22+U.c.damage*0.35),0,0.6)end
U.c.radar.Visible=senseOn
U.c.status.Text=string.format("SENSE  %d/%d",#U.c.contacts,U.c.total or 0)local cb=workspace.CurrentCamera
if not cb then return end
local width,height=math.max(cb.ViewportSize.X,1),math.max(cb.ViewportSize.Y,1)U.c.radar.Size=UDim2.fromOffset(math.min(156,width*0.28),math.min(156,width*0.28))local ds=0
for _,e in ipairs(U.c.contacts)do
if e.targetRoot and e.targetRoot.Parent and e.head.Parent
and e.targetHum and e.targetHum.Parent and e.targetHum.Health>0 then
e.distance=(e.targetRoot.Position-root.Position).Magnitude
local dL=(e.head.Position-cb.CFrame.Position).Magnitude
e.tagScale=U.dr(e.tagScale,U.cK(dL),dt)e.scale.Scale=e.tagScale
e.hl.FillColor,e.hl.OutlineColor=e.color,e.color
e.hl.FillTransparency=1-an*(0.12+pulse*0.12)e.hl.OutlineTransparency=1-an*0.85
e.name.TextTransparency,e.dist.TextTransparency=1-an,1-an
e.user.TextTransparency=1-an
e.status.TextTransparency=1-an
e.name.Text=e.player.DisplayName
e.user.Text=ec.betaUsername(e.player)
e.backing.BackgroundTransparency=1-an*0.68
e.bb.Enabled=an>0.05
and(aa.SenseNameRange<=0 or e.distance<=aa.SenseNameRange)e.dist.Visible=true
e.healthBack.Visible=true
e.status.Visible=e.distance<=aa.SenseLabelRange
e.health.Size=UDim2.fromScale(e.hp,1)e.health.BackgroundColor3=Color3.fromRGB(255,100,100):Lerp(Color3.fromRGB(105,230,195),e.hp)local offset=e.targetRoot.Position-root.Position
local aY=cb.CFrame.LookVector
aY=U.O(Vector3.new(aY.X,0,aY.Z),-Vector3.zAxis)local right=aY:Cross(Vector3.yAxis)local bj=Vector2.new(offset:Dot(right),-offset:Dot(aY))/aa.SenseRadarRange
if bj.Magnitude>1 then bj=bj.Unit end
e.dot.Visible=true
e.dot.Position=UDim2.fromScale(0.5+bj.X*0.43,0.5+bj.Y*0.43)e.dot.BackgroundColor3=e.color
e.dot.BackgroundTransparency=1-an
local gC,onScreen=cb:WorldToViewportPoint(e.targetRoot.Position)local fs=not onScreen or gC.Z<=0
e.arrow.Visible=senseOn and fs and ds<aa.SenseMaxArrows
if e.arrow.Visible then ds+=1 end
e.arrowName.Visible=e.arrow.Visible
if e.arrow.Visible then
local af=U.de(cb.CFrame:PointToObjectSpace(e.targetRoot.Position))local fF=Vector2.new(math.max(20,width*0.5-44),math.max(20,height*0.5-65))local radius=1/math.max(math.abs(af.X)/fF.X,math.abs(af.Y)/fF.Y)e.arrow.Position=UDim2.fromOffset(width*0.5+af.X*radius,height*0.5+af.Y*radius)e.arrow.Rotation=math.deg(math.atan2(af.Y,af.X))+90
e.arrow.TextColor3=e.color
e.arrow.TextTransparency=1-an*0.85
local x=width*0.5+af.X*(radius-45)local y=height*0.5+af.Y*(radius-45)e.arrowName.Position=UDim2.fromOffset(math.clamp(x,math.min(85,width*0.5),math.max(width-85,width*0.5)),math.clamp(y,22,math.max(22,height-22)))e.arrowName.Text=string.format("@%s\n%d studs",e.player.Name,math.floor(e.distance))e.arrowName.TextColor3=e.color
e.arrowName.TextTransparency=1-an
end
else
e.bb.Enabled=false
e.arrow.Visible,e.arrowName.Visible,e.dot.Visible=false,false,false
e.hl.FillTransparency,e.hl.OutlineTransparency=1,1
end
end
end
local ad,humanoid,animator
local ar,aQ
local aj,leftHandAtt
local hand,webHandAtt
local bu="right"local lastSide="left"local ah=false
local ak=Vector3.new(0,0,1)local co
local bp=0
local aZ=0
local az=0
local climbHeading=Vector3.new(0,1,0)local dF=0
local aT,bJ,am,cn,bx,bG,animTrack
local chargeSparks
local as,aK,bz,pullBeams,dD,pullDirY=false,0,nil,{},0,0
local bm={}
local cC={}
local cd
local ai=false
local bX=0
local cy=Vector3.zero
local anchor,cz,bH,fk,bh
local go,hy,webS2,webBeams=nil,nil,nil,{}
local eK=0
local lastBigJump=0
local ac=nil
local chargeFull=false
local bM=0
local di=false
local idlePlayed=false
local crouchPose=false
local ab={track=nil,fallback=nil,animId=nil}
local dance={track=nil,busy=false,customTrick=false}
local fidget,dg,dV,nextFidget,lastFidget=nil,0,0,0,0
local cq={"fidget_webcheck"}if aa.IdleExtraFidgets then
table.insert(cq,"fidget_scratch")table.insert(cq,"fidget_stretch")table.insert(cq,"fidget_look")end
local dz={}
local mutedTracks,fidgetMuted={},false
local diving=false
local aG,cu,releaseSign="frontflip","",1
local lastGhost,lastRing,lastSpeed=0,0,0
local aI,releaseEnd=0,0
local dd,ev,lastVelY=false,0,0
local landUntil,landKind=0,"soft"local cm=false
local shakeEnd,shaking=0,false
local cw="idle"local ay=CFrame.new()local trailsOn=false
local aD={objs={}}

function aD.destroy(key)local o=aD.objs[key]if o then
aD.objs[key]=nil
if o.lv then o.lv:Destroy()end
if o.att then o.att:Destroy()end
if o.core then o.core:Destroy()end
end
end

function aD.destroyAll()for key in pairs(aD.objs)do
aD.destroy(key)end
end

function aD.safeVelocity(v,limit)local bO=v.Magnitude
if bO~=bO or bO==math.huge then return Vector3.zero end
if bO>limit then return v*(limit/bO)end
return v
end

function aD.drive(key,velocity)
if not U.f() or not root or not root.Parent then return nil end
local limit=key=="zipattack" and aa.ZipAttackSpeed
or key=="swing" and aa.SwingMaxSpeed
or key=="pull" and aa.PullSpeed
or key=="dash" and aa.DashSpeed or 160
velocity=aD.safeVelocity(velocity,limit)
for other in pairs(aD.objs) do
if other~=key then aD.destroy(other) end
end
local o=aD.objs[key]
if o and (o.owner~=root or not o.core.Parent or not o.lv.Parent or not o.weld.Parent) then
aD.destroy(key) o=nil
end
if not o then
local core=Instance.new("Part")
core.Name="HuybypassDriveCore_"..key
core.Size=Vector3.new(0.05,0.05,0.05)
core.Transparency=1
core.Anchored=false
core.CanCollide=false
core.CanTouch=false
core.CanQuery=false
core.Massless=true
core.CFrame=root.CFrame
local weld=Instance.new("WeldConstraint")
weld.Part0=root
weld.Part1=core
weld.Parent=core
local lv=Instance.new("BodyVelocity")
lv.Name="HuybypassBodyVelocity_"..key
lv.P=key=="zipattack" and 6000 or 1250
lv.Velocity=velocity
local force=math.min(aa.LinearVelocityMaxForce,root.AssemblyMass*(workspace.Gravity+(key=="zipattack" and 3000 or 1500)))
lv.MaxForce=Vector3.new(force,force,force)
lv.Parent=core
core.Parent=aq
o={lv=lv,core=core,weld=weld,owner=root}
aD.objs[key]=o
end
local force=math.min(aa.LinearVelocityMaxForce,root.AssemblyMass*(workspace.Gravity+(key=="zipattack" and 3000 or 1500)))
o.lv.MaxForce=Vector3.new(force,force,force)
o.lv.Velocity=velocity
return o.lv
end
aD.collide={}

function aD.noCollide()if not ad then return end
for _,p in ipairs(ad:GetChildren())do
if p:IsA("BasePart")and p.CanCollide then
aD.collide[p]=true
p.CanCollide=false
end
end
end

function aD.restoreCollide()for p in pairs(aD.collide)do
if p.Parent then p.CanCollide=true end
end
aD.collide={}end
local bf,au,lastDash=0,0,0
local ee=Vector3.new(0,0,-1)local aV,dashRoll=0,0
function U.A()bf=0
au=0
aD.destroy("dash")if humanoid and not U.m and not ai and not ah and not as then humanoid.AutoRotate=true end
end
local cv=0
local cK=0
local blurNow=0
local aB={"RightShoulder","LeftShoulder","RightElbow","LeftElbow","RightHip","LeftHip","RightKnee","LeftKnee","Root","Waist","Neck","RightWrist",}local cg={idle={},fidget_webcheck={LeftShoulder={-10,0,-12},LeftElbow={25,0,0},Waist={-4,0,0},},fidget_scratch={LeftShoulder={-4,0,-8},LeftElbow={8,0,0},},fidget_stretch={RightShoulder={172,0,12},LeftShoulder={172,0,-12},RightElbow={0,0,0},LeftElbow={0,0,0},},fidget_look={RightShoulder={-15,0,30},LeftShoulder={-15,0,-30},RightElbow={95,0,0},LeftElbow={95,0,0},},swing={RightShoulder={120,0,6},LeftShoulder={116,0,-6},RightElbow={8,0,0},LeftElbow={14,0,0},RightHip={35,0,0},LeftHip={-25,0,0},RightKnee={-20,0,0},LeftKnee={-45,0,0},Root={-8,0,0},},jump={RightShoulder={150,0,15},LeftShoulder={-30,0,-35},RightElbow={10,0,0},LeftElbow={30,0,0},RightHip={60,0,0},RightKnee={-80,0,0},LeftHip={-20,0,0},LeftKnee={-30,0,0},Root={-10,0,0},},fall={RightShoulder={40,0,70},LeftShoulder={40,0,-70},RightElbow={15,0,0},LeftElbow={15,0,0},RightHip={10,0,12},LeftHip={-10,0,-12},RightKnee={-25,0,0},LeftKnee={-25,0,0},Root={-8,0,0},},release={RightShoulder={100,0,20},LeftShoulder={100,0,-20},RightElbow={60,0,0},LeftElbow={60,0,0},RightHip={85,0,0},LeftHip={85,0,0},RightKnee={-110,0,0},LeftKnee={-110,0,0},Waist={-25,0,0},},dive={RightShoulder={170,0,5},LeftShoulder={170,0,-5},RightHip={-20,0,5},LeftHip={-20,0,-5},RightKnee={-10,0,0},LeftKnee={-10,0,0},Root={-75,0,0},Waist={-10,0,0},},charge={RightShoulder={-55,0,12},LeftShoulder={-55,0,-12},RightElbow={20,0,0},LeftElbow={20,0,0},RightHip={75,0,6},LeftHip={75,0,-6},RightKnee={-100,0,0},LeftKnee={-100,0,0},Root={-30,0,0},Waist={-15,0,0},rootY=-0.8,},land_soft={RightShoulder={-25,0,15},LeftShoulder={-25,0,-15},RightHip={40,0,5},LeftHip={40,0,-5},RightKnee={-60,0,0},LeftKnee={-60,0,0},Root={-15,0,0},rootY=-0.5,},land_hard={RightShoulder={35,0,25},RightElbow={10,0,0},LeftShoulder={-45,0,-30},RightHip={95,0,10},RightKnee={-100,0,0},LeftHip={-10,0,-15},LeftKnee={-85,0,0},Root={-35,0,0},Waist={-20,0,0},rootY=-1.0,},}cg.release_spread={RightShoulder={20,0,85},LeftShoulder={20,0,-85},RightElbow={5,0,0},LeftElbow={5,0,0},RightHip={-5,0,12},LeftHip={-5,0,-12},RightKnee={-10,0,0},LeftKnee={-10,0,0},Waist={5,0,0},}cg.release_swan={RightShoulder={10,0,100},LeftShoulder={10,0,-100},RightElbow={0,0,0},LeftElbow={0,0,0},RightHip={-28,0,8},LeftHip={-28,0,-8},RightKnee={-30,0,0},LeftKnee={-30,0,0},Waist={18,0,0},Root={-8,0,0},}cg.glide={RightShoulder={165,0,12},LeftShoulder={165,0,-12},RightHip={-25,0,5},LeftHip={-25,0,-5},RightKnee={-25,0,0},LeftKnee={-25,0,0},Root={-55,0,0},Waist={-5,0,0},}cg.dash={RightShoulder={165,0,5},LeftShoulder={165,0,-5},RightHip={-15,0,4},LeftHip={-15,0,-4},RightKnee={-8,0,0},LeftKnee={-8,0,0},Waist={-8,0,0},}cg.zip={RightShoulder={170,0,6},LeftShoulder={170,0,-6},RightElbow={5,0,0},LeftElbow={5,0,0},RightHip={-15,0,4},LeftHip={-15,0,-4},RightKnee={-8,0,0},LeftKnee={-8,0,0},}cg.crouch={rootY=-1.4,}cg.climb={RightShoulder={125,0,32},LeftShoulder={125,0,-32},RightElbow={30,0,0},LeftElbow={30,0,0},RightHip={100,0,38},LeftHip={100,0,-38},RightKnee={-75,0,0},LeftKnee={-75,0,0},Root={-8,0,0},Waist={-5,0,0},Neck={30,0,0},}local dA={frontflip={pose="release",axis="x",deg=-360,time=0.75},backflip={pose="release",axis="x",deg=360,time=0.8},sideflip={pose="release",axis="z",deg=360,time=0.75},corkscrew={pose="release_spread",axis="y",deg=720,time=0.9},spiral={pose="release",axis="xy",deg=-360,time=0.9},swan={pose="release_swan",axis=nil,deg=0,time=0.9},custom={pose="release",axis=nil,deg=0,time=0.9},}local cW={"frontflip","corkscrew","spiral","swan","backflip","sideflip"}dance.trickEmote={frontflip="trick_frontflip",backflip="trick_backflip",sideflip="trick_sideflip",corkscrew="trick_spin",custom="trick_custom",}local hq={idle=10,glide=9,fidget_webcheck=9,fidget_scratch=6,fidget_stretch=6,fidget_look=6,swing=10,jump=14,fall=8,release=16,dive=10,charge=12,land_soft=22,land_hard=28,dash=20,climb=14,zip=20,crouch=12,}local current={}local dX=0
function U.aC()for _,n in ipairs(aB)do
current[n]=Vector3.zero
end
dX=0
ay=CFrame.new()end
U.aC()function U.v(aS)cv=math.clamp(cv+aS,-12,20)end
local aM
local dr=84
local fE=8
local aU={}local bR,sentNeutral=0,false
function U.N(v)return math.clamp(math.round(v),-32768,32767)end
function U.dS(now,dashCF)if not U.a or not aM or not aM.Parent or not aa.ReplicatePoses then return end
local tx,ty,tz=ay:ToEulerAnglesYXZ()local cN=math.abs(dX)<0.02 and aV<0.01 and dashRoll==0
and math.abs(tx)+math.abs(ty)+math.abs(tz)<0.01
if cN then
for _,name in ipairs(aB)do
if current[name].Magnitude>0.6 then
cN=false
break
end
end
end
if cN and sentNeutral then return end
if now-bR<1/aa.ReplicateRate then return end
bR=now
sentNeutral=cN
local b=buffer.create(dr)if not cN then
local o=0
for _,name in ipairs(aB)do
local c=current[name]buffer.writei16(b,o,U.N(c.X*fE))buffer.writei16(b,o+2,U.N(c.Y*fE))buffer.writei16(b,o+4,U.N(c.Z*fE))o+=6
end
buffer.writei16(b,o,U.N(dX*100))buffer.writei16(b,o+2,U.N(math.deg(tx)*fE))buffer.writei16(b,o+4,U.N(math.deg(ty)*fE))buffer.writei16(b,o+6,U.N(math.deg(tz)*fE))buffer.writei16(b,o+8,U.N(math.deg(aV)*fE))buffer.writei16(b,o+10,U.N(math.deg(dashRoll)*fE))end
aM:FireServer(b)end
function U.dg(char)local rig={}local hum=char:FindFirstChildOfClass("Humanoid")if not hum or hum.RigType~=Enum.HumanoidRigType.R15 then return rig end
for _,name in ipairs(aB)do
local j=char:FindFirstChild(name,true)if j and j:IsA("Motor6D")then
rig[#rig+1]={name=name,joint=j,c0=j.C0}end
end
return rig
end
function U.cB(sender,buf)if typeof(sender)~="Instance"or not sender:IsA("Player")or sender.Parent~=bo
or sender==player or typeof(buf)~="buffer"or buffer.len(buf)~=dr then return end
local r=aU[sender]if not r then
r={cur={},tgt={},ex={0,0,0,0,0,0},tex={0,0,0,0,0,0},rig={},rigTry=0,t=0}for _,n in ipairs(aB)do
r.cur[n]=Vector3.zero
r.tgt[n]=Vector3.zero
end
aU[sender]=r
end
local o=0
for _,name in ipairs(aB)do
r.tgt[name]=Vector3.new(buffer.readi16(buf,o)/fE,buffer.readi16(buf,o+2)/fE,buffer.readi16(buf,o+4)/fE)o+=6
end
r.tex[1]=buffer.readi16(buf,o)/100
for i=2,6 do
r.tex[i]=buffer.readi16(buf,o+(i-1)*2)/fE
end
r.t=os.clock()end
function U.aH(a,b)return((b-a+180)%360)-180
end
U.b(ae.RenderStepped,function(dt)if not aa.ReplicatePoses then return end
local k=1-math.exp(-16*dt)local now=os.clock()for sender,r in pairs(aU)do
local char=sender.Character
if char and char.Parent then
if r.char~=char or(#r.rig==0 and now-r.rigTry>1)then
r.char=char
r.rig=U.dg(char)r.rigTry=now
end
if#r.rig>0 then
local fS=now-r.t>3
for _,name in ipairs(aB)do
local target=fS and Vector3.zero or r.tgt[name]local c=r.cur[name]r.cur[name]=Vector3.new(c.X+U.aH(c.X,target.X)*k,c.Y+U.aH(c.Y,target.Y)*k,c.Z+U.aH(c.Z,target.Z)*k)end
local ex,tex=r.ex,r.tex
ex[1]+=((fS and 0 or tex[1])-ex[1])*k
for i=2,6 do
ex[i]+=U.aH(ex[i],fS and 0 or tex[i])*k
end
local ho=CFrame.new(0,ex[1],0)*CFrame.fromEulerAnglesYXZ(math.rad(ex[2]),math.rad(ex[3]),math.rad(ex[4]))*CFrame.Angles(-math.rad(ex[5]),0,0)*CFrame.Angles(0,math.rad(ex[6]),0)for _,j in ipairs(r.rig)do
if j.joint.Parent then
local c=r.cur[j.name]local cf=j.c0*CFrame.Angles(math.rad(c.X),math.rad(c.Y),math.rad(c.Z))if j.name=="Root"then
cf=ho*cf
end
j.joint.C0=cf
end
end
end
end
end
end)U.b(bo.PlayerRemoving,function(p)local ax=aU[p]if ax then
for _,joint in ipairs(ax.rig)do
if joint.joint.Parent then joint.joint.C0=joint.c0 end
end
end
aU[p]=nil
end)task.spawn(function()if not aa.ReplicatePoses then return end
aM=cV:WaitForChild(aa.ReplicateRemoteName,15)if not U.d then return end
if not aM or not aM:IsA("RemoteEvent")then
aM=nil
warn("[HUYBYPASS] RemoteEvent '"..aa.ReplicateRemoteName.."' not found. Install HuybypassPoseRelay.server.lua in ServerScriptService to share poses with other players.")return
end
U.b(aM.OnClientEvent,U.cB)end)function U.aM()local params=U.ab()local r=workspace:Raycast(root.Position,Vector3.new(0,-12,0),params)if r then
return r.Position+Vector3.new(0,0.15,0)end
return root.Position-Vector3.new(0,3,0)end
local fx={WHITE=Color3.new(1,1,1),ICE=Color3.fromRGB(170,215,255),BLUE=Color3.fromRGB(90,150,255),SPARK="rbxasset://textures/particles/sparkles_main.dds",SMOKE="rbxasset://textures/particles/smoke_main.dds",Bloom=true,Grade=true,Streaks=true,ChargeSwirl=true,streaks={},}function fx.ns(list)local k={}for i,p in ipairs(list)do k[i]=NumberSequenceKeypoint.new(p[1],p[2])end
return NumberSequence.new(k)end
function fx.cs(list)local k={}for i,p in ipairs(list)do k[i]=ColorSequenceKeypoint.new(p[1],p[2])end
return ColorSequence.new(k)end
function fx.emitter(parent,props)U.am=U.am or{}U.ai=U.ai or 0
if U.ai>=80 then
if not U.G then
U.G=Instance.new("ParticleEmitter")U.G.Enabled=false
U.G.Rate=0
end
return U.G
end
local e=Instance.new("ParticleEmitter")U.am[e]=true
U.ai+=1
e.Rate=0
e.LightInfluence=0
for k,v in pairs(props)do e[k]=v end
e.Parent=parent
return e
end
function fx.anchorPart(pos,life,size)local p=Instance.new("Part")p.Anchored=true
p.CanCollide=false
p.CanQuery=false
p.CanTouch=false
p.CastShadow=false
p.Transparency=1
p.Size=size or Vector3.new(1,1,1)p.Position=pos
p.Parent=aq
dK:AddItem(p,life)return p
end
function fx.groundColor(pos)local dE={aq}if ad then table.insert(dE,ad)end
local params=RaycastParams.new()params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances=dE
local r=workspace:Raycast(pos+Vector3.new(0,2,0),Vector3.new(0,-8,0),params)if r and r.Instance and r.Instance:IsA("BasePart")then
return r.Instance.Color:Lerp(Color3.fromRGB(215,215,215),0.55)end
return Color3.fromRGB(225,225,225)end
function U.O(v,fallback)return v.Magnitude>0.001 and v.Unit or fallback
end
function U.ab()if U.bA and os.clock()<(U.du or 0)then return U.bA end
local p=RaycastParams.new()p.FilterType=Enum.RaycastFilterType.Exclude
local dE={aq}for _,plr in ipairs(bo:GetPlayers())do
if plr.Character then table.insert(dE,plr.Character)end
end
p.FilterDescendantsInstances=dE
p.RespectCanCollide=true
p.IgnoreWater=false
U.bA,U.du=p,os.clock()+0.25
return p
end
function U.as(pos)local bC=workspace:Raycast(pos+Vector3.yAxis*2,-Vector3.yAxis*9,U.ab())if not bC then return nil end
local dj=Color3.fromRGB(160,150,137)if bC.Instance:IsA("BasePart")then
dj=bC.Instance.Color
elseif bC.Instance==workspace.Terrain then
dj=workspace.Terrain:GetMaterialColor(bC.Material)end
return bC.Position,bC.Normal,dj,bC.Material
end
function U.J(pos,normal)normal=U.O(normal,Vector3.yAxis)local gO=math.abs(normal.Y)<0.95 and Vector3.yAxis or Vector3.xAxis
local right=U.O(gO:Cross(normal),Vector3.xAxis)return CFrame.fromMatrix(pos,right,normal:Cross(right),normal)end
function U.q(pos)local ag=workspace.CurrentCamera
return ag and(ag.CFrame.Position-pos).Magnitude<=aa.VFXCullDistance
end
function U.W()local p=table.remove(U.aS)if not p then
if U.aQ>=aa.VFXMaxParts then return nil end
p=Instance.new("Part")p.Name="HuybypassFXPooled"p.Anchored=true
p.CanCollide,p.CanTouch,p.CanQuery=false,false,false
p.CastShadow=false
p.Size=Vector3.one
p.Parent=aq
U.aQ+=1
end
p.Shape=Enum.PartType.Block
p.Material=Enum.Material.Neon
p.Color=fx.ICE
p.Transparency=1
return p
end
function U.bh(p)p.Transparency=1
p.CFrame=CFrame.new(0,-10000,0)table.insert(U.aS,p)end
function U.s(n)return math.max(1,math.floor(n*aa.VFXQuality*U.C))end
function U.aD(pos,normal,radius,duration,color,thickness,delayTime)if not U.q(pos)or not U.d then return end
local fw=aa.VFXMaxParts-(U.aQ-#U.aS)local eE=math.min(fw,math.clamp(U.s(aa.RingSegments),12,48))if eE<8 then return end
local parts={}for i=1,eE do
local p=U.W()if not p then break end
p.Color=color
table.insert(parts,p)end
if#parts<8 then
for _,p in ipairs(parts)do U.bh(p)end
return
end
table.insert(U.w,{kind="ring",parts=parts,basis=U.J(pos,normal),born=os.clock()+(delayTime or 0),life=duration,radius=radius,width=thickness,})end
function U.cR(pos,size,color,duration)if not U.q(pos)or not U.d then return end
local p=U.W()if not p then return end
p.Shape=Enum.PartType.Ball
p.Color=color
table.insert(U.w,{kind="flash",parts={p},pos=pos,size=size,born=os.clock(),life=duration,})end
function U.t(pos,normal,radius,sweep,rotation,color,life,movingRoot)if not U.d or not U.q(pos)then return end
local parts={}for _=1,math.clamp(U.s(12),6,18)do
local p=U.W()if not p then break end
p.Color=color
table.insert(parts,p)end
if#parts<5 then for _,p in ipairs(parts)do U.bh(p)end return end
table.insert(U.w,{kind="arc",parts=parts,basis=U.J(pos,normal),radius=radius,sweep=sweep,rotation=rotation,spin=1.8,born=os.clock(),life=life,follow=movingRoot,})end
function U.cS(e,t,dt)local basis=e.basis
if e.follow and e.follow.Parent then
basis=CFrame.new(e.follow.Position)*e.basis.Rotation
end
local radius=e.radius*(0.72+0.28*t)local rotation=e.rotation+t*e.spin
for j,p in ipairs(e.parts)do
local a=rotation+(j-1)/#e.parts*e.sweep
local b=rotation+j/#e.parts*e.sweep
local p0=basis:PointToWorldSpace(Vector3.new(math.cos(a)*radius,math.sin(a)*radius,0))local p1=basis:PointToWorldSpace(Vector3.new(math.cos(b)*radius,math.sin(b)*radius,0))local hr=math.sin(j/(#e.parts+1)*math.pi)local width=math.max(0.015,0.065*hr*(1-t))p.Size=Vector3.new(width,width,math.max(0.01,(p1-p0).Magnitude*1.05))p.CFrame=CFrame.lookAt((p0+p1)*0.5,p1)p.Transparency=math.clamp(0.22+0.78*t,0,1)end
end
function U.B(key,cooldown)U.be=U.be or{}local now=os.clock()if now<(U.be[key]or 0)then return false end
U.be[key]=now+cooldown
return true
end
function U.aZ(damage)if not root or not U.B("sense",damage and 0.3 or 1)then return end
if U.p then U.p(damage and"damage"or"senseScan")end
local pos=root.Position
local color=damage and Color3.fromRGB(255,105,80)or aa.SenseColor
if not aa.ReducedMotion then
U.aD(pos-Vector3.yAxis*2.4,Vector3.yAxis,damage and 7 or 18,0.8,color,0.045)end
U.t(pos+Vector3.yAxis*1.5,Vector3.yAxis,2.2,math.pi*0.7,0,color,0.5)U.t(pos+Vector3.yAxis*1.5,Vector3.yAxis,2.5,math.pi*0.7,math.pi,color,0.6)end
function U.dK(dt,speed,vel)if not U.a or not root or not root.Parent then return end
local now=os.clock()local normal=U.O(vel,root.CFrame.LookVector)if ac and not aa.ReducedMotion and U.B("chargeOrbit",0.22)then
local charge=math.clamp((now-ac)/aa.ChargeTime,0,1)local color=Color3.fromRGB(245,90,65):Lerp(Color3.fromRGB(255,215,120),charge)U.t(root.Position,Vector3.yAxis,2.4+charge*1.1,math.pi*1.2,now*3,color,0.45,root)if charge>0.65 and U.C>0.7 then
U.t(root.Position,Vector3.xAxis,3,math.pi*0.8,-now*3,fx.ICE,0.35,root)end
end
if aa.ReducedMotion then return end
if now<au and U.B("dashWake",0.13)then
U.t(root.Position-normal*2,normal,3.4,math.pi*1.55,now*12,fx.ICE,0.28)elseif as and speed>60 and U.B("zipWake",0.24)then
U.t(root.Position-normal*2,normal,2.6,math.pi*1.2,now*7,fx.WHITE,0.28)elseif ai and speed>85 and U.B("swingWake",0.55)then
U.t(root.Position-normal*2,normal,3,math.pi*0.85,now*4,fx.ICE,0.4)end
end
U.ag=Random.new()function U.aw()local hN=U.aQ-#U.aS
return aa.FilamentFX and not aa.ReducedMotion and U.a and U.d
and U.C>=0.65 and hN<aa.VFXMaxParts-32
end
function U.cl(pos,normal,power)if not U.aw()or not U.q(pos)then return end
normal=U.O(normal,Vector3.yAxis)local basis=U.J(pos,normal)local count=math.clamp(U.s(8),4,10)for j=1,count do
local part=U.W()if not part then break end
local angle=j/count*math.pi*2+U.ag:NextNumber(-0.12,0.12)local aN=basis.RightVector*math.cos(angle)+basis.UpVector*math.sin(angle)local velocity=aN*U.ag:NextNumber(8,15)*power+normal*U.ag:NextNumber(1.5,4)part.Color=j%3==0 and fx.ICE or fx.WHITE
table.insert(U.w,{kind="filament",parts={part},pos=pos+normal*0.09,velocity=velocity,born=os.clock(),life=U.ag:NextNumber(0.24,0.42),accel=-normal*5,width=U.ag:NextNumber(0.025,0.055),})end
end
function U.aX(a,b,c,d,t)local u=1-t
return a*(u*u*u)+b*(3*u*u*t)+c*(3*u*t*t)+d*(t*t*t)end
function U.aU(beam)if beam and beam:GetAttribute("Silk")then return end if not beam or not beam.Parent or not beam.Attachment0 or not beam.Attachment1
or not U.aw()or not U.q(beam.Attachment0.WorldPosition)then return end
local parts={}for i=1,2 do
local part=U.W()if not part then break end
part.Color=i==1 and fx.WHITE or fx.ICE
table.insert(parts,part)end
if#parts==0 then return end
table.insert(U.w,{kind="webGlint",parts=parts,beam=beam,hand=beam.Attachment0,tip=beam.Attachment1,born=os.clock(),life=0.3,})end
function U.cT(e)if e.kind~="webGlint"then return true end
return e.beam.Parent~=nil and e.hand.Parent~=nil and e.tip.Parent~=nil
and e.beam.Attachment0==e.hand and e.beam.Attachment1==e.tip
end
function U.cL(e,t)if e.kind=="filament"then
local gG=t*e.life
local function aW(a)return e.pos+e.velocity*a+e.accel*(0.5*a*a)end
local head=aW(gG)local fg=aW(math.max(0,gG-0.035*(1-t)))local aE=head-fg
local p=e.parts[1]if aE.Magnitude<0.001 then p.Transparency=1 return end
local width=math.max(0.01,e.width*(1-t))p.Size=Vector3.new(width,width,math.max(0.02,aE.Magnitude))p.CFrame=CFrame.lookAt((head+fg)*0.5,head)p.Transparency=math.clamp(0.15+t*t*0.85,0,1)elseif e.kind=="webGlint"then
local a,d=e.hand.WorldPosition,e.tip.WorldPosition
local b=a+e.hand.WorldCFrame.RightVector*e.beam.CurveSize0
local c=d-e.tip.WorldCFrame.RightVector*e.beam.CurveSize1
for j,p in ipairs(e.parts)do
local dZ=math.clamp(t-(j-1)*0.08,0,1)local p0=U.aX(a,b,c,d,dZ)local p1=U.aX(a,b,c,d,math.min(1,dZ+0.012))local aE=p1-p0
if aE.Magnitude>0.001 then
local width=math.max(0.025,aa.WebWidth*(j==1 and 0.9 or 1.5))p.Size=Vector3.new(width,width,math.clamp(aE.Magnitude,0.04,1.3))p.CFrame=CFrame.lookAt((p0+p1)*0.5,p1)p.Transparency=math.clamp(1-math.sin(dZ*math.pi)*(j==1 and 0.9 or 0.4),0,1)else p.Transparency=1 end
end
end
end
function U.dh()if not U.aw()or not U.B("webGlint",0.48)then return end
if ai then U.aU(fk)elseif as then
U.aU(pullBeams[2])if U.C>0.8 then U.aU(pullBeams[4])end
elseif U.aq and U.aq.arrived then
U.aU(U.aq.beams[1])end
end
U.r={pulse=0,hudAt=0,speed=0,color=Color3.fromRGB(160,219,255)}function U.bc(color,power)U.r.color=color
U.r.pulse=math.max(U.r.pulse,aa.ReducedMotion and 0 or power)end
function U.ap(pos,normal,power,inward,color)if aa.ReducedMotion or not U.q(pos)or not U.aw()then return end
local basis=U.J(pos,normal)local count=math.clamp(U.s(inward and 3 or 6),2,8)for i=1,count do
if U.aQ-#U.aS>aa.VFXMaxParts-100 then break end
local parts={}for _=1,5 do
local p=U.W()if not p then break end
p.Color=color
table.insert(parts,p)end
if#parts==0 then break end
local dh=i/count*math.pi*2+U.ag:NextNumber(-0.2,0.2)local aN=basis.RightVector*math.cos(dh)+basis.UpVector*math.sin(dh)local aR=normal:Cross(aN)local es=power*U.ag:NextNumber(3.5,6.5)local a=pos+normal*0.1
local b=a+aN*es*0.3+normal*(inward and 2.2 or 0.9)*power
local c=a+aN*es*0.75+aR*es*0.3+normal*power*1.6
local d=a+aN*es+aR*es*0.5+normal*power*0.1
table.insert(U.w,{kind="ribbon",parts=parts,a=a,b=b,c=c,d=d,born=os.clock()+i*0.013,life=inward and 0.65 or 0.48,inward=inward,follow=inward and root or nil,origin=pos,width=inward and 0.04 or 0.06})end
end
function U.dk(e,t)local offset=e.follow and e.follow.Parent and(e.follow.Position-e.origin)or Vector3.zero
local head=math.clamp(t*1.22,0,1)local fg=math.max(0,head-0.26*(1-t))for i,p in ipairs(e.parts)do
local a=fg+(head-fg)*(i-1)/#e.parts
local b=fg+(head-fg)*i/#e.parts
if e.inward then a,b=1-a,1-b end
local p0=U.aX(e.a,e.b,e.c,e.d,a)+offset
local p1=U.aX(e.a,e.b,e.c,e.d,b)+offset
local aE=p1-p0
if aE.Magnitude<0.002 then
p.Transparency=1
else
local width=math.max(0.01,e.width*math.sin(i/(#e.parts+1)*math.pi)*(1-t*0.6))p.Size=Vector3.new(width,width,aE.Magnitude*1.04)p.CFrame=CFrame.lookAt((p0+p1)*0.5,p1)p.Transparency=0.25+0.75*t*t
end
end
end
function U.dH()if U.r.gui or not aa.CinematicHUD then return end
local c=U.r
local gui=U.ui("ScreenGui",player.PlayerGui,{Name="HuybypassCinematicHUD",ResetOnSpawn=false,IgnoreGuiInset=false,DisplayOrder=2})c.gui=gui
table.insert(U.aa,gui)local panel=U.ui("Frame",gui,{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,22,1,-24),Size=UDim2.fromOffset(210,106),BackgroundColor3=Color3.fromRGB(9,16,28),BackgroundTransparency=0.18,BorderSizePixel=0})c.panel=panel
U.g(panel,12)U.ui("UIStroke",panel,{Color=c.color,Thickness=1,Transparency=0.72})U.ui("UIGradient",panel,{Rotation=35,Color=ColorSequence.new(Color3.fromRGB(179,200,231),Color3.fromRGB(83,101,136))})U.bj(panel,c.color,5,11)c.mode=U.i(panel,"HUYBYPASS / READY",10,UDim2.fromOffset(15,11),UDim2.fromOffset(180,15))c.speedLabel=U.i(panel,"000",28,UDim2.fromOffset(14,26),UDim2.fromOffset(80,34))c.speedLabel.Font=Enum.Font.GothamBold
U.i(panel,"STUDS / S",9,UDim2.fromOffset(92,43),UDim2.fromOffset(95,15))c.keys={}for i,def in ipairs({{"E","WEB"},{"Q","CHARGE"},{"F","DASH"}})do
local x=14+(i-1)*64
local key=U.i(panel,def[1].."  "..def[2],10,UDim2.fromOffset(x,70),UDim2.fromOffset(61,16))local hG=U.ui("Frame",panel,{Position=UDim2.fromOffset(x,91),Size=UDim2.fromOffset(54,2),BackgroundColor3=Color3.fromRGB(60,78,100),BorderSizePixel=0})local fill=U.ui("Frame",hG,{Size=UDim2.fromScale(1,1),BackgroundColor3=c.color,BorderSizePixel=0})c.keys[i]={label=key,fill=fill}end
c.edges=U.bj(gui,c.color,14,34)for _,gQ in ipairs(c.edges)do gQ.BackgroundTransparency=1 end
if U.c.radar then
c.sweep=U.ui("Frame",U.c.radar,{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0})local eV=U.ui("Frame",c.sweep,{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.new(0.43,0,0,1),BackgroundColor3=aa.SenseColor,BackgroundTransparency=0.5,BorderSizePixel=0})U.ui("UIGradient",eV,{Transparency=NumberSequence.new(0.8,0.15)})end
end
function U.dq()U.r.pulse,U.r.speed=0,0
if U.r.gui then U.r.gui.Enabled=false end
U.r.lastClimbPhase=nil
end
function U.dC(dt,speed,vel)U.dH()local c=U.r
c.pulse*=math.exp(-dt*5)c.speed+=(speed-c.speed)*(1-math.exp(-dt*9))local now=os.clock()local charge=ac and math.clamp((now-ac)/aa.ChargeTime,0,1)or 0
if ac and U.B("chargeStream",0.3)then
U.ap(root.Position,Vector3.yAxis,0.8+charge,true,fx.ICE:Lerp(Color3.fromRGB(255,202,123),charge))end
if ah and az>0.1 and U.B("crawlContact",0.28)and U.aw()then
local eS=(math.floor(now*4)%2==0 and aQ or ar)if eS then
local bC=workspace:Raycast(eS.Position+ak,-ak*5,U.ab())if bC then U.t(bC.Position+bC.Normal*0.06,bC.Normal,0.45,math.pi*1.5,now*5,fx.WHITE,0.24)end
end
end
if c.gui then
c.gui.Enabled=U.a and U.k
local ag=workspace.CurrentCamera
if ag then
c.panel.Visible=true
if bw.TouchEnabled then c.panel.AnchorPoint=Vector2.zero c.panel.Position=UDim2.fromOffset(10,8) local scale=c.panel:FindFirstChildOfClass("UIScale")or U.ui("UIScale",c.panel,{}) scale.Scale=math.clamp(ag.ViewportSize.X/680,0.55,0.8)end
end
for _,gQ in ipairs(c.edges)do
gQ.BackgroundColor3=c.color
gQ.BackgroundTransparency=1-c.pulse*0.48
end
if c.sweep then c.sweep.Rotation=aa.ReducedMotion and-90 or(now*65)%360 end
if now>=c.hudAt then
c.hudAt=now+0.08
c.speedLabel.Text=string.format("%03d",math.floor(c.speed+0.5))local mode=ac and"CHARGING"or now<au and"DASH"or as and"WEB ZIP"or ai and"SWING"or ah and"CLIMBING"or U.al and"GLIDE"or"READY"c.mode.Text="HUYBYPASS / "..mode
local eU={1,math.clamp((now-lastBigJump)/aa.BigJumpCooldown,0,1),math.clamp((now-lastDash)/aa.DashCooldown,0,1)}if ac then eU[2]=charge end
for i,key in ipairs(c.keys)do
key.fill.Size=UDim2.fromScale(eU[i],1)key.fill.BackgroundColor3=(i==2 and ac)and Color3.fromRGB(255,198,126)or fx.ICE
key.label.Text=({aa.WebKey.Name,aa.JumpKey.Name,aa.DashKey.Name})[i].." "..({"WEB","CHARGE","DASH"})[i]key.label.TextTransparency=eU[i]>=0.999 and 0 or 0.35
end
end
end
end
U.j={page=1,connections={},observed={}}function U.ae(immediate)local t=U.j
for _,conn in ipairs(t.connections)do conn:Disconnect()end
table.clear(t.connections)if not t.gui then return end
local gui,panel=t.gui,t.panel
t.gui,t.panel=nil,nil
if immediate or aa.ReducedMotion then gui:Destroy()return end
aA:Create(panel,TweenInfo.new(0.18),{GroupTransparency=1}):Play()task.delay(0.2,function()gui:Destroy()end)end
function U.ci(dt)local t=U.j
if not t.gui or not t.panel then return end
local ag=workspace.CurrentCamera
if ag then
local vp=ag.ViewportSize
fitHuybypassDialog(t.scale,math.clamp(math.min((vp.X-24)/370,(vp.Y-80)/368,1),0.35,1))end
if t.progress then
t.progress.Text=t.observed[t.page]and("✓ "..t.locale.ui[5])or t.locale.ui[6]t.progress.TextColor3=t.observed[t.page]and Color3.fromRGB(139,231,191)or Color3.fromRGB(149,173,199)end
end
U.aN={["en"]={["name"]="English",["ui"]={"Skip","Back","Next","Play","Tried — continue when ready","Try the keys, or select Next"},["pages"]={{"01 / MOVEMENT","Your first swing starts here.","W A S D · MOVE\nMOUSE · AIM / CAMERA","Find an open area with tall buildings. You can keep moving while reading this tutorial.",{"W","A","S","D"}},{"02 / WEB SWING","Aim high. Hold. Release.","HOLD E · SWING\nRELEASE E · LAUNCH","Aim at a building above you. Steer with WASD. Release E as you swing upward to fly farther.",{"E"}},{"03 / CHARGED JUMP","Build your energy.","HOLD Q · CHARGE\nRELEASE Q · LAUNCH","Charging holds you in place. The bar turns gold at full charge. Look where you want to go and release Q.",{"Q"}},{"04 / DASH & WEB ZIP","Connect your moves.","F IN THE AIR · DASH\nCTRL + E · WEB ZIP","Jump before dashing. Aim at a surface and press Ctrl + E to pull yourself toward it. The HUD shows cooldowns.",{"F","E"}},{"05 / CLIMB & GLIDE","Use walls and height.","CTRL · CRAWL / CLIMB\nSPACE · JUMP OFF / GLIDE","Hold Ctrl against a wall. Press Space to jump off. Hold Space in the air to glide; speed and height help.",{"LeftControl","RightControl","Space"}},{"06 / SUIT & HUYBYPASS-SENSE","Make it your style.","P · TOGGLE SUIT\nT · HUYBYPASS-SENSE","Huybypass-sense shows contacts, distances and radar. P changes your local outfit; clothing may take a moment to load.",{"P","T"}},{"07 / TRICKS & EXTRAS","Ready to explore.","L · TRICKS  H · CROUCH  J · CHAT\nM · DANCE  N · WRIST WEB  B · GOOFY","L switches your swing-release trick. M, N and B toggle emotes. Press F1 whenever you want to reopen this guide.",{"L","H","J","M","N","B"}}}},["nl"]={["name"]="Nederlands",["ui"]={"Overslaan","Terug","Volgende","Spelen","Geprobeerd — ga verder wanneer je wilt","Probeer de toetsen, of kies Volgende"},["pages"]={{"01 / BEWEGEN","Je eerste swing begint hier.","W A S D · BEWEGEN\nMUIS · RICHTEN / CAMERA","Kies een open plek met hoge gebouwen. Je kunt tijdens het lezen blijven bewegen.",{"W","A","S","D"}},{"02 / WEB SWING","Richt hoog. Houd vast. Laat los.","E VASTHOUDEN · SWING\nE LOSLATEN · AFZETTEN","Richt op een gebouw boven je. Stuur met WASD. Laat E los als je omhoog zwaait om verder te vliegen.",{"E"}},{"03 / SUPERSPRONG","Bouw energie op.","Q VASTHOUDEN · LADEN\nQ LOSLATEN · LANCEREN","Tijdens laden blijf je op je plek. De balk wordt goud bij volle lading. Kijk waar je heen wilt en laat Q los.",{"Q"}},{"04 / DASH & WEB ZIP","Verbind je bewegingen.","F IN DE LUCHT · DASH\nCTRL + E · WEB ZIP","Spring eerst voor een dash. Richt op een oppervlak en druk Ctrl + E om jezelf erheen te trekken. De HUD toont cooldowns.",{"F","E"}},{"05 / KLIMMEN & GLIDE","Gebruik muren en hoogte.","CTRL · KRUIPEN / KLIMMEN\nSPATIE · AFZETTEN / GLIDE","Houd Ctrl vast tegen een muur. Spatie laat je afzetten. Houd Spatie in de lucht vast voor glide; snelheid en hoogte helpen.",{"LeftControl","RightControl","Space"}},{"06 / PAK & HUYBYPASS-SENSE","Maak het jouw stijl.","P · PAK AAN / UIT\nT · HUYBYPASS-SENSE","Huybypass-sense toont contacten, afstand en radar. P wisselt je lokale outfit; kleding laden kan even duren.",{"P","T"}},{"07 / TRICKS & EXTRA’S","Klaar om vrij te spelen.","L · TRICKS  H · HURKEN  J · CHAT\nM · DANS  N · POLSWEB  B · GOOFY","L wisselt je trick na het swingen. M, N en B schakelen emotes aan of uit. Met F1 open je deze uitleg opnieuw.",{"L","H","J","M","N","B"}}}},["de"]={["name"]="Deutsch",["ui"]={"Überspringen","Zurück","Weiter","Spielen","Ausprobiert — weiter, wenn du bereit bist","Probiere die Tasten oder wähle Weiter"},["pages"]={{"01 / BEWEGUNG","Dein erster Schwung beginnt hier.","W A S D · BEWEGEN\nMAUS · ZIELEN / KAMERA","Suche einen freien Bereich mit hohen Gebäuden. Während der Anleitung kannst du dich weiter bewegen.",{"W","A","S","D"}},{"02 / NETZSCHWUNG","Hoch zielen. Halten. Loslassen.","E HALTEN · SCHWINGEN\nE LOSLASSEN · ABSCHWINGEN","Ziele auf ein Gebäude über dir. Lenke mit WASD. Lass E beim Aufwärtsschwingen los, um weiter zu fliegen.",{"E"}},{"03 / SPRUNG LADEN","Sammle Energie.","Q HALTEN · LADEN\nQ LOSLASSEN · STARTEN","Beim Laden bleibst du stehen. Bei voller Ladung wird der Balken gold. Schau in die gewünschte Richtung und lass Q los.",{"Q"}},{"04 / DASH & NETZZUG","Verbinde deine Bewegungen.","F IN DER LUFT · DASH\nCTRL + E · NETZZUG","Springe vor dem Dash. Ziele auf eine Fläche und drücke Ctrl + E, um dich dorthin zu ziehen. Das HUD zeigt Wartezeiten.",{"F","E"}},{"05 / KLETTERN & GLEITEN","Nutze Wände und Höhe.","CTRL · KRIECHEN / KLETTERN\nLEERTASTE · ABSPRINGEN / GLEITEN","Halte Ctrl an einer Wand. Mit der Leertaste springst du ab. Halte sie in der Luft zum Gleiten; Tempo und Höhe helfen.",{"LeftControl","RightControl","Space"}},{"06 / ANZUG & SPINNENSINN","Finde deinen Stil.","P · ANZUG UMSCHALTEN\nT · SPINNENSINN","Der Spinnensinn zeigt Kontakte, Entfernungen und Radar. P wechselt dein lokales Outfit. Das Laden kann kurz dauern.",{"P","T"}},{"07 / TRICKS & EXTRAS","Bereit zum Erkunden.","L · TRICKS  H · HOCKEN  J · CHAT\nM · TANZ  N · HANDNETZ  B · GOOFY","L wechselt den Trick nach dem Schwung. M, N und B schalten Emotes um. F1 öffnet diese Anleitung erneut.",{"L","H","J","M","N","B"}}}},["fr"]={["name"]="Français",["ui"]={"Passer","Retour","Suivant","Jouer","Essayé — continue quand tu veux","Essaie les touches ou choisis Suivant"},["pages"]={{"01 / DÉPLACEMENT","Ton premier élan commence ici.","W A S D · SE DÉPLACER\nSOURIS · VISER / CAMÉRA","Trouve un espace dégagé avec de hauts bâtiments. Tu peux continuer à bouger pendant le tutoriel.",{"W","A","S","D"}},{"02 / BALANCEMENT","Vise haut. Maintiens. Relâche.","MAINTENIR E · SE BALANCER\nRELÂCHER E · SE PROPULSER","Vise un bâtiment au-dessus de toi. Dirige-toi avec WASD. Relâche E pendant la montée pour aller plus loin.",{"E"}},{"03 / SAUT CHARGÉ","Accumule de l’énergie.","MAINTENIR Q · CHARGER\nRELÂCHER Q · DÉCOLLER","Tu restes immobile pendant la charge. La barre devient dorée à pleine charge. Regarde ta destination et relâche Q.",{"Q"}},{"04 / DASH & TRACTION","Enchaîne les mouvements.","F EN L’AIR · DASH\nCTRL + E · TRACTION","Saute avant le dash. Vise une surface et appuie sur Ctrl + E pour te tirer vers elle. Le HUD affiche les délais.",{"F","E"}},{"05 / GRIMPER & PLANER","Profite des murs et de la hauteur.","CTRL · RAMPER / GRIMPER\nESPACE · SE DÉTACHER / PLANER","Maintiens Ctrl contre un mur. Espace permet de sauter du mur. Maintiens Espace en l’air pour planer avec de la vitesse.",{"LeftControl","RightControl","Space"}},{"06 / TENUE & SENS D’ARAIGNÉE","Choisis ton style.","P · CHANGER DE TENUE\nT · SENS D’ARAIGNÉE","Le sens d’araignée montre les contacts, distances et radar. P change ta tenue locale. Son chargement peut prendre un instant.",{"P","T"}},{"07 / FIGURES & EXTRAS","Prêt à explorer.","L · FIGURES  H · ACCROUPI  J · CHAT\nM · DANSE  N · TOILE  B · GOOFY","L change la figure après un balancement. M, N et B activent ou arrêtent les emotes. F1 permet de rouvrir ce guide.",{"L","H","J","M","N","B"}}}},["es"]={["name"]="Español",["ui"]={"Omitir","Atrás","Siguiente","Jugar","Probado — continúa cuando quieras","Prueba las teclas o pulsa Siguiente"},["pages"]={{"01 / MOVIMIENTO","Tu primer balanceo empieza aquí.","W A S D · MOVERSE\nRATÓN · APUNTAR / CÁMARA","Busca una zona abierta con edificios altos. Puedes seguir moviéndote mientras lees el tutorial.",{"W","A","S","D"}},{"02 / BALANCEO","Apunta alto. Mantén. Suelta.","MANTENER E · BALANCEARSE\nSOLTAR E · IMPULSARSE","Apunta a un edificio sobre ti. Dirige con WASD. Suelta E al subir durante el balanceo para llegar más lejos.",{"E"}},{"03 / SALTO CARGADO","Acumula energía.","MANTENER Q · CARGAR\nSOLTAR Q · LANZARSE","Te quedas quieto al cargar. La barra se vuelve dorada con la carga completa. Mira hacia tu destino y suelta Q.",{"Q"}},{"04 / DASH & TIRÓN","Combina tus movimientos.","F EN EL AIRE · DASH\nCTRL + E · TIRÓN","Salta antes de hacer un dash. Apunta a una superficie y pulsa Ctrl + E para acercarte. El HUD muestra los tiempos de espera.",{"F","E"}},{"05 / ESCALAR & PLANEAR","Usa las paredes y la altura.","CTRL · GATEAR / ESCALAR\nESPACIO · SALTAR / PLANEAR","Mantén Ctrl contra una pared. Pulsa Espacio para saltar de ella. Mantén Espacio en el aire para planear; la velocidad ayuda.",{"LeftControl","RightControl","Space"}},{"06 / TRAJE & SENTIDO ARÁCNIDO","Elige tu estilo.","P · CAMBIAR TRAJE\nT · SENTIDO ARÁCNIDO","El sentido arácnido muestra contactos, distancias y radar. P cambia tu traje local. La ropa puede tardar un poco en cargar.",{"P","T"}},{"07 / TRUCOS & EXTRAS","Listo para explorar.","L · TRUCOS  H · AGACHARSE  J · CHAT\nM · BAILE  N · RED  B · GOOFY","L cambia el truco al soltar la red. M, N y B activan o desactivan emotes. Pulsa F1 para volver a abrir esta guía.",{"L","H","J","M","N","B"}}}}}function U.dx()if not U.d or U.j.gui then return end
local t=U.j
t.page=1
t.language=player:GetAttribute("HuybypassTutorialLanguage")or"en"if not U.aN[t.language]then t.language="en"end
t.locale=U.aN[t.language]t.pages=t.locale.pages
local gui=U.ui("ScreenGui",player.PlayerGui,{Name="HuybypassFirstUse",ResetOnSpawn=false,DisplayOrder=90})t.gui=gui
table.insert(U.aa,gui)local panel=U.ui("CanvasGroup",gui,{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-18,0.5,0),Size=UDim2.fromOffset(370,368),BackgroundColor3=Color3.fromRGB(9,15,27),BackgroundTransparency=0.04,BorderSizePixel=0,GroupTransparency=0})t.panel=panel
t.scale=U.ui("UIScale",panel,{Scale=1})U.g(panel,16)U.ui("UIStroke",panel,{Color=fx.ICE,Thickness=1,Transparency=0.55})U.bj(panel,Color3.fromRGB(255,104,113),7,17)t.heading=U.i(panel,"",11,UDim2.fromOffset(22,20),UDim2.fromOffset(318,20))t.heading.TextColor3=Color3.fromRGB(255,129,136)t.title=U.i(panel,"",18,UDim2.fromOffset(22,47),UDim2.fromOffset(326,27))t.title.Font=Enum.Font.GothamBold
local keys=U.ui("Frame",panel,{Position=UDim2.fromOffset(22,88),Size=UDim2.fromOffset(326,54),BackgroundColor3=Color3.fromRGB(25,39,57),BorderSizePixel=0})U.g(keys,8)t.keys=U.i(keys,"",11,UDim2.fromOffset(12,6),UDim2.fromOffset(306,42))t.keys.Font=Enum.Font.GothamBold
t.body=U.i(panel,"",12,UDim2.fromOffset(22,154),UDim2.fromOffset(326,62))t.body.TextWrapped=true
t.body.TextYAlignment=Enum.TextYAlignment.Top
t.progress=U.i(panel,"",10,UDim2.fromOffset(22,222),UDim2.fromOffset(326,18))local hg=U.ui("TextButton",panel,{Text="Skip",Font=Enum.Font.GothamMedium,TextSize=12,TextColor3=Color3.fromRGB(171,190,212),BackgroundTransparency=1,Position=UDim2.fromOffset(18,252),Size=UDim2.fromOffset(90,32)})local gN=U.ui("TextButton",panel,{Text="Back",Font=Enum.Font.GothamMedium,TextSize=12,TextColor3=fx.ICE,BackgroundTransparency=1,Position=UDim2.fromOffset(137,252),Size=UDim2.fromOffset(70,32)})local cH=U.ui("TextButton",panel,{Text="Next",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Color3.fromRGB(13,24,38),BackgroundColor3=fx.ICE,BorderSizePixel=0,Position=UDim2.fromOffset(218,250),Size=UDim2.fromOffset(130,36)})U.g(cH,8)local dP=U.i(panel,"",10,UDim2.fromOffset(22,292),UDim2.fromOffset(326,18))local bW={}local function eh()t.locale=U.aN[t.language]t.pages=t.locale.pages
hg.Text,gN.Text=t.locale.ui[1],t.locale.ui[2]dP.Text="Language / "..t.locale.name
for cA,at in pairs(bW)do
at.BackgroundColor3=cA==t.language and fx.ICE or Color3.fromRGB(25,39,57)at.TextColor3=cA==t.language and Color3.fromRGB(9,15,27)or fx.ICE
end
local page=t.pages[t.page]t.heading.Text,t.title.Text,t.keys.Text,t.body.Text=page[1],page[2],page[3],page[4]if U.ce and bw.TouchEnabled then U.ce()elseif U.bL then t.keys.Text=U.bL(page[3])t.body.Text=U.bL(page[4])end gN.Visible=t.page>1
cH.Text=t.page==#t.pages and t.locale.ui[4]or(t.locale.ui[3].."  →")U.ci(0)end
for i,cA in ipairs({"en","nl","de","fr","es"})do
local at=U.ui("TextButton",panel,{Text=U.aN[cA].name,Font=Enum.Font.GothamMedium,TextSize=10,BorderSizePixel=0,Position=UDim2.fromOffset(22+(i-1)*66,318),Size=UDim2.fromOffset(62,30)})U.g(at,6)bW[cA]=at
table.insert(t.connections,at.Activated:Connect(function()t.language=cA
player:SetAttribute("HuybypassTutorialLanguage",cA)eh()end))end
table.insert(t.connections,hg.Activated:Connect(function()U.ae(false)end))table.insert(t.connections,gN.Activated:Connect(function()t.page=math.max(1,t.page-1)eh()end))table.insert(t.connections,cH.Activated:Connect(function()if t.page==#t.pages then U.ae(false)else t.page+=1 eh()end
end))table.insert(t.connections,bw.InputBegan:Connect(function(av,processed)if processed or bw:GetFocusedTextBox()or not U.a or not U.k then return end
for _,key in ipairs(t.pages[t.page][5])do
if av.KeyCode.Name==key then t.observed[t.page]=true break end
end
end))eh()aA:Create(panel,TweenInfo.new(aa.ReducedMotion and 0 or 0.28),{GroupTransparency=0}):Play()end
function U.bY()local env=getfenv(0)local read,write=env.readfile,env.writefile
if type(read)~="function"or type(write)~="function"then return nil end
return{read=read,write=write,path="HuybypassSwing_TutorialSeen_"..tostring(player.UserId)..".txt"}end
function U.bm()if not U.d then return false end
local ok,err=pcall(U.dx)if not ok then
U.ae(true)warn("[HUYBYPASS] "..tostring(err))return false
end
return U.j.gui~=nil and U.j.panel~=nil
end
function U.cp()player:SetAttribute(aa.TutorialSeenAttribute,true)local br=U.bY()U.j.persisted=false
if br then
local saved=pcall(br.write,br.path,"displayed_v2")if saved then
local ok,value=pcall(br.read,br.path)U.j.persisted=ok and value=="displayed_v2"end
end
end
function U.dl()if not aa.TutorialEnabled or player:GetAttribute(aa.TutorialSeenAttribute)then return end
local bq=player:GetAttribute("HuybypassTutorialDisplayLock")if type(bq)=="number"and os.clock()-bq<10 then return end
player:SetAttribute("HuybypassTutorialDisplayLock",os.clock())local br=U.bY()if br then
local ok,value=pcall(br.read,br.path)if ok and value=="displayed_v2"then
player:SetAttribute(aa.TutorialSeenAttribute,true)player:SetAttribute("HuybypassTutorialDisplayLock",nil)return
end
end
if U.bm()then U.cp()end
player:SetAttribute("HuybypassTutorialDisplayLock",nil)end
U.b(bw.InputBegan,function(av,processed)if U.F or U.ad or processed or bw:GetFocusedTextBox()then return end
if av.KeyCode==aa.TutorialKey then
if U.j.gui then
U.ae(false)elseif U.bm()then
U.cp()end
end
end)task.defer(U.dl)function U.cz(dt)local now=os.clock()if now>=(U.dp or 0)then
U.dp=now+0.2
for e in pairs(U.am or{})do
if not e.Parent then
U.am[e]=nil
U.ai=math.max(0,U.ai-1)end
end
end
for i=#U.w,1,-1 do
local e=U.w[i]local t=(now-e.born)/e.life
if t>=1 or(not U.cT(e))then
for _,p in ipairs(e.parts)do U.bh(p)end
table.remove(U.w,i)elseif t>=0 then
if e.kind=="ribbon"then
U.dk(e,t)elseif e.kind=="filament"or e.kind=="webGlint"then
U.cL(e,t)elseif e.kind=="arc"then
U.cS(e,t,dt)elseif e.kind=="ring"then
local r=0.15+e.radius*(1-(1-t)^2.4)local count=#e.parts
for j,p in ipairs(e.parts)do
local a,b=(j-1)/count*math.pi*2,j/count*math.pi*2
local p0=e.basis:PointToWorldSpace(Vector3.new(math.cos(a)*r,math.sin(a)*r,0))local p1=e.basis:PointToWorldSpace(Vector3.new(math.cos(b)*r,math.sin(b)*r,0))local w=math.max(0.015,e.width*(1-t))p.Size=Vector3.new(w,w,math.max(0.01,(p1-p0).Magnitude*1.08))p.CFrame=CFrame.lookAt((p0+p1)*0.5,p1)p.Transparency=0.24+(t^1.5)*0.76
end
elseif e.kind=="flash"then
local p=e.parts[1]p.Size=Vector3.one*math.max(0.05,e.size*(0.2+0.8*t))p.Position=e.pos
p.Transparency=0.68+t*0.32
elseif e.kind=="chunk"then
local p=e.parts[1]if not e.rest then
e.velocity-=Vector3.yAxis*workspace.Gravity*dt*0.65
local gE=e.velocity*dt
local bC=gE.Magnitude>0.001 and workspace:Raycast(p.Position,gE,e.params)if bC then
p.Position=bC.Position+bC.Normal*p.Size.Y*0.5
e.velocity=(e.velocity-bC.Normal*(1.35*e.velocity:Dot(bC.Normal)))*0.48
e.bounces+=1
e.rest=e.bounces>=2 or e.velocity.Magnitude<3
else
p.CFrame=(p.CFrame+gE)*CFrame.Angles(e.spin.X*dt,e.spin.Y*dt,e.spin.Z*dt)end
end
p.Transparency=math.clamp((t-0.6)/0.4,0,1)elseif e.kind=="crack"then
local p=e.parts[1]local tip=e.a:Lerp(e.b,math.min(1,t*9))local aE=tip-e.a
if aE.Magnitude>0.005 then
p.Size=Vector3.new(e.width,0.025,aE.Magnitude)p.CFrame=CFrame.lookAt((e.a+tip)*0.5,tip,e.normal)p.Transparency=0.24+0.76*math.clamp((t-0.5)/0.5,0,1)end
elseif e.kind=="line"then
e.parts[1].Transparency=e.startAlpha+(1-e.startAlpha)*t^2
end
end
end
end
function U.cn(ag)
if bw.TouchEnabled and(U.M or not bw.MouseEnabled)then
local v=ag.ViewportSize
return ag:ViewportPointToRay(v.X/2,v.Y/2)
end
local m=bw:GetMouseLocation()
return ag:ScreenPointToRay(m.X,m.Y)
end
function U.cP(maxDistance,minDistance,allowAir)local ag=workspace.CurrentCamera
if not ag or not root then return nil end
local eV=U.cn(ag)local params=U.ab()local function valid(bC)if not bC or bC.Material==Enum.Material.Water then return false end
local d=(bC.Position-root.Position).Magnitude
if d<minDistance or d>maxDistance then return false end
local model=bC.Instance:FindFirstAncestorOfClass("Model")if model and model:FindFirstChildOfClass("Humanoid")then return false end
local aE=bC.Position-root.Position
local gB=workspace:Raycast(root.Position,aE,params)return not gB or(gB.Position-bC.Position).Magnitude<2
end
local eQ=workspace:Raycast(eV.Origin,eV.Direction*(maxDistance+25),params)if valid(eQ)then return eQ.Position,eQ,params end
if aa.AimAssistRadius>0 then
local ek,score
local ga=aa.AimAssistRadius/math.max(maxDistance*0.5,1)for _,xy in ipairs({{-1,0},{1,0},{0,1},{-1,1},{1,1},{-0.5,2},{0.5,2}})do
local df=U.O(eV.Direction+ag.CFrame.RightVector*xy[1]*ga+ag.CFrame.UpVector*xy[2]*ga,eV.Direction)local bC=workspace:Raycast(eV.Origin,df*(maxDistance+25),params)if valid(bC)then
local aE=bC.Position-root.Position
local s=df:Dot(eV.Direction)*100+math.clamp(aE.Y/maxDistance,-1,1)*2-aE.Magnitude/maxDistance
if not score or s>score then ek,score=bC,s end
end
end
if ek then return ek.Position,ek,params end
end
if allowAir then
local df=U.O(Vector3.new(eV.Direction.X,math.max(0.45,eV.Direction.Y),eV.Direction.Z),Vector3.yAxis)local target=root.Position+df*math.min(aa.AirWebDistance,maxDistance)local bE=workspace:Raycast(root.Position,target-root.Position,params)if bE then
if valid(bE)then return bE.Position,bE,params end
return nil
end
return target,nil,params
end
return nil
end
function U.bT(velocity,dt)if velocity.Magnitude<0.1 or not root then return velocity,false end
local distance=velocity.Magnitude*math.clamp(dt,1/240,0.06)+0.7
local af=velocity.Unit
local bC=workspace:Spherecast(root.Position,aa.CollisionRadius,af*distance,U.ab())if bC and velocity:Dot(bC.Normal)<-1 then
local fT=math.max(0,bC.Distance-0.4)/math.max(dt,1/240)if fT<velocity.Magnitude then return af*fT,true end
end
return velocity,false
end
function U.dz()local bq=U.D
U.D=nil
if not bq then return end
local r,h=bq.root,bq.humanoid
if r and r.Parent then
r.Anchored=bq.anchored
r.AssemblyLinearVelocity=Vector3.zero
r.AssemblyAngularVelocity=Vector3.zero
end
if h and h.Parent and not U.m then
h.WalkSpeed=bq.walk
h.JumpPower=bq.jumpPower
h.JumpHeight=bq.jumpHeight
h.AutoRotate=bq.rotate
h.Jump=false
h:SetStateEnabled(Enum.HumanoidStateType.Jumping,bq.canJump)end
end
function U.cW()if U.D or not root or not humanoid or not root.Parent
or root.Anchored or humanoid.Health<=0 or humanoid.Sit then return false end
U.D={root=root,humanoid=humanoid,generation=U.e,anchored=root.Anchored,walk=humanoid.WalkSpeed,jumpPower=humanoid.JumpPower,jumpHeight=humanoid.JumpHeight,rotate=humanoid.AutoRotate,canJump=humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping),}root.AssemblyLinearVelocity=Vector3.zero
root.AssemblyAngularVelocity=Vector3.zero
root.Anchored=true
humanoid.WalkSpeed=0
humanoid.JumpPower=0
humanoid.JumpHeight=0
humanoid.AutoRotate=false
humanoid.Jump=false
humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)return true
end
function U.dv()if U.bx then U.bx()end local bq=U.D
if not bq then return end
local r,h=bq.root,bq.humanoid
if not ac or not U.a or bq.generation~=U.e
or r~=root or h~=humanoid or not r.Parent or not h.Parent
or h.Health<=0 or h.Sit or not U.k or bw:GetFocusedTextBox()then
U.y()return
end
r.Anchored=true
r.AssemblyLinearVelocity=Vector3.zero
r.AssemblyAngularVelocity=Vector3.zero
h.WalkSpeed,h.JumpPower,h.JumpHeight=0,0,0
h.AutoRotate,h.Jump=false,false
end
U.b(ae.PreSimulation,U.dv)function U.y(reason)local et=ac~=nil
U.dz()ac=nil
chargeFull=false
al.Visible=false
if am then am:Stop()end
if chargeSparks then chargeSparks.Rate=0 end
if fx.swirlEm then fx.swirlEm.Rate=0 end
if et and reason~="launch"and U.p then U.p("chargeCancel")end
end
function U.dc()U.dq()U.dJ()for emitter in pairs(U.am or{})do
if emitter~=fx.swirlEm then emitter:Destroy()end
end
U.am={}U.ai=0
if fx.swirlEm and fx.swirlEm.Parent then
U.am[fx.swirlEm]=true
U.ai=1
end
for _,e in ipairs(U.w)do
for _,p in ipairs(e.parts)do U.bh(p)end
end
table.clear(U.w)for _,s in ipairs(fx.streaks)do
s.alive,s.enableNext=false,false
s.trail.Enabled=false
s.trail:Clear()end
if fx.swirlEm then fx.swirlEm.Rate=0 fx.swirlEm:Clear()end
for _,tr in ipairs(cC)do
if tr.Parent then tr.Enabled=false tr:Clear()end
end
end
function fx.flash(pos,size,color,dur)U.cR(pos,size,color or fx.WHITE,dur or 0.2)end
function U.u(parentPart,aS)if not parentPart then return end
aS=math.clamp(U.s(aS or 10),1,28)if not U.q(parentPart.Position)then return end
local bY=fx.emitter(parentPart,{Texture=fx.SPARK,Color=fx.cs({{0,fx.WHITE},{0.4,fx.ICE},{1,fx.BLUE}}),LightEmission=1,Size=fx.ns({{0,0.12},{0.12,0.44},{1,0}}),Transparency=fx.ns({{0,0},{0.7,0.15},{1,1}}),Lifetime=NumberRange.new(0.25,0.6),Speed=NumberRange.new(14,42),SpreadAngle=Vector2.new(180,180),Drag=3,Acceleration=Vector3.new(0,-20,0),})bY:Emit(aS)local eN=fx.emitter(parentPart,{Texture=fx.SPARK,Color=fx.cs({{0,fx.WHITE},{1,fx.ICE}}),LightEmission=1,Orientation=Enum.ParticleOrientation.VelocityParallel,Size=fx.ns({{0,0.7},{0.2,0.95},{1,0}}),Transparency=fx.ns({{0,0.1},{1,1}}),Lifetime=NumberRange.new(0.15,0.35),Speed=NumberRange.new(30,70),SpreadAngle=Vector2.new(180,180),Drag=2,})eN:Emit(math.max(2,math.floor(aS*0.5)))local ce=fx.emitter(parentPart,{Texture=fx.SMOKE,Color=fx.cs({{0,fx.WHITE},{1,fx.ICE}}),LightEmission=1,Size=fx.ns({{0,1.5},{1,5}}),Transparency=fx.ns({{0,0.8},{1,1}}),Lifetime=NumberRange.new(0.15,0.25),Speed=NumberRange.new(0,0),})ce:Emit(math.max(1,math.floor(aS/6)))if bY~=U.G then dK:AddItem(bY,1.2)end
if eN~=U.G then dK:AddItem(eN,1.2)end
if ce~=U.G then dK:AddItem(ce,1.2)end
end
function U.ao(pos,size,orientation)local normal
if orientation then
normal=orientation.RightVector
else
local du,surfaceNormal=U.as(pos)if du then pos=du+surfaceNormal*0.08 end
normal=surfaceNormal or Vector3.yAxis
end
U.bc(fx.ICE,math.clamp(size/65,0.15,0.65))U.ap(pos,normal,math.clamp(size/26,0.5,1.7),false,fx.ICE)U.aD(pos,normal,size*0.5,0.52,fx.WHITE,0.11)U.aD(pos+normal*0.08,normal,size*0.38,0.62,fx.ICE,0.09,0.05)if aa.VFXQuality>=0.8 and U.C>0.65 then
U.t(pos+normal*0.14,normal,size*0.24,math.pi*1.3,os.clock(),fx.WHITE,0.4)end
if size>=30 and U.B("impactArcs",0.18)then
U.cl(pos,normal,math.clamp(size/35,0.8,1.5))for i=1,3 do
U.t(pos+normal*0.17,normal,size*(0.22+i*0.055),math.pi*0.55,i*math.pi*2/3,fx.ICE,0.5+i*0.07)end
end
fx.flash(pos,math.clamp(size*0.045,0.5,1.7),fx.ICE,0.12)end
function fx.debris(pos,dj,count)if not U.q(pos)then return end
local aW,normal,groundColor,material=U.as(pos)if not aW or material==Enum.Material.Water then return end
local frame=U.J(aW,normal)local params=U.ab()for _=1,math.min(12,U.s(count))do
local p=U.W()if not p then break end
local angle=math.random()*math.pi*2
local aN=frame.RightVector*math.cos(angle)+frame.UpVector*math.sin(angle)local size=0.16+math.random()*0.38
p.Material=material
p.Color=(groundColor or dj):Lerp(Color3.new(0,0,0),0.12)p.Size=Vector3.new(size,size*0.65,size*1.2)p.CFrame=CFrame.new(aW+normal*0.35)p.Transparency=0
table.insert(U.w,{kind="chunk",parts={p},born=os.clock(),life=1.15+math.random()*0.3,velocity=aN*(8+math.random()*17)+normal*(12+math.random()*17),spin=Vector3.new(math.random(),math.random(),math.random())*14,params=params,bounces=0,})end
end
function U.bK(pos,aS)if not U.q(pos)then return end
local aW,normal,dj,material=U.as(pos)if not aW or material==Enum.Material.Water then return end
aS=U.s(aS)local p=fx.anchorPart(aW+normal*0.12,2.4)p.CFrame=U.J(aW+normal*0.12,normal)local a=Instance.new("Attachment")a.Parent=p
a.WorldCFrame=CFrame.fromMatrix(aW+normal*0.12,p.CFrame.RightVector,normal)fx.emitter(a,{Texture=fx.SMOKE,Color=ColorSequence.new(dj:Lerp(fx.WHITE,0.22),dj),EmissionDirection=Enum.NormalId.Top,Size=fx.ns({{0,0.25},{0.15,1.4},{0.55,3.7},{1,5.4}}),Transparency=fx.ns({{0,0.82},{0.15,0.58},{0.6,0.82},{1,1}}),Lifetime=NumberRange.new(0.55,1.2),Speed=NumberRange.new(5,16),SpreadAngle=Vector2.new(85,85),Drag=5,LightEmission=0,LightInfluence=0.65,Rotation=NumberRange.new(0,360),RotSpeed=NumberRange.new(-16,16),Acceleration=normal*2.5,}):Emit(aS)local n=math.min(10,U.s(10))for i=1,n do
local dh=i/n*math.pi*2
local basis=U.J(aW,normal)local bQ=basis.RightVector*math.cos(dh)+basis.UpVector*math.sin(dh)local att=Instance.new("Attachment")att.Parent=p
att.WorldCFrame=CFrame.lookAt(aW+normal*0.2,aW+normal*0.2+bQ)fx.emitter(att,{Texture=fx.SMOKE,Color=ColorSequence.new(dj),EmissionDirection=Enum.NormalId.Front,Speed=NumberRange.new(20,34),SpreadAngle=Vector2.new(8,8),Drag=5,Lifetime=NumberRange.new(0.35,0.65),Size=fx.ns({{0,0.8},{0.4,2.8},{1,4.5}}),Transparency=fx.ns({{0,0.55},{1,1}}),LightInfluence=0.8,}):Emit(2)end
fx.debris(aW,dj,math.floor(aS/4))end
function fx.crackSeg(a,b,w,delayTime)if not U.q(a)then return end
local pa,na=U.as(a)local pb,nb=U.as(b)if not pa or not pb or na:Dot(nb)<0.85 then return end
pa,pb=pa+na*0.025,pb+nb*0.025
local aE=pb-pa
if aE.Magnitude<0.08 then return end
local p=U.W()if not p then return end
p.Material=Enum.Material.SmoothPlastic
p.Color=Color3.fromRGB(20,20,24)p.Size=Vector3.new(w,0.025,aE.Magnitude)p.CFrame=CFrame.lookAt((pa+pb)*0.5,pb,na)p.Transparency=1
table.insert(U.w,{kind="crack",parts={p},born=os.clock()+(delayTime or 0),life=1.55,a=pa,b=pb,normal=na,width=w,})end
function U.bO(pos,count,length)if not aa.GroundCracks or not U.q(pos)then return end
local aW,normal,_,material=U.as(pos)if not aW or material==Enum.Material.Water or material==Enum.Material.Grass
or material==Enum.Material.Sand or material==Enum.Material.Snow then return end
local frame=U.J(aW,normal)local base=math.random()*math.pi*2
for i=1,math.min(9,U.s(count))do
local angle=base+i/math.min(9,U.s(count))*math.pi*2
local cF=aW
for s=1,4 do
angle+=(math.random()-0.5)*0.5
local dm=cF+(frame.RightVector*math.cos(angle)+frame.UpVector*math.sin(angle))*length*0.18
fx.crackSeg(cF,dm,math.max(0.04,0.18-s*0.025),(s-1)*0.035)if s==3 and i%2==0 and U.C>0.7 then
local gT=dm+(frame.RightVector*math.cos(angle+0.65)+frame.UpVector*math.sin(angle+0.65))*length*0.17
fx.crackSeg(dm,gT,0.035,0.12)end
cF=dm
end
end
end
function fx.impact(pos,normal)if not U.q(pos)or not U.B("impact",0.055)then return end
U.ap(pos,normal,0.5,false,fx.WHITE)U.cl(pos,normal,0.65)U.t(pos+normal*0.12,normal,2.7,math.pi*1.4,os.clock()*6,fx.WHITE,0.42)U.aD(pos+normal*0.05,normal,2.2,0.22,fx.WHITE,0.085)U.aD(pos+normal*0.07,normal,3.1,0.38,fx.ICE,0.045,0.035)fx.flash(pos+normal*0.1,1.1,fx.WHITE,0.13)local p=fx.anchorPart(pos+normal*0.12,0.8)U.u(p,U.s(9))end
function fx.muzzle(h)if not h then return end
fx.flash(h.Position,0.5,fx.WHITE,0.1)U.bc(fx.ICE,0.16)if U.B("muzzle",0.04)then
U.t(h.Position,h.CFrame.LookVector,0.65,math.pi*1.6,os.clock()*8,fx.ICE,0.18)U.u(h,7)end
end
function U.ds()if aa.ReducedMotion then return end
if not ad or not root or not U.q(root.Position)or U.C<0.75 then return end
fx.ghostFlip=not fx.ghostFlip
local dj=fx.ghostFlip and aa.GhostColor or Color3.fromRGB(255,120,120)for _,part in ipairs(ad:GetChildren())do
if part:IsA("BasePart")and part.Name~="HumanoidRootPart"and part.Transparency<1 then
local g=part:Clone()if g then
for _,ch in ipairs(g:GetChildren())do
if not ch:IsA("DataModelMesh")then ch:Destroy()end
end
if g:IsA("MeshPart")then g.TextureID=""end
g.Anchored=true
g.CanCollide=false
g.CanQuery=false
g.CanTouch=false
g.CastShadow=false
g.Massless=true
g.Material=Enum.Material.Neon
g.Color=dj
g.Transparency=0.35
g.CFrame=part.CFrame
g.Parent=aq
aA:Create(g,TweenInfo.new(aa.GhostFade,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1,Size=g.Size*1.18}):Play()dK:AddItem(g,aa.GhostFade+0.1)end
end
end
end
U.ax={}
function U.bf(source,tip,host)
local count=bw.TouchEnabled and 10 or 16
local ax={source=source,tip=tip,host=host,nodes={},count=count,born=os.clock()}
local beams={}
for strand=1,3 do
local nodes={}ax.nodes[strand]=nodes
for i=0,count do
local a=Instance.new("Attachment")a.Name="SilkPoint"a.Parent=host
a.WorldPosition=source.WorldPosition nodes[i+1]=a
if i>0 then
local beam=Instance.new("Beam")beam.Name="HuybypassSilk"
beam.Attachment0,beam.Attachment1=nodes[i],a
beam.Width0=aa.WebWidth*0.28 beam.Width1=beam.Width0
beam.Color=ColorSequence.new(Color3.fromRGB(218,218,208),Color3.fromRGB(245,243,231))
beam.LightEmission=0 beam.LightInfluence=0.75 beam.FaceCamera=true beam.Segments=1
beam.Transparency=NumberSequence.new(0.08)
beam:SetAttribute("BaseT",0.08)beam:SetAttribute("Silk",true)
beam.Parent=host table.insert(beams,beam)
end
end
end
table.insert(U.ax,ax)
U.cs(ax)
return beams
end
function U.cs(ax)
local a,b=ax.source.WorldPosition,ax.tip.WorldPosition
local aE=b-a local length=aE.Magnitude
if length<0.001 then
for _,nodes in ipairs(ax.nodes)do for _,node in ipairs(nodes)do node.WorldPosition=a end end
return
end
local af=aE/length
local right=ax.right or Vector3.xAxis
right=right-af*right:Dot(af)
if right.Magnitude<0.01 then right=af:Cross(math.abs(af.Y)<0.95 and Vector3.yAxis or Vector3.xAxis)end
right=right.Unit ax.right=right
local up=af:Cross(right)
local gG=os.clock()-ax.born
local gd=math.exp(-gG*9)
for strand,nodes in ipairs(ax.nodes)do
for i,node in ipairs(nodes)do
local t=(i-1)/ax.count
local dI=math.sin(t*math.pi)
local angle=t*math.pi*6+(strand-1)*math.pi*2/3
local radius=aa.WebWidth*0.46*dI
local hB=(right*math.cos(angle)+up*math.sin(angle))*radius
local gW=up*(math.sin(t*math.pi*4-gG*16)*0.14*gd*dI)
node.WorldPosition=a+aE*t+hB+gW-Vector3.yAxis*(0.09*dI)
end
end
end
U.b(ae.RenderStepped,function()
for i=#U.ax,1,-1 do
local ax=U.ax[i]
if not ax.host.Parent or not ax.source.Parent or not ax.tip.Parent then
table.remove(U.ax,i)
else U.cs(ax)end
end
end)
function U.bZ(parentPart,pos,normal)fx.impact(pos,normal)local frame=U.J(pos+normal*0.04,normal)local bl=Instance.new("Attachment")bl.Position=parentPart.CFrame:PointToObjectSpace(frame.Position)bl.Parent=parentPart
local nodes={}local n=math.clamp(U.s(10),6,10)local function gD(a,b,width)local beam=Instance.new("Beam")beam.Name="WebSplatFilament"beam.Attachment0,beam.Attachment1=a,b
beam.Width0,beam.Width1=width,width*0.65
beam.FaceCamera=true
beam.LightEmission=0 beam.LightInfluence=0.8
beam.Color=ColorSequence.new(aa.WebColor)beam.Transparency=NumberSequence.new(0.22)beam:SetAttribute("BaseT",0.22)beam.Segments=3
beam.CurveSize0,beam.CurveSize1=0.04,-0.04
beam.Parent=parentPart
end
for ring=1,3 do
nodes[ring]={}for i=1,n do
local dh=i/n*math.pi*2
local radius=ring*0.8*(0.92+math.random()*0.16)local hm=frame:PointToWorldSpace(Vector3.new(math.cos(dh)*radius,math.sin(dh)*radius,0))local a=Instance.new("Attachment")a.Position=bl.Position
a.Parent=parentPart
aA:Create(a,TweenInfo.new(0.08+ring*0.035,Enum.EasingStyle.Quad),{Position=parentPart.CFrame:PointToObjectSpace(hm)}):Play()nodes[ring][i]=a
if ring==1 then gD(bl,a,0.065)else gD(nodes[ring-1][i],a,0.045)end
end
for i=1,n do gD(nodes[ring][i],nodes[ring][i%n+1],0.035)end
end
end
function fx.makeStreak()local p=Instance.new("Part")p.Anchored=true
p.CanCollide=false
p.CanQuery=false
p.CanTouch=false
p.CastShadow=false
p.Transparency=1
p.Size=Vector3.new(0.2,0.2,0.2)p.Parent=aq
local a0=Instance.new("Attachment")a0.Position=Vector3.new(0,0.09,0)a0.Parent=p
local a1=Instance.new("Attachment")a1.Position=Vector3.new(0,-0.09,0)a1.Parent=p
local tr=Instance.new("Trail")tr.Attachment0=a0
tr.Attachment1=a1
tr.Lifetime=0.2
tr.MinLength=0.05
tr.FaceCamera=true
tr.LightEmission=1
tr.LightInfluence=0
tr.Color=ColorSequence.new(fx.WHITE)tr.Transparency=fx.ns({{0,0.55},{1,1}})tr.WidthScale=fx.ns({{0,1},{1,0}})tr.Enabled=false
tr.Parent=p
return{part=p,trail=tr,alive=false,enableNext=false}end
function fx.ensure()if not fx.bloom then
local b=Instance.new("BloomEffect")b.Name="HuybypassBloom"b.Intensity=0
b.Size=28
b.Threshold=1.1
b.Parent=dq
fx.bloom=b
local cc=Instance.new("ColorCorrectionEffect")cc.Name="HuybypassGrade"cc.Parent=dq
fx.cc=cc
end
if fx.ChargeSwirl and(not fx.swirlPart or not fx.swirlPart.Parent)and os.clock()>=(U.di or 0)then
U.di=os.clock()+0.2
local sp=Instance.new("Part")sp.Name="ChargeSwirl"sp.Anchored=true
sp.CanCollide=false
sp.CanQuery=false
sp.CanTouch=false
sp.CastShadow=false
sp.Transparency=1
sp.Size=Vector3.new(9,9,9)sp.Parent=aq
fx.swirlPart=sp
fx.swirlEm=fx.emitter(sp,{Texture=fx.SPARK,Shape=Enum.ParticleEmitterShape.Sphere,ShapeInOut=Enum.ParticleEmitterShapeInOut.Inward,ShapeStyle=Enum.ParticleEmitterShapeStyle.Surface,LightEmission=1,Size=fx.ns({{0,0.1},{0.3,0.8},{1,0}}),Transparency=fx.ns({{0,1},{0.2,0.1},{1,0.4}}),Lifetime=NumberRange.new(0.4,0.5),Speed=NumberRange.new(8,11),Color=ColorSequence.new(Color3.fromRGB(255,60,50)),})if fx.swirlEm==U.G then
sp:Destroy()fx.swirlPart,fx.swirlEm=nil,nil
end
end
end
function fx.update(dt,speed,vel)dt=math.clamp(dt,0,0.05)U.cz(dt)U.dK(dt,speed,vel)U.ck()U.cy()U.bS()U.dh()U.dC(dt,speed,vel)U.ci(dt)local dQ=aa.VFXAdaptive and(U.co>0.028 and 0.55 or 1)or 1
U.C+=(dQ-U.C)*(1-math.exp(-dt*0.8))fx.ensure()local now=os.clock()local sp=math.clamp(speed/aa.FOVMaxSpeed,0,1)local c=ac and math.clamp((now-ac)/aa.ChargeTime,0,1)or 0
local k=1-math.exp(-dt*6)U.E.Text=c>=0.999 and"READY • RELEASE Q"or string.format("CHARGE %d%% • HOLD Q",math.floor(c*100))U.E.TextColor3=fx.ICE:Lerp(Color3.fromRGB(255,218,120),c)if fx.Bloom then
local target=math.min(0.55,0.07+0.16*sp+0.2*c+math.max(cv,0)*0.004)fx.bloom.Enabled=true
fx.bloom.Intensity+=(target-fx.bloom.Intensity)*k
else
fx.bloom.Enabled=false
end
if fx.Grade then
local gV=fx.WHITE:Lerp(Color3.fromRGB(215,235,255),sp*0.6)gV=gV:Lerp(Color3.fromRGB(255,170,170),math.clamp(an,0,1)*0.45)fx.cc.Enabled=true
fx.cc.Saturation+=((0.05+0.18*sp+0.1*c)-fx.cc.Saturation)*k
fx.cc.Contrast+=((0.03+0.1*sp)-fx.cc.Contrast)*k
fx.cc.TintColor=fx.cc.TintColor:Lerp(gV,k)else
fx.cc.Enabled=false
end
if fx.swirlEm then
if root and root.Parent and ac then
fx.swirlPart.CFrame=root.CFrame
fx.swirlEm.Rate=(12+90*c)*aa.VFXQuality*U.C*(aa.ReducedMotion and 0.2 or 1)fx.swirlEm.Color=ColorSequence.new(Color3.fromRGB(255,60,50):Lerp(Color3.fromRGB(255,215,0),c))else
fx.swirlEm.Rate=0
end
end
if fx.Streaks and root and root.Parent then
local on=speed>70 and not aa.ReducedMotion and U.a
local df=(speed>1)and vel.Unit or Vector3.zero
local right=df:Cross(Vector3.yAxis)if right.Magnitude<0.1 then right=Vector3.xAxis end
right=right.Unit
local hR=right:Cross(df)for i=1,18 do
local s=fx.streaks[i]if not s then
s=fx.makeStreak()fx.streaks[i]=s
end
if on and i<=math.floor(18*U.C*aa.VFXQuality)then
local hQ=s.part.Position-root.Position
if(not s.alive)or hQ:Dot(df)<-25 or hQ.Magnitude>130 then
s.trail.Enabled=false
s.trail:Clear()s.part.Position=root.Position+df*(25+math.random()*70)+right*((math.random()-0.5)*50)+hR*((math.random()-0.5)*32)s.alive=true
s.enableNext=true
else
if s.enableNext then
s.trail.Enabled=true
s.enableNext=false
end
s.trail.Lifetime=0.12+0.12*sp
s.part.Position-=vel*dt*0.55
end
elseif s.alive then
s.alive=false
s.enableNext=false
s.trail.Enabled=false
end
end
end
end
U.ac={}function U.bB(e)e.anchor:Destroy()for _,host in ipairs(e.holders)do host:Destroy()end
end
function U.dJ()for _,e in ipairs(U.ac)do U.bB(e)end
table.clear(U.ac)end
function U.bS()local now=os.clock()for i=#U.ac,1,-1 do
local e=U.ac[i]local t=math.clamp((now-e.born)/0.34,0,1)if not U.d or not U.a or e.generation~=U.e
or not e.anchor.Parent or t>=1 then
U.bB(e)table.remove(U.ac,i)else
for _,item in ipairs(e.fading)do
if item.beam.Parent then
item.beam.Transparency=NumberSequence.new(item.alpha+(1-item.alpha)*t)end
end
end
end
end
function U.cc(a,beams)if not a then return end
if not aa.WebRetract or not U.d or not U.a then a:Destroy()return end
if#U.ac>=8 then U.bB(table.remove(U.ac,1))end
local holders,mapping={},{}
for _,ax in ipairs(U.ax)do
if ax.host==a and ax.source.Parent then
local host=fx.anchorPart(ax.source.WorldPosition,0.5,Vector3.one*0.1)
local endpoint=Instance.new("Attachment")endpoint.Parent=host
ax.source=endpoint table.insert(holders,host)
aA:Create(host,TweenInfo.new(0.22,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=a.Position}):Play()
end
end
for _,beam in ipairs(beams)do
if not beam:GetAttribute("Silk")and beam.Parent and beam.Attachment0 and beam.Attachment0.Parent then
local source=beam.Attachment0
local endpoint=mapping[source]if not endpoint then
local host=fx.anchorPart(source.WorldPosition,0.5,Vector3.one*0.1)endpoint=Instance.new("Attachment")endpoint.Parent=host
mapping[source]=endpoint
table.insert(holders,host)aA:Create(host,TweenInfo.new(0.22,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=a.Position}):Play()end
beam.Attachment0=endpoint
end
end
local fading={}for _,d in ipairs(a:GetDescendants())do
if d:IsA("Beam")then
table.insert(fading,{beam=d,alpha=d:GetAttribute("BaseT")or 0.1})end
end
table.insert(U.ac,{anchor=a,holders=holders,fading=fading,born=os.clock(),generation=U.e,})end
function U.cE(part)local w=math.max(part.Size.X,0.6)*0.5
local y=-part.Size.Y*0.35
local a0=Instance.new("Attachment")a0.Name="TrailA0"a0.Position=Vector3.new(-w,y,0)a0.Parent=part
local a1=Instance.new("Attachment")a1.Name="TrailA1"a1.Position=Vector3.new(w,y,0)a1.Parent=part
local bY=Instance.new("Trail")bY.Attachment0=a0
bY.Attachment1=a1
bY.Lifetime=aa.TrailLifetime
bY.MinLength=0.05
bY.FaceCamera=true
bY.LightEmission=1
bY.LightInfluence=0
bY.Brightness=1.3
bY.Color=fx.cs({{0,fx.WHITE},{0.5,fx.ICE},{1,fx.BLUE}})bY.Transparency=fx.ns({{0,aa.TrailTransparency},{0.6,0.7},{1,1}})bY.WidthScale=fx.ns({{0,0.16},{0.08,0.48},{0.42,0.26},{1,0}})bY.Enabled=false
bY.Parent=part
table.insert(cC,bY)local ce=Instance.new("Trail")ce.Attachment0=a0
ce.Attachment1=a1
ce.Lifetime=aa.TrailLifetime*1.3
ce.MinLength=0.05
ce.FaceCamera=true
ce.LightEmission=1
ce.LightInfluence=0
ce.Color=fx.cs({{0,fx.ICE},{1,fx.BLUE}})ce.Transparency=fx.ns({{0,0.85},{0.4,0.93},{1,1}})ce.WidthScale=fx.ns({{0,0.7},{0.25,1.05},{1,0.02}})ce.Enabled=false
ce.Parent=part
table.insert(cC,ce)end
U.P={voices={},cooldowns={}}U.cf={webAttach={source="WebSoundId",volume=0.3,pitch=0.8,life=0.32,gap=0.12},webRelease={source="WebSoundId",volume=0.25,pitch=1.35,life=0.28,gap=0.15},chargeReady={source="LaunchSoundId",volume=0.42,pitch=1.7,life=0.5,gap=0.4},chargeCancel={source="WebSoundId",volume=0.16,pitch=0.65,life=0.23,gap=0.3},senseOn={source="LaunchSoundId",volume=0.32,pitch=1.45,life=0.48,gap=0.25},senseOff={source="WebSoundId",volume=0.2,pitch=0.7,life=0.28,gap=0.25},senseScan={source="WebSoundId",volume=0.08,pitch=1.8,life=0.16,gap=2.5},damage={source="LandSoundId",volume=0.32,pitch=1.3,life=0.35,gap=0.5},climbGrab={source="WebSoundId",volume=0.3,pitch=0.9,life=0.27,gap=0.35},climbJump={source="DashSoundId",volume=0.25,pitch=1.3,life=0.35,gap=0.3},emoteWeb={source="WebSoundId",volume=0.65,pitch=1.1,life=0.5,gap=0.35},emoteImpact={source="WebSoundId",volume=0.24,pitch=0.75,life=0.24,gap=0.2},}function U.dt()if not aa.ExtraSounds or U.dA then return end
U.dA=true
local fP,seen={},{}for name,def in pairs(U.cf)do
local id=aa.CueSoundIds[name]if id==nil then id=aa[def.source]end
if type(id)=="string"and id~=""and not seen[id]then
seen[id]=true
table.insert(fP,id)end
end
task.spawn(function()local ok=pcall(function()game:GetService("ContentProvider"):PreloadAsync(fP)end)if not ok and aa.Debug then warn("[HUYBYPASS] Supplemental cue preload failed.")end
end)end
function U.dF()for _,voice in ipairs(U.P.voices)do voice.sound:Destroy()end
table.clear(U.P.voices)table.clear(U.P.cooldowns)end
function U.p(name)if not aa.ExtraSounds or not U.a or not root or not root.Parent then return false end
local def=U.cf[name]if not def then return false end
local now=os.clock()if now<(U.P.cooldowns[name]or 0)then return false end
local id=aa.CueSoundIds[name]if id==nil then id=aa[def.source]end
if type(id)~="string"or id==""then return false end
local voice
for _,candidate in ipairs(U.P.voices)do
if now>=candidate.untilTime and candidate.sound.Parent==root then
voice=candidate
break
end
end
if not voice then
if#U.P.voices>=aa.CueMaxVoices then return false end
local sound=Instance.new("Sound")sound.Name="HuybypassCueVoice"sound.RollOffMinDistance=6
sound.RollOffMaxDistance=85
sound.Looped=false
sound.Parent=root
voice={sound=sound,untilTime=0}table.insert(U.P.voices,voice)end
local sound=voice.sound
sound:Stop()sound.SoundId=id
sound.TimePosition=0
sound.PlaybackSpeed=def.pitch
sound.Volume=math.clamp(aa.CueMasterVolume*def.volume,0,1)voice.volume,voice.born,voice.life=sound.Volume,now,def.life
voice.untilTime=now+def.life
sound:Play()U.P.cooldowns[name]=now+def.gap
return true
end
function U.cy()local now=os.clock()for _,voice in ipairs(U.P.voices)do
local sound=voice.sound
if now>=voice.untilTime then
if sound.IsPlaying then sound:Stop()end
else
local fA=math.clamp((voice.untilTime-now)/math.min(0.1,voice.life),0,1)sound.Volume=voice.volume*fA
end
end
end
function U.R(name,id,volume)if id==""then return nil end
local s=Instance.new("Sound")s.Name=name
s.SoundId=id
s.Volume=volume
s.RollOffMaxDistance=150
s.Parent=root
return s
end
function U.av(s,minSpeed,maxSpeed)if not s then return end
s.PlaybackSpeed=minSpeed+math.random()*(maxSpeed-minSpeed)s:Play()end
function U.dm()if am then
am:Stop()am.PlaybackSpeed=1
end
end
function U.bP(volumeFactor,minSpeed,maxSpeed)if not bx then return end
bx.Volume=aa.LandSoundVolume*volumeFactor
U.av(bx,minSpeed,maxSpeed)end
function U.dL()releaseSign=1
if dance.customTrick then
local ct=dance.E and dance.E.tracks.trick_custom
if ct and ct.Length>0 then
return"custom"end
end
local eb=U.M and humanoid and humanoid.MoveDirection or Vector3.zero
local ag=workspace.CurrentCamera
local dS=ag and eb:Dot(ag.CFrame.RightVector)or 0
local fv=ag and eb:Dot(ag.CFrame.LookVector)<-0.3
if bw:IsKeyDown(Enum.KeyCode.S)or fv then
cu="backflip"return"backflip"end
local lf,rt=bw:IsKeyDown(Enum.KeyCode.A)or dS<-0.3,bw:IsKeyDown(Enum.KeyCode.D)or dS>0.3 if lf or rt then
releaseSign=lf and-1 or 1
cu="sideflip"return"sideflip"end
local gg
repeat
gg=cW[math.random(#cW)]until gg~=cu
cu=gg
releaseSign=(math.random()<0.5)and-1 or 1
return gg
end
function U.da(target)if not aa.AutoHandSide then
return aa.DefaultHandSide
end
local cb=workspace.CurrentCamera
local side=(target-cb.CFrame.Position):Dot(cb.CFrame.RightVector)if math.abs(side)<aa.HandSideDeadzone then
return(lastSide=="right")and"left"or"right"end
return(side<0)and"left"or"right"end
function ab.stop()local tr=ab.track
ab.track=nil
if tr then
if tr.IsPlaying then tr:Stop(0.2)end
if tr~=ab.fallback then tr:Destroy()end
end
local fb=ab.fallback
if fb and fb~=tr and fb.IsPlaying then
fb:Stop(0.2)end
end
function ab.load(animId)if not animator then return false end
local bA,generation=animator,U.e
local a=Instance.new("Animation")a.AnimationId=animId
local ok,tr=pcall(function()return bA:LoadAnimation(a)end)a:Destroy()if ok and tr then
if not U.a or animator~=bA or U.e~=generation then tr:Destroy()return false end
if ab.fallback then ab.fallback:Stop(0)ab.fallback:Destroy()end
tr.Priority=Enum.AnimationPriority.Action4
tr.Looped=aa.SwingEmoteLooped
ab.fallback=tr
return true
end
return false
end
function ab.resolve(char)if ab.animId then
ab.load(ab.animId)return
end
local hum=humanoid
local t0=os.clock()while U.d and U.a and ad==char and hum and hum.Parent and os.clock()-t0<60 do
if hum.Health>0 and hum.FloorMaterial~=Enum.Material.Air and not ai and not ah
and not as and not ac and not hum.Sit and hum.MoveDirection.Magnitude<0.05
and not dance.isPlaying()and os.clock()>=au then
local ok,dG,tr=pcall(function()return hum:PlayEmoteAndGetAnimTrackById(aa.SwingEmoteId)end)if ok and dG and typeof(tr)=="Instance"and tr:IsA("AnimationTrack")then
local id=tr.Animation and tr.Animation.AnimationId
tr:Stop(0)tr:Destroy()if not U.a or ad~=char or hum~=humanoid then return end
if id and id~=""then
ab.animId=id
if ad==char then ab.load(id)end
return
end
end
end
task.wait(0.5)end
end
function ab.start(myToken)if aa.SwingEmoteId==0 or not humanoid then return end
ab.stop()local hum=humanoid
task.spawn(function()local track=ab.fallback
if track and track.Length>0 then
track:Play(0.15)else
local ok,dG,emoteTr=pcall(function()return hum:PlayEmoteAndGetAnimTrackById(aa.SwingEmoteId)end)if ok and dG and typeof(emoteTr)=="Instance"and emoteTr:IsA("AnimationTrack")then
track=emoteTr
end
end
if not track then return end
if track.Length<=0 or not U.a or hum~=humanoid or bX~=myToken or not ai then
track:Stop(0.1)if track~=ab.fallback then track:Destroy()end
return
end
pcall(function()track.Priority=Enum.AnimationPriority.Action4
track.Looped=aa.SwingEmoteLooped
end)ab.track=track
end)end
do
local E={defs={goofy={id=aa.GoofyEmoteId,loop=true},webglide={id=aa.GlideEmoteId,loop=true},fall={id=aa.FallEmoteId,loop=aa.FallEmoteLooped},charge={id=aa.ChargeEmoteId,loop=aa.ChargeEmoteLooped},launch={id=aa.LaunchEmoteId,loop=aa.LaunchEmoteLooped},land={id=aa.LandEmoteId,loop=aa.LandEmoteLooped},crawl={id=aa.CrawlEmoteId,loop=aa.CrawlEmoteLooped},dance={id=aa.DanceEmoteId,loop=aa.DanceLooped},emote={id=aa.EmoteId,loop=aa.EmoteLooped},dash={id=aa.DashEmoteId,loop=aa.DashEmoteLooped},trick_frontflip={id=aa.TrickFrontflipEmoteId,loop=false},trick_backflip={id=aa.TrickBackflipEmoteId,loop=false},trick_sideflip={id=aa.TrickSideflipEmoteId,loop=false},trick_spin={id=aa.TrickSpinEmoteId,loop=false},trick_custom={id=aa.CustomTrickEmoteId,loop=aa.CustomTrickLooped},},order={"dance","emote","goofy","webglide","fall","charge","launch","land","crawl","dash","trick_frontflip","trick_backflip","trick_sideflip","trick_spin","trick_custom"},tracks={},animIds={},active=nil,launching=false,launchAt=0,}dance.E=E
function E.load(name)local d=E.defs[name]if not d or d.id==0 or not animator then return end
local old=E.tracks[name]if old and old.IsPlaying then return end
local bA,generation=animator,U.e
local a=Instance.new("Animation")a.AnimationId=E.animIds[d.id]or("rbxassetid://"..tostring(d.id))local ok,tr=pcall(function()return bA:LoadAnimation(a)end)a:Destroy()if not ok or not tr then return end
if not U.a or generation~=U.e or animator~=bA then tr:Destroy()return end
tr.Priority=Enum.AnimationPriority.Action4
tr.Looped=d.loop
if old then old:Stop(0)old:Destroy()end
E.tracks[name]=tr
end
function E.isPlaying(name)local tr=name and E.tracks[name]return tr~=nil and tr.IsPlaying
end
function E.stop(name)local tr=E.tracks[name]if tr and tr.IsPlaying then tr:Stop(0.2)end
end
function E.play(name)if not U.f()then return false end if U.K and U.K()then return false end
local tr=E.tracks[name]if not tr or tr.Length<=0 then return false end
if not tr.IsPlaying then tr:Play(0.15)end
return true
end
function E.owns(track)if U.modeEmote and U.modeEmote.track==track then return true end
for _,tr in pairs(E.tracks)do
if tr==track then return true end
end
return false
end
function E.resolve(char)local w0=os.clock()while U.d and U.a and aa.SwingEmoteId~=0 and not ab.animId and ad==char and os.clock()-w0<65 do
task.wait(0.3)end
for _,name in ipairs(E.order)do
local id=E.defs[name].id
if id~=0 and not E.animIds[id]then
local t0,attempts=os.clock(),0
while U.d and U.a and ad==char and humanoid and humanoid.Parent and attempts<3 and os.clock()-t0<120 do
local hum=humanoid
if hum.Health>0 and hum.FloorMaterial~=Enum.Material.Air and not ai and not ah
and not as and not ac and not hum.Sit and hum.MoveDirection.Magnitude<0.05
and not dance.isPlaying()and os.clock()>=au then
attempts+=1
local ok,dG,tr=pcall(function()return hum:PlayEmoteAndGetAnimTrackById(id)end)if ok and dG and typeof(tr)=="Instance"and tr:IsA("AnimationTrack")then
local hF=tr.Animation and tr.Animation.AnimationId
tr:Stop(0)tr:Destroy()if not U.a or ad~=char or hum~=humanoid then return end
if hF and hF~=""then
E.animIds[id]=hF
if ad==char then
for _,n2 in ipairs(E.order)do
if E.defs[n2].id==id then E.load(n2)end
end
end
break
end
end
task.wait(0.2)else
task.wait(0.5)end
end
end
end
end
function E.update(state,air,now)
if U.modeEmote and U.modeEmote.track.IsPlaying then
for _,tr in pairs(E.tracks)do if tr.IsPlaying then tr:Stop(0.1)end end
E.active,E.launching,E.pending=nil,false,false
return true
end
if U.K()then
for name,tr in pairs(E.tracks)do if name~="emote"and tr.IsPlaying then tr:Stop(0)end end
E.active,E.launching,E.pending=nil,false,false
return E.isPlaying("emote")end
if state=="swing"or state=="dash"or state=="zip"or state=="climb"or state=="charge"or state=="land_hard"or state=="land_soft"or(not air and now-E.launchAt>0.3)then
E.launching=false
end
local bc
local ef=(state=="release")and dance.trickEmote[aG]if state=="webglide"then
E.launching=false
bc="webglide"elseif state=="charge"then
bc="charge"elseif ef and E.tracks[ef]and E.tracks[ef].Length>0 then
bc=ef
elseif state=="dash"and E.tracks.dash and E.tracks.dash.Length>0 then
bc="dash"elseif state=="climb"then
bc="crawl"elseif state=="land_hard"then
bc="land"elseif state=="dive"and diving=="swing"then
bc="fall"elseif E.launching and(air or now-E.launchAt<0.3)and state~="release"then
bc="launch"end
if bc~=E.active then
if E.active then E.stop(E.active)end
E.active=bc
E.pending=bc~=nil
end
if bc and(E.pending or(E.defs[bc].loop and not E.isPlaying(bc)))then
if E.play(bc)then E.pending=false end
end
return bc~=nil and E.isPlaying(bc)and E.tracks[bc].Length>0
end
end
function U.swingCameraRecover()
local camera=workspace.CurrentCamera
if U.bo then U.bo()end
cK=0 shakeEnd=0
if humanoid and humanoid.Parent then
if shaking then humanoid.CameraOffset=U.aV or Vector3.zero end
shaking=false
end
if not camera or not humanoid or not root or camera.CameraType==Enum.CameraType.Scriptable then return end
local subject=camera.CameraSubject
if subject and subject.Parent and subject~=humanoid and not subject:IsDescendantOf(ad)then return end
camera.CameraSubject=humanoid
local zoom=U.swingCameraZoom
if zoom and zoom>1 then
local focus=root.Position+Vector3.new(0,1.5,0)
camera.CFrame=CFrame.new(focus-camera.CFrame.LookVector*zoom)*camera.CFrame.Rotation
camera.Focus=CFrame.new(focus)
end
U.swingCameraZoom=nil
end
function U.o(boost)U.aj=nil if not ai then return end
ai=false
bX+=1
if bh then
bh:Disconnect()bh=nil
end
aD.destroy("swing")if cz then cz:Destroy()cz=nil end
if bH then bH:Destroy()bH=nil end
if anchor then
local a,beams=anchor,webBeams
anchor=nil
webBeams={}U.cc(a,beams)end
fk,go,hy,webS2=nil,nil,nil,nil
if animTrack then animTrack:Stop(0.2)end
ab.stop()if humanoid and not U.m then humanoid.AutoRotate=true end
if boost and root and humanoid and humanoid.Health>0 then
U.p("webRelease")local v=root.AssemblyLinearVelocity
local gi=aa.ReleaseBoost
local dU=v.Y>15 and v.Magnitude>60
if dU then gi+=aa.SlingshotBonus end
local hA=math.sqrt(v.X*v.X+v.Z*v.Z)local fW=v*gi+Vector3.new(0,aa.ReleaseUpBoost+hA*aa.ReleaseUpFromSpeed,0)local aP=Vector3.new(fW.X,0,fW.Z)if aP.Magnitude<aa.ReleaseMinSpeed then
local df
if aP.Magnitude>3 then
df=aP.Unit
else
local ag=workspace.CurrentCamera
local cR=ag and ag.CFrame.LookVector or root.CFrame.LookVector
local lf=Vector3.new(cR.X,0,cR.Z)df=lf.Magnitude>0.01 and lf.Unit or root.CFrame.LookVector
end
local fI=1-aP.Magnitude/aa.ReleaseMinSpeed
fW=Vector3.new(df.X*aa.ReleaseMinSpeed,fW.Y+aa.ReleaseSlowLift*fI,df.Z*aa.ReleaseMinSpeed)end
root.AssemblyLinearVelocity=fW
if dU then
U.v(12)U.u(root,16)end
if humanoid.FloorMaterial==Enum.Material.Air then
aG=U.dL()local tr=dA[aG]aI=os.clock()releaseEnd=aI+tr.time*aa.FlipTime/0.75
local en=dance.trickEmote[aG]local hL=en and dance.E.tracks[en]if hL and hL.Length>0 then
releaseEnd=aI+math.min(hL.Length,3)end
if aa.SwingReleaseDive then diving="swing"end
end
end
end
function U.n()if not as then return end
as=false
aK+=1
aD.destroy("pull")if bz then
local a,beams=bz,pullBeams
bz,pullBeams=nil,{}U.cc(a,beams)end
if humanoid and not U.m and not ai and not ah then
humanoid.AutoRotate=true
end
end
function U.aG()if U.F or U.ad or not U.k or bw:GetFocusedTextBox()then return false end
return U.S or bw:IsKeyDown(aa.ClimbKey)or(aa.ClimbKey==Enum.KeyCode.LeftControl and bw:IsKeyDown(Enum.KeyCode.RightControl))end
function U.aI(inst)local model=inst:FindFirstAncestorOfClass("Model")return model~=nil and model:FindFirstChildOfClass("Humanoid")~=nil
end
function U.l()U.bv=nil
if not ah then return end
ah=false
bp=os.clock()az=0
if co then
co:Disconnect()co=nil
end
aD.destroy("climb")aD.restoreCollide()if root and root.Parent and not U.m then
local pos=root.Position
local fr=root.CFrame.LookVector
if ak.Y>0.75 then
pos=pos+ak*1.9
fr=climbHeading
end
local aP=Vector3.new(fr.X,0,fr.Z)if aP.Magnitude>0.01 then
root.CFrame=CFrame.lookAt(pos,pos+aP.Unit)else
root.CFrame=CFrame.new(pos)end
root.AssemblyAngularVelocity=Vector3.zero
end
if humanoid and not U.m then
humanoid.PlatformStand=false
if not ai and os.clock()>=au then
humanoid.AutoRotate=true
end
end
end
function U.dE()if not ah or not root then return end
U.p("climbJump")local n=ak
local heading=climbHeading
local gM=az>0.1
local r,h,generation=root,humanoid,U.e
U.l()local bT=U.z()task.spawn(function()ae.Heartbeat:Wait()if U.bX(bT,generation,r,h)and not ac and not ai
and not as and not ah and os.clock()>=au then
if n.Y>0.75 then
r.AssemblyLinearVelocity=Vector3.new(0,aa.JumpPower,0)+(gM and heading*25 or Vector3.zero)else
r.AssemblyLinearVelocity=n*aa.ClimbJumpOut+Vector3.new(0,aa.ClimbJumpUp,0)end
end
end)U.v(8)end
function U.bi(n,camLook)if math.abs(n.Y)<0.75 then
local u=Vector3.new(0,1,0)-n*n.Y
if u.Magnitude>0.01 then return u.Unit end
end
local c=camLook-n*camLook:Dot(n)if c.Magnitude>0.05 then return c.Unit end
local f=root.CFrame.LookVector
f=f-n*f:Dot(n)return(f.Magnitude>0.01)and f.Unit or Vector3.new(0,0,-1)end
local function newHeading(oldN,newN,convex,camLook)local hd
if math.abs(oldN.Y)<0.75 and math.abs(newN.Y)<0.75 then
hd=U.bi(newN,camLook)else
hd=convex and-oldN or oldN
end
hd=hd-newN*hd:Dot(newN)if hd.Magnitude<0.2 then return U.bi(newN,camLook)end
return hd.Unit
end
function U.bR(dt)local c=U.bv
if not c then return false end
c.time=math.min(c.duration,c.time+math.min(dt,0.05))local t=c.time/c.duration
local eT=t*t*(3-2*t)local rotation=CFrame.fromAxisAngle(c.axis,c.angle*eT)ak=rotation:VectorToWorldSpace(c.normal).Unit
climbHeading=rotation:VectorToWorldSpace(c.heading).Unit
local pos=c.p0*(1-t)^2+c.control*(2*(1-t)*t)+c.p2*t*t
local orientation
if aa.CrawlEmoteUpright and dance.E.isPlaying("crawl")then
orientation=CFrame.lookAt(pos,pos+climbHeading,ak)*CFrame.Angles(0,math.rad(aa.CrawlEmoteTurn),0)else
orientation=CFrame.lookAt(pos,pos-ak,climbHeading)end
aD.drive("climb",Vector3.zero)root.AssemblyLinearVelocity,root.AssemblyAngularVelocity=Vector3.zero,Vector3.zero
root.CFrame=orientation
if t>=1 then
ak,climbHeading=c.newNormal,c.newHeading
U.bv=nil
U.dI=os.clock()+0.2
end
return true
end
function U.dP(n,moveDir,support,params)if not moveDir then return false end
local gt=n.Y>0.75 and aa.ClimbGroundOffset or aa.ClimbOffset
if dance.E.isPlaying("crawl")then gt+=aa.CrawlEmoteLift end
local da=gt+1.2
local gv=workspace:Raycast(root.Position+moveDir*da,-n*aa.ClimbReach,params)if gv and gv.Normal:Dot(n)>0.8 then return false end
for _,depth in ipairs({0.6,1.4,2.4})do
local origin=root.Position+moveDir*da-n*(gt+depth)local cX=workspace:Raycast(origin,-moveDir*(da+aa.ClimbReach),params)if cX and not U.aI(cX.Instance)and cX.Normal.Y>-0.5
and cX.Normal:Dot(n)<0.5 and cX.Normal:Dot(moveDir)>0.4 then
local newN=cX.Normal
local base=support and support.Position or root.Position-n*gt
local fJ=(cX.Position-base):Dot(newN)/moveDir:Dot(newN)if fJ<=0.7 and fJ>=-aa.ClimbReach then
local bP=base+moveDir*fJ
local eR=newN.Y>0.75 and aa.ClimbGroundOffset or aa.ClimbOffset
if dance.E.isPlaying("crawl")then eR+=aa.CrawlEmoteLift end
local axis=n:Cross(newN)if axis.Magnitude<0.01 then return false end
axis=axis.Unit
local angle=math.acos(math.clamp(n:Dot(newN),-1,1))local rotation=CFrame.fromAxisAngle(axis,angle)local aY=rotation:VectorToWorldSpace(moveDir).Unit
local newHeading=rotation:VectorToWorldSpace(climbHeading).Unit
U.bv={time=0,duration=aa.ClimbOuterCornerTime,axis=axis,angle=angle,normal=n,newNormal=newN,heading=climbHeading,newHeading=newHeading,p0=root.Position,control=bP+n*gt+newN*eR,p2=bP+newN*eR+aY*1.2,}return true
end
end
end
return false
end
function U.bu(bC)if not U.f()then return end if ac or not U.a then return end
U.o(false)U.n()U.A()releaseEnd=0
diving=false
ah=true
U.p("climbGrab")ak=bC.Normal
aZ=0
az=0
climbHeading=U.bi(ak,workspace.CurrentCamera.CFrame.LookVector)humanoid.AutoRotate=false
humanoid.PlatformStand=true
root.AssemblyLinearVelocity=Vector3.zero
root.AssemblyAngularVelocity=Vector3.zero
aD.drive("climb",Vector3.zero)aD.noCollide()U.u(root,8)U.v(-4)local params=RaycastParams.new()params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={ad,aq}local cj=0
co=U.b(ae.Heartbeat,function(dt)if not U.a or not ah or not root or not humanoid or humanoid.Health<=0 then
U.l()return
end
if not U.aG()then
U.l()return
end
aD.noCollide()if U.bR(dt)then return end
local n=ak
local cb=workspace.CurrentCamera
local camLook=cb.CFrame.LookVector
local dn=U.bi(n,camLook)local dY=dn:Cross(n)local h=climbHeading-n*climbHeading:Dot(n)h=(h.Magnitude>0.01)and h.Unit or dn
if aa.ClimbBodyFollowsCamera and os.clock()>=(U.dI or 0)then
local bc=dn*(camLook:Dot(dn)+aa.ClimbUpBias)+dY*(camLook:Dot(dY)*aa.ClimbSideWeight)if bc.Magnitude>0.05 then
bc=bc.Unit
local hH=math.atan2(n:Dot(h:Cross(bc)),h:Dot(bc))h=CFrame.fromAxisAngle(n,hH*math.min(1,dt*aa.ClimbTurnSpeed)):VectorToWorldSpace(h)end
elseif not aa.ClimbBodyFollowsCamera then
h=dn
end
climbHeading=h
local cU=cb.CFrame.RightVector
local dl=cU-n*cU:Dot(n)dl=(dl.Magnitude>0.05)and dl.Unit or h:Cross(n)local ix=(bw:IsKeyDown(Enum.KeyCode.D)and 1 or 0)-(bw:IsKeyDown(Enum.KeyCode.A)and 1 or 0)local iy=(bw:IsKeyDown(Enum.KeyCode.W)and 1 or 0)-(bw:IsKeyDown(Enum.KeyCode.S)and 1 or 0)if U.M then
local md=humanoid.MoveDirection
local cR=Vector3.new(camLook.X,0,camLook.Z)
local right=Vector3.new(cU.X,0,cU.Z)
ix=right.Magnitude>0.01 and md:Dot(right.Unit)or 0
iy=cR.Magnitude>0.01 and md:Dot(cR.Unit)or 0
end
local ci=dl*ix+h*iy
if ci.Magnitude>1 then ci=ci.Unit end
az=ci.Magnitude
dF=ci:Dot(h)local moveDir=(ci.Magnitude>0.1)and ci.Unit or nil
local dJ=(n.Y>0.75)and aa.ClimbGroundSpeed or aa.ClimbSpeed
local hj=Vector3.zero
local hw=Vector3.zero
local bZ=false
if moveDir then
local fh=workspace:Raycast(root.Position,moveDir*aa.ClimbCornerDist,params)if fh and fh.Normal:Dot(n)<0.5 and fh.Normal.Y>-0.5 and not U.aI(fh.Instance)then
ak=fh.Normal
climbHeading=newHeading(n,fh.Normal,false,camLook)bZ=true
cj=0
end
end
local bn
if not bZ then
bn=workspace:Raycast(root.Position,-n*aa.ClimbReach,params)if bn and bn.Normal.Y<-0.5 then bn=nil end
end
if not bZ and U.dP(n,moveDir,bn,params)then
cj=0
U.bR(dt)return
end
if bn then
cj=0
ak=n:Lerp(bn.Normal,math.min(1,dt*10)).Unit
local gt=(bn.Normal.Y>0.75)and aa.ClimbGroundOffset or aa.ClimbOffset
if dance.E and dance.E.isPlaying("crawl")then gt+=aa.CrawlEmoteLift end
local err=(bn.Position+bn.Normal*gt-root.Position):Dot(bn.Normal)hw=bn.Normal*err
elseif not bZ then
cj+=dt
if cj>0.18 then
U.l()return
end
end
if bZ then
ci=ci-ak*ci:Dot(ak)if ci.Magnitude>0.01 then ci=ci.Unit*az end
end
aD.drive("climb",ci*dJ+hj)root.AssemblyAngularVelocity=Vector3.zero
local pos=root.Position
local target
if aa.CrawlEmoteUpright and dance.E and dance.E.isPlaying("crawl")then
target=CFrame.lookAt(pos,pos+climbHeading,ak)*CFrame.Angles(0,math.rad(aa.CrawlEmoteTurn),0)else
target=CFrame.lookAt(pos,pos-ak,climbHeading)end
root.CFrame=root.CFrame:Lerp(target,math.min(1,dt*14))root.CFrame+=hw*math.min(1,dt*20)end)end
function U.cj()if not U.f()then return end if ah or as or not aa.ClimbEnabled or not root or not humanoid or humanoid.Health<=0 then return end
if os.clock()-bp<aa.ClimbRegrabDelay then return end
if ac or os.clock()<au or humanoid.Sit then return end
local hs=humanoid:GetState()if hs==Enum.HumanoidStateType.Climbing or hs==Enum.HumanoidStateType.Swimming
or hs==Enum.HumanoidStateType.Seated or hs==Enum.HumanoidStateType.Dead then
return
end
local params=RaycastParams.new()params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={ad,aq}local hc={}local function hE(v)local f=Vector3.new(v.X,0,v.Z)if f.Magnitude>0.1 then table.insert(hc,f.Unit)end
end
hE(root.CFrame.LookVector)hE(humanoid.MoveDirection)hE(root.AssemblyLinearVelocity)hE(workspace.CurrentCamera.CFrame.LookVector)for _,d in ipairs(hc)do
local r=workspace:Raycast(root.Position,d*aa.ClimbGrabDistance,params)if r and math.abs(r.Normal.Y)<0.6 and not U.aI(r.Instance)then
U.bu(r)return
end
end
if aa.GroundCrawl and not ai and humanoid.FloorMaterial~=Enum.Material.Air then
local g=workspace:Raycast(root.Position,Vector3.new(0,-6,0),params)if g and g.Normal.Y>0.6 and not U.aI(g.Instance)then
U.bu(g)end
end
end
function U.cX(ag,hum)if not aa.SwingSteeringEnabled or not U.k or bw:GetFocusedTextBox()then return nil,0 end
if hum then
local ci=hum.MoveDirection
local aP=Vector3.new(ci.X,0,ci.Z)if aP.Magnitude>0.08 then
return aP.Unit,aa.SwingInputTurnRate*math.min(aP.Magnitude,1)end
end
if aa.SwingCameraSteering and ag then
local cR=ag.CFrame.LookVector
local aP=Vector3.new(cR.X,0,cR.Z)if aP.Magnitude>0.08 then return aP.Unit,aa.SwingCameraTurnRate end
end
return nil,0
end
function U.dj(velocity,ropeDirection,wish,dt,degreesPerSecond)if not wish or not degreesPerSecond or degreesPerSecond<=0 or dt<=0 then return velocity end
local fm=ropeDirection.Magnitude
if fm<0.001 then return velocity end
local normal=ropeDirection/fm
local aN=normal*velocity:Dot(normal)local aR=velocity-aN
local speed=aR.Magnitude
local he=wish-normal*wish:Dot(normal)if speed<0.05 or he.Magnitude<0.05 then return velocity end
local af=aR/speed
local target=he.Unit
local dot=math.clamp(af:Dot(target),-1,1)local hJ=normal:Dot(af:Cross(target))local angle=math.atan2(hJ,dot)if math.abs(angle)<0.00001 then return velocity end
local eG=math.rad(math.clamp(degreesPerSecond,0,360))*math.clamp(dt,0,0.05)local ht=math.clamp(angle,-eG,eG)local gl=af*math.cos(ht)+normal:Cross(af)*math.sin(ht)return aN+gl*speed
end
function U.bV()if not U.f()then return end if ai or not U.a or not root or not humanoid or humanoid.Health<=0 then return end
local cb=workspace.CurrentCamera
if not cb or humanoid.Sit then return end
local eV=U.cn(cb)local params=RaycastParams.new()params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={ad,aq}local result=workspace:Raycast(eV.Origin,eV.Direction*aa.MaxWebDistance,params)local target
if result then
target=result.Position
elseif aa.AllowAirWeb then
local d=eV.Direction
d=Vector3.new(d.X,math.max(d.Y,0.5),d.Z).Unit
target=root.Position+d*aa.AirWebDistance
else
return
end
if(target-root.Position).Magnitude<aa.MinWebDistance then return end
U.z()U.n()U.l()U.y()dance.stop()bu=U.da(target)lastSide=bu
if bu=="left"and aQ and leftHandAtt then
hand,webHandAtt=aQ,leftHandAtt
else
bu="right"hand,webHandAtt=ar,aj
end
ai=true U.aj=nil
diving=false
releaseEnd=0
bX+=1
local myToken=bX
cy=target
U.A()U.av(bJ,0.95,1.05)U.v(aa.FOVShootKick)anchor=Instance.new("Part")anchor.Name="WebAnchor"anchor.Anchored=true
anchor.CanCollide=false
anchor.CanQuery=false
anchor.CanTouch=false
anchor.Transparency=1
anchor.Size=Vector3.new(0.2,0.2,0.2)anchor.Position=hand.Position
anchor.Parent=aq
local tip=Instance.new("Attachment")tip.Name="WebTip"tip.Parent=anchor
webBeams=U.bf(webHandAtt,tip,anchor)
fx.muzzle(hand)local cY=hand.Position
local t0=os.clock()while true do
if bX~=myToken or not anchor then return end
local a=math.min((os.clock()-t0)/aa.WebShootTime,1)anchor.Position=cY:Lerp(target,a)if a>=1 then break end
ae.Heartbeat:Wait()end
if bX~=myToken then return end
U.p("webAttach")U.u(anchor,14)eK=os.clock()if aa.WebSplat and result and result.Normal then
U.bZ(anchor,target,result.Normal)end
cz=Instance.new("RopeConstraint")cz.Attachment0=aT
cz.Attachment1=tip
cz.Length=(target-root.Position).Magnitude+1
cz.Visible=false
cz.Enabled=false
cz.Parent=anchor
if aa.SwingFaceVelocity then
local driver=aD.drive("swing",root.AssemblyLinearVelocity)
if driver then
bH=Instance.new("BodyGyro")
bH.Name="HuybypassSwingGyro"
bH.P=90000
bH.D=1000
bH.MaxTorque=Vector3.new(1e6,1e6,1e6)
bH.CFrame=root.CFrame.Rotation
bH.Parent=driver.Parent
end
humanoid.AutoRotate=false
end
if animTrack then animTrack:Play(0.15)end
ab.start(myToken)local fY=humanoid.FloorMaterial~=Enum.Material.Air
if fY then
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)ae.Heartbeat:Wait()if bX~=myToken or not root then return end
else
local v=root.AssemblyLinearVelocity
local aN=root.Position-target
if aN.Magnitude>0.1 then
aN=aN.Unit
local bQ=v:Dot(aN)if bQ>0 then
local aR=v-aN*bQ
if aR.Magnitude>1 then
root.AssemblyLinearVelocity=aR.Unit*math.max(aR.Magnitude,v.Magnitude*aa.MomentumKeep)end
end
end
end
local dM=(target-root.Position).Unit
root.AssemblyLinearVelocity=root.AssemblyLinearVelocity+dM*aa.LaunchPull+Vector3.new(0,aa.LaunchLift,0)local v0=root.AssemblyLinearVelocity
local fI=math.clamp(1-Vector3.new(v0.X,0,v0.Z).Magnitude/aa.FirstSwingSpeed,0,1)if fI>0 then
local dk=Vector3.new(dM.X,0,dM.Z)if dk.Magnitude>0.01 then
dk=dk.Unit
root.AssemblyLinearVelocity=v0+dk*aa.FirstSwingForward*fI+Vector3.new(0,aa.FirstSwingLift*fI,0)end
end
local swingStarted=os.clock()
local swingWasAirborne=humanoid.FloorMaterial==Enum.Material.Air
local swingCamera=workspace.CurrentCamera
if swingCamera then U.swingCameraZoom=(swingCamera.CFrame.Position-swingCamera.Focus.Position).Magnitude end
bh=U.b(ae.Heartbeat,function(dt)if bX~=myToken or not ai or not U.a then return end
if not root or not root.Parent or not cz or not anchor or humanoid.Health<=0 then
U.o(false)return
end
local grounded=humanoid.FloorMaterial~=Enum.Material.Air
if not grounded then swingWasAirborne=true end
if grounded and (swingWasAirborne or os.clock()-swingStarted>0.45)then
U.o(false)U.swingCameraRecover()return
end
if not workspace.CurrentCamera then return end
dt=math.clamp(dt,0,0.05)local vel=aD.safeVelocity(root.AssemblyLinearVelocity,aa.SwingMaxSpeed)local aP=Vector3.new(vel.X,0,vel.Z)local cT=cy-root.Position
local dist=cT.Magnitude
local cl=(dist>0.1)and(cT/dist)or Vector3.new(0,1,0)local wish,turnRate=U.cX(workspace.CurrentCamera,humanoid)
if wish then
U.aj=U.aj and U.aj:Lerp(wish,1-math.exp(-14*dt))or wish
wish=U.aj.Magnitude>0.01 and U.aj.Unit or wish
else U.aj=nil end
vel=U.dj(vel,cl,wish,dt,turnRate)local aR=vel-cl*vel:Dot(cl)local gK
if aR.Magnitude>3 then
gK=aR.Unit
else
local cR=workspace.CurrentCamera.CFrame.LookVector
local lf=Vector3.new(cR.X,0,cR.Z)gK=(lf.Magnitude>0.01)and lf.Unit or root.CFrame.LookVector
end
local ff=1
if humanoid.FloorMaterial~=Enum.Material.Air then
ff=0
elseif vel.Y>0 then
ff=1-aa.SwingUpswingAssist
end
local v=vel+Vector3.new(0,-workspace.Gravity*ff*dt,0)local ha=v.Magnitude
local gR=1-math.clamp((ha-aa.SwingSoftCap)/math.max(aa.SwingMaxSpeed-aa.SwingSoftCap,1),0,1)v+=gK*aa.SwingBoost*gR*dt
local bQ=v:Dot(-cl)if dist>=cz.Length-0.5 and bQ>0 then
v+=cl*bQ
end
if dist>cz.Length then
v+=cl*math.min((dist-cz.Length)*10,aa.SwingMaxSpeed*0.5)end
local hU=v.Magnitude
if hU>aa.SwingMaxSpeed then
v=v.Unit*aa.SwingMaxSpeed
end
aD.drive("swing",v)cz.Length=math.max(aa.MinRopeLength,cz.Length-aa.ReelSpeed*dt)aP=Vector3.new(v.X,0,v.Z)if bH and aP.Magnitude>5 then
bH.CFrame=bH.CFrame:Lerp(CFrame.lookAt(Vector3.zero,aP),1-math.exp(-12*dt))end
end)end
function U.bq()if not U.f()then return end if as or not U.a or not root or not humanoid or humanoid.Health<=0 then return end
if os.clock()-dD<aa.PullCooldown then return end
if not(aQ and ar and leftHandAtt and aj)then return end
local target,result=U.cP(aa.PullMaxDistance,aa.PullMinDistance,false)if not target or not result then U.h("No clear pull target")return end
local normal=result.Normal
local aF=result.Instance:IsA("BasePart")and result.Instance or nil
local fy=aF and aF.CFrame:PointToObjectSpace(target)or nil
local eP=aF and aF.CFrame:VectorToObjectSpace(normal)or nil
U.y()dance.stop()U.z()dD=os.clock()U.l()U.o(false)U.A()releaseEnd=0
diving=false
as=true
aK+=1
local myToken=aK
hand,webHandAtt=ar,aj
humanoid.AutoRotate=false
U.av(bJ,0.9,1.0)U.v(aa.PullFOVKick)local eJ=Vector3.new(target.X-root.Position.X,0,target.Z-root.Position.Z)if eJ.Magnitude>0.01 then
root.CFrame=CFrame.lookAt(root.Position,root.Position+eJ.Unit)end
local cY=(aQ.Position+ar.Position)/2
local a=Instance.new("Part")a.Name="WebPullAnchor"a.Anchored=true
a.CanCollide=false
a.CanQuery=false
a.CanTouch=false
a.Transparency=1
a.Size=Vector3.new(0.2,0.2,0.2)a.Position=cY
a.Parent=aq
local tip=Instance.new("Attachment")tip.Parent=a
bz=a
pullBeams={}
for _,att in ipairs({aj,leftHandAtt})do
for _,beam in ipairs(U.bf(att,tip,a))do table.insert(pullBeams,beam)end
end
fx.muzzle(ar)fx.muzzle(aQ)local t0=os.clock()while true do
if aK~=myToken or not bz then return end
local p=math.min((os.clock()-t0)/aa.PullShootTime,1)a.Position=cY:Lerp(target,p)if p>=1 then break end
ae.Heartbeat:Wait()end
if aK~=myToken then return end
U.u(a,14)if aa.WebSplat then U.bZ(a,target,normal)end
if humanoid.FloorMaterial~=Enum.Material.Air then
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)ae.Heartbeat:Wait()if aK~=myToken or not root then return end
end
local gf=target+normal*math.max(aa.PullStopDistance,aa.CollisionRadius+0.5)local eu=aa.ClimbEnabled and math.abs(normal.Y)<0.6
local gP=os.clock()local fe=1/60
local bI=(gf-root.Position).Unit
while aK==myToken do
if not root or not humanoid or humanoid.Health<=0 then
U.n()return
end
if aF then
if not aF:IsDescendantOf(workspace)then U.n()return end
target=aF.CFrame:PointToWorldSpace(fy)normal=aF.CFrame:VectorToWorldSpace(eP)a.Position=target
gf=target+normal*math.max(aa.PullStopDistance,aa.CollisionRadius+0.5)end
local to=gf-root.Position
local dist=to.Magnitude
local el=os.clock()-gP
local ha=aa.PullSpeed*math.min(1,0.45+el*5)if dist<=math.max(1.6,ha*fe*1.3)or el>aa.PullMaxTime then break end
ha=math.min(ha,math.sqrt(math.max(0,2*220*dist)))bI=to.Unit
pullDirY=bI.Y
local safeVelocity,obstructed=U.bT(bI*ha,fe)if obstructed and dist>6 then U.n()return end
aD.drive("pull",safeVelocity)local aP=Vector3.new(bI.X,0,bI.Z)if aP.Magnitude>0.1 then
root.CFrame=CFrame.lookAt(root.Position,root.Position+aP.Unit)end
fe=ae.Heartbeat:Wait()end
if aK~=myToken then return end
local arrived=(gf-root.Position).Magnitude<=4.5
U.n()if not(root and root.Parent)then return end
if arrived and eu and U.aG()then
root.AssemblyLinearVelocity=Vector3.zero
U.bu({Normal=normal})elseif normal.Y>0.6 then
local aP=Vector3.new(bI.X,0,bI.Z)root.AssemblyLinearVelocity=aP*aa.PullSpeed*aa.PullExitSpeed*0.8+Vector3.new(0,aa.PullExitLift,0)else
root.AssemblyLinearVelocity=bI*aa.PullSpeed*aa.PullExitSpeed+Vector3.new(0,aa.PullExitLift,0)U.v(8)end
end
function U.dR(charge)if not root or not humanoid or humanoid.Health<=0 then return end
local launchSerial=U.z()lastBigJump=os.clock()U.l()U.o(false)U.A()releaseEnd=0
U.n()diving=charge>=aa.DiveMinCharge
local gi=1+charge*(aa.MaxChargeMultiplier-1)U.bc(Color3.fromRGB(255,199,127),0.35+charge*0.35)U.ap(root.Position,Vector3.yAxis,0.8+charge,false,Color3.fromRGB(255,199,127))U.v(8+30*charge)if charge>0.25 and humanoid.FloorMaterial~=Enum.Material.Air then
local gp=U.aM()U.ao(gp,12+charge*30)U.bK(gp,math.floor(10+charge*25))U.bO(gp,6+math.floor(charge*8),8+charge*14)end
if charge>0.1 then
U.u(root,math.floor(8+charge*20))end
local ag=workspace.CurrentCamera
local cR=ag and ag.CFrame.LookVector or root.CFrame.LookVector
local aP=Vector3.new(cR.X,0,cR.Z)if aP.Magnitude<0.01 then
local fr=root.CFrame.LookVector
aP=U.O(Vector3.new(fr.X,0,fr.Z),-Vector3.zAxis)end
aP=aP.Unit
local dN,ea,bL,launchToken=root,humanoid,U.e,bX
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)ae.Heartbeat:Wait()if not U.a or root~=dN or humanoid~=ea or U.e~=bL
or bX~=launchToken or ai or as or ah or os.clock()<au
or not U.bX(launchSerial,bL,dN,ea)then return end
root.CFrame=CFrame.lookAt(root.Position,root.Position+aP)local hO=aa.BigJumpForward*gi
root.AssemblyLinearVelocity=aP*hO+Vector3.new(0,aa.BigJumpUp+hO*aa.BigJumpArc,0)dance.E.launching=true
dance.E.launchAt=os.clock()end
function U.dM()if not U.f()then return end if ac or not U.a or not root or not humanoid or humanoid.Health<=0
or humanoid.Sit or root.Anchored or cm or not workspace.CurrentCamera then return end
if os.clock()-lastBigJump<aa.BigJumpCooldown then return end
U.o(false)U.n()U.A()U.l()dance.stop()releaseEnd=0
if not U.cW()then return end
U.z()ac=os.clock()chargeFull=false
al.Visible=true
if am then
am.Looped=aa.ChargeSoundLoop
am.TimePosition=0
am.PlaybackSpeed=1
am.Volume=aa.ChargeSoundVolume
am:Play()end
end
function U.cm()if not ac then return end
local charge=math.clamp((os.clock()-ac)/aa.ChargeTime,0,1)U.y("launch")U.dm()if not U.a or not humanoid or humanoid.Health<=0 or not root or root.Anchored then return end
U.av(bG,0.95+charge*0.1,1.0+charge*0.1)U.dR(charge)end
function U.dd()if not U.f()then return end if not U.a or not root or not humanoid or humanoid.Health<=0 then return end
local ag=workspace.CurrentCamera
if not ag or humanoid.Sit or(root.Anchored and not U.D)then return end
if os.clock()-lastDash<aa.DashCooldown then return end
if humanoid.FloorMaterial~=Enum.Material.Air and not ah then return end
U.z()lastDash=os.clock()U.y()dance.stop()U.n()U.l()U.o(false)releaseEnd=0
diving=false
local df=ag.CFrame.LookVector
if df.Y<-0.5 then
df=Vector3.new(df.X,-0.5,df.Z).Unit
end
ee=df
bf=os.clock()au=bf+aa.DashTime
U.ap(root.Position,df,1.3,false,fx.ICE)local ep=bf
local aP=Vector3.new(df.X,0,df.Z)if aP.Magnitude>0.01 then
root.CFrame=CFrame.lookAt(root.Position,root.Position+aP.Unit)end
humanoid.AutoRotate=false
U.av(cn,0.95,1.05)U.v(aa.DashFOVKick)U.ao(root.Position,16,CFrame.lookAt(Vector3.zero,df)*CFrame.Angles(0,math.rad(90),0))U.u(root,12)task.spawn(function()while os.clock()<au and bf==ep do
if not root or not humanoid or humanoid.Health<=0 then
aD.destroy("dash")return
end
local dZ=math.clamp((os.clock()-ep)/aa.DashTime,0,1)local dJ=aa.DashSpeed*(1-0.15*dZ*dZ)local safeVelocity,blocked=U.bT(ee*dJ,1/30)if blocked then
U.A()if humanoid and not U.m then humanoid.AutoRotate=true end
return
end
aD.drive("dash",safeVelocity)ae.PreSimulation:Wait()end
if bf==ep and root and humanoid then
aD.destroy("dash")root.AssemblyLinearVelocity=ee*aa.DashSpeed*aa.DashExitSpeed
if not ai then
humanoid.AutoRotate=true
end
end
end)end
U.b(ae.RenderStepped,function()if not ac then
if chargeSparks and chargeSparks.Rate>0 then
chargeSparks.Rate=0
end
return
end
local c=math.clamp((os.clock()-ac)/aa.ChargeTime,0,1)aL.Size=UDim2.fromScale(c,1)aL.BackgroundColor3=Color3.fromRGB(220,30,30):Lerp(Color3.fromRGB(255,215,0),c)if am and am.IsPlaying then
am.PlaybackSpeed=1+aa.ChargePitchRise*c
end
if chargeSparks then
chargeSparks.Rate=8+60*c
end
if c>=1 and not chargeFull then
chargeFull=true
U.p("chargeReady")U.v(6)if root and humanoid then
U.u(root,24)if humanoid.FloorMaterial~=Enum.Material.Air then
U.ao(U.aM(),18)end
end
end
end)local fM,fQ,WEB_T3=0.8,2.1,2.9
function U.bQ(p)p=p%1
if p<0.6 then
return 1-(p/0.6)*2,0
end
local t=(p-0.6)/0.4
return-1+2*(t*t*(3-2*t)),math.sin(math.pi*t)end
local function pulse(t,t0)if t<t0 then return 0 end
local d=t-t0
return math.exp(-d*12)*math.sin(d*45)end
function U.bk(mute)if not animator then return end
if U.carryActive and U.carryActive()and not ai and not ah and not as then mute=false end
if mute then
for _,tr in ipairs(animator:GetPlayingAnimationTracks())do
if tr~=animTrack and not dance.E.owns(tr)and tr~=ab.track and tr~=ab.fallback and mutedTracks[tr]==nil then
mutedTracks[tr]=tr.WeightTarget
tr:AdjustWeight(0,0.15)end
end
else
for tr,weight in pairs(mutedTracks)do
if tr.IsPlaying then tr:AdjustWeight(weight,0.2)end
end
mutedTracks={}end
end
function U.K()return U.f()and U.a and humanoid~=nil and root~=nil and humanoid.Health>0
and humanoid.FloorMaterial~=Enum.Material.Air and not humanoid.Sit
and humanoid.WalkSpeed>0 and not root.Anchored
and not ah and not ac and not ai and not as
and os.clock()>=au and humanoid.MoveDirection.Magnitude>0.08
end
function U.an()if U.bN then U.bN:Destroy()U.bN=nil end
end
function U.cV()if ah then return end
if not U.aY then
U.aY=true
if not U.ah and U.aW~="emote"then dance.stop()end
U.an()U.bk(false)fidgetMuted=false
U.aC()aV,dashRoll=0,0
for _,j in ipairs(bm)do if j.joint.Parent then U.aT(j)end end
end
for name,track in pairs(dance.E.tracks)do
if name~="emote"and track.IsPlaying then track:Stop(0)end
end
if animTrack and animTrack.IsPlaying then animTrack:Stop(0)end
ab.stop()dance.E.active,dance.E.launching=nil,false
fidget,crouchPose,releaseEnd,landUntil,diving=nil,false,0,0,false
bM,nextFidget,idlePlayed=os.clock(),0,false
end
function U.cd(request,generation,ownerChar,name)return U.d and U.a and U.U==request
and U.e==generation and ad==ownerChar and U.k
and not bw:GetFocusedTextBox()and(name=="emote"or not U.K())and humanoid~=nil and humanoid.Health>0 and not humanoid.Sit
and not ah and not ai and not as and not ac
and os.clock()>=au
end
function U.aF()local aO=U.aq
U.aq=nil
if aO then aO.host:Destroy()end
end
function U.df()if not aa.EmoteWebEnabled or not U.a or not root or not humanoid
or humanoid.Health<=0 or humanoid.Sit or not aj
or not aj.Parent or not dance.E.isPlaying("dance")or ah or ai or as or ac or os.clock()<au or U.K()then
return false
end
U.aF()local origin=aj.WorldPosition
local eA=root.Position+Vector3.yAxis*3
local bC=workspace:Raycast(eA,Vector3.yAxis*aa.EmoteWebRange,U.ab())local target=bC and bC.Position or eA+Vector3.yAxis*aa.EmoteWebAirHeight
local host=Instance.new("Part")host.Name="NDanceOverheadWeb"host.Anchored=true
host.CanCollide,host.CanTouch,host.CanQuery=false,false,false
host.CastShadow,host.Transparency=false,1
host.Size=Vector3.one*0.1
host.Position=origin
host.Parent=aq
local tip=Instance.new("Attachment")tip.Parent=host
local beams=U.bf(aj,tip,host)
local aO={host=host,beams=beams,hand=aj,born=os.clock(),generation=U.e,start=origin,target=target,track=dance.E.tracks.dance,hitPart=bC and bC.Instance:IsA("BasePart")and bC.Instance or nil,hitNormal=bC and bC.Normal or nil,}if aO.hitPart then
aO.localTarget=aO.hitPart.CFrame:PointToObjectSpace(target)aO.localNormal=aO.hitPart.CFrame:VectorToObjectSpace(bC.Normal)end
U.aq=aO
fx.muzzle(ar)U.p("emoteWeb")return true
end
function U.ck()local aO=U.aq
if not aO then return end
if not U.a or aO.generation~=U.e or not aO.host.Parent
or not aO.hand.Parent or not humanoid or humanoid.Health<=0 or humanoid.Sit
or not U.k or bw:GetFocusedTextBox()or U.K()or not aO.track.IsPlaying or dance.E.tracks.dance~=aO.track
or ah or ai or as or ac or os.clock()<au
or(aO.hitPart and not aO.hitPart.Parent)then
U.aF()return
end
if aO.hitPart then
aO.target=aO.hitPart.CFrame:PointToWorldSpace(aO.localTarget)aO.hitNormal=aO.hitPart.CFrame:VectorToWorldSpace(aO.localNormal)end
local gG=os.clock()-aO.born
local fK=math.clamp(gG/math.max(0.03,aa.EmoteWebShootTime),0,1)aO.host.Position=aO.start:Lerp(aO.target,1-(1-fK)^2)
if fK>=1 and not aO.arrived then
aO.arrived=true
if aO.hitNormal then fx.impact(aO.target,aO.hitNormal)U.p("emoteImpact")end
end
end
function U.cH()if not root or not ar or not aj or U.K()then return end
U.an()local df=(root.CFrame.LookVector+Vector3.new(0,0.3,0)).Unit
local a=Instance.new("Part")a.Name="WebCheckAnchor"U.bN=a
a.Anchored=true
a.CanCollide=false
a.CanQuery=false
a.CanTouch=false
a.Transparency=1
a.Size=Vector3.new(0.2,0.2,0.2)a.Position=ar.Position
a.Parent=aq
local tip=Instance.new("Attachment")tip.Parent=a
local hM=U.bf(aj,tip,a)
fx.muzzle(ar)aA:Create(a,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=ar.Position+df*22}):Play()task.delay(0.1,function()if a.Parent then U.u(a,8)end
end)U.av(bJ,1.05,1.15)task.spawn(function()local t0=os.clock()while a.Parent do
local t=(os.clock()-t0)/0.6
if t>=1 then break end
local gR=math.max(0,(t-0.25)/0.75)for _,beam in ipairs(hM)do beam.Transparency=NumberSequence.new(0.08+0.92*gR)end
ae.Heartbeat:Wait()end
a:Destroy()end)end
 
function U.emoteBoombox()
local containers={ad,player:FindFirstChildOfClass("Backpack")}
for _,container in ipairs(containers)do
for _,tool in ipairs(container:GetChildren())do
if tool:IsA("Tool")then
local name=tool.Name:lower():gsub("[^%w]","")
if name=="boombox"or name=="boomboxv3"then return tool end
end
end
end
return nil
end
function U.emoteBoomboxAdapter(tool)
 
local selected,score=nil,0
for _,item in ipairs(tool:GetDescendants())do
if item:IsA("RemoteEvent")or item:IsA("RemoteFunction")then
local name=item.Name:lower():gsub("[^%w]","")
local rank=(name=="remote"and 30)or(name=="remoteevent"and 20)or(name=="playsong"and 40)or(name=="play"and 10)or 0
if rank>score then selected=item score=rank end
end
end
if selected then
local name=selected.Name:lower():gsub("[^%w]","")
if name=="play"then return {remote=selected,mode="id",label="tool/play"}end
if name=="playsong"and selected:IsA("RemoteFunction")then return {remote=selected,mode="status",label="tool/PlaySong"}end
return {remote=selected,mode="classic",label="tool/"..selected.Name}
end
local events=cV:FindFirstChild("Events")
local song=events and events:FindFirstChild("PlaySong")
if song and song:IsA("RemoteFunction")then return {remote=song,mode="status",label="Events/PlaySong"}end
local main=cV:FindFirstChild("MainEvent")
if main and main:IsA("RemoteEvent")then return {remote=main,mode="main",label="MainEvent"}end
return nil
end
function U.emoteBoomboxSend(state,stopping)
local route=state.route
if not route or not route.remote.Parent then return end
local args
if route.mode=="status"then args=stopping and {"_Stop"}or{"_Play",tonumber(state.audioId)}
elseif route.mode=="id"then args={stopping and 0 or tonumber(state.audioId)}
elseif route.mode=="classic"then args={"PlaySong",stopping and "0"or state.audioId}
else args={"Boombox",stopping and "0"or state.audioId}end
if route.remote:IsA("RemoteFunction")then
if stopping then
 
task.spawn(function()
if U.emoteAudio and U.emoteAudio~=state then return end
pcall(function()route.remote:InvokeServer(table.unpack(args))end)
end)
else route.remote:InvokeServer(table.unpack(args))end
else route.remote:FireServer(table.unpack(args))end
end
function U.emoteBoomboxSounds(state)
local sounds,seen={},{}
for _,container in ipairs({state.tool,state.character})do
if container and container.Parent then
for _,item in ipairs(container:GetDescendants())do
if item:IsA("Sound")and not seen[item]and item.IsPlaying
and (container==state.tool or item.Name=="BOOMBOXSOUND")
and tostring(item.SoundId):match("%d+")==state.audioId then
sounds[#sounds+1]=item seen[item]=true
end
end
end
end
return sounds
end
function U.emoteBoomboxStopRequest(state,onlyIfPlaying)
local matching=U.emoteBoomboxSounds(state)
if onlyIfPlaying and #matching==0 then return end
if state.sent then pcall(U.emoteBoomboxSend,state,true)end
for _,sound in ipairs(matching)do sound:Stop()end
end
function U.emoteAudioStop()
U.emoteAudioToken=(U.emoteAudioToken or 0)+1
local token=U.emoteAudioToken
local state=U.emoteAudio
U.emoteAudio=nil
if not state then return end
for _,connection in ipairs(state.connections)do connection:Disconnect()end
if state.sent then
U.emoteBoomboxStopRequest(state,false)
 
for _,delay in ipairs({0.25,0.75,1.5})do
task.delay(delay,function()
if U.emoteAudioToken==token and not U.emoteAudio and player.Character==state.character then
U.emoteBoomboxStopRequest(state,true)
end
end)
end
end
if U.V then U.V:Destroy()U.V=nil end
 
if state.equipped and state.tool.Parent==state.character and player.Character==state.character then
local bag=player:FindFirstChildOfClass("Backpack")
if bag then
state.tool.Parent=bag
if state.previous and state.previous.Parent==bag and state.humanoid.Parent and state.humanoid.Health>0
and not state.character:FindFirstChildOfClass("Tool")then
pcall(function()state.humanoid:EquipTool(state.previous)end)
end
end
end
end
function U.emoteAudioStart(track)
U.emoteAudioStop()
local state={character=ad,humanoid=humanoid,generation=U.e,request=U.U,connections={},audioId=tostring(aa.EmoteSoundId):match("%d+")}
U.emoteAudio=state
local function active()
return U.emoteAudio==state and U.d and U.a and U.ah and U.e==state.generation and U.U==state.request
and ad==state.character and player.Character==state.character and state.humanoid.Parent and state.humanoid.Health>0
end
state.connections[#state.connections+1]=track.Stopped:Connect(function()
if U.emoteAudio==state then dance.stop()end
end)
state.tool=U.emoteBoombox()
if not state.tool then
U.V=U.R("BalenciEmote",aa.EmoteSoundId,0.7)U.V.Looped=true U.V:Play()
return
end
 
if not state.audioId then U.h("M: the emote audio ID is invalid.")return end
state.connections[#state.connections+1]=ae.Heartbeat:Connect(function()
if not active()then
if U.emoteAudio==state then U.emoteAudioStop()end
return
end
local bag=player:FindFirstChildOfClass("Backpack")
if state.tool.Parent~=state.character and state.tool.Parent~=bag then dance.stop()end
end)
task.spawn(function()
local ok,err=pcall(function()
if not active()then return end
if state.tool.Parent~=state.character then
local bag=player:FindFirstChildOfClass("Backpack")
if not bag or state.tool.Parent~=bag then return end
state.previous=state.character:FindFirstChildOfClass("Tool")
state.equipped=true
state.humanoid:EquipTool(state.tool)
 
task.wait(0.15)
end
if not active()or state.tool.Parent~=state.character then return end
for attempt=1,10 do
if not active()or state.tool.Parent~=state.character then return end
state.route=U.emoteBoomboxAdapter(state.tool)
if state.route then break end
task.wait(0.2)
end
if not active()then return end
if not state.route then
local found={}
for _,item in ipairs(state.tool:GetDescendants())do
if item:IsA("RemoteEvent")or item:IsA("RemoteFunction")then found[#found+1]=item.ClassName..":"..item.Name end
end
local details=#found>0 and table.concat(found,", ")or"no audio remotes found"
U.h("M: "..state.tool.Name.." detected; "..details)
warn("[HUYBYPASS] "..state.tool.Name..": "..details)
return
end
state.remote=state.route.remote
U.h("M: trying "..state.tool.Name.." via "..state.route.label)
state.sent=true
U.emoteBoomboxSend(state,false)
if not active()and not U.emoteAudio then U.emoteBoomboxStopRequest(state,false)return end
task.delay(3,function()
if active()then
if #U.emoteBoomboxSounds(state)>0 then
U.h("M: boombox audio playing")
else U.h("M: "..state.route.label.." sent; audio not confirmed. The game may reject this audio ID.")end
end
end)
end)
if not ok and U.emoteAudio==state then
U.emoteAudioStop()
U.h("M: boombox could not start. Normal audio was kept muted.")
if aa.Debug then warn(tostring(err))end
end
end)
end
function dance.isPlaying()return dance.E.isPlaying("dance")or dance.E.isPlaying("emote")or dance.E.isPlaying("goofy")end
function dance.stop()U.ah,U.aW,U.cg=false,nil,nil
U.emoteAudioStop()
U.U=(U.U or 0)+1
dance.busy=false
U.aF()dance.E.stop("dance")dance.E.stop("emote")dance.E.stop("goofy")if U.Q then U.Q:Destroy()U.Q=nil end
if U.V then U.V:Destroy()U.V=nil end
end
function dance.toggleName(name,label)if not U.f()then return end if not U.a or not humanoid or humanoid.Health<=0 or not root then return end
if dance.E.isPlaying(name)or(name=="emote"and U.ah)then dance.stop()return end
if dance.busy then dance.stop()return end
if not U.k or bw:GetFocusedTextBox()or(name~="emote"and U.K())or humanoid.Sit
or ah or ai or as or ac or os.clock()<au then return end
dance.stop()local request,generation,ownerChar=U.U,U.e,ad
dance.busy=true
U.aW=name
local t0=os.clock()while U.cd(request,generation,ownerChar,name)and(not dance.E.tracks[name]or dance.E.tracks[name].Length==0)and os.clock()-t0<3 do task.wait(0.05)end
if U.U~=request then return end
dance.busy=false
U.aW=nil
if not U.cd(request,generation,ownerChar,name)then return end
local track=dance.E.tracks[name]if not track or track.Length==0 then
U.h(label.." animation not loaded. No hanging web is left behind.")return
end
crouchPose,fidget=false,nil
track.Looped=dance.E.defs[name].loop
track:Play(0.15)if name=="dance"then U.df()end
if name=="emote"then
U.ah=true
U.emoteAudioStart(track)end
if name=="goofy"then
local count=#aa.GoofySounds
local bi=U.cD
local bU=bi and bi>=1 and bi<=count and count>1
local fp=math.random(1,bU and count-1 or count)if bU and fp>=bi then fp+=1 end
U.cD=fp
local hu=aa.GoofySounds[fp]U.Q=U.R("GoofyEmote",hu.id,0.55)U.Q.PlaybackSpeed=hu.speed
U.Q.Looped=true
U.Q:Play()end
end
function dance.toggle()dance.toggleName("dance","Dance")end
 
function U.glideHoldReady(now)
return U.Z and U.glideHeldAt~=nil and now-U.glideHeldAt>=aa.GlideHoldDelay
end
function U.L()U.al=false
if not U.Z then U.glideHeldAt=nil end
dance.E.stop("webglide")if U.bE then U.bE:Destroy()U.bE=nil end
U.aP=nil
end
function U.dN(dt)if not U.f()then U.L()return end local valid=U.a and U.k and U.glideHoldReady(os.clock()) and not bw:GetFocusedTextBox()and humanoid and humanoid.Health>0 and not humanoid.Sit and root and not root.Anchored
and humanoid.FloorMaterial==Enum.Material.Air and not ah and not ai
and not as and not ac and os.clock()>=au and not U.aG()local hs=humanoid and humanoid:GetState()valid=valid and(hs==Enum.HumanoidStateType.Freefall or hs==Enum.HumanoidStateType.Jumping)if not valid then if U.al then U.L()end return end
if not U.al then
dance.stop()releaseEnd,diving=0,false
dance.E.launching=false
U.al=true
local by=Instance.new("Part")by.Name="HuybypassWebWings"by.Anchored,by.CanCollide,by.CanTouch,by.CanQuery=true,false,false,false
by.Transparency,by.Size=1,Vector3.new(0.1,0.1,0.1)by.Parent=aq
U.bE,U.aP=by,{}for _,side in ipairs({-1,1})do
local cD={side=side,rows={}}table.insert(U.aP,cD)for row=0,8 do
cD.rows[row]={}for dj=0,6 do
local a=Instance.new("Attachment")a.Parent=by
cD.rows[row][dj]=a
end
end
local function strand(a,b,width,alpha)local beam=Instance.new("Beam")beam.Attachment0,beam.Attachment1=a,b
beam.Width0,beam.Width1=width,width
beam.FaceCamera=true
beam.Color=ColorSequence.new(Color3.fromRGB(235,245,255))beam.Transparency=NumberSequence.new(alpha)beam.LightInfluence=0.5
beam.Parent=by
end
for row=0,8 do
for dj=0,6 do
if dj<6 then strand(cD.rows[row][dj],cD.rows[row][dj+1],0.022,0.12)end
if row<8 then strand(cD.rows[row][dj],cD.rows[row+1][dj],0.022,0.12)end
end
strand(cD.rows[row][0],cD.rows[row][6],0.18,0.7)end
end
end
local ag=workspace.CurrentCamera
local af=humanoid.MoveDirection
if af.Magnitude<0.1 then af=ag and ag.CFrame.LookVector or root.CFrame.LookVector end
af=Vector3.new(af.X,0,af.Z)if af.Magnitude>0.01 then
af=af.Unit
local v=root.AssemblyLinearVelocity
local target=af*aa.GlideSpeed+Vector3.new(0,-aa.GlideSink,0)root.AssemblyLinearVelocity=v:Lerp(target,1-math.exp(-5*math.min(dt,0.05)))end
end
U.b(ae.Heartbeat,U.dN)U.b(ae.RenderStepped,function()if U.V and not U.ah and not dance.E.isPlaying("emote")then U.V:Destroy()U.V=nil end
if U.Q and not dance.E.isPlaying("goofy")then U.Q:Destroy()U.Q=nil end
if not U.al or not U.aP or not ad then return end
local bV=ad:FindFirstChild("UpperTorso")or ad:FindFirstChild("Torso")local fi=ad:FindFirstChild("LowerTorso")or bV
if not bV or not fi then return end
for _,cD in ipairs(U.aP)do
local gx=cD.side<0 and aQ or ar
if gx then
local fV=bV.CFrame:PointToWorldSpace(Vector3.new(cD.side*bV.Size.X*0.45,bV.Size.Y*0.4,0.15))local hV=fi.CFrame:PointToWorldSpace(Vector3.new(cD.side*fi.Size.X*0.45,-fi.Size.Y*0.4,0.15))for row=0,8 do
local t=row/8
local bP=gx.Position:Lerp(hV,t)bP+=bV.CFrame.RightVector*cD.side*(-0.18*math.sin(t*math.pi))for dj=0,6 do cD.rows[row][dj].WorldPosition=fV:Lerp(bP,dj/6)end
end
end
end
end)function U.cA(duration)if cm or not humanoid or U.D then return end
cm=true
local hum=humanoid
local hi=hum.WalkSpeed
hum.WalkSpeed=0
task.delay(duration,function()if hum and hum.Parent and hum==humanoid then
if U.D and U.D.humanoid==hum then
U.D.walk=hi
else
hum.WalkSpeed=hi
end
end
if hum==humanoid then cm=false end
end)end
function U.dw()if not animator then return end
for _,tr in ipairs(animator:GetPlayingAnimationTracks())do
local eZ=tr.Animation
if eZ and(eZ.Name=="JumpAnim"or eZ.Name=="FallAnim")then
tr:Stop(0)end
end
end
function U.dQ()local cT=cy-root.Position
if cT.Magnitude<0.1 then return CFrame.new()end
local l=root.CFrame:VectorToObjectSpace(cT.Unit)local up=Vector3.new(0,1,0)local b=up*(1-aa.SwingTiltAmount)+l*aa.SwingTiltAmount
if b.Magnitude<0.01 then return CFrame.new()end
b=b.Unit
local axis=up:Cross(b)if axis.Magnitude<1e-4 then return CFrame.new()end
local hH=math.min(math.acos(math.clamp(up:Dot(b),-1,1)),math.rad(aa.MaxSwingTilt))return CFrame.fromAxisAngle(axis.Unit,hH)end
function U.aT(j)if j.applied and j.joint.Transform==j.applied then
j.joint.Transform=j.native or CFrame.new()end
j.applied,j.native,j.offset=nil,nil,CFrame.new()end
U.b(ae.PreAnimation,function()for _,j in ipairs(bm)do
if j.joint.Parent and j.applied then
if j.joint.Transform==j.applied then j.joint.Transform=j.native end
j.applied=nil
end
end
end)U.b(ae.PreSimulation,function()if not U.f()then return end
for _,j in ipairs(bm)do
if j.joint.Parent then
local native=j.joint.Transform
j.native=native
j.applied=(j.offset or CFrame.new())*native
j.joint.Transform=j.applied
end
end
end)U.b(ae.PostSimulation,function()if not U.f()then return end if not U.a or not root or not root.Parent or not humanoid
or humanoid.Health<=0 or humanoid.Sit then return end
local aY=aa.BigJumpForward*aa.MaxChargeMultiplier
local up=aa.BigJumpUp+aY*aa.BigJumpArc
local limit=math.max(200,math.sqrt(aY*aY+up*up)*1.15)if ai then limit=aa.SwingMaxSpeed
elseif as then limit=aa.PullSpeed
elseif os.clock()<au then limit=aa.DashSpeed end
local v=root.AssemblyLinearVelocity
local fT=aD.safeVelocity(v,limit)if v~=fT then root.AssemblyLinearVelocity=fT end
local spin=root.AssemblyAngularVelocity
local eC=aD.safeVelocity(spin,35)if spin~=eC then root.AssemblyAngularVelocity=eC end
end)U.b(ae.RenderStepped,function(dt)if not U.f()then return end if not U.a or not ad or not humanoid or not root or not root.Parent then return end
dt=math.clamp(dt,0,0.05)local now=os.clock()local hs=humanoid:GetState()local blocked=humanoid.Health<=0
or hs==Enum.HumanoidStateType.Climbing
or hs==Enum.HumanoidStateType.Swimming
or hs==Enum.HumanoidStateType.Seated
or hs==Enum.HumanoidStateType.Dead
or humanoid.Sit
local air=(not blocked)and humanoid.FloorMaterial==Enum.Material.Air
local vel=root.AssemblyLinearVelocity
local speed=vel.Magnitude
if aa.ClimbEnabled and not ah and not ac and not blocked and U.aG()and now-U.bs>=0.075 then
U.bs=now
U.cj()end
local dc=Vector3.new(vel.X,0,vel.Z).Magnitude
local walking=U.K()if walking then
U.cV()else
U.aY=false
end
if ai and ab.track and not ab.track.IsPlaying then
ab.track:Play(0.1)end
local dR=U.al or blocked
or(walking and not U.ah and U.aW~="emote")or ah or ai or as or ac or now<au
if(dance.isPlaying()or dance.busy or U.ah)and dR then
dance.stop()end
if U.ah then
local track=dance.E.tracks.emote
if track then
if not track.IsPlaying then
track:Play(0.1)if track.Length>0 then track.TimePosition=(U.cg or 0)%track.Length end
end
U.cg=track.TimePosition
end
end
if crouchPose and(blocked or air or ah or ai or as or ac
or humanoid.MoveDirection.Magnitude>0.1 or dc>4)then
crouchPose=false
end
local hC=(not air)and(not blocked)and(not ac)and(not ah)and(not crouchPose)and not dance.isPlaying()and dc<1.5 and humanoid.MoveDirection.Magnitude<0.1
if not hC then
bM=now
fidget=nil
nextFidget=0
idlePlayed=false
elseif di then
if fidget and now>=dV then
fidget=nil
nextFidget=now+aa.IdleFidgetPause
elseif(not fidget)and(aa.IdleRepeat or not idlePlayed)and(now-bM)>=aa.IdleStanceDelay and now>=nextFidget then
local hk=math.random(#cq)if hk==lastFidget then hk=hk%#cq+1 end
lastFidget=hk
fidget=cq[hk]idlePlayed=true
dg=now
dV=now+((fidget=="fidget_webcheck")and aa.WebCheckTime or aa.IdleFidgetTime)dz={}if aa.Debug then print("[HUYBYPASS] idle animation started:",fidget)end
end
end
if blocked or U.zipAttack or U.gunOrbit or U.gunPurchase or U.gunBodyFollow or U.attackRecovery or U.voidHide or U.bringState then
dd=false
ev=root.Position.Y lastVelY=0
else
if air then
if not dd then ev=root.Position.Y end
ev=math.max(ev,root.Position.Y)lastVelY=vel.Y
elseif dd then
local gw=ev-root.Position.Y
diving=false
releaseEnd=0
if gw>=aa.HardLandHeight and-lastVelY>=aa.HardLandMinSpeed then
landKind="hard"landUntil=now+aa.HardLandTime
U.cA(aa.HardLandStun)if aa.ShakeStrength>0 then
shakeEnd=now+aa.ShakeTime
end
local gp=U.aM()U.ao(gp,50)U.bK(gp,35)U.bO(gp,12,16)U.v(-6)U.bP(1,0.75,0.85)elseif gw>=aa.SoftLandHeight then
landKind="soft"landUntil=now+aa.SoftLandTime
local gp=U.aM()U.ao(gp,14)U.bK(gp,10)U.bP(0.6,1.0,1.15)end
end
dd=air
end
if ah or as then
ev=root.Position.Y
end
local state="idle"if blocked then
state="idle"elseif U.zipAttack or U.gunOrbit or U.gunBodyFollow or U.attackRecovery then
state="idle"elseif ac then
state="charge"elseif now<au then
state="dash"elseif as then
state="zip"elseif U.al then
state="webglide"elseif now<releaseEnd and air
and not(now-aI>=aa.MinimumTrickTime
and diving=="swing"and aa.SwingReleaseDive and vel.Y<=-aa.SwingDiveMinFall)then
state="release"elseif ah then
state="climb"elseif ai then
state="swing"elseif air then
if diving==true or(diving=="swing"and aa.SwingReleaseDive and vel.Y<=-aa.SwingDiveMinFall)then
state="dive"elseif vel.Y>4 then
state="jump"elseif dc>55 and vel.Y>-45 then
state="glide"else
state="fall"end
elseif now<landUntil then
state=(landKind=="hard")and"land_hard"or"land_soft"elseif crouchPose then
state="crouch"elseif di and fidget then
state=fidget
end
if walking then state="idle"end
if dance.isPlaying()then
state="idle"end
local cx=dance.E.update(state,air,now)if state=="climb"then
local ei=dance.E.tracks.crawl
if ei and ei.IsPlaying then
ei:AdjustSpeed(az>0.05 and 1 or 0)end
end
if air then
U.dw()end
local ew=string.sub(state,1,7)=="fidget_"or state=="climb"or state=="crouch"if ew and not fidgetMuted then
fidgetMuted=true
U.bk(true)elseif not ew and fidgetMuted then
fidgetMuted=false
U.bk(false)end
if state=="climb"or state=="crouch"then
U.bk(true)end
local k=1-math.exp(-hq[state]*dt)local pose=cg[state]if state=="release"then
pose=cg[(dA[aG]or dA.frontflip).pose]end
local eI=math.clamp(speed/aa.FOVMaxSpeed,0,1)local aJ
local ed=0
local dB=CFrame.new()local ft=now-dg
if cx then
pose=cg.idle
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))elseif state=="swing"and not animTrack and not ab.track then
dB=U.dQ()ay=ay:Lerp(dB,k)local l=root.CFrame:VectorToObjectSpace((cy-root.Position).Unit)local lb=ay:VectorToObjectSpace(l)local fu=math.atan2(lb.Y,math.sqrt(lb.X^2+lb.Z^2))local gc=math.deg(math.clamp(math.rad(90)+fu,math.rad(60),math.rad(175)))local cI=(bu=="left")local gJ=cI and-1 or 1
local cQ=cI and"Left"or"Right"local bS=cI and"Right"or"Left"local ph=now*(4+eI*5)local s=math.sin(ph)aJ={[cQ.."Shoulder"]=Vector3.new(gc,0,6*gJ),[bS.."Shoulder"]=Vector3.new(gc-4,0,-6*gJ),[cQ.."Elbow"]=Vector3.new(8,0,0),[bS.."Elbow"]=Vector3.new(14,0,0),[cQ.."Hip"]=Vector3.new(35+s*12,0,0),[bS.."Hip"]=Vector3.new(-25-s*12,0,0),[cQ.."Knee"]=Vector3.new(-20-math.max(0,s)*25,0,0),[bS.."Knee"]=Vector3.new(-45-math.max(0,-s)*25,0,0),}elseif state=="climb"then
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))local gr=(dF<-0.1)and-1 or 1
aZ+=dt*az*aa.ClimbAnimSpeed*gr
local a=az
local tw=aa.ClimbTorsoTwist
local gZ,lRA=U.bQ(aZ)local gY,lLA=U.bQ(aZ+0.5)gZ,lRA,gY,lLA=gZ*a,lRA*a,gY*a,lLA*a
local bV=math.cos(aZ*math.pi*2)*a*tw
local hv=math.sin(aZ*math.pi*4)*a*tw
local ck=math.sin(now*2.2)ed=0.08*hv
aJ={RightShoulder=Vector3.new(125+28*gZ,0,32+8*lRA),LeftShoulder=Vector3.new(125+28*gY,0,-(32+8*lLA)),RightElbow=Vector3.new(15+15*(1-gZ)+25*lRA,0,0),LeftElbow=Vector3.new(15+15*(1-gY)+25*lLA,0,0),RightHip=Vector3.new(100+20*gY,0,38+6*lLA),LeftHip=Vector3.new(100+20*gZ,0,-(38+6*lRA)),RightKnee=Vector3.new(-(100+20*gY)+25-40*lLA,0,0),LeftKnee=Vector3.new(-(100+20*gZ)+25-40*lRA,0,0),Waist=Vector3.new(-5+hv*4+ck*1.2,11*bV,-7*bV),Root=Vector3.new(-8,-6*bV,3*bV),Neck=Vector3.new(30,-5*bV,0),}elseif state=="crouch"then
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))local cI=(aa.CrouchHand=="left")local gJ=cI and-1 or 1
local cQ=cI and"Left"or"Right"local bS=cI and"Right"or"Left"local ck=math.sin(now*1.8)ed=ck*0.03
aJ={[cQ.."Shoulder"]=Vector3.new(aa.CrouchHandAngle+ck*1.2,0,10*gJ),[cQ.."Elbow"]=Vector3.new(6,0,0),[bS.."Shoulder"]=Vector3.new(-38+ck*1.5,0,-26*gJ),[bS.."Elbow"]=Vector3.new(22,0,0),[cQ.."Hip"]=Vector3.new(104,0,12*gJ),[cQ.."Knee"]=Vector3.new(-118,0,0),[bS.."Hip"]=Vector3.new(-8,0,-14*gJ),[bS.."Knee"]=Vector3.new(-88,0,0),Waist=Vector3.new(-24+ck*1.2,0,0),Root=Vector3.new(-34,0,0),Neck=Vector3.new(40,0,0),}elseif state=="dive"and diving=="swing"then
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))local fall=math.clamp(-vel.Y/70,0,1)aJ={Root=Vector3.new(-(35+50*fall),0,0),RightShoulder=Vector3.new(172,0,8),LeftShoulder=Vector3.new(172,0,-8),}elseif state=="fidget_webcheck"then
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))if ft>=fM and not dz[1]then
dz[1]=true
if aa.Debug then print("[HUYBYPASS] shooter check 1 (no web)")end
if ar then U.u(ar,6)end
end
if ft>=fQ and not dz[2]then
dz[2]=true
if aa.Debug then print("[HUYBYPASS] shooter check 2 (no web)")end
if ar then U.u(ar,6)end
end
if ft>=WEB_T3 and not dz[3]then
dz[3]=true
if aa.Debug then print("[HUYBYPASS] shooter check 3 (web!)")end
U.cH()end
local gI=pulse(ft,fM)+pulse(ft,fQ)local hK=pulse(ft,WEB_T3)local ey=(ft>1.1 and ft<2.0)local gA=ft>3.7
local fX=-22
if ft>WEB_T3 then fX=6 end
if ft>3.5 then fX=-12 end
aJ={RightShoulder=Vector3.new((gA and 40 or 75)+gI*4-hK*10,0,-8),RightElbow=Vector3.new((gA and 60 or 105)+gI*6-hK*8,aa.WebCheckPalmTwist,0),RightWrist=Vector3.new(30*gI+45*hK,0,0),Neck=Vector3.new(fX,ey and math.sin((ft-1.1)*7)*12 or 0,ey and 10 or 0),}elseif state=="fidget_scratch"then
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))local w=math.sin(ft*16)aJ={RightShoulder=Vector3.new(125+w*4,0,22),RightElbow=Vector3.new(125+w*14,0,0),Neck=Vector3.new(0,0,8+w*1.5),Waist=Vector3.new(-3,0,0),}elseif state=="fidget_stretch"then
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))aJ={Waist=Vector3.new(10+math.sin(ft*2.5)*3,0,0),Neck=Vector3.new(15,0,0),}elseif state=="fidget_look"then
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))aJ={Neck=Vector3.new(0,math.sin(ft*1.4)*50,0),}else
if state=="swing"then pose=cg.idle end
ay=ay:Lerp(CFrame.new(),1-math.exp(-12*dt))end
for _,name in ipairs(aB)do
local target=aJ and aJ[name]if not target then
local t=pose[name]target=t and Vector3.new(t[1],t[2],t[3])or Vector3.zero
end
current[name]=current[name]:Lerp(target,k)end
local eD=(pose.rootY or 0)+ed
dX+=(eD-dX)*k
if state=="release"and not cx then
local tr=dA[aG]or dA.frontflip
local dur=math.max(releaseEnd-aI,0.01)local t=math.clamp((now-aI)/dur,0,1)local fR=t*t*(3-2*t)local d=tr.deg*fR
if tr.axis=="x"then
current.Root=Vector3.new(d,0,0)elseif tr.axis=="y"then
current.Root=Vector3.new(0,d*releaseSign,0)elseif tr.axis=="z"then
current.Root=Vector3.new(0,0,d*releaseSign)elseif tr.axis=="xy"then
current.Root=Vector3.new(d,d*releaseSign,0)end
elseif cw=="release"then
current.Root=Vector3.zero
end
cw=state
local cG=0
if state=="dash"then
cG=cx and 0 or math.rad(80)elseif state=="zip"then
cG=math.clamp(math.rad(88)-math.asin(math.clamp(pullDirY,-1,1)),math.rad(10),math.rad(150))end
aV+=(cG-aV)*(1-math.exp(-dt*18))if state=="dash"and not cx then
local t=math.clamp((now-bf)/aa.DashTime,0,1)local fR=t*t*(3-2*t)dashRoll=-math.pi*2*aa.DashRolls*fR
else
dashRoll=0
end
local dashCF=CFrame.new()if aV>0.001 or dashRoll~=0 then
dashCF=CFrame.Angles(-aV,0,0)*CFrame.Angles(0,dashRoll,0)end
for _,j in ipairs(bm)do
if j.joint.Parent then
local c=current[j.name]local offset=CFrame.Angles(math.rad(c.X),math.rad(c.Y),math.rad(c.Z))if j.name=="Root"then
offset=CFrame.new(0,math.clamp(dX,-2,2),0)*ay*dashCF*offset
end
j.offset=blocked and CFrame.new()or offset
end
end
U.dS(now,dashCF)if aa.Trails then
if not trailsOn and speed>aa.TrailMinSpeed then
trailsOn=true
elseif trailsOn and speed<aa.TrailMinSpeed*0.7 then
trailsOn=false
end
local bc=(not blocked)and(trailsOn or state=="swing"or state=="release"or state=="dash"or state=="zip")for _,tr in ipairs(cC)do
if tr.Enabled~=bc then
tr.Enabled=bc
end
tr.Lifetime=aa.TrailLifetime*(state=="dash"and 1.25 or 1)if aa.ReducedMotion then tr.Lifetime=math.min(tr.Lifetime,0.1)end
end
end
if aa.Afterimages and not blocked then
local fC=state=="dash"or state=="dive"or state=="glide"or(state=="release"and aG~="swan")or speed>120
if fC and now-lastGhost>aa.GhostInterval then
lastGhost=now
U.ds()end
end
local gh=lastSpeed<=aa.SpeedRingSpeed and speed>aa.SpeedRingSpeed
lastSpeed=speed
if gh and air and now-lastRing>1.2 then
lastRing=now
local d=vel.Unit
if aa.SpeedRing then
U.ao(root.Position+d*4,28,CFrame.lookAt(Vector3.zero,d)*CFrame.Angles(0,math.rad(90),0))end
if aa.SpeedHop then
root.AssemblyLinearVelocity=vel+d*aa.SpeedHopForward+Vector3.new(0,aa.SpeedHopUp,0)end
U.v(10)end
if cd then
if ac then
local c=math.clamp((now-ac)/aa.ChargeTime,0,1)cd.FillColor=Color3.fromRGB(220,30,30):Lerp(Color3.fromRGB(255,215,0),c)cd.OutlineColor=Color3.new(1,1,1)local gF=(c>=1 and not aa.ReducedMotion)and(math.sin(now*5)*0.055)or 0
cd.FillTransparency=0.92-0.13*c+gF
cd.OutlineTransparency=0.4-0.3*c
else
local f=1-math.exp(-dt*10)cd.FillTransparency+=(1-cd.FillTransparency)*f
cd.OutlineTransparency+=(1-cd.OutlineTransparency)*f
end
end
local fj=0
if not aa.ReducedMotion and workspace.CurrentCamera
and workspace.CurrentCamera.CameraType~=Enum.CameraType.Scriptable then
if now<shakeEnd then
fj=aa.ShakeStrength*math.clamp((shakeEnd-now)/aa.ShakeTime,0,1)^2
elseif ac then
fj=aa.ChargeShake*math.clamp((now-ac)/aa.ChargeTime,0,1)end
end
if fj>0 then
if not shaking then U.aV=humanoid.CameraOffset end
humanoid.CameraOffset=(U.aV or Vector3.zero)+Vector3.new(math.noise(now*24,13),math.noise(29,now*27),0)*fj
shaking=true
elseif shaking then
humanoid.CameraOffset=U.aV or Vector3.zero
shaking=false
end
end)U.cu="HuybypassCameraReset_"..tostring(player.UserId)U.ca="HuybypassCamera_"..tostring(player.UserId)function U.bo()local cb=U.T
if cb and U.bD and cb.CFrame==U.bD then
cb.CFrame=cb.CFrame*U.br:Inverse()end
U.bD=nil
U.br=CFrame.new()end
ae:BindToRenderStep(U.cu,Enum.RenderPriority.Camera.Value-1,U.bo)ae:BindToRenderStep(U.ca,Enum.RenderPriority.Camera.Value+1,function(rawDt)if not U.d then return end
local cb=workspace.CurrentCamera
if not cb then
U.cz(math.clamp(rawDt,0,0.05))U.bS()U.cy()U.ck()return
end
local dt=math.clamp(rawDt,0,0.05)if U.T~=cb then
U.bo()if U.T and U.X and math.abs(U.T.FieldOfView-U.X)<0.01 then
U.T.FieldOfView=U.bH or aa.BaseFOV
end
U.T,U.bH,U.X=cb,cb.FieldOfView,nil
end
local vel=U.a and root and root.Parent and root.AssemblyLinearVelocity or Vector3.zero
local speed=vel.Magnitude
local dp=cb.CameraType==Enum.CameraType.Scriptable or U.autoKillView~=nil
if not dp and U.a then
local eM=math.clamp((speed-15)/math.max(1,aa.FOVMaxSpeed-15),0,1)local boost=aa.ReducedMotion and math.min(aa.FOVSpeedBoost,5)or aa.FOVSpeedBoost
local target=aa.BaseFOV+eM*boost
if ai then target+=aa.ReducedMotion and 0 or aa.FOVSwingBonus end
if ac then
target-=aa.FOVChargeZoom*math.clamp((os.clock()-ac)/aa.ChargeTime,0,1)end
target+=aa.ReducedMotion and 0 or cv
target=math.clamp(target,50,aa.MaxCameraFOV)cb.FieldOfView+=(target-cb.FieldOfView)*(1-math.exp(-dt*aa.FOVSmooth))U.X=cb.FieldOfView
local gn=vel:Dot(cb.CFrame.RightVector)local fc=(aa.ReducedMotion or not ai)and 0
or-math.rad(aa.CameraRoll)*math.clamp(gn/110,-1,1)cK+=(fc-cK)*(1-math.exp(-dt*7))U.br=CFrame.Angles(0,0,cK)cb.CFrame*=U.br
U.bD=cb.CFrame
else
cK=0
if U.X and math.abs(cb.FieldOfView-U.X)<0.01 then
cb.FieldOfView=U.bH or aa.BaseFOV
end
U.X=nil
end
cv*=math.exp(-dt*8)local fd=not aa.ReducedMotion and not dp and U.a
and math.clamp((speed-aa.SpeedBlurStart)/120,0,1)*aa.SpeedBlur or 0
blurNow+=(fd-blurNow)*(1-math.exp(-dt*7))ba.Size=blurNow
U.cG(dt,dp and 0 or speed)U.co+=(math.min(rawDt,0.15)-U.co)*(1-math.exp(-dt*1.5))fx.update(dt,speed,vel)U.cO(dt)end)function U.bU(item)return item:IsA("Accessory")or item:IsA("Shirt")or item:IsA("Pants")or item:IsA("ShirtGraphic")end
function U.aJ()U.au=(U.au or 0)+1
U.bz=false
local state=U.aB
U.aB=nil
if not state then return end
for _,item in ipairs(state.added)do item:Destroy()end
if state.char.Parent then
for _,item in ipairs(state.saved:GetChildren())do item.Parent=state.char end
end
state.saved:Destroy()end
function U.bl(id,hum,destination)local eL=game:GetService("MarketplaceService"):GetProductInfo(id,Enum.InfoType.Asset)local bt
for _,value in ipairs(Enum.AssetType:GetEnumItems())do
if value.Value==eL.AssetTypeId then bt=value.Name break end
end
local aw=hum:GetAppliedDescription()aw:SetAccessories({},true)aw.Shirt,aw.Pants,aw.GraphicTShirt=0,0,0
if bt=="Shirt"then
aw.Shirt=id
elseif bt=="Pants"then
aw.Pants=id
elseif bt=="TShirt"then
aw.GraphicTShirt=id
else
local name=bt and bt:gsub("Accessory$","")local ok,kind=pcall(function()return Enum.AccessoryType[name]end)if not ok or not kind then
aw:Destroy()error("Unsupported clothing/accessory asset: "..tostring(id))end
local gj=name=="TShirt"or name=="Shirt"or name=="Pants"or name=="Jacket"or name=="Sweater"or name=="Shorts"or name=="LeftShoe"or name=="RightShoe"or name=="DressSkirt"local fU={AssetId=id,AccessoryType=kind}if gj then fU.Order=1 fU.IsLayered=true end
aw:SetAccessories({fU},true)end
local ok,model=pcall(function()return bo:CreateHumanoidModelFromDescriptionAsync(aw,hum.RigType)end)aw:Destroy()if not ok then error(model)end
local count=0
for _,item in ipairs(model:GetChildren())do
if U.bU(item)then
for _,child in ipairs(item:GetDescendants())do
if child:IsA("LuaSourceContainer")then child:Destroy()end
end
item.Parent=destination
count+=1
end
end
model:Destroy()if count==0 then error("Roblox did not load asset "..tostring(id).."")end
end
function U.cF(item,char)if not item:IsA("Accessory")then item.Parent=char return end
local cB=item:FindFirstChild("Handle")if not cB or not cB:IsA("BasePart")then error("Accessory is missing its Handle")end
for _,child in ipairs(cB:GetChildren())do
if child:IsA("JointInstance")or child:IsA("WeldConstraint")then child:Destroy()end
end
local target,source
for _,attachment in ipairs(cB:GetChildren())do
if attachment:IsA("Attachment")then
for _,part in ipairs(char:GetChildren())do
if part:IsA("BasePart")then
local match=part:FindFirstChild(attachment.Name)if match and match:IsA("Attachment")then target,source=match,attachment break end
end
end
if target then break end
end
end
local cS=target and target.Parent or char:FindFirstChild("Head")if not cS then error("No attachment point found for accessory")end
for _,part in ipairs(item:GetDescendants())do
if part:IsA("BasePart")then
part.Anchored,part.CanCollide,part.CanTouch,part.Massless=false,false,false,true
end
end
local c0=target and target.CFrame or CFrame.new(0,cS.Size.Y/2,0)local c1=source and source.CFrame or item.AttachmentPoint
cB.CFrame=cS.CFrame*c0*c1:Inverse()item.Parent=char
local fz=Instance.new("Weld")fz.Name,fz.Part0,fz.Part1="AccessoryWeld",cS,cB
fz.C0,fz.C1,fz.Parent=c0,c1,cB
end
function U.cC()if U.bz then
U.aJ()U.h("Suit loading cancelled")return
end
if U.aB then
U.aJ()U.h("Huybypass-suit: OFF — original outfit restored")return
end
if not U.a or not humanoid or humanoid.Health<=0 then return end
U.au=(U.au or 0)+1
local request,bA,hum,generation=U.au,ad,humanoid,U.e
U.bz=true
U.h("Loading Huybypass-suit…")task.spawn(function()local cP=Instance.new("Folder")local function valid()return U.d and U.a and U.au==request and U.e==generation
and ad==bA and bA.Parent and hum.Health>0
end
local ok,reason=pcall(function()U.bl(137973109129923,hum,cP)if not valid()then return end
U.bl(120108315928410,hum,cP)if not valid()then return end
U.bl(8454853036,hum,cP)if not valid()then return end
local saved=Instance.new("Folder")saved.Name="LocalHuybypassOriginalOutfit"U.aB={char=bA,saved=saved,added={}}for _,item in ipairs(bA:GetChildren())do
if U.bU(item)then item.Parent=saved end
end
for _,item in ipairs(cP:GetChildren())do
table.insert(U.aB.added,item)U.cF(item,bA)end
end)cP:Destroy()if U.au~=request then return end
U.bz=false
if not ok then
U.aJ()warn("[HUYBYPASS] "..tostring(reason))U.h("Suit could not load; your original outfit is unchanged. See Output.")elseif valid()and U.aB then
U.ap(root.Position,Vector3.yAxis,1,false,Color3.fromRGB(255,91,99))U.bc(Color3.fromRGB(255,91,99),0.5)U.h("Huybypass-suit: ON (local) — P = original outfit")end
end)end
function U.bb()if U.carryUnlock then U.carryUnlock()end if U.H then U.H(U.autoKillPause and U.autoKillPause())end U.m=false U.af=nil U.bF=nil U.bd=nil U.aJ()U.Z=false
U.L()dance.stop()U.z()U.a=false
U.e+=1
U.U=(U.U or 0)+1
U.aY=false
U.an()bX+=1
aK+=1
U.n()U.o(false)U.l()U.A()U.y()U.aF()U.dF()aD.destroyAll()aD.restoreCollide()if U.bM then U.bM:Disconnect()U.bM=nil end
if humanoid and humanoid.Parent then
if shaking then humanoid.CameraOffset=U.aV or Vector3.zero end
humanoid.AutoRotate=true
humanoid.PlatformStand=false
if U.aE then
humanoid.WalkSpeed=U.aE.walk
humanoid.UseJumpPower=U.aE.usePower
humanoid.JumpPower=U.aE.jump
end
end
for track,weight in pairs(mutedTracks)do
if track.IsPlaying then track:AdjustWeight(weight,0.1)end
end
for _,j in ipairs(bm)do
if j.joint.Parent then U.aT(j)end
end
local aX={}for _,tr in pairs(dance.E.tracks)do aX[tr]=true end
if animTrack then aX[animTrack]=true end
if ab.track then aX[ab.track]=true end
if ab.fallback then aX[ab.fallback]=true end
for tr in pairs(aX)do tr:Stop(0)tr:Destroy()end
dance.E.tracks,dance.E.active,dance.E.launching,dance.E.pending={},nil,false,false
ab.track,ab.fallback,animTrack=nil,nil,nil
U.dc()for _,tr in ipairs(cC)do
if tr.Parent then
local a0,a1=tr.Attachment0,tr.Attachment1
tr:Destroy()if a0 then a0:Destroy()end
if a1 then a1:Destroy()end
end
end
for _,inst in pairs({aj,leftHandAtt,aT,cd,chargeSparks})do
if inst then inst:Destroy()end
end
for _,sound in pairs({bJ,am,cn,bx,bG,senseSound})do
if sound then sound:Destroy()end
end
senseOn,an,sensePing=false,0,0
U.dD()U.be={}U.dU=true
if ap then ap.Enabled=false end
if fx.bloom then fx.bloom.Intensity=0 end
if fx.cc then fx.cc.TintColor=Color3.new(1,1,1)fx.cc.Contrast=0 fx.cc.Saturation=0 end
al.Visible=false
ac,chargeFull=nil,false
diving,releaseEnd,landUntil,shakeEnd=false,0,0,0
aV,dashRoll=0,0
dd,cm,shaking,trailsOn=false,false,false,false
cv,cK,blurNow=0,0,0
ba.Size=0
U.aV,U.aE=nil,nil
U.bA=nil
hand,ar,aQ,webHandAtt,aj,leftHandAtt=nil,nil,nil,nil,nil,nil
aT,cd,chargeSparks=nil,nil,nil
bJ,am,cn,bx,bG,senseSound=nil,nil,nil,nil,nil,nil
ad,humanoid,root,animator=nil,nil,nil,nil
bm,cC,mutedTracks={},{},{}fidgetMuted=false
bR,sentNeutral=0,false
lastSpeed,lastRing,lastGhost=0,0,0
U.bs=0
U.aC()end
function U.bw()if not U.d then return end
if U.modeEmoteStop then U.modeEmoteStop()end
if U.autoKillViewStop then U.autoKillViewStop()end
U.d=false
if U.emoteUnlock then U.emoteUnlock()end
if ec.betaStop then ec.betaStop()end
if U.noSitHum and U.noSitHum.Parent then U.noSitHum:SetStateEnabled(Enum.HumanoidStateType.Seated,U.noSitBefore)end
if U.at then U.at:Destroy()U.at=nil end
U.ae(true)U.bb()ae:UnbindFromRenderStep(U.cu)ae:UnbindFromRenderStep(U.ca)U.bo()if U.T and U.X and math.abs(U.T.FieldOfView-U.X)<0.01 then
U.T.FieldOfView=U.bH or aa.BaseFOV
end
for c in pairs(U.bg)do c:Disconnect()end
table.clear(U.bg)for _,r in pairs(aU)do
for _,j in ipairs(r.rig)do if j.joint.Parent then j.joint.C0=j.c0 end end
end
U.aL()for _,gui in ipairs(U.aa)do gui:Destroy()end
if ba then ba:Destroy()end
if fx.bloom then fx.bloom:Destroy()end
if fx.cc then fx.cc:Destroy()end
U.cZ()if U.G then U.G:Destroy()end
aq:Destroy()end
function U.aK(char)if not U.d or char~=player.Character then return end
if U.emoteNoReturnCharacter~=char then U.emoteNoReturnCharacter=nil end
if U.a and ad==char then return end
U.bb()local generation=U.e
local function cp(parent,name)local item=parent:WaitForChild(name,10)if not U.d or U.e~=generation or char~=player.Character or not char.Parent then
return nil
end
if not item then warn("[HUYBYPASS] Missing character part: "..name)end
return item
end
local hum=cp(char,"Humanoid")local hb=cp(char,"HumanoidRootPart")if not hum or not hb then return end
local cZ=hum:FindFirstChildOfClass("Animator")or cp(hum,"Animator")local hD=hum.RigType==Enum.HumanoidRigType.R15
local rh=cp(char,hD and"RightHand"or"Right Arm")local lh=cp(char,hD and"LeftHand"or"Left Arm")if not rh or not lh then return end
local fD=hD and{"RightHand","LeftHand","RightFoot","LeftFoot"}or{"Right Arm","Left Arm","Right Leg","Left Leg"}local gu={}for _,name in ipairs(fD)do
local eS=cp(char,name)if not eS then return end
table.insert(gu,eS)end
if U.e~=generation or not U.d then return end
ad,humanoid,root,animator=char,hum,hb,cZ
ar,aQ,hand=rh,lh,rh
U.aE={walk=hum.WalkSpeed,jump=hum.JumpPower,usePower=hum.UseJumpPower}humanoid.WalkSpeed=aa.WalkSpeed
humanoid.UseJumpPower=true
humanoid.JumpPower=aa.JumpPower
bM,fidget,nextFidget=os.clock(),nil,0
idlePlayed,crouchPose,dance.busy=false,false,false
cw="idle"bu,lastSide=aa.DefaultHandSide,aa.DefaultHandSide
bp,dD,lastDash,lastBigJump=-math.huge,-math.huge,-math.huge,-math.huge
if hD then
for _,name in ipairs(aB)do
local joint=char:FindFirstChild(name,true)if joint and(joint:IsA("Motor6D")or joint:IsA("AnimationConstraint"))then
table.insert(bm,{joint=joint,c0=joint.C0,name=name,offset=CFrame.new()})end
end
else
warn("[HUYBYPASS] R6: movement/VFX enabled; procedural poses require R15.")end
if aa.Trails then for _,eS in ipairs(gu)do U.cE(eS)end end
cd=Instance.new("Highlight")cd.Name="ChargeAura"cd.FillTransparency=1
cd.OutlineTransparency=1
cd.DepthMode=Enum.HighlightDepthMode.Occluded
cd.Parent=char
aj=Instance.new("Attachment")aj.Name="WebHandAttachmentRight"aj.Position=Vector3.new(0,-0.2,0)aj.Parent=ar
leftHandAtt=Instance.new("Attachment")leftHandAtt.Name="WebHandAttachmentLeft"leftHandAtt.Position=Vector3.new(0,-0.2,0)leftHandAtt.Parent=aQ
webHandAtt=aj
aT=Instance.new("Attachment")aT.Name="WebRootAttachment"aT.Parent=root
chargeSparks=Instance.new("ParticleEmitter")chargeSparks.Name="ChargeSparks"chargeSparks.Texture="rbxasset://textures/particles/sparkles_main.dds"chargeSparks.Color=ColorSequence.new(Color3.fromRGB(255,80,60),Color3.fromRGB(255,215,0))chargeSparks.LightEmission=1
chargeSparks.LightInfluence=0
chargeSparks.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.8),NumberSequenceKeypoint.new(1,0)})chargeSparks.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.7,0.15),NumberSequenceKeypoint.new(1,1),})chargeSparks.Lifetime=NumberRange.new(0.3,0.7)chargeSparks.Speed=NumberRange.new(8,22)chargeSparks.Drag=2
chargeSparks.Acceleration=Vector3.new(0,6,0)chargeSparks.SpreadAngle=Vector2.new(180,180)chargeSparks.Rate=0
chargeSparks.Parent=root
bJ=U.R("WebShootSound",aa.WebSoundId,aa.WebSoundVolume)am=U.R("ChargeJumpSound",aa.ChargeSoundId,aa.ChargeSoundVolume)cn=U.R("AirDashSound",aa.DashSoundId,aa.DashSoundVolume)bx=U.R("LandSound",aa.LandSoundId,aa.LandSoundVolume)bG=U.R("LaunchSound",aa.LaunchSoundId,aa.LaunchSoundVolume)senseSound=U.R("SenseSound",aa.SenseSoundId,1)U.a=true
U.dt()if aa.SwingAnimationId~=""and animator then
local eZ=Instance.new("Animation")eZ.AnimationId=aa.SwingAnimationId
local ok,loaded=pcall(function()return animator:LoadAnimation(eZ)end)eZ:Destroy()if ok and loaded then
animTrack=loaded
animTrack.Looped=true
animTrack.Priority=Enum.AnimationPriority.Action
end
end
if aa.SwingEmoteId~=0 and animator then
local fL=Instance.new("Animation")fL.AnimationId="rbxassetid://"..tostring(aa.SwingEmoteId)local hS,trS=pcall(function()return animator:LoadAnimation(fL)end)fL:Destroy()if hS and trS then
trS.Priority=Enum.AnimationPriority.Action4
trS.Looped=aa.SwingEmoteLooped
ab.fallback=trS
end
if ab.animId then
ab.load(ab.animId)else
task.spawn(ab.resolve,char)end
end
if animator then
for _,name in ipairs(dance.E.order)do
dance.E.load(name)end
task.spawn(dance.E.resolve,char)end
U.bM=U.b(humanoid.Died,function()if ad==char then U.bb()end
end)end
U.ak={saved={},busy=false}function U.cv(object,property)local ok,currentValue=pcall(function()return object[property]end)if not ok then return false end
local key=object
if not U.ak.saved[key]then
U.ak.saved[key]={object=object,property=property,value=currentValue}end
return pcall(function()object[property]=true end)end
function U.cQ()local cO=game:GetService("StarterGui")local state=U.ak
local fH=pcall(function()if state.coreBefore==nil then state.coreBefore=cO:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)end
cO:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true)end)local em=game:GetService("TextChatService")if em.ChatVersion~=Enum.ChatVersion.TextChatService then return fH end
local ge=em:FindFirstChildOfClass("ChatWindowConfiguration")local av=em:FindFirstChildOfClass("ChatInputBarConfiguration")local fG=ge and U.cv(ge,"Enabled")or false
local gm=av and U.cv(av,"Enabled")or false
return fH and fG and gm
end
function U.bp(announce)if not aa.NativeChatEnabled or U.ak.busy or not U.d then return end
U.ak.busy=true
task.spawn(function()local er=false
for _=1,5 do
if not U.d then break end
local ok,result=pcall(U.cQ)er=ok and result
if er then break end
task.wait(0.4)end
U.ak.busy=false
if announce and U.d then
U.h(er and"Roblox chat UI enabled. Only available messages can appear."or"Roblox chat UI unavailable here. No hidden messages are recovered.")end
end)end
function U.cZ()local state=U.ak
if not state then return end
for _,snapshot in pairs(state.saved)do
pcall(function()if snapshot.object[snapshot.property]==true then
snapshot.object[snapshot.property]=snapshot.value
end
end)end
if state.coreBefore~=nil then
pcall(function()local cO=game:GetService("StarterGui")if cO:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)then
cO:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,state.coreBefore)end
end)end
table.clear(state.saved)state.coreBefore=nil
end
function U.by(object)
if not object then return false end
for _,name in ipairs({"K.O","KO","Knocked","KnockedOut","Downed","Ragdolled","Ragdoll"})do
local value=object:GetAttribute(name)
if value==true or(type(value)=="number"and value~=0)then return true end
local eY=object:FindFirstChild(name)
if eY and(eY:IsA("BoolValue")or eY:IsA("NumberValue")or eY:IsA("IntValue"))then
if eY.Value==true or(type(eY.Value)=="number"and eY.Value~=0)then return true end
end
end
return false
end
function U.cx()
if not humanoid or not ad or not root or not root.Parent then return true end
if humanoid.Health<=0 then return true end
if U.by(ad)or U.by(humanoid)or U.by(ad:FindFirstChild("BodyEffects"))then return true end
local state=humanoid:GetState()
if state==Enum.HumanoidStateType.Ragdoll or state==Enum.HumanoidStateType.FallingDown
or state==Enum.HumanoidStateType.GettingUp or state==Enum.HumanoidStateType.Dead then return true end
if not ah and not U.bd and(humanoid.PlatformStand or state==Enum.HumanoidStateType.Physics)then return true end
for _,j in ipairs(bm)do
if j.joint.Parent and not j.joint.Enabled then return true end
end
return false
end
function U.f()
return U.d and U.a and not U.m and not U.cx()
end
function U.dy()
for _,j in ipairs(bm)do if j.joint.Parent then U.aT(j)end end
bm={}
if humanoid.RigType==Enum.HumanoidRigType.R15 then
for _,name in ipairs(aB)do
local joint=ad:FindFirstChild(name,true)
if joint and(joint:IsA("Motor6D")or joint:IsA("AnimationConstraint"))then
table.insert(bm,{name=name,joint=joint,c0=joint.C0,offset=CFrame.new()})
end
end
end
U.aC()
end
function U.dn()
U.m=true
U.bd=ah
U.cY=(ai or ah or as or os.clock()<au or ac)and true or humanoid.AutoRotate
U.bF=U.D
U.z()
bX+=1 aK+=1
U.U=(U.U or 0)+1
if U.H then U.H(U.autoKillPause and U.autoKillPause())end
U.S=false U.Z=false
U.o(false)U.n()U.l()U.A()U.y()
U.L()dance.stop()ab.stop()
aD.destroyAll()aD.restoreCollide()
U.an()U.aF()
for _,j in ipairs(bm)do if j.joint.Parent then U.aT(j)end end
for track,weight in pairs(mutedTracks)do if track.IsPlaying then track:AdjustWeight(weight,0)end end
mutedTracks={}fidgetMuted=false
for _,trail in ipairs(cC)do trail.Enabled=false end
U.aC()
aV,dashRoll,releaseEnd,landUntil=0,0,0,0
diving,dd,cm,trailsOn=false,false,false,false
fidget,crouchPose=nil,false
lastSpeed,lastRing=0,0
U.aY=false U.af=nil
end
function U.bx()
local attack=U.voidHide or U.bringState or U.gunOrbit or U.zipAttack or U.gunBodyFollow or U.attackRecovery
if attack and U.gunOrbitGuardStep then U.gunOrbitGuardStep(attack)end
if not U.a or not humanoid or not root or not ad then return end
local bD=ad:FindFirstChild("HumanoidRootPart")
if bD and bD~=root then
local bA=ad U.a=false task.defer(U.aK,bA)return
end
if U.cx()then
U.af=nil
if not U.m then U.dn()end
return
end
if not U.m then return end
if root.Anchored or humanoid.Sit or root.CFrame.UpVector.Y<0.55 then U.af=nil return end
local now=os.clock()
U.af=U.af or now
if now-U.af<0.4 then return end
local fn=ad:FindFirstChild("HumanoidRootPart")
if fn and fn~=root then
local bA=ad U.a=false task.defer(U.aK,bA)return
end
U.dy()
root.AssemblyLinearVelocity=Vector3.zero root.AssemblyAngularVelocity=Vector3.zero
animator=humanoid:FindFirstChildOfClass("Animator")or animator
if U.bd then humanoid.PlatformStand=false end
humanoid.AutoRotate=U.cY~=false
local bq=U.bF
if bq and bq.humanoid==humanoid then
if humanoid.WalkSpeed==0 then humanoid.WalkSpeed=bq.walk end
if humanoid.JumpPower==0 then humanoid.JumpPower=bq.jumpPower end
if humanoid.JumpHeight==0 then humanoid.JumpHeight=bq.jumpHeight end
humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,bq.canJump)
end
U.m=false U.bd=nil U.bF=nil U.af=nil
U.bs=now bp=now
aI,releaseEnd,lastSpeed,lastRing=0,0,0,0
cw="idle"bM=now
U.h("Recovered - movement ready")
end
U.b(ae.PreSimulation,U.bx)
U.b(bw.InputBegan,function(av,processed)if not U.F and not U.ad and not processed and U.k and not bw:GetFocusedTextBox()and av.KeyCode==aa.NativeChatKey then U.bp(true)end
end)U.bp(false)U.b(player.CharacterAdded,U.aK)U.b(player.CharacterRemoving,function(char)if ad==char or not U.a then U.bb()end
end)if player.Character then
task.spawn(U.aK,player.Character)end
 
 
aa.ZipAttackKey=Enum.KeyCode.C
aa.ZipAttackRange=400
aa.ZipAttackSpeed=220
aa.ZipAttackStopDistance=2.8
aa.ZipAttackPrediction=0.14
aa.ZipAttackMaxLead=2.5
aa.ZipAttackMaxAcceleration=100
aa.ZipAttackMinimumGap=2.2
aa.ZipAttackChargeTime=3
aa.ZipAttackSounds=true
aa.ZipAttackTravelVolume=0.35
aa.ZipAttackSnapBehind=true
aa.ZipAttackHideRange=10
aa.ZipAttackHideDepth=9
aa.ZipAttackBelowTime=1.5
aa.ZipAttackAboveTime=1
aa.ZipAttackStrikeWindow=0.4
aa.ZipAttackToolNames={"Combat","[Combat]","Fists","[Fists]"}
function U.zipStatus(message,quiet)
U.zipLastStatus=tostring(message)
if not quiet then U.h(U.zipLastStatus)end
end
function U.zipAttackValid(state)
if U.zipAttack~=state or not U.f() or not U.k or U.ad or U.F or bw:GetFocusedTextBox() then return false end
if root~=state.root or ad~=state.character or humanoid~=state.humanoid then return false end
if root.Anchored or humanoid.Sit then return false end
if state.target.Parent~=bo or state.target.Character~=state.targetCharacter then return false end
if not state.targetRoot:IsDescendantOf(workspace) or state.targetHum.Health<=0 then return false end
if state.targetCharacter:FindFirstChildOfClass("ForceField") then return false end
return true
end
function U.zipAttackKnocked(state)
for _,object in ipairs({state.targetCharacter,state.targetHum,state.targetCharacter:FindFirstChild("BodyEffects")})do
for _,name in ipairs({"K.O","KO","Knocked","KnockedOut","Downed"})do
local value=object:GetAttribute(name)
local child=object:FindFirstChild(name)
if value==true or(type(value)=="number" and value~=0)then return true end
if child and(child:IsA("BoolValue")or child:IsA("NumberValue")or child:IsA("IntValue"))then
if child.Value==true or(type(child.Value)=="number" and child.Value~=0)then return true end
end
end
end
return false
end
function U.zipAttackUnlock(state)
local guard=state.inputGuard
if not guard then return end
state.inputGuard=nil
for _,group in ipairs(guard.groups)do
if group.wrapper then group.wrapper:Disconnect()end
for _,connection in ipairs(group.saved)do
pcall(function()connection:Enable()end)
end
end
end
function U.gunCompatibility()
if bw.TouchEnabled then return true end
local env=getfenv(0)
local identify=env.identifyexecutor or env.getexecutorname
if type(identify)=="function"then
local ok,name=pcall(identify)
if ok and type(name)=="string"then
name=name:lower()
if name:find("madium",1,true) or name:find("delta",1,true)then return true end
end
end
return false
end
function U.zipAttackLock(state)
if U.gunCompatibility()then
state.compatibility=true
state.press=function()state.tool:Activate()end
state.release=function()state.tool:Deactivate()end
state.inputGuard={groups={}}
for _,definition in ipairs({{state.tool.Activated,"down"},{state.tool.Deactivated,"up"}})do
local group={saved={},direction=definition[2],seen=false}
table.insert(state.inputGuard.groups,group)
group.wrapper=definition[1]:Connect(function()
if not state.inputGuard then return end
if group.direction=="down" and state.held and not group.seen then
 group.seen=true state.chargeObserved=true state.chargeAt=os.clock()
elseif group.direction=="up" then
 if state.releasing then group.seen=true
 elseif state.held then state.inputError="Tool hold interrupted in compatibility mode."end
end
end)
end
return true
end
local env=getfenv(0)
if type(env.getconnections)~="function" or type(env.mouse1press)~="function" or type(env.mouse1release)~="function" then
return false,"Held-input lock requires getconnections, mouse1press and mouse1release."
end
state.press=env.mouse1press state.release=env.mouse1release
local mouse=player:GetMouse()
local guard={groups={}}
state.inputGuard=guard
local definitions={
{bw.InputBegan,"down",true},{bw.InputEnded,"up",true},
{mouse.Button1Down,"down",false},{mouse.Button1Up,"up",false},
{state.tool.Activated,"down",false},{state.tool.Deactivated,"up",false}}
if bw.TouchEnabled then
table.remove(definitions,2)table.remove(definitions,1)
end
local ok,err=pcall(function()
for _,definition in ipairs(definitions)do
local signal,direction,typed=definition[1],definition[2],definition[3]
local group={saved={},direction=direction,seen=false}
table.insert(guard.groups,group)
 
for _,connection in ipairs(env.getconnections(signal))do
if connection.Enabled==true and type(connection.Function)=="function" then
if type(connection.Disable)~="function" or type(connection.Enable)~="function" or type(connection.Fire)~="function" then
error("Executor lacks reversible connection control.")
end
table.insert(group.saved,connection)
connection:Disable()
end
end
group.wrapper=signal:Connect(function(...)
local args=table.pack(...)
local isMouse=not typed or (args[1] and args[1].UserInputType==Enum.UserInputType.MouseButton1)
local pass=not isMouse
if isMouse then
local expected=(direction=="down" and state.held) or (direction=="up" and state.releasing)
pass=expected and not group.seen
if pass then
group.seen=true
if direction=="down" then
 
 
state.chargeObserved=true state.chargeAt=os.clock()
end
end
if not pass and direction=="up" and state.held then state.reassert=true end
end
if pass then
for _,connection in ipairs(group.saved)do
local delivered,message=pcall(function()connection:Fire(table.unpack(args,1,args.n))end)
if not delivered then state.inputError=tostring(message)end
end
end
end)
end
end)
if not ok then U.zipAttackUnlock(state)return false,tostring(err)end
return true
end
function U.zipAttackArrived(state)
return not state.hidden and
(state.targetRoot.Position-state.root.Position).Magnitude<=aa.ZipAttackStopDistance+0.6
end
function U.zipAttackChargeReady(state)
return state.held and state.chargeObserved and state.chargeAt~=nil
and os.clock()-state.chargeAt>=aa.ZipAttackChargeTime
end
function U.zipAttackSetNoclip(state)
if not state.collisionSnapshot then
state.collisionSnapshot={}
local function add(part)
if part:IsA("BasePart") and state.collisionSnapshot[part]==nil then
state.collisionSnapshot[part]=part.CanCollide
end
end
for _,part in ipairs(state.character:GetDescendants())do add(part)end
state.collisionAdded=state.character.DescendantAdded:Connect(add)
end
for part in pairs(state.collisionSnapshot)do
if part.Parent then
if part.CanCollide then part.CanCollide=false end
else state.collisionSnapshot[part]=nil end
end
end
function U.zipAttackRestoreCollision(state)
if state.collisionAdded then state.collisionAdded:Disconnect()state.collisionAdded=nil end
if state.noclipConnection then state.noclipConnection:Disconnect()state.noclipConnection=nil end
for part,value in pairs(state.collisionSnapshot or {})do
if part.Parent then part.CanCollide=value end
end
state.collisionSnapshot=nil
end
function U.zipAttackPositionClear(state)
local overlap=OverlapParams.new()
overlap.FilterType=Enum.RaycastFilterType.Exclude
overlap.FilterDescendantsInstances={state.character,aq,state.targetCharacter}
for _,part in ipairs(workspace:GetPartBoundsInBox(state.root.CFrame,Vector3.new(2.4,4,2.4),overlap))do
if part.CanCollide then return false end
end
return true
end
function U.zipAttackPress(state)
 
if os.clock()<(state.surfaceUntil or 0) or not U.zipAttackArrived(state)then return false end
for _,group in ipairs(state.inputGuard.groups)do group.seen=false end
state.releasing=false state.reassert=false state.held=true
state.chargeObserved=false state.snapUsed=false state.snapSettleUntil=nil
state.reassertCount=0 state.lastReassertAt=os.clock()
state.hideUsed=false state.hideUntil=nil
state.chargeAt=os.clock()
state.press()
return true
end
function U.zipAttackRelease(state)
if state.hidden or not U.zipAttackChargeReady(state)then return false end
state.held=false state.releasing=true state.reassert=false
state.releaseAt=os.clock()
state.strikeUntil=state.releaseAt+aa.ZipAttackStrikeWindow
state.release()
return true
end
function U.zipAttackSafeLanding(state)
local r,hum=state.root,state.humanoid
local target=state.targetRoot
local center=target and target.Parent and target.Position or r.Position
local height=hum.HipHeight+r.Size.Y*0.5
local leg=state.character:FindFirstChild("Left Leg")
if leg and leg:IsA("BasePart")then height=height+leg.Size.Y end
local params=RaycastParams.new()
params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={state.character,aq,state.targetCharacter}
params.RespectCanCollide=true
local outward=Vector3.new(r.Position.X-center.X,0,r.Position.Z-center.Z)
if outward.Magnitude<0.01 then outward=Vector3.new(0,0,1)else outward=outward.Unit end
local right=Vector3.new(-outward.Z,0,outward.X)
for _,radius in ipairs({7,10,14})do
for _,direction in ipairs({outward,right,-right,-outward})do
local spot=center+direction*radius
local hit=workspace:Raycast(spot+Vector3.new(0,12,0),Vector3.new(0,-48,0),params)
if hit and hit.Normal.Y>=0.7 and not hit.Instance:IsA("Seat")and not hit.Instance:IsA("VehicleSeat")then
local position=hit.Position+Vector3.new(0,height+0.15,0)
local pose=CFrame.lookAt(position,position-direction,Vector3.yAxis)
if U.gunOrbitPositionClear(state,pose)then
r.CFrame=pose state.safeCFrame=pose
r.AssemblyLinearVelocity=Vector3.zero r.AssemblyAngularVelocity=Vector3.zero
return true
end
end
end
end
return false
end
function U.zipAttackBodyGuard(state)
if not state.targetCharacter or not state.targetCharacter.Parent then return end
local folder=Instance.new("Folder")folder.Name="HuybypassMeleeBodyGuard"folder.Parent=state.character
state.bodyCollisionGuard=folder
 
for own,collides in pairs(state.collisionSnapshot or {})do
if collides and own.Parent then
for _,part in ipairs(state.targetCharacter:GetDescendants())do
if part:IsA("BasePart")then
local constraint=Instance.new("NoCollisionConstraint")
constraint.Part0=own constraint.Part1=part constraint.Parent=folder
end
end
end
end
end
function U.zipAttackStop(reason,expected,followBody)
local state=U.zipAttack
if not state or (expected and state~=expected)then return end
U.zipAttack=nil
if state.hidden and state.root.Parent then
if U.emoteNoReturnCharacter~=state.character then state.root.CFrame=state.surfaceReturn end
state.root.AssemblyLinearVelocity=Vector3.zero
state.hidden=false
end
if state.noclipConnection then state.noclipConnection:Disconnect()state.noclipConnection=nil end
 
if state.tool and state.tool.Parent==state.character then
pcall(function()state.humanoid:UnequipTools()end)
end
state.held=false state.releasing=true
if state.release then pcall(state.release)end
U.zipAttackUnlock(state)
aD.destroy("zipattack")
if root==state.root and humanoid==state.humanoid and state.root.Parent then
humanoid.AutoRotate=state.rotate
root.AssemblyLinearVelocity=Vector3.zero
root.AssemblyAngularVelocity=Vector3.zero
end
if state.travelSound then state.travelSound:Destroy()state.travelSound=nil end
if state.visual then state.visual:Destroy()end
 
if root==state.root and ad==state.character and state.root.Parent
and (followBody or (state.targetHum and state.targetHum.Health<=0))then
U.zipAttackSafeLanding(state)
U.zipAttackBodyGuard(state)
end
U.gunOrbitRelease(state)
if reason and U.d then U.zipStatus(reason)end
end
function U.zipAttackETA(state)
local offset=state.targetRoot.CFrame:VectorToWorldSpace(state.followOffset)
local errorVector=state.targetRoot.Position+offset-root.Position
local gap=errorVector.Magnitude
if gap<0.01 then return 0 end
local escapingSpeed=state.targetRoot.AssemblyLinearVelocity:Dot(errorVector.Unit)
local closingSpeed=math.max(1,aa.ZipAttackSpeed-escapingSpeed)
return gap/closingSpeed
end
function U.zipAttackTimedVelocity(errorVector,targetVelocity,remaining,dt)
local gap=errorVector.Magnitude
local correction=Vector3.zero
if gap>0.01 then
local closingSpeed=math.min(aa.ZipAttackSpeed,gap*28,gap/math.max(dt,1/240))
correction=errorVector.Unit*closingSpeed
end
return aD.safeVelocity(correction+targetVelocity,aa.ZipAttackSpeed)
end
function U.zipAttackSample(state,dt)
local now=os.clock()
local position=state.targetRoot.Position
local reported=aD.safeVelocity(state.targetRoot.AssemblyLinearVelocity,aa.ZipAttackSpeed)
local elapsed=state.sampledAt and now-state.sampledAt or dt
 
if state.followPoint and elapsed<1/240 then return state.followPoint,state.targetVelocity end
elapsed=math.clamp(elapsed,1/240,0.25)
local displacement=state.lastTargetPosition and position-state.lastTargetPosition or Vector3.zero
local reset=not state.lastTargetPosition or displacement.Magnitude>math.max(12,aa.ZipAttackSpeed*elapsed*2)
local measured=reset and reported or displacement/elapsed
local velocity=aD.safeVelocity(reported*0.75+measured*0.25,aa.ZipAttackSpeed)
local previous=state.targetVelocity
local stopped=Vector3.new(reported.X,0,reported.Z).Magnitude<1
and Vector3.new(measured.X,0,measured.Z).Magnitude<1
local reversed=previous and Vector3.new(previous.X,0,previous.Z):Dot(Vector3.new(velocity.X,0,velocity.Z))<0
if reset or stopped or reversed or not previous then
state.targetVelocity=stopped and Vector3.new(0,velocity.Y,0) or velocity
state.targetAcceleration=Vector3.zero
else
state.targetVelocity=previous:Lerp(velocity,1-math.exp(-elapsed*32))
 
state.targetVelocity=Vector3.new(state.targetVelocity.X,velocity.Y,state.targetVelocity.Z)
local acceleration=aD.safeVelocity((state.targetVelocity-previous)/elapsed,aa.ZipAttackMaxAcceleration)
state.targetAcceleration=(state.targetAcceleration or Vector3.zero):Lerp(acceleration,1-math.exp(-elapsed*14))
end
state.lastTargetPosition=position state.sampledAt=now
local gap=(position-state.root.Position).Magnitude
local horizon=aa.ZipAttackPrediction+math.clamp(gap/aa.ZipAttackSpeed*0.25,0,0.06)
state.predictionTime=horizon
local lead=state.targetVelocity*horizon+state.targetAcceleration*(0.5*horizon*horizon)
lead=aD.safeVelocity(lead,aa.ZipAttackMaxLead)
state.aimPoint=position+lead
local direction=state.targetRoot.CFrame.LookVector
local heading=Vector3.new(direction.X,0,direction.Z)
heading=heading.Magnitude>0.01 and heading.Unit or Vector3.new(0,0,-1)
local separation=state.aimPoint-heading*aa.ZipAttackStopDistance-position
local radius=math.clamp(separation.Magnitude,aa.ZipAttackMinimumGap,aa.ZipAttackStopDistance+0.4)
local away=separation.Magnitude>0.01 and separation.Unit or -heading
state.followPoint=position+away*radius
return state.followPoint,state.targetVelocity
end
function U.zipAttackCanRelease(state)
local delta=state.targetRoot.Position-root.Position
if delta.Magnitude>aa.ZipAttackStopDistance+0.6 then return false end
if state.snapSettleUntil and os.clock()<state.snapSettleUntil then return false end
 
local horizon=state.predictionTime or aa.ZipAttackPrediction
local velocity=state.targetVelocity or state.targetRoot.AssemblyLinearVelocity
local relative=velocity-root.AssemblyLinearVelocity
local acceleration=state.targetAcceleration or Vector3.zero
return (delta+relative*horizon+acceleration*(0.5*horizon*horizon)).Magnitude<=aa.ZipAttackStopDistance+0.9
end
function U.zipAttackSnap(state)
if not aa.ZipAttackSnapBehind then return false end
local targetRoot=state.targetRoot
local destination=state.followPoint
if not destination then destination=U.zipAttackSample(state,1/60)end
local aim=state.aimPoint or targetRoot.Position
local params=RaycastParams.new()
params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={ad,aq,state.targetCharacter}
if workspace:Raycast(targetRoot.Position,destination-targetRoot.Position,params)then return false end
local overlap=OverlapParams.new()
overlap.FilterType=Enum.RaycastFilterType.Exclude
overlap.FilterDescendantsInstances={ad,aq,state.targetCharacter}
local facing=CFrame.lookAt(destination,aim)
for _,part in ipairs(workspace:GetPartBoundsInBox(facing,Vector3.new(2.4,4,2.4),overlap))do
if part.CanCollide then return false end
end
root.CFrame=facing
root.AssemblyLinearVelocity=state.targetVelocity or targetRoot.AssemblyLinearVelocity
state.snapSettleUntil=state.snapSettleUntil or (os.clock()+0.04)
state.followOffset=targetRoot.CFrame:VectorToObjectSpace(destination-targetRoot.Position)
return true
end
function U.zipAttackHide(state)
local now=os.clock()
 
if state.hidden or state.hideUsed or not state.held or U.zipAttackChargeReady(state)
or now<(state.surfaceUntil or 0) or now-state.chargeAt>=aa.ZipAttackBelowTime then return end
if (state.targetRoot.Position-root.Position).Magnitude>aa.ZipAttackHideRange then return end
local params=RaycastParams.new()
params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={ad,aq,state.targetCharacter}
local floor=workspace:Raycast(root.Position,Vector3.new(0,-20,0),params)
if not floor then return end
local y=floor.Position.Y-aa.ZipAttackHideDepth
if y<workspace.FallenPartsDestroyHeight+15 then return end
state.surfaceReturn=root.CFrame
state.hidden=true state.hideUsed=true state.hideY=y
state.hideUntil=math.min(now+aa.ZipAttackBelowTime,state.chargeAt+aa.ZipAttackBelowTime)
root.CFrame=CFrame.new(root.Position.X,y,root.Position.Z)*root.CFrame.Rotation
root.AssemblyLinearVelocity=Vector3.zero
U.zipAttackSetNoclip(state)
aD.drive("zipattack",Vector3.zero)
end
function U.zipAttackSurfaceDue(state)
return state.hidden and (os.clock()>=(state.hideUntil or 0) or U.zipAttackChargeReady(state))
end
function U.zipAttackSurface(state)
if not state.hidden then return true end
if not U.zipAttackSnap(state)then
root.CFrame=state.surfaceReturn
root.AssemblyLinearVelocity=Vector3.zero
end
state.hidden=false state.hideUntil=nil
state.surfaceUntil=os.clock()+aa.ZipAttackAboveTime
 
 
return true
end
function U.zipAttackFollow(state,dt)
local delta=state.targetRoot.Position-root.Position
 
 
local desired,targetVelocity=U.zipAttackSample(state,dt)
local errorVector=desired-root.Position
 
local remaining=state.held and math.max(0,aa.ZipAttackChargeTime-(os.clock()-state.chargeAt)) or nil
local velocity=U.zipAttackTimedVelocity(errorVector,targetVelocity,remaining,dt)
if state.travelSound then
local approachSpeed=(velocity-state.targetRoot.AssemblyLinearVelocity).Magnitude
local intensity=math.clamp(approachSpeed/aa.ZipAttackSpeed,0,1)
state.travelSound.Volume=aa.ZipAttackTravelVolume*intensity
state.travelSound.PlaybackSpeed=0.8+0.45*intensity
end
aD.drive("zipattack",velocity)
local aim=(state.aimPoint or state.targetRoot.Position)-root.Position
local horizontal=Vector3.new(aim.X,0,aim.Z)
if horizontal.Magnitude>0.01 then root.CFrame=CFrame.lookAt(root.Position,root.Position+horizontal)end
return true,delta.Magnitude
end
function U.zipAttackRun(state)
local function stop(reason,followBody)U.zipAttackStop(reason,state,followBody)end
 
U.zipAttackSetNoclip(state)
state.noclipConnection=ae.PreSimulation:Connect(function()
if U.zipAttack==state and state.character.Parent then U.zipAttackSetNoclip(state)end
end)
humanoid:EquipTool(state.tool)
ae.Heartbeat:Wait()
if not U.zipAttackValid(state) or state.tool.Parent~=ad then stop("Fists could not be equipped.")return end
local locked,message=U.zipAttackLock(state)
if not locked then stop(message)return end
if aa.ZipAttackSounds then
U.av(bJ,0.95,1.05)
state.travelSound=U.R("HuybypassZipTravel",aa.DashSoundId,0)
if state.travelSound then state.travelSound.Looped=true state.travelSound:Play()end
end
local dt=1/60
local lastStatus=-math.huge
while U.zipAttack==state do
if U.zipAttackKnocked(state)then stop("Target knocked — C attack finished.",true)return end
if not U.zipAttackValid(state) or state.tool.Parent~=ad then stop("Zip attack cancelled: character or target unavailable.")return end
if state.inputError then stop("Input forwarding failed: "..state.inputError)return end
U.zipAttackSample(state,dt)  
 
if not state.held and not state.releasing and state.tool.Enabled
and U.zipAttackArrived(state)then
U.zipAttackPress(state)
end
U.zipAttackHide(state)
local following,distance=true,(state.targetRoot.Position-root.Position).Magnitude
if state.hidden then
if U.zipAttackSurfaceDue(state)then
U.zipAttackSurface(state)
else
local target=state.targetRoot.Position
root.CFrame=CFrame.new(target.X,state.hideY,target.Z)*root.CFrame.Rotation
root.AssemblyLinearVelocity=Vector3.zero
U.zipAttackSetNoclip(state)
aD.drive("zipattack",Vector3.zero)
if state.travelSound then state.travelSound.Volume=0 end
end
end
if not state.hidden then
following,distance=U.zipAttackFollow(state,dt)
 
if U.zipAttackChargeReady(state)
or(state.strikeUntil and os.clock()<state.strikeUntil)then
U.zipAttackSnap(state)
distance=(state.targetRoot.Position-root.Position).Magnitude
end
end
if not following then stop(distance)return end
if state.reassert and state.held and os.clock()-(state.lastReassertAt or 0)>=0.25 then
state.reassert=false
state.reassertCount=(state.reassertCount or 0)+1
if state.reassertCount>3 then stop("Input repeatedly interrupted; zip attack stopped to prevent a retry loop.")return end
state.lastReassertAt=os.clock()
state.chargeAt=state.lastReassertAt
state.press()
end
if state.releasing then
 
local seenRelease=false
for _,group in ipairs(state.inputGuard.groups)do
if group.direction=="up" and group.seen then seenRelease=true end
end
if seenRelease and state.tool.Enabled and os.clock()>=(state.strikeUntil or 0) then
state.releasing=false
elseif os.clock()-state.releaseAt>1 and not seenRelease then
stop("Mouse release was not observed; executor input may be unsupported.")return
end
elseif not state.hidden and U.zipAttackChargeReady(state)then
if distance>aa.ZipAttackStopDistance+0.6 and U.zipAttackSnap(state)then
distance=(state.targetRoot.Position-root.Position).Magnitude
end
if U.zipAttackCanRelease(state)then U.zipAttackRelease(state)end
end
if state.held and os.clock()-state.chargeAt>0.75 then
local observed=false
for _,group in ipairs(state.inputGuard.groups)do
if group.direction=="down" and group.seen then observed=true end
end
if not observed then stop("Mouse hold was not observed; no punch fallback is used.")return end
end
if not state.hidden and os.clock()>=(state.nextClearCheck or 0)then
state.nextClearCheck=os.clock()+0.1
if U.zipAttackPositionClear(state)then state.safeCFrame=root.CFrame end
end
if os.clock()-lastStatus>0.3 then
lastStatus=os.clock()
local phase=state.held and("holding LMB "..string.format("%.1f",os.clock()-state.chargeAt).."s")
or (state.releasing and"attack released; checking KO" or"approaching; charge starts on arrival")
U.zipStatus(state.target.DisplayName.." | "..phase.." | "..string.format("%.1f",distance).." studs | "..aa.ZipAttackKey.Name.." cancels",true)
end
dt=math.clamp(ae.Heartbeat:Wait(),1/240,0.05)
end
end

function U.zipAttackPickTarget(camera,screenPoint,params)
local target,character
local bestPixels=math.huge
for _,candidate in ipairs(bo:GetPlayers())do
if candidate~=player then
local char=candidate.Character
local hrp=char and char:FindFirstChild("HumanoidRootPart")
local hum=char and char:FindFirstChildOfClass("Humanoid")
if hrp and hum and hum.Health>0 and (hrp.Position-root.Position).Magnitude<=aa.ZipAttackRange
and not char:FindFirstChildOfClass("ForceField") and not U.by(char) and not U.by(char:FindFirstChild("BodyEffects"))then
local projected,onScreen=camera:WorldToViewportPoint(hrp.Position)
local pixels=(Vector2.new(projected.X,projected.Y)-screenPoint).Magnitude
if onScreen and pixels<bestPixels then
target=candidate character=char bestPixels=pixels
end
end
end
end
return target,character
end
function U.zipAttackStart()
if not ec.hvh then return end
if U.carryActive and U.carryActive()then U.zipStatus("Carry mode: use the game controls.")return end
if U.zipAttack then U.zipAttackStop("Zip attack cancelled.")return end
if not U.d then return end
if not U.a then U.zipStatus("Character controller is not ready yet.")return end
if U.m then U.zipStatus("Controller is suspended; recover before zipping.")return end
if not U.k then U.zipStatus("Click back into the game window.")return end
if U.ad or U.F then U.zipStatus("Close the controls/tutorial panel first.")return end
if bw:GetFocusedTextBox() then U.zipStatus("Close chat or leave the text box first.")return end
if not U.f() then U.zipStatus("Character state blocks movement (KO, ragdoll, or disabled joints).")return end
local camera=workspace.CurrentCamera
if not camera then U.zipStatus("Camera is unavailable.")return end
local params=RaycastParams.new()
params.FilterType=Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances={ad,aq}
 
local screenPoint=Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2)
if not U.M and bw.MouseBehavior==Enum.MouseBehavior.Default then
local inset=game:GetService("GuiService"):GetGuiInset()
screenPoint=bw:GetMouseLocation()-inset
end
local target,character=U.zipAttackPickTarget(camera,screenPoint,params)
if not target then U.zipStatus("No eligible visible player within "..aa.ZipAttackRange.." studs.")return end
local targetRoot=character:FindFirstChild("HumanoidRootPart")
local targetHum=character:FindFirstChildOfClass("Humanoid")
if not targetRoot or not targetHum or (targetRoot.Position-root.Position).Magnitude>aa.ZipAttackRange then
U.zipStatus("Zip attack: target out of range.")return
end
local tool
local backpack=player:FindFirstChildOfClass("Backpack")
for _,name in ipairs(aa.ZipAttackToolNames)do
local candidate=ad:FindFirstChild(name) or (backpack and backpack:FindFirstChild(name))
if candidate and candidate:IsA("Tool")then tool=candidate break end
end
if not tool then
local found={}
for _,container in ipairs({ad,backpack})do
for _,item in ipairs(container:GetChildren())do
if item:IsA("Tool")then table.insert(found,item.Name)end
end
end
U.zipStatus("Fists not found. Tools: "..(#found>0 and table.concat(found,", ")or"none"))return
end
if not U.gunCompatibility()then
local env=getfenv(0)
if type(env.getconnections)~="function" or type(env.mouse1press)~="function" or type(env.mouse1release)~="function" then
U.zipStatus("Executor needs getconnections + mouse1press + mouse1release for exclusive held input.")return
end
if bw:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)then U.zipStatus("Release left click, then press the zip key.")return end
end
U.H()U.l()U.A()U.z()dance.stop()U.an()
local state={root=root,character=ad,humanoid=humanoid,rotate=humanoid.AutoRotate,
target=target,targetCharacter=character,targetRoot=targetRoot,targetHum=targetHum,tool=tool,startCFrame=root.CFrame,safeCFrame=root.CFrame}
local away=Vector3.new(root.Position.X-targetRoot.Position.X,0,root.Position.Z-targetRoot.Position.Z)
if away.Magnitude<0.01 then away=-targetRoot.CFrame.LookVector end
state.followOffset=targetRoot.CFrame:VectorToObjectSpace(away.Unit*aa.ZipAttackStopDistance)
U.zipAttack=state
U.gunOrbitGuardStart(state)
if not U.zipAttackValid(state) then U.zipAttackStop("Zip attack: target unavailable.")return end
humanoid.AutoRotate=false
local visual=Instance.new("Folder")
visual.Name="ZipAttackWeb"
visual.Parent=aq
state.visual=visual
local from=Instance.new("Attachment")
from.Parent=root
 
local to=Instance.new("Attachment")
to.Parent=targetRoot
local beam=Instance.new("Beam")
beam.Attachment0=from beam.Attachment1=to
beam.Width0=0.1 beam.Width1=0.1 beam.FaceCamera=true
beam.Color=ColorSequence.new(Color3.new(1,1,1))
beam.Parent=visual
state.webBeam=beam
visual.Destroying:Once(function()from:Destroy()to:Destroy()end)
U.zipStatus("Zipping to "..target.DisplayName)
task.spawn(function()
local ok,err=pcall(U.zipAttackRun,state)
if not ok and U.zipAttack==state then
U.zipAttackStop("Zip attack stopped: input or movement failed.")
if aa.Debug then warn("Huybypass zip attack: "..tostring(err))end
end
end)
end

function U.carryActive()
if not ad then return false end
local effects=ad:FindFirstChild("BodyEffects")
local grabbed=effects and effects:FindFirstChild("Grabbed")
if not grabbed then return false end
if grabbed:IsA("ObjectValue")then return grabbed.Value~=nil end
if grabbed:IsA("StringValue")then
local value=grabbed.Value
return value~="" and value~="nil" and value~="None"
end
if grabbed:IsA("BoolValue")then return grabbed.Value end
return false
end
function U.carryUnlock()
if U.carryBinding then
U.carryBinding=false
game:GetService("ContextActionService"):UnbindAction("HuybypassCarrySwingE")
end
local guard=U.carryGuard U.carryGuard=nil
if guard then
for _,group in ipairs(guard)do
if group.wrapper then group.wrapper:Disconnect()end
for _,connection in ipairs(group.saved)do pcall(function()connection:Enable()end)end
end
end
end
function U.carryLock()
if U.carryBinding then return end
local action=game:GetService("ContextActionService")
U.carryBinding=true
 
action:BindActionAtPriority("HuybypassCarrySwingE",function(_,inputState)
if not U.carryActive() or bw:GetFocusedTextBox() or U.F or U.ad or not U.k then return Enum.ContextActionResult.Pass end
if inputState==Enum.UserInputState.Begin then U.bn(Enum.KeyCode.E,false)
elseif inputState==Enum.UserInputState.End then U.dO(Enum.KeyCode.E)
elseif inputState==Enum.UserInputState.Cancel then U.o(false)end
return Enum.ContextActionResult.Sink
end,false,10000,Enum.KeyCode.E)
if bw.TouchEnabled then return end
local env=getfenv(0)
if type(env.getconnections)~="function" then U.h("Carry: native action bindings blocked; raw E listeners need getconnections.")return end
local mouse=player:GetMouse()
local groups={} U.carryGuard=groups
local ok,err=pcall(function()
for _,definition in ipairs({{bw.InputBegan,true},{bw.InputEnded,true},{mouse.KeyDown,false},{mouse.KeyUp,false}})do
local signal,typed=definition[1],definition[2]
local group={saved={}} table.insert(groups,group)
for _,connection in ipairs(env.getconnections(signal))do
if connection.Enabled==true and type(connection.Function)=="function" then
if type(connection.Disable)~="function" or type(connection.Enable)~="function" or type(connection.Fire)~="function" then error("Missing reversible input control")end
table.insert(group.saved,connection)connection:Disable()
end
end
group.wrapper=signal:Connect(function(...)
local args=table.pack(...)
local isE=(typed and args[1] and args[1].KeyCode==Enum.KeyCode.E)
or (not typed and type(args[1])=="string" and string.lower(args[1])=="e")
if isE and U.carryActive() and not bw:GetFocusedTextBox() and not U.F and not U.ad then return end
for _,connection in ipairs(group.saved)do
pcall(function()connection:Fire(table.unpack(args,1,args.n))end)
end
end)
end
end)
if not ok then
 
for _,group in ipairs(groups)do
if group.wrapper then group.wrapper:Disconnect()end
for _,connection in ipairs(group.saved)do pcall(function()connection:Enable()end)end
end
U.carryGuard=nil
U.h("Carry: raw E suppression unavailable; action-binding suppression remains.")
if aa.Debug then warn(tostring(err))end
end
end
U.b(ae.PreSimulation,function()
local carrying=U.carryActive()
if U.noSitStep then U.noSitStep()end
if carrying~=U.wasCarrying then
U.wasCarrying=carrying
U.bk(false)
for _,joint in ipairs(bm)do if joint.joint.Parent then U.aT(joint)end end
if not ai and not ah and not as then U.aC()end
end
if carrying then
if U.zipAttack then U.zipAttackStop("Carrying: swing stays available.")end
if not U.carryBinding then U.carryLock()end
elseif U.carryBinding or U.carryGuard then U.carryUnlock()end
end)

function U.gunPurchaseCancel()
local job=U.gunPurchase
if not job then return end
U.gunPurchase=nil
if job.lock then job.lock:Disconnect()end
game:GetService("ContextActionService"):UnbindAction("HuybypassPurchaseLock")
if job.humanoid and job.humanoid.Parent then
job.humanoid.WalkSpeed=job.walk job.humanoid.JumpPower=job.jump job.humanoid.JumpHeight=job.height
end
if root==job.root and ad==job.character and job.root.Parent then
job.root.CFrame=job.position job.root.AssemblyLinearVelocity=Vector3.zero
end
U.gunOrbitRelease(job)
end
task.spawn(function()
if not ec.hvh then return end
local remote=cV:WaitForChild("MainEvent",10)
if remote and remote:IsA("RemoteEvent") and not player:GetAttribute("HuybypassMacroCodeAttempted")then
local ok=pcall(function()remote:FireServer("EnterPromoCode","MACRO!")end)
if ok then player:SetAttribute("HuybypassMacroCodeAttempted",true)end
end
end)

aa.GunOrbitKey=Enum.KeyCode.X
aa.GunOrbitRadius=12
aa.GunOrbitHeight=4
aa.GunRandomMoveInterval=0.10
aa.GunRandomMobileMoveInterval=0.16
-- Ammo purchases are confirmed individually; no fixed batch.
aa.GunOrbitShotInterval=0.05
aa.GunOrbitMobileShotInterval=0.10
 
function U.gunOrbitGuardStep(state)
local hum=state.humanoid
if not state.guardStates or not hum.Parent or hum.Health<=0 then return end
for kind in pairs(state.guardStates)do
if hum:GetStateEnabled(kind)then hum:SetStateEnabled(kind,false)end
end
local seat=hum.SeatPart
if seat then
local weld=seat:FindFirstChild("SeatWeld")
if weld and weld:IsA("JointInstance")then
local p0,p1=weld.Part0,weld.Part1
if (p0 and p0:IsDescendantOf(state.character))or(p1 and p1:IsDescendantOf(state.character))then weld:Destroy()end
end
end
if hum.Sit then hum.Sit=false end
local kind=hum:GetState()
local accidental=not U.by(state.character)and not U.by(hum)and not U.by(state.character:FindFirstChild("BodyEffects"))
if accidental and (hum.PlatformStand or kind==Enum.HumanoidStateType.FallingDown or kind==Enum.HumanoidStateType.Ragdoll or kind==Enum.HumanoidStateType.GettingUp or kind==Enum.HumanoidStateType.Physics or kind==Enum.HumanoidStateType.PlatformStanding)then
hum.PlatformStand=false
if state.root.Parent then
state.root.CFrame=U.gunOrbitUpright(state.root.CFrame)
state.root.AssemblyAngularVelocity=Vector3.zero
end
hum:ChangeState(hum.FloorMaterial==Enum.Material.Air and Enum.HumanoidStateType.Freefall or Enum.HumanoidStateType.Running)
end
if hum:GetState()==Enum.HumanoidStateType.Seated then
hum:ChangeState(hum.FloorMaterial==Enum.Material.Air and Enum.HumanoidStateType.Freefall or Enum.HumanoidStateType.Running)
end
end
function U.gunOrbitGuardStart(state)
if U.attackRecoveryEnd then U.attackRecoveryEnd()end
local hum=state.humanoid
state.guardStates={}
for _,kind in ipairs({Enum.HumanoidStateType.Seated,Enum.HumanoidStateType.FallingDown,Enum.HumanoidStateType.Ragdoll})do
state.guardStates[kind]=hum:GetStateEnabled(kind)
hum:SetStateEnabled(kind,false)
end
local function enforce()U.gunOrbitGuardStep(state)end
state.guardConnections={hum:GetPropertyChangedSignal("Sit"):Connect(enforce),hum:GetPropertyChangedSignal("SeatPart"):Connect(enforce),hum.Seated:Connect(enforce)}
enforce()
end
function U.gunOrbitUpright(cf)
local forward=Vector3.new(cf.LookVector.X,0,cf.LookVector.Z)
if forward.Magnitude<0.01 then forward=Vector3.new(0,0,-1)end
return CFrame.lookAt(cf.Position,cf.Position+forward.Unit,Vector3.yAxis)
end
function U.gunOrbitPositionClear(state,cf)
local overlap=OverlapParams.new()
overlap.FilterType=Enum.RaycastFilterType.Exclude
 
overlap.FilterDescendantsInstances={state.character,aq}
for _,part in ipairs(workspace:GetPartBoundsInBox(cf,Vector3.new(3,5,3),overlap))do
if part.CanCollide then return false end
end
return true
end
function U.gunOrbitRelease(state)
local hum,r=state.humanoid,state.root
if root==r and ad==state.character and r.Parent then
local upright=U.gunOrbitUpright(r.CFrame)
if not U.gunOrbitPositionClear(state,upright)then
local candidates={state.safeCFrame or upright,state.startCFrame or state.position or upright}
for height=3,18,3 do candidates[#candidates+1]=upright+Vector3.new(0,height,0)end
for _,candidate in ipairs(candidates)do
candidate=U.gunOrbitUpright(candidate)
if U.gunOrbitPositionClear(state,candidate)then upright=candidate break end
end
end
 
r.CFrame=upright
r.AssemblyLinearVelocity=Vector3.zero r.AssemblyAngularVelocity=Vector3.zero
dd=false ev=r.Position.Y lastVelY=0 landUntil=0 releaseEnd=0 diving=false
end
U.gunOrbitGuardStep(state)
U.zipAttackRestoreCollision(state)
if hum and hum.Parent and hum.Health>0 and root==r and ad==state.character
and not U.by(state.character)and not U.by(hum)and not U.by(state.character:FindFirstChild("BodyEffects"))then
hum.Sit=false hum.PlatformStand=false
hum:ChangeState(hum.FloorMaterial==Enum.Material.Air and Enum.HumanoidStateType.Freefall or Enum.HumanoidStateType.Running)
end
if U.aC then U.aC()end
for _,joint in ipairs(bm)do if joint.joint.Parent then U.aT(joint)end end
if U.d and U.a and not U.m and hum and hum.Parent and hum.Health>0 and root==r and ad==state.character
and not U.by(state.character)and not U.by(hum)and not U.by(state.character:FindFirstChild("BodyEffects"))then
U.attackRecovery=state
state.recoveryUntil=os.clock()+1
state.recoveryConnection=ae.PreSimulation:Connect(U.attackRecoveryStep)
else U.attackGuardRestore(state)end
end
function U.attackGuardRestore(state)
if state.bodyCollisionGuard then state.bodyCollisionGuard:Destroy()state.bodyCollisionGuard=nil end
for _,connection in ipairs(state.guardConnections or {})do connection:Disconnect()end
state.guardConnections=nil
local saved=state.guardStates state.guardStates=nil
if state.humanoid and state.humanoid.Parent then
for kind,enabled in pairs(saved or {})do if U.d and kind==Enum.HumanoidStateType.Seated then state.humanoid:SetStateEnabled(kind,false)else state.humanoid:SetStateEnabled(kind,enabled)end end
end
end
function U.attackRecoveryEnd()
local state=U.attackRecovery
if not state then return end
U.attackRecovery=nil
if state.recoveryConnection then state.recoveryConnection:Disconnect()state.recoveryConnection=nil end
U.attackGuardRestore(state)
end
function U.attackRecoveryStep()
local state=U.attackRecovery
if not state then return end
local hum,r=state.humanoid,state.root
if not U.d or not U.a or U.m or root~=r or ad~=state.character or not r.Parent or not hum.Parent or hum.Health<=0
or U.by(state.character)or U.by(hum)or U.by(state.character:FindFirstChild("BodyEffects"))
or ai or ah or as or ac or U.al or os.clock()<au then U.attackRecoveryEnd()return end
U.gunOrbitGuardStep(state)
 
if r.CFrame.UpVector.Y<0.98 then r.CFrame=U.gunOrbitUpright(r.CFrame)end
r.AssemblyAngularVelocity=Vector3.zero
if os.clock()>=state.recoveryUntil then U.attackRecoveryEnd()end
end
function U.gunBodyFollowStop()
local state=U.gunBodyFollow
if not state then return end
U.gunBodyFollow=nil
if state.followConnection then state.followConnection:Disconnect()state.followConnection=nil end
U.gunOrbitRelease(state)
end
function U.gunOrbitFollow(state)
U.gunBodyFollow=state
state.root.CFrame=U.gunOrbitUpright(state.root.CFrame)
state.root.AssemblyLinearVelocity=Vector3.zero state.root.AssemblyAngularVelocity=Vector3.zero
dd=false landUntil=0 releaseEnd=0 diving=false
U.aC()
for _,joint in ipairs(bm)do if joint.joint.Parent then U.aT(joint)end end
local autoStomp=not state.sentry and U.autoKill and U.autoKill.target==state.target
local deadline=os.clock()+(autoStomp and 13 or 2)
local offset=state.root.Position-state.targetRoot.Position
offset=Vector3.new(offset.X,0,offset.Z)
offset=autoStomp and Vector3.new(0,3,0)or(offset.Magnitude>0.01 and offset.Unit or Vector3.new(0,0,1))*5+Vector3.new(0,4,0)
state.followConnection=ae.PreSimulation:Connect(function()
local ok,err=pcall(function()
if U.gunBodyFollow~=state then return end
U.gunOrbitGuardStep(state)
if os.clock()>=deadline or not U.f()or not U.k or root~=state.root or ad~=state.character
or not state.targetRoot.Parent or not U.zipAttackKnocked(state)
or state.humanoid.MoveDirection.Magnitude>0.05 or state.humanoid.Jump then U.gunBodyFollowStop()return end
local body=autoStomp and(state.targetCharacter:FindFirstChild("UpperTorso")or state.targetCharacter:FindFirstChild("Torso"))or state.targetRoot
local destination=body.Position+offset
if destination.Y<=workspace.FallenPartsDestroyHeight+10 then U.gunBodyFollowStop()return end
U.zipAttackSetNoclip(state)
local face=Vector3.new(state.targetRoot.Position.X,destination.Y,state.targetRoot.Position.Z)
if(face-destination).Magnitude<0.01 then face=destination+Vector3.new(0,0,-1)end
local cf=CFrame.lookAt(destination,face)
root.CFrame=cf
root.AssemblyLinearVelocity=Vector3.zero root.AssemblyAngularVelocity=Vector3.zero
if U.gunOrbitPositionClear(state,cf)then state.safeCFrame=cf end
end)
if not ok then U.gunBodyFollowStop()if aa.Debug then warn(err)end end
end)
end
function U.gunOrbitStop(reason,followBody)
local state=U.gunOrbit
if not state then return end
U.gunOrbit=nil
if state.copyAimBinding then ae:UnbindFromRenderStep(state.copyAimBinding)end
U.copyCameraRestore(state)
if state.copyReloadRelease then pcall(state.copyReloadRelease)state.copyReloadRelease=nil end
if reason and U.sentryTarget==state.target then U.sentryTarget=nil end
game:GetService("ContextActionService"):UnbindAction("HuybypassGunMovementLock")
if state.connection then state.connection:Disconnect()end
if state.noclipConnection then state.noclipConnection:Disconnect()state.noclipConnection=nil end
for _,weapon in ipairs(state.weapons or {state.tool})do pcall(function()weapon:Deactivate()end)end
aD.destroy("zipattack")
if humanoid==state.humanoid and root==state.root then
humanoid.AutoRotate=state.rotate
if state.walkSpeed~=nil then humanoid.WalkSpeed=state.walkSpeed end
if state.jumpPower~=nil then humanoid.JumpPower=state.jumpPower end
if state.jumpHeight~=nil then humanoid.JumpHeight=state.jumpHeight end
root.AssemblyLinearVelocity=Vector3.zero
root.AssemblyAngularVelocity=Vector3.zero
end
if followBody and not state.sentry and root==state.root and ad==state.character and state.targetRoot and state.targetRoot.Parent then
 
U.gunOrbitFollow(state)
else U.gunOrbitRelease(state)end
if reason then U.h(reason)end
end
U.isOriginalDaHood=game.PlaceId==2788229376
aa.GunOrbitDefaultGun=U.isOriginalDaHood and "[LMG]"or "[Revolver]"
function U.gunLoadout()
if not U.isOriginalDaHood then return {"[Revolver]"}end
return (U.flameMode and not U.sentryTarget)and {"[Flamethrower]"}or{"[LMG]","[Rifle]"}
end
function U.gunFind(parent,name)
if parent then for _,item in ipairs(parent:GetChildren())do if item.Name:lower()==name:lower()then return item end end end
end
-- Read magazine and reserve separately; nil means unknown, never zero.
function U.gunAmmoNumber(object)
if not object or not object:IsA("ValueBase")then return nil end
local n=tonumber(object.Value)
if n and n==n and n>=0 and n<math.huge then return n end
end
function U.gunReserve(tool)
for _,name in ipairs({"SavedAmmo","ReserveAmmo","Reserve"})do
local n=U.gunAmmoNumber(tool:FindFirstChild(name))
if n~=nil then return n end
end
local data=player:FindFirstChild("DataFolder")
local inventory=data and data:FindFirstChild("Inventory")
if not inventory then return nil end
local entry=U.gunFind(inventory,tool.Name)or U.gunFind(inventory,tool.Name:gsub("[%[%]]",""))
return U.gunAmmoNumber(entry)
end
function U.gunShopToken(name)
local token=tostring(name):match("%[([^%]]+)%]")or tostring(name)
return token:lower():gsub("^%s*%d+%s+",""):gsub("^%s+",""):gsub("%s+$","")
end
function U.gunEnsureAmmo(tool,active,buyOne)
if not U.isOriginalDaHood then return end
local ammo=tool:FindFirstChild("Ammo")
local function loaded()return U.gunAmmoNumber(ammo)end
U.gunAmmoPurchasePending=U.gunAmmoPurchasePending or setmetatable({},{__mode="k"})
local pending=U.gunAmmoPurchasePending
if loaded()==nil then error("Magazine count unavailable: "..tool.Name)end
if loaded()>0 then pending[tool]=nil return end
local function check()if not active()then error("Purchase/reload cancelled.")end end
local function reload()
check()
if (loaded()or 0)>0 then return true end
local remote=cV:FindFirstChild("MainEvent")
if not remote or not remote:IsA("RemoteEvent")then error("Reload remote unavailable.")end
humanoid:EquipTool(tool)
remote:FireServer("Reload",tool)
local deadline=os.clock()+6
repeat task.wait(0.05)check()until (loaded()or 0)>0 or os.clock()>=deadline
return (loaded()or 0)>0
end
local reserve=U.gunReserve(tool)
-- A known empty reserve goes straight to the shop. Unknown reserves get a reload first.
if reserve~=0 and reload()then pending[tool]=nil return end
reserve=U.gunReserve(tool)
if reserve and reserve>0 then error("Reserve ammo remains but reload failed; no ammo bought for "..tool.Name)end
if pending[tool]and os.clock()-pending[tool]<30 then error("Previous ammo purchase unconfirmed; wait before buying another pack.")end
check()
buyOne("["..tool.Name:sub(2,-2).." Ammo]",function()
check()
local current=U.gunReserve(tool)
if (loaded()or 0)>0 or(current and current>0)then return false end
if pending[tool]and os.clock()-pending[tool]<30 then return false end
pending[tool]=os.clock()
return true
end)
local deadline=os.clock()+3
repeat
check()
if (loaded()or 0)>0 then pending[tool]=nil return end
reserve=U.gunReserve(tool)
if reserve and reserve>0 then break end
task.wait(0.05)
until os.clock()>=deadline
-- Magazine growth confirms a purchase even if reserve values are not replicated.
if reload()then pending[tool]=nil return end
error("Ammo purchase/reload not confirmed; no repeat purchase sent. Check cash and shop availability.")
end

-- Returns ready, waiting, restock, or error. A single shared reload prevents spam.
function U.copyCameraSave(state)
if U.isOriginalDaHood or state.copyCamera then return end
local cam=workspace.CurrentCamera
if cam then state.copyCamera={camera=cam,kind=cam.CameraType,subject=cam.CameraSubject,pose=cam.CFrame,mouseBehavior=bw.MouseBehavior}end
end
function U.copyCameraRestore(state)
if state.copyWaitBinding then ae:UnbindFromRenderStep(state.copyWaitBinding)state.copyWaitBinding=nil end
local saved=state.copyCamera state.copyCamera=nil
if saved and workspace.CurrentCamera==saved.camera then
local cam=saved.camera
bw.MouseBehavior=saved.mouseBehavior
cam.CameraType=saved.kind
cam.CameraSubject=(saved.subject and saved.subject.Parent)and saved.subject or humanoid
cam.CFrame=saved.pose
end
end
function U.copyWaitCamera(state)
if U.isOriginalDaHood then return end
if U.autoKillView then U.autoKillViewStop()end
U.copyCameraSave(state)
if not state.copyCamera then return end
state.copyWaitBinding="HuybypassCopyWaitCamera"
ae:BindToRenderStep(state.copyWaitBinding,Enum.RenderPriority.Last.Value,function()
local saved=state.copyCamera
if saved and workspace.CurrentCamera==saved.camera then
saved.camera.CameraType=Enum.CameraType.Scriptable
saved.camera.CFrame=saved.pose
end
end)
end
function U.copyAim(state)
if U.isOriginalDaHood or U.gunOrbit~=state then return end
local cam=workspace.CurrentCamera
local char=state.targetCharacter
local part=char and (char:FindFirstChild("UpperTorso")or char:FindFirstChild("Torso")or state.targetRoot)
if not cam or not part or not part.Parent then return end
U.copyCameraSave(state)
state.copyViewOffset=state.copyViewOffset or Vector3.new(0,8,22)
cam.CameraType=Enum.CameraType.Scriptable
cam.CFrame=CFrame.lookAt(part.Position+state.copyViewOffset,part.Position)
-- Keep aim centered instead of rotating the camera whenever the cursor moves.
bw.MouseBehavior=Enum.MouseBehavior.LockCenter
cam.Focus=CFrame.new(part.Position)
end
function U.gunReloadStep(state,weapon,now)
if not U.isOriginalDaHood then
local rounds=U.gunAmmoNumber(weapon:FindFirstChild("Ammo"))
if rounds==nil then
local attribute=weapon:GetAttribute("Ammo")
if type(attribute)=="number"and attribute>=0 and attribute<math.huge then rounds=attribute end
end
if state.reload then
if state.reload.unobserved then
if now<state.reload.deadline then return "waiting"end
state.reload=nil state.copyReloadAt=now+2.5 state.nextShot=0
elseif rounds and rounds>0 then
state.reload=nil state.copyReloadAt=now+2.5 state.nextShot=0
elseif now>=state.reload.deadline then
state.reload=nil return "error","R reload did not refill the magazine; stopped without buying ammo."
else return "waiting"end
end
if rounds and rounds>0 then state.externalReloadUntil=nil return "ready"end
if rounds==nil then
-- No replicated count: periodically request reload, without claiming it succeeded.
state.copyReloadAt=state.copyReloadAt or(now+2.5)
if now<state.copyReloadAt then return "ready"end
end
weapon:Deactivate()
state.reload={weapon=weapon,deadline=now+(rounds==nil and 1.2 or 8),unobserved=rounds==nil}
local env=getfenv(0)
local press,release
if type(env.keypress)=="function"and type(env.keyrelease)=="function"then
press=function()env.keypress(0x52)end
release=function()env.keyrelease(0x52)end
else
press=function()game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.R,false,game)end
release=function()game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.R,false,game)end
end
local ok,err=pcall(press)
if not ok then pcall(release)state.reload=nil return "error","R input unavailable: "..tostring(err)end
state.copyReloadRelease=release
task.delay(0.08,function()
pcall(release)
if state.copyReloadRelease==release then state.copyReloadRelease=nil end
end)
return "waiting"
end
local effects=state.character:FindFirstChild("BodyEffects")
local reloading=effects and effects:FindFirstChild("Reload")
if state.externalReloadUntil and not(reloading and reloading:IsA("BoolValue")and reloading.Value)then state.externalReloadUntil=nil end
local rounds=U.gunAmmoNumber(weapon:FindFirstChild("Ammo"))
if rounds==nil then return "error","Magazine count unavailable: "..weapon.Name end
if rounds>0 then
if state.reload and state.reload.weapon==weapon then state.reload=nil end
return "ready"
end
if state.reload then
if now>=state.reload.deadline and state.reload.weapon==weapon then
state.reload=nil
local reserve=U.gunReserve(weapon)
if reserve==nil or reserve==0 then return "restock"end
return "error","Reserve ammo remains but reload failed; stopped without buying more."
end
return "waiting"
end
if U.gunReserve(weapon)==0 then return "restock"end
if reloading and reloading:IsA("BoolValue")and reloading.Value then
state.externalReloadUntil=state.externalReloadUntil or(now+8)
if now>=state.externalReloadUntil then return "error","Existing reload did not finish."end
return "waiting"
end
state.externalReloadUntil=nil
local remote=cV:FindFirstChild("MainEvent")
if not remote or not remote:IsA("RemoteEvent")then return "error","Reload remote unavailable."end
state.reload={weapon=weapon,deadline=now+8}
local ok,err=pcall(function()remote:FireServer("Reload",weapon)end)
if not ok then state.reload=nil return "error",tostring(err)end
return "waiting"
end

function U.gunOrbitBuy(gunName,target)
if not ec.hvh then return end
if U.gunPurchase then return end
U.H(true)
local job={root=root,character=ad,position=root.CFrame,hold=root.CFrame,humanoid=humanoid,walk=humanoid.WalkSpeed,jump=humanoid.JumpPower,height=humanoid.JumpHeight}
U.gunPurchase=job
U.gunOrbitGuardStart(job)
game:GetService("ContextActionService"):BindActionAtPriority("HuybypassPurchaseLock",function()return Enum.ContextActionResult.Sink end,false,10000,table.unpack(Enum.PlayerActions:GetEnumItems()))
job.lock=ae.PreSimulation:Connect(function()
if U.gunPurchase~=job or root~=job.root or ad~=job.character then return end
U.gunOrbitGuardStep(job)
job.humanoid.WalkSpeed=0 job.humanoid.JumpPower=0 job.humanoid.JumpHeight=0 job.humanoid.Jump=false
job.humanoid:Move(Vector3.zero,false)
job.root.CFrame=job.hold job.root.AssemblyLinearVelocity=Vector3.zero
end)
U.h("Gun random: buying "..gunName..(U.isOriginalDaHood and " / ammo with in-game cash."or " with in-game cash."))
task.spawn(function()
local function active()return U.gunPurchase==job and root==job.root and ad==job.character and U.f() and U.k end
local function owned()
local bag=player:FindFirstChildOfClass("Backpack")
return U.gunFind(job.character,gunName)or U.gunFind(bag,gunName)
end
local function shopBuy(item,shouldBuy)
if not active()then error("Purchase cancelled.")end
local ignored=workspace:FindFirstChild("Ignored")
local shops=ignored and ignored:FindFirstChild("Shop")
local shop
if shops then
for _,candidate in ipairs(shops:GetChildren())do
if U.gunShopToken(candidate.Name)==U.gunShopToken(item)then shop=candidate break end
end
end
local head=shop and shop:FindFirstChild("Head")
local detector=shop and shop:FindFirstChildOfClass("ClickDetector")
local click=getfenv(0).fireclickdetector
if not head or not detector or type(click)~="function"then error("Shop or purchase API unavailable: "..item)end
job.hold=head.CFrame+Vector3.new(0,3,0)
job.root.CFrame=job.hold
job.root.AssemblyLinearVelocity=Vector3.zero
task.wait(0.22)
if not active()then error("Purchase cancelled.")end
if shouldBuy and not shouldBuy()then return end
click(detector)
task.wait(0.25)
end
local ok,message=pcall(function()
for _,wanted in ipairs(U.gunLoadout())do
gunName=wanted
local tool=owned()
if not tool then
shopBuy(gunName)
local deadline=os.clock()+3
tool=owned()
while active()and not tool and os.clock()<deadline do task.wait(0.03)tool=owned()end
if not active()then error("Purchase cancelled.")end
if not tool then error("Gun purchase was not confirmed; check cash and shop availability.")end
end
U.gunEnsureAmmo(tool,active,shopBuy)
end
end)
local resume=active()
if U.gunPurchase==job then U.gunPurchaseCancel()end
if not resume then return end
if not ok then U.sentryTarget=nil U.h(tostring(message))return end
if target and target.Character then U.gunOrbitStart(target,true)end
end)
end

function U.gunRandomOffset(state,now,mobile)
if state.orbitOffset and now<(state.nextRandomMove or 0)then return state.orbitOffset end
state.random=state.random or Random.new()
 
state.angle=((state.angle or 0)+state.random:NextNumber(math.pi/3,math.pi*5/3))%(math.pi*2)
local radius=state.random:NextNumber(aa.GunOrbitRadius*0.75,aa.GunOrbitRadius)
local height=state.random:NextNumber(aa.GunOrbitHeight-2,aa.GunOrbitHeight+2)
state.orbitOffset=Vector3.new(math.cos(state.angle)*radius,height,math.sin(state.angle)*radius)
 
state.nextRandomMove=now+(mobile and aa.GunRandomMobileMoveInterval or aa.GunRandomMoveInterval)
return state.orbitOffset
end
function U.gunOrbitStart(resumeTarget,afterPurchase)
if not ec.hvh then return end
if U.autoKill and not resumeTarget then U.autoKillStop("Stopped by X")return end
if U.gunPurchase then U.gunPurchaseCancel() U.h("Gun purchase cancelled.")return end
if U.gunOrbit then U.gunOrbitStop("Gun random cancelled.")return end
if U.gunBodyFollow then U.gunBodyFollowStop() U.h("Gun follow cancelled.")return end
if not U.f() or not U.k or U.F or U.ad or bw:GetFocusedTextBox()then return end
if U.carryActive()then U.h("Put down the carried player before gun random.")return end
local camera=workspace.CurrentCamera
if not camera then return end
local point=camera.ViewportSize/2
if not U.M and bw.MouseBehavior==Enum.MouseBehavior.Default then
local inset=game:GetService("GuiService"):GetGuiInset()
point=bw:GetMouseLocation()-inset
end
local target,char=U.zipAttackPickTarget(camera,point)
if resumeTarget then target=resumeTarget char=target.Character end
if not target then U.h("No eligible target within 400 studs.")return end
if not char or not char:FindFirstChild("HumanoidRootPart")or not char:FindFirstChildOfClass("Humanoid")then U.h("Target character unavailable.")return end
if U.sentryTarget==target and U.zipAttackKnocked({targetCharacter=char,targetHum=char:FindFirstChildOfClass("Humanoid")})then U.sentryTarget=nil U.h("Sentry: target already knocked; no attack.")return end
local backpack=player:FindFirstChildOfClass("Backpack")
local weapons={}
for _,name in ipairs(U.gunLoadout())do
local weapon=U.gunFind(ad,name)or U.gunFind(backpack,name)
local rounds=weapon and weapon:FindFirstChild("Ammo")
if not weapon or not weapon:IsA("Tool") or not weapon:FindFirstChild("Handle") or (U.isOriginalDaHood and (not rounds or rounds.Value<=0)) then
if afterPurchase then U.h("Selected loadout not ready; X stopped.")return end
U.gunOrbitBuy(aa.GunOrbitDefaultGun,target)return
end
weapons[#weapons+1]=weapon
end
local tool=weapons[1]
local ammo=tool:FindFirstChild("Ammo")
local remote=cV:FindFirstChild("MainEvent")
if U.isOriginalDaHood and (not remote or not remote:IsA("RemoteEvent"))then U.h("Gun random: MainEvent firing path unavailable.")return end
U.H(true)U.l()U.A()U.z()dance.stop()U.an()
 
if not U.isOriginalDaHood or (U.flameMode and not U.sentryTarget) then humanoid:EquipTool(tool)else for _,weapon in ipairs(weapons)do weapon.Parent=ad end end
if tool.Parent~=ad then U.h("Gun could not be equipped.")return end
local state={root=root,character=ad,humanoid=humanoid,rotate=humanoid.AutoRotate,
target=target,targetCharacter=char,targetRoot=char:FindFirstChild("HumanoidRootPart"),
targetHum=char:FindFirstChildOfClass("Humanoid"),tool=tool,weapons=weapons,safeCFrame=root.CFrame,startCFrame=root.CFrame,angle=0,nextShot=0,flame=U.flameMode and not U.sentryTarget,sentry=U.sentryTarget==target}
U.gunOrbit=state
if not U.isOriginalDaHood then
if U.autoKillView then U.autoKillViewStop()end
U.copyCameraSave(state)
state.copyAimBinding="HuybypassCopyGunAim"
ae:BindToRenderStep(state.copyAimBinding,Enum.RenderPriority.Last.Value,function()
local ok,err=pcall(U.copyAim,state)
if not ok then U.gunOrbitStop("Copy aim failed: "..tostring(err))end
end)
end
U.gunOrbitGuardStart(state)
state.walkSpeed=humanoid.WalkSpeed state.jumpPower=humanoid.JumpPower state.jumpHeight=humanoid.JumpHeight
local blocked=Enum.PlayerActions:GetEnumItems()
for _,key in ipairs({aa.WebKey,aa.JumpKey,aa.PullKey,aa.GlideKey,aa.ClimbKey,aa.DashKey,aa.ZipAttackKey,aa.SuitKey,aa.SenseKey,aa.TrickToggleKey,aa.CrouchKey,aa.EmoteKey,aa.DanceKey,aa.GoofyKey,aa.TutorialKey,aa.SettingsKey,aa.NativeChatKey})do
if key and (U.isOriginalDaHood or key~=Enum.KeyCode.R)then blocked[#blocked+1]=key end
end
game:GetService("ContextActionService"):BindActionAtPriority("HuybypassGunMovementLock",function()return Enum.ContextActionResult.Sink end,false,10000,table.unpack(blocked))
U.zipAttackSetNoclip(state)
state.noclipConnection=ae.PreSimulation:Connect(function()
if U.gunOrbit==state then
U.gunOrbitGuardStep(state)
U.zipAttackSetNoclip(state)
state.humanoid.WalkSpeed=0 state.humanoid.JumpPower=0 state.humanoid.JumpHeight=0 state.humanoid.Jump=false
state.humanoid:Move(Vector3.zero,false)
if state.root.Parent and state.targetRoot and state.targetRoot.Parent and state.orbitOffset then
 
local targetPosition=state.targetRoot.Position
local destination=targetPosition+state.orbitOffset
state.holdCFrame=CFrame.lookAt(destination,targetPosition)
state.root.CFrame=state.holdCFrame
state.positioned=true
state.root.AssemblyLinearVelocity=Vector3.zero
state.root.AssemblyAngularVelocity=Vector3.zero
end
end
end)
humanoid.AutoRotate=false
state.connection=ae.Heartbeat:Connect(function(dt)
local ok,err=pcall(function()
if U.gunOrbit~=state then return end
if not U.f() or not U.k or ad~=state.character or root~=state.root or humanoid~=state.humanoid
or target.Parent~=bo or target.Character~=char or not state.targetRoot
or not state.targetRoot.Parent or not state.targetHum or state.targetHum.Health<=0
or char:FindFirstChildOfClass("ForceField") or U.carryActive()then
U.gunOrbitStop("Gun random ended: character or target unavailable.")return end
if U.zipAttackKnocked(state)then
if state.sentry then U.sentryTarget=nil U.gunOrbitStop("Sentry: target knocked; no stomp.")
else U.gunOrbitStop("Target knocked; move to end body follow.",true)end
return end
if not U.isOriginalDaHood then U.gunRandomOffset(state,os.clock(),bw.TouchEnabled)end
for _,weapon in ipairs(weapons)do
local rounds=weapon:FindFirstChild("Ammo")
if weapon.Parent~=ad then
local bag=player:FindFirstChildOfClass("Backpack")
if weapon.Parent~=bag then U.gunOrbitStop("Gun removed from inventory.")return end
state.equipRetries=state.equipRetries or {}
local retry=state.equipRetries[weapon] or {count=0,nextAt=0}
state.equipRetries[weapon]=retry
if os.clock()>=retry.nextAt then
if retry.count>=3 then U.gunOrbitStop("Dual equip repeatedly rejected; X stopped.")return end
retry.count=retry.count+1 retry.nextAt=os.clock()+0.5
if U.isOriginalDaHood then weapon.Parent=ad else state.humanoid:EquipTool(weapon)end
end
end
local reloadAction,reloadError=U.gunReloadStep(state,weapon,os.clock())
if reloadAction=="error"then U.gunOrbitStop(reloadError)return end
if reloadAction=="restock"then U.gunOrbitStop()U.gunOrbitBuy(weapon.Name,target)return end
end
if state.reload or state.externalReloadUntil then return end
local targetRoot=state.targetRoot
local sampleDt=math.max(dt,1/240)
local position=targetRoot.Position
local reported=aD.safeVelocity(targetRoot.AssemblyLinearVelocity,1000)
local displacement=state.lastOrbitTarget and position-state.lastOrbitTarget or nil
local measured=displacement and displacement/sampleDt or reported
local teleported=displacement and displacement.Magnitude>math.max(80,reported.Magnitude*sampleDt*3)
if teleported or sampleDt>0.2 then
state.orbitVelocity=reported
else
local observed=aD.safeVelocity(measured,1000)
local estimate=(observed-reported).Magnitude>25 and observed*0.8+reported*0.2 or reported
state.orbitVelocity=state.orbitVelocity and state.orbitVelocity:Lerp(estimate,1-math.exp(-30*sampleDt)) or estimate
end
state.lastOrbitTarget=position
local velocity=state.orbitVelocity
U.gunRandomOffset(state,os.clock(),bw.TouchEnabled)
local fast=velocity.Magnitude>90
if U.isOriginalDaHood and fast and not state.flame then
local direction=velocity.Magnitude>1 and velocity.Unit or targetRoot.CFrame.LookVector
state.orbitOffset=-direction*5+Vector3.new(0,2,0)
end
local desired=position+state.orbitOffset
aD.destroy("zipattack")
 
if os.clock()>=(state.nextClearCheck or 0)then
state.nextClearCheck=os.clock()+0.2
if U.gunOrbitPositionClear(state,U.gunOrbitUpright(root.CFrame))then state.safeCFrame=root.CFrame end
end
local hitPart=char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or targetRoot
local aim=hitPart.Position+((teleported or fast or state.flame)and Vector3.zero or aD.safeVelocity(velocity*0.025,3))
local now=os.clock()
if state.positioned and now>=state.nextShot then
state.nextShot=now+(bw.TouchEnabled and aa.GunOrbitMobileShotInterval or aa.GunOrbitShotInterval)
for _,weapon in ipairs(weapons)do
local handle=weapon:FindFirstChild("Handle")
if weapon.Parent==ad and handle and handle:IsA("BasePart") then
if not U.isOriginalDaHood then
-- Aim the cursor ray before activating the equipped copy-game tool.
U.copyAim(state)
weapon:Deactivate()
weapon:Activate()
elseif state.flame then
local rounds=weapon:FindFirstChild("Ammo")
if not state.flameHeld or(now>=(state.flameCheck or 0)and rounds and rounds.Value==state.flameAmmo)then
weapon:Deactivate()weapon:Activate()state.flameHeld=true
end
if now>=(state.flameCheck or 0)then state.flameCheck=now+1 state.flameAmmo=rounds and rounds.Value end
else remote:FireServer("ShootGun",handle,handle.Position,aim,hitPart,Vector3.zero)end
end
end
end
end)
if not ok then U.gunOrbitStop("X error: "..tostring(err)) if aa.Debug then warn(err)end end
end)
U.h("Gun random: "..target.DisplayName.." — X or GUN RANDOM cancels.")
end

function U.bn(key,processed)
if U.emoteLocked and(key==Enum.KeyCode.W or key==Enum.KeyCode.A or key==Enum.KeyCode.S or key==Enum.KeyCode.D or key==Enum.KeyCode.E or key==Enum.KeyCode.Q or key==Enum.KeyCode.F or key==aa.WebKey or key==aa.JumpKey or key==aa.DashKey)then return end
if key==Enum.KeyCode.RightShift then return end
if ec.hvh and key==aa.GunOrbitKey and not processed then U.gunOrbitStart()return end
if U.gunOrbit or U.gunPurchase or U.autoKillRoam or U.voidHide or U.bringState then return end
if U.gunBodyFollow then U.gunBodyFollowStop()end
U.bodyFollow=nil
if ec.hvh and key==aa.ZipAttackKey and not U.F then
if U.zipAttack then U.zipAttackStop("Zip attack cancelled.")return end
if processed then U.zipStatus("Key consumed by game/UI; close menus or rebind in F2.")return end
U.zipStatus("Key received; checking target...",true)
local ok,err=pcall(U.zipAttackStart)
if not ok then
U.zipAttackStop("Zip attack failed.")
U.zipStatus("Error: "..tostring(err))
warn("Huybypass zip attack: "..tostring(err))
end
return
end
if U.zipAttack then return end
if U.F or U.ad then return end if U.cq then U.cq(key)end if not U.f()then return end if key==aa.GlideKey and not processed and not bw:GetFocusedTextBox()and U.k then
if not U.Z then U.glideHeldAt=os.clock()end
U.Z=true end
if key==aa.GlideKey and ah and not ac and not bw:GetFocusedTextBox()then
U.dE()return
end
if processed or not U.f()or bw:GetFocusedTextBox()or not U.k then return end
if key==aa.PullKey then U.bq()
elseif key==aa.WebKey then
if U.aG()then
U.bq()else
U.bV()end
elseif key==aa.SenseKey then
U.cM()U.v(8)elseif key==aa.SuitKey then
U.cC()elseif key==aa.TrickToggleKey then
dance.customTrick=not dance.customTrick
if dance.customTrick then
local ct=dance.E.tracks.trick_custom
if ct and ct.Length>0 then
U.h("Custom trick: ON")else
U.h("Custom trick: ON (still loading; stand still on the ground)")end
else
U.h("Custom trick: OFF (flips)")end
elseif key==aa.CrouchKey then
if crouchPose then
crouchPose=false
U.h("Crouch pose: OFF")elseif root and humanoid and humanoid.Health>0 and humanoid.FloorMaterial~=Enum.Material.Air
and not ah and not ai and not as and not ac then
local v=root.AssemblyLinearVelocity
if Vector3.new(v.X,0,v.Z).Magnitude<4 then
crouchPose=true
fidget=nil
U.h("Crouch pose: ON")end
end
elseif key==aa.GoofyKey then
dance.toggleName("goofy","Goofy")elseif key==aa.EmoteKey then
dance.toggleName("emote","Emote")elseif key==aa.DanceKey then
dance.toggle()elseif key==aa.JumpKey then
U.dM()elseif key==aa.DashKey then
U.dd()end
end
U.b(bw.InputBegan,function(av,processed)if U.carryBinding and av.KeyCode==Enum.KeyCode.E then return end U.bn(av.KeyCode,processed)end)
function U.dO(key)if U.gunOrbit then return end if key==aa.GlideKey then U.Z=false U.L()end
if key==aa.WebKey then
U.o(not U.m)elseif key==aa.JumpKey then
U.cm()end
end
U.b(bw.InputEnded,function(av)if U.carryBinding and av.KeyCode==Enum.KeyCode.E then return end U.dO(av.KeyCode)end)
U.b(bw.WindowFocused,function()U.k=true end)U.b(bw.WindowFocusReleased,function()if not bw.TouchEnabled then U.k=false end
if U.voidHide then U.S=false U.Z=false return end
if U.H then U.H()end U.S=false U.Z=false
U.L()U.z()if not bw.TouchEnabled then U.k=false end
U.o(false)U.n()U.l()U.A()U.y()dance.stop()U.an()end)U.b(bw.TextBoxFocused,function()if U.H then U.H()end U.S=false U.Z=false
U.L()U.z()U.o(false)U.n()U.l()U.A()U.y()dance.stop()U.an()end)if typeof(script)=="Instance"then U.b(script.Destroying,U.bw)end
U.Y={}
function U.H(preserveAutoKill)
if U.voidHideStop then U.voidHideStop(true)end
if U.controlHoldStop then U.controlHoldStop("bringState",false)end
if not preserveAutoKill then U.sentryTarget=nil U.sentryPending=nil U.sentryHit=nil U.sentryEvidence={} end
if U.autoKillRoamStop then U.autoKillRoamStop()end
if not preserveAutoKill and U.autoKill then U.autoKill=nil U.autoKillStatus("Stopped")end
U.bodyFollow=nil
if U.gunBodyFollowStop then U.gunBodyFollowStop()end
if U.gunPurchaseCancel then U.gunPurchaseCancel()end
if U.gunOrbitStop then U.gunOrbitStop()end
if U.zipAttackStop then U.zipAttackStop("Zip attack cancelled.")end
if U.attackRecoveryEnd then U.attackRecoveryEnd()end
table.clear(U.Y)
U.S=false U.Z=false
U.o(false)U.n()U.y()U.L()
if U.modeEmoteWanted and not U.modeEmoteWanted()then U.modeEmoteStop()end
end
function U.ba(name,begin,cancel)
if U.emoteLocked and begin and(name=="Swing"or name=="Zip"or name=="Charge"or name=="Dash")then return end
if not ec.hvh and(name=="GunOrbit"or name=="ZipAttack")then return end
if name=="GunOrbit"then if begin then U.gunOrbitStart()end return end
if U.gunOrbit or U.gunPurchase or U.autoKillRoam or U.voidHide or U.bringState then return end
if U.gunBodyFollow then U.gunBodyFollowStop()end
U.bodyFollow=nil
if name=="ZipAttack"then
if begin then U.bn(aa.ZipAttackKey,false)end
return
end
if U.zipAttack then U.zipAttackStop("Zip attack cancelled.")end
if name=="Review"then if begin then U.bG()end return end
if name=="Controls"then if begin then U.aR()end return end
if name=="Tutorial"then
if begin then if U.j.gui then U.ae(true)else U.bm()end end
return
end
if name=="Chat"then if begin then U.bp(true)end return end
if not begin then
if name=="Swing"then U.o(not cancel and U.f())
elseif name=="Charge"then if cancel or not U.f()then U.y()else U.cm()end
elseif name=="Glide"then U.Z=false U.L()end
return
end
if U.ad or not U.f()or not U.k or bw:GetFocusedTextBox()then return end
local keys={Swing=aa.WebKey,Charge=aa.JumpKey,Dash=aa.DashKey,
Suit=aa.SuitKey,Sense=aa.SenseKey,Tricks=aa.TrickToggleKey,
Crouch=aa.CrouchKey,Emote=aa.EmoteKey,Dance=aa.DanceKey,Goofy=aa.GoofyKey}
if name=="Zip"then U.bq()
elseif name=="Climb"then U.S=not U.S if not U.S then U.l()else U.cj()end
elseif name=="Glide"then
local ez=ah
U.bn(aa.GlideKey,false)
if not ez and humanoid.FloorMaterial~=Enum.Material.Air then humanoid.Jump=true end
elseif name=="Swing"then U.bV()
elseif keys[name]then U.bn(keys[name],false)end
local t=U.j
local key=keys[name]or(name=="Zip"and aa.WebKey)or(name=="Climb"and Enum.KeyCode.LeftControl)or(name=="Glide"and Enum.KeyCode.Space)
if t.gui and t.pages and key then
for _,expected in ipairs(t.pages[t.page][5])do if key.Name==expected then t.observed[t.page]=true end end
end
end
function U.ce()
if not bw.TouchEnabled or not U.j.gui then return end
local t=U.j
local gk={"THUMBSTICK: MOVE / DRAG SCREEN: AIM","HOLD SWING / RELEASE TO LAUNCH","HOLD CHARGE / RELEASE TO LAUNCH","DASH / AIM WITH CENTRE DOT + ZIP","CLIMB: TOGGLE / HOLD JUMP-GLIDE","MORE: SUIT / SENSE","MORE: TRICKS / CROUCH / EMOTE / DANCE / GOOFY"}
t.keys.Text=gk[t.page]
local eg={WASD="thumbstick",["W A S D"]="thumbstick",["Ctrl + E"]="Zip",["CTRL + E"]="Zip",Ctrl="Climb",CTRL="Climb",Space="Jump/Glide",SPACE="Jump/Glide",Spatie="Jump/Glide",Leertaste="Jump/Glide",Espace="Jump/Glide",Espacio="Jump/Glide"}
local body=t.body.Text
body=body:gsub("Ctrl %+ E","Zip"):gsub("CTRL %+ E","Zip")
for word,bD in pairs(eg)do
if not word:find("+",1,true)then body=body:gsub("%f[%w]"..word.."%f[%W]",bD)end
end
for key,label in pairs({E="Swing",Q="Charge",F="Dash",P="Suit",T="Sense",L="Tricks",H="Crouch",M="Emote",N="Dance",B="Goofy",F1="Tutorial"})do
body=body:gsub("%f[%w]"..key.."%f[%W]",label)
end
t.body.Text=body
end
function U.touchPanelPosition(normalized,viewport,panelSize)
local width=math.max(1,viewport.X-panelSize.X-16)
local height=math.max(1,viewport.Y-panelSize.Y-16)
return Vector2.new(8+math.clamp(normalized.X,0,1)*width,8+math.clamp(normalized.Y,0,1)*height)
end
function U.touchPanelNormalized(position,viewport,panelSize)
return Vector2.new(math.clamp((position.X-8)/math.max(1,viewport.X-panelSize.X-16),0,1),
math.clamp((position.Y-8)/math.max(1,viewport.Y-panelSize.Y-16),0,1))
end
function U.touchPanelBounds(state)
local camera=workspace.CurrentCamera
if not camera then return nil end
local top,bottom=game:GetService("GuiService"):GetGuiInset()
return camera.ViewportSize-top-bottom,Vector2.new(248,328)*state.scale.Scale
end
function U.touchPanelDrag(state,handle)
U.b(handle.InputBegan,function(input)
local kind=input.UserInputType
if kind~=Enum.UserInputType.Touch and kind~=Enum.UserInputType.MouseButton1 then return end
if state.drag then return end
U.k=true U.M=true
 
U.H()
state.drag={input=input,mouse=kind==Enum.UserInputType.MouseButton1,
start=Vector2.new(input.Position.X,input.Position.Y),
position=Vector2.new(state.panel.Position.X.Offset,state.panel.Position.Y.Offset)}
end)
U.b(bw.InputChanged,function(input)
local drag=state.drag
if not drag then return end
if input~=drag.input and not(drag.mouse and input.UserInputType==Enum.UserInputType.MouseMovement)then return end
local viewport,panelSize=U.touchPanelBounds(state)
if not viewport then return end
local delta=Vector2.new(input.Position.X,input.Position.Y)-drag.start
state.normalized=U.touchPanelNormalized(drag.position+delta,viewport,panelSize)
local position=U.touchPanelPosition(state.normalized,viewport,panelSize)
state.panel.Position=UDim2.fromOffset(position.X,position.Y)
end)
U.b(bw.InputEnded,function(input)
local drag=state.drag
if not drag then return end
if input~=drag.input and not(drag.mouse and input.UserInputType==Enum.UserInputType.MouseButton1)then return end
state.drag=nil
player:SetAttribute("HuybypassTouchPanelX",state.normalized.X)
player:SetAttribute("HuybypassTouchPanelY",state.normalized.Y)
end)
U.b(bw.WindowFocusReleased,function()state.drag=nil end)
end

function U.cb()
if U.bI or not bw.TouchEnabled then return end
local g=U.ui("ScreenGui",player.PlayerGui,{Name="HuybypassTouchControls",ResetOnSpawn=false,DisplayOrder=12,IgnoreGuiInset=false})
table.insert(U.aa,g)
local panel=U.ui("Frame",g,{AnchorPoint=Vector2.new(0,0),Position=UDim2.fromOffset(8,8),Size=UDim2.fromOffset(248,328),BackgroundTransparency=1})
local scale=U.ui("UIScale",panel,{Scale=1})
local extras=U.ui("Frame",g,{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(280,420),BackgroundColor3=Color3.fromRGB(9,16,28),BackgroundTransparency=0.06,Visible=false})
U.g(extras,14)
local extraScale=U.ui("UIScale",extras,{Scale=1})
local actionList=U.ui("ScrollingFrame",extras,{Name="Actions",Position=UDim2.fromOffset(0,46),Size=UDim2.new(1,0,1,-46),CanvasSize=UDim2.fromOffset(0,330),ScrollBarThickness=5,BackgroundTransparency=1,BorderSizePixel=0})
U.i(extras,"MENU",15,UDim2.fromOffset(14,8),UDim2.fromOffset(248,30))
local aim=U.ui("TextLabel",g,{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(34,34),BackgroundTransparency=1,Text="+",TextColor3=Color3.new(1,1,1),TextStrokeTransparency=0.2,TextSize=30})
local state={gui=g,panel=panel,extras=extras,scale=scale,extraScale=extraScale,aim=aim,buttons={}}
U.bI=state U.M=true
local savedX=player:GetAttribute("HuybypassTouchPanelX")
local savedY=player:GetAttribute("HuybypassTouchPanelY")
state.normalized=Vector2.new(type(savedX)=="number" and savedX or 1,type(savedY)=="number" and savedY or 0.45)
local handle=U.ui("TextButton",panel,{Name="DragControls",Text=":: DRAG PANEL",Position=UDim2.fromOffset(0,0),Size=UDim2.fromOffset(248,28),BackgroundColor3=Color3.fromRGB(14,25,42),BackgroundTransparency=0.12,BorderSizePixel=0,TextColor3=Color3.fromRGB(150,200,230),Font=Enum.Font.GothamBold,TextSize=11,AutoButtonColor=false,Active=true})
U.g(handle,8)U.touchPanelDrag(state,handle)
local function at(parent,name,label,x,y,w,h,hold)
local b=U.ui("TextButton",parent,{Name=name,Text=label,Font=Enum.Font.GothamBold,TextSize=14,TextColor3=Color3.fromRGB(230,244,255),BackgroundColor3=Color3.fromRGB(18,34,54),BackgroundTransparency=0.08,BorderSizePixel=0,Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),AutoButtonColor=true,TextWrapped=true,LineHeight=1.1})
U.g(b,12)
U.ui("UIStroke",b,{Color=Color3.fromRGB(90,170,220),Transparency=0.45,Thickness=1.5})
state.buttons[name]=b
if hold then
U.b(b.InputBegan,function(av)
if av.UserInputType~=Enum.UserInputType.Touch and av.UserInputType~=Enum.UserInputType.MouseButton1 then return end
for _,held in pairs(U.Y)do if held==name then return end end
if state.drag or not U.f()or bw:GetFocusedTextBox()then return end
if av.UserInputType==Enum.UserInputType.Touch then U.k=true end
U.M=true U.Y[av]=name
task.spawn(U.ba,name,true,false)
end)
else
U.b(b.Activated,function()
if state.drag then return end
U.k=true U.M=true
if name=="More"then extras.Visible=not extras.Visible return end
if (U.gunOrbit or U.gunPurchase) and name~="GunOrbit"then return end
if name=="Close"then extras.Visible=false return end
if parent==actionList then extras.Visible=false end
task.spawn(U.ba,name,true,false)
end)
end
return b
end
if ec.hvh then
at(panel,"ZipAttack","TARGET",8,30,74,54,false)
at(panel,"GunOrbit","GUN",90,30,74,54,false)
at(panel,"More","MORE",172,30,68,54,false)
else
local more=at(panel,"More","MORE",8,30,232,54,false)
more.TextSize=16
end
at(panel,"Swing","SWING\n(hold)",8,90,112,76,true)
at(panel,"Zip","WEB\nZIP",128,90,112,76,false)
at(panel,"Charge","CHARGE\n(hold)",8,172,112,76,true)
at(panel,"Dash","AIR\nDASH",128,172,112,76,false)
at(panel,"Climb","CLIMB\nOFF",8,254,112,76,false)
at(panel,"Glide","JUMP\nGLIDE",128,254,112,76,true)
local names={"Suit","Sense","Tricks","Crouch","Emote","Dance","Goofy","Tutorial","Chat","Controls","Review","Close"}
for i,name in ipairs(names)do
local col=(i-1)%3 local row=math.floor((i-1)/3)
at(actionList,name,string.upper(name),10+col*90,10+row*80,78,68,false)
end
U.b(bw.InputEnded,function(av)
local name=U.Y[av]
if name then U.Y[av]=nil U.ba(name,false,av.UserInputState==Enum.UserInputState.Cancel)end
end)
U.b(bw.InputChanged,function(av)
if av.UserInputState==Enum.UserInputState.Cancel then
local name=U.Y[av]
if name then U.Y[av]=nil U.ba(name,false,true)end
end
end)
U.b(bw.LastInputTypeChanged,function(kind)
if kind==Enum.UserInputType.Touch then U.M=true U.k=true
elseif kind==Enum.UserInputType.MouseButton1 and U.zipAttack then return
elseif kind==Enum.UserInputType.Keyboard or kind==Enum.UserInputType.MouseButton1 then
if next(U.Y)==nil and not bw.TouchEnabled then U.M=false end
end
end)
U.b(ae.RenderStepped,function()
if not U.d then return end
local ag=workspace.CurrentCamera if not ag then return end
local size=ag.ViewportSize
state.scale.Scale=math.clamp(math.min(size.X/480,size.Y/460),0.50,1)
state.extraScale.Scale=math.min(1,(size.X-24)/280)
extras.Size=UDim2.fromOffset(280,math.clamp((size.Y-40)/state.extraScale.Scale,120,460))
local viewport,panelSize=U.touchPanelBounds(state)
if viewport then
local position=U.touchPanelPosition(state.normalized,viewport,panelSize)
state.panel.Position=UDim2.fromOffset(position.X,position.Y)
end
local visible=bw.TouchEnabled and U.k and not bw:GetFocusedTextBox()
g.Enabled=visible
local ready=U.a and not U.m and not U.ad
state.panel.Visible=ready
if not ready then state.extras.Visible=false end
state.aim.Visible=ready and U.M and not state.extras.Visible and not U.j.gui
local inset=game:GetService("GuiService"):GetGuiInset()
state.aim.Position=UDim2.fromOffset(size.X/2-inset.X,size.Y/2-inset.Y)
state.buttons.Climb.Text=U.S and"CLIMB\nON"or"CLIMB\nOFF"
if state.buttons.ZipAttack then state.buttons.ZipAttack.Text=U.zipAttack and"STOP"or"TARGET"end
if state.buttons.GunOrbit then state.buttons.GunOrbit.Text=U.gunOrbit and"STOP\nGUN"or"GUN"end
if U.r.panel and U.M then U.r.panel.Visible=false end
end)
end
U.cb()
U.b(bw.TouchStarted,function()
U.k=true U.M=true
 
if U.carryGuard then U.carryUnlock()end
end)
U.b(bw:GetPropertyChangedSignal("TouchEnabled"),U.cb)
U.ar={
{"ZipAttackKey","Zip + charged fists"},
{"WebKey","Swing"},{"PullKey","Web zip"},{"JumpKey","Charge jump"},{"DashKey","Air dash"},
{"ClimbKey","Climb / crawl"},{"GlideKey","Jump off / glide"},{"SuitKey","Suit"},{"SenseKey","Huybypass-sense"},
{"TrickToggleKey","Trick mode"},{"CrouchKey","Crouch"},{"EmoteKey","Emote"},{"DanceKey","Dance"},
{"GoofyKey","Goofy emote"},{"TutorialKey","Tutorial"},{"NativeChatKey","Show chat"},{"SettingsKey","Controls panel"}}
if not ec.hvh then
for index=#U.ar,1,-1 do if U.ar[index][1]=="ZipAttackKey"then table.remove(U.ar,index)end end
end
U.ct={}
for _,def in ipairs(U.ar)do U.ct[def[1]]=aa[def[1]]end
function U.bW(key)
return key and key.EnumType==Enum.KeyCode and key~=Enum.KeyCode.Unknown
and key~=Enum.KeyCode.Escape and not key.Name:match("^Button")
and not key.Name:match("^Thumbstick")and not key.Name:match("^DPad")
and key~=Enum.KeyCode.W and key~=Enum.KeyCode.A and key~=Enum.KeyCode.S and key~=Enum.KeyCode.D
and key~=Enum.KeyCode.Up and key~=Enum.KeyCode.Down and key~=Enum.KeyCode.Left and key~=Enum.KeyCode.Right
end
function U.cw()
local data={version=2,keys={}}
for _,def in ipairs(U.ar)do data.keys[def[1]]=aa[def[1]].Name end
local ok,raw=pcall(function()return game:GetService("HttpService"):JSONEncode(data)end)
if not ok then return false end
player:SetAttribute("HuybypassKeybinds",raw)
local env=getfenv(0)
local saved=false
if type(env.writefile)=="function"then saved=pcall(env.writefile,"HuybypassSwing_Keybinds_"..player.UserId..".json",raw)end
return saved
end
function U.cJ()
local raw=player:GetAttribute("HuybypassKeybinds")
local env=getfenv(0)
if type(raw)~="string"and type(env.readfile)=="function"then
local ok,value=pcall(env.readfile,"HuybypassSwing_Keybinds_"..player.UserId..".json")
if ok then raw=value end
end
if type(raw)~="string"or#raw>4096 then return end
local ok,data=pcall(function()return game:GetService("HttpService"):JSONDecode(raw)end)
if not ok or type(data)~="table"or (data.version~=1 and data.version~=2)or type(data.keys)~="table"then return end
local migrate=data.version==1
if migrate and data.keys.ZipAttackKey=="G"then
for field,key in pairs(data.keys)do if field~="ZipAttackKey"and key=="C"then data.keys[field]="G"end end
data.keys.ZipAttackKey="C"
end
local eH,used={},{}
for _,def in ipairs(U.ar)do
local name=data.keys[def[1]]
if name==nil and def[1]=="ZipAttackKey"then
local occupied={}
for _,saved in pairs(data.keys)do occupied[saved]=true end
for _,candidate in ipairs({"C","V","G","X","Z","K","O","I","U","Y","J","T","R","E","Q","F","H","L","B","N","M","P","F3","F4"})do
if not occupied[candidate]then name=candidate break end
end
end
if type(name)~="string"then return end
local cX,key=pcall(function()return Enum.KeyCode[name]end)
if not cX or not U.bW(key)or used[key]then return end
if key==Enum.KeyCode.Space and def[1]~="GlideKey"then return end
eH[def[1]]=key used[key]=true
end
for field,key in pairs(eH)do aa[field]=key end
if migrate then U.cw()end
end
function U.bL(text)
local mapping={E="WebKey",Q="JumpKey",F="DashKey",P="SuitKey",T="SenseKey",L="TrickToggleKey",H="CrouchKey",M="EmoteKey",N="DanceKey",B="GoofyKey",F1="TutorialKey",Ctrl="ClimbKey",CTRL="ClimbKey",Space="GlideKey",SPACE="GlideKey"}
return(text:gsub("[%w]+",function(word)
local field=mapping[word]
return field and aa[field].Name or word
end))
end
function U.cq(key)
local t=U.j
if not t.gui or not t.pages then return end
local hP={E="WebKey",Q="JumpKey",F="DashKey",P="SuitKey",T="SenseKey",L="TrickToggleKey",H="CrouchKey",M="EmoteKey",N="DanceKey",B="GoofyKey",Space="GlideKey",LeftControl="ClimbKey",RightControl="ClimbKey"}
for _,expected in ipairs(t.pages[t.page][5])do
if(hP[expected]and key==aa[hP[expected]])or key.Name==expected then t.observed[t.page]=true end
end
end
function U.az(message)
if not U.x then return end
for field,at in pairs(U.x.rows)do at.Text=aa[field].Name end
U.x.hint.Text=message or"Select a binding, then press a keyboard key. Esc cancels."
end
function U.aR()
if U.x and U.x.panel.Visible then
U.x.panel.Visible=false U.ad=false U.F=nil return
end
U.H()U.l()U.A()U.z()
if U.bI then U.bI.extras.Visible=false end
if U.j.gui then U.ae(true)end
if not U.x then
local gui=U.ui("ScreenGui",player.PlayerGui,{Name="HuybypassControls",ResetOnSpawn=false,DisplayOrder=95})
table.insert(U.aa,gui)
local panel=U.ui("Frame",gui,{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(400,480),BackgroundColor3=Color3.fromRGB(10,18,30),BorderSizePixel=0})
U.g(panel,12)
local scale=U.ui("UIScale",panel,{Scale=1})
U.i(panel,"CONTROLS",18,UDim2.fromOffset(16,12),UDim2.fromOffset(250,28))
local fZ=U.ui("TextButton",panel,{Text="REVIEW",TextSize=12,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(29,51,72),Position=UDim2.fromOffset(282,12),Size=UDim2.fromOffset(102,28),BorderSizePixel=0})
U.g(fZ,6)U.b(fZ.Activated,function()U.aR()U.bG()end)
local hint=U.i(panel,"",11,UDim2.fromOffset(16,46),UDim2.fromOffset(368,42))
hint.TextWrapped=true
local list=U.ui("ScrollingFrame",panel,{Position=UDim2.fromOffset(12,96),Size=UDim2.fromOffset(376,316),CanvasSize=UDim2.fromOffset(0,#U.ar*44),ScrollBarThickness=4,BackgroundTransparency=1,BorderSizePixel=0})
U.x={gui=gui,panel=panel,rows={},hint=hint,scale=scale}
for i,def in ipairs(U.ar)do
local field,label=def[1],def[2]
U.i(list,label,12,UDim2.fromOffset(5,(i-1)*44),UDim2.fromOffset(200,40))
local at=U.ui("TextButton",list,{Text=aa[field].Name,TextSize=12,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(29,51,72),BorderSizePixel=0,Position=UDim2.fromOffset(215,(i-1)*44+2),Size=UDim2.fromOffset(144,38)})
U.g(at,8)U.x.rows[field]=at
U.b(at.Activated,function()
U.F=field
U.az("Press a key for "..label..". Escape cancels. A keyboard is required to change keyboard bindings.")
at.Text="PRESS A KEY"
end)
end
local gz=U.ui("TextButton",panel,{Text="RESET DEFAULTS",TextSize=12,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(95,38,49),Position=UDim2.fromOffset(16,428),Size=UDim2.fromOffset(180,38),BorderSizePixel=0})
local fq=U.ui("TextButton",panel,{Text="CLOSE",TextSize=12,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(29,51,72),Position=UDim2.fromOffset(208,428),Size=UDim2.fromOffset(176,38),BorderSizePixel=0})
U.g(gz,8)U.g(fq,8)
U.b(gz.Activated,function()
U.F=nil
for field,key in pairs(U.ct)do aa[field]=key end
local gH=U.cw()
U.az(gH and"Defaults restored and saved."or"Defaults restored for this session.")
end)
U.b(fq.Activated,function()U.aR()end)
U.b(ae.RenderStepped,function()
local ag=workspace.CurrentCamera
if ag then fitHuybypassDialog(scale,math.clamp(math.min((ag.ViewportSize.X-20)/400,(ag.ViewportSize.Y-65)/480),0.25,1))end
end)
end
U.x.panel.Visible=true U.ad=true
U.az("Movement uses Roblox's thumbstick / WASD. Touch buttons stay labelled by action.")
end
function U.forceZipC()
if not ec.hvh then return end
local old=aa.ZipAttackKey
for _,def in ipairs(U.ar)do
if def[1]~="ZipAttackKey"and aa[def[1]]==Enum.KeyCode.C then aa[def[1]]=old end
end
aa.ZipAttackKey=Enum.KeyCode.C
U.cw()
end
U.cJ()
 
U.forceZipC()
U.h("Controls updated: C = zip fists / X = gun orbit")
U.b(bw.InputBegan,function(av,processed)
if av.UserInputType~=Enum.UserInputType.Keyboard then return end
local key=av.KeyCode
if U.F then
local field=U.F
if key==Enum.KeyCode.Escape then U.F=nil U.az("Rebinding cancelled.")return end
if not U.bW(key)or(key==Enum.KeyCode.Space and field~="GlideKey")then U.x.hint.Text="That key is reserved. Choose another key, or Escape to cancel."return end
for _,def in ipairs(U.ar)do
if def[1]~=field and aa[def[1]]==key then U.x.hint.Text="Already used by "..def[2]..". Choose another key."return end
end
aa[field]=key U.F=nil
local gH=U.cw()
U.az(gH and"Saved. Your new keybind is active."or"Saved for this session. File storage is unavailable.")
elseif not processed and not bw:GetFocusedTextBox()and key==aa.SettingsKey then U.aR()end
end)
U.bJ={count=0,reviewed=false}
function U.cr(path,body)
body.key=ec.key body.userId=player.UserId
local gU=game:GetService("HttpService")
local cL={Url=ec.base..path,Method="POST",Headers={["Content-Type"]="application/json"},Body=gU:JSONEncode(body)}
local env=getfenv(0)local bK=env.request or env.http_request
local response=type(bK)=="function"and bK(cL)or gU:RequestAsync(cL)
local cA=tonumber(response.StatusCode or response.Status)
local data=gU:JSONDecode(response.Body or response.body or"{}")
if cA~=200 or type(data)~="table"or not data.ok then error("Community request failed: "..tostring(cA))end
return data
end
function U.bG()
local state=U.bJ
if state.reviewed then U.h("Thanks - your review is already submitted.")return end
if state.count<5 or not state.reviewToken then U.h("Reviews unlock after 5 counted launches ("..state.count.."/5).")return end
if U.ch then U.ch.Enabled=true return end
local gui=U.ui("ScreenGui",player.PlayerGui,{Name="HuybypassReview",ResetOnSpawn=false,DisplayOrder=96})
U.ch=gui table.insert(U.aa,gui)
local panel=U.ui("Frame",gui,{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(390,380),BackgroundColor3=Color3.fromRGB(10,18,30),BorderSizePixel=0})
U.g(panel,12)local scale=U.ui("UIScale",panel,{Scale=1})
U.i(panel,"HOW WAS YOUR SWING?",17,UDim2.fromOffset(18,16),UDim2.fromOffset(354,28))
local notice=U.i(panel,"Optional: sends your Roblox username, stars and comment to the server's Discord reviews channel.",12,UDim2.fromOffset(18,50),UDim2.fromOffset(354,50))notice.TextWrapped=true
local dw=0 local stars={}
for i=1,5 do
local at=U.ui("TextButton",panel,{Text=i.." *",Font=Enum.Font.GothamBold,TextSize=18,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(29,51,72),BorderSizePixel=0,Position=UDim2.fromOffset(18+(i-1)*72,110),Size=UDim2.fromOffset(65,44)})U.g(at,8)stars[i]=at
U.b(at.Activated,function()
if U.ay then return end
dw=i
for n,b in ipairs(stars)do b.BackgroundColor3=n<=i and Color3.fromRGB(151,106,29)or Color3.fromRGB(29,51,72)end
end)
end
local fo=U.ui("TextBox",panel,{Text="",PlaceholderText="Optional comment (up to 500 characters)",ClearTextOnFocus=false,MultiLine=true,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,Font=Enum.Font.GothamMedium,TextSize=13,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(23,35,52),BorderSizePixel=0,Position=UDim2.fromOffset(18,168),Size=UDim2.fromOffset(354,92)})U.g(fo,8)
local status=U.i(panel,"Your username: "..player.Name,11,UDim2.fromOffset(18,266),UDim2.fromOffset(354,42))status.TextWrapped=true
local fB=U.ui("TextButton",panel,{Text="SEND REVIEW",Font=Enum.Font.GothamBold,TextSize=13,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(40,124,153),Position=UDim2.fromOffset(18,324),Size=UDim2.fromOffset(210,40),BorderSizePixel=0})U.g(fB,8)
local gb=U.ui("TextButton",panel,{Text="NOT NOW",Font=Enum.Font.GothamBold,TextSize=13,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(29,51,72),Position=UDim2.fromOffset(240,324),Size=UDim2.fromOffset(132,40),BorderSizePixel=0})U.g(gb,8)
U.b(gb.Activated,function()gui.Enabled=false end)
U.b(fB.Activated,function()
if U.ay or state.reviewed then return end
if dw==0 then status.Text="Choose a rating from 1 to 5 stars."return end
local text=fo.Text
if(utf8.len(text)or#text)>500 then status.Text="Please shorten your comment to 500 characters."return end
U.ay=true fB.Text="SENDING..."status.Text="Sending your review..."
U.aA=(U.aA or 0)+1 local bT=U.aA
task.delay(15,function()
if U.d and U.aA==bT and U.ay then
U.aA+=1 U.ay=false fB.Text="RETRY REVIEW"status.Text="Timed out. Retrying will not create a second review."
end
end)
task.spawn(function()
local ok,result=pcall(U.cr,"/review",{reviewToken=state.reviewToken,stars=dw,text=text})
if not U.d or U.aA~=bT then return end
U.ay=false
if ok then state.reviewed=true fB.Text="THANK YOU"status.Text="Review accepted and queued for Discord."gb.Text="CLOSE"
else fB.Text="RETRY REVIEW"status.Text="Could not submit. Check your connection and today's key, then retry."end
end)
end)
U.b(ae.RenderStepped,function()
local ag=workspace.CurrentCamera
if ag then fitHuybypassDialog(scale,math.clamp(math.min((ag.ViewportSize.X-20)/390,(ag.ViewportSize.Y-60)/380),0.25,1))end
end)
end
function U.dG()
if U.cU then return end U.cU=true
local id=game:GetService("HttpService"):GenerateGUID(false)
task.spawn(function()
for attempt=1,3 do
if not U.d then return end
local ok,data=pcall(U.cr,"/launch",{username=player.Name,userId=player.UserId,profileUrl="https://www.roblox.com/users/"..player.UserId.."/profile",jobId=game.JobId,launchId=id})
if ok then
if not U.d then return end
U.bJ={count=data.count,reviewToken=data.reviewToken,reviewed=data.reviewed==true}
if data.offerReview and not U.bJ.reviewed then
task.delay(3,function()if U.d then U.bG()end end)
end
return
end
task.wait(attempt*3)
end
if U.d then U.h("Discord logging unavailable; reviews unlock after counted launches.")end
end)
end
task.spawn(function()
while U.d and not U.a do task.wait(0.2)end
if U.d then U.dG()end
end)

-- Positions belong to the character/root that started the action.
function U.autoReturnHome(job)
if U.emoteNoReturnCharacter==ad then return false end
if not job.homeCFrame or ad~=job.localCharacter or root~=job.localRoot or not root or not root.Parent or not humanoid or humanoid.Health<=0 then return false end
if job.homeCFrame.Position.Y<=workspace.FallenPartsDestroyHeight+10 then return false end
root.CFrame=job.homeCFrame
root.AssemblyLinearVelocity=Vector3.zero root.AssemblyAngularVelocity=Vector3.zero
return true
end
function U.controlHoldStop(field,returnHome)
local state=U[field]
if state and(state.humanoid.Health<=0 or(U.emoteNoReturnCharacter==state.character and(field~="voidHide"or U.emoteLocked)))then returnHome=false end
if not state then return end
U[field]=nil
U.copyCameraRestore(state)
if state.connection then state.connection:Disconnect()end
game:GetService("ContextActionService"):UnbindAction(state.lockName)
if root==state.root and ad==state.character and root.Parent then
state.humanoid.WalkSpeed=state.walk state.humanoid.JumpPower=state.jump state.humanoid.JumpHeight=state.height
if returnHome then root.CFrame=state.startCFrame end
end
U.gunOrbitRelease(state)
if returnHome and root==state.root and ad==state.character and root.Parent and state.humanoid.Health>0 then
root.CFrame=state.startCFrame root.AssemblyLinearVelocity=Vector3.zero root.AssemblyAngularVelocity=Vector3.zero
end
end
function U.controlHoldStart(field,pose,lockName)
if U.emoteLocked and field=="voidHide"then return end
local state={root=root,character=ad,humanoid=humanoid,startCFrame=root.CFrame,safeCFrame=root.CFrame,pose=pose,
walk=humanoid.WalkSpeed,jump=humanoid.JumpPower,height=humanoid.JumpHeight,lockName=lockName}
if field=="voidHide"then
state.bounds=U.autoKillRoamBounds(root.Position)state.random=Random.new()state.nextMove=0
U.copyWaitCamera(state)
end
U[field]=state
U.gunOrbitGuardStart(state)U.zipAttackSetNoclip(state)
game:GetService("ContextActionService"):BindActionAtPriority(lockName,function()return Enum.ContextActionResult.Sink end,false,10000,table.unpack(Enum.PlayerActions:GetEnumItems()))
state.connection=ae.PreSimulation:Connect(function()
if U[field]~=state then return end
local ok,err=pcall(function()
if not U.d or(not U.k and field~="voidHide")or not U.f()or root~=state.root or ad~=state.character or not state.root.Parent then
if field=="voidHide"then U.voidHideStop(true)else U.autoKillStop("Bring stopped: character unavailable")end
return
end
U.gunOrbitGuardStep(state)U.zipAttackSetNoclip(state)
state.humanoid.WalkSpeed=0 state.humanoid.JumpPower=0 state.humanoid.JumpHeight=0 state.humanoid.Jump=false
state.humanoid:Move(Vector3.zero,false)
if field=="voidHide"then U.autoHideMove(state,os.clock())end
if state.pose.Position.Y<=workspace.FallenPartsDestroyHeight+20 then error("Destination crossed the destruction boundary")end
state.root.CFrame=state.pose state.root.AssemblyLinearVelocity=Vector3.zero state.root.AssemblyAngularVelocity=Vector3.zero
end)
if not ok then
if field=="voidHide"then U.voidHideStop(true)U.utilityStatus("Void Hide stopped: "..tostring(err))
else U.autoKillStop("Bring stopped: "..tostring(err))end
end
end)
return state
end
function U.voidHideStop(returnHome)
U.controlHoldStop("voidHide",returnHome)
if U.modeEmoteWanted and not U.modeEmoteWanted()then U.modeEmoteStop()end
if U.voidHideButton then U.voidHideButton.Text="VOID HIDE: OFF" U.voidHideButton.BackgroundColor3=Color3.fromRGB(36,51,72)end
end
function U.voidHideToggle()
if U.emoteLocked then return end
if not ec.hvh then return end
if U.voidHide then U.voidHideStop(true)U.utilityStatus("Void Hide off; returned to start")return end
if not U.f()or not U.k or U.carryActive()then U.utilityStatus("Void Hide: stand up and put down carried players first")return end
U.H()
local ok,err=pcall(U.controlHoldStart,"voidHide",root.CFrame,"HuybypassVoidHideLock")
if not ok then U.voidHideStop(true)U.utilityStatus("Void Hide failed: "..tostring(err))return end
if U.voidHideButton then U.voidHideButton.Text="VOID HIDE: ON" U.voidHideButton.BackgroundColor3=Color3.fromRGB(33,108,85)end
if U.modeEmoteStep then U.modeEmoteStep()end
U.utilityStatus("Void Hide roaming like Auto Kill; toggle off to return")
end
function U.bringCarriesTarget(job)
local char=job.character
if not char or job.target.Character~=char or not ad then return false end
local effects=ad:FindFirstChild("BodyEffects")local grabbed=effects and effects:FindFirstChild("Grabbed")
if grabbed then
if grabbed:IsA("ObjectValue")then
local value=grabbed.Value
if value and(value==job.target or value==char or value:IsDescendantOf(char))then return true end
elseif grabbed:IsA("StringValue")and(grabbed.Value==job.target.Name or grabbed.Value==tostring(job.target.UserId))then return true end
end
for _,model in ipairs({ad,char})do
for _,joint in ipairs(model:GetDescendants())do
if joint:IsA("JointInstance")or joint:IsA("WeldConstraint")then
local a,b=joint.Part0,joint.Part1
if a and b and((a:IsDescendantOf(ad)and b:IsDescendantOf(char))or(b:IsDescendantOf(ad)and a:IsDescendantOf(char)))then return true end
end
end
end
return false
end
function U.bringPickupPose(job,char,targetRoot)
local names={"UpperTorso","HumanoidRootPart","LowerTorso","Torso","Head"}
local attempt=job.pickupAttempts or 0
local part=char:FindFirstChild(names[attempt%#names+1])or char:FindFirstChild("UpperTorso")or char:FindFirstChild("Torso")or targetRoot
local offsets={Vector3.new(0,2.7,0),Vector3.new(1.4,2.7,0),Vector3.new(-1.4,2.7,0),Vector3.new(0,2.7,1.4),Vector3.new(0,2.7,-1.4)}
return CFrame.new(part.Position+offsets[attempt%#offsets+1])
end
function U.bringPressG(job)
if U.autoKill~=job or not U.k or bw:GetFocusedTextBox()then return false,"Game must be focused with chat closed"end
if U.bringCarriesTarget(job)then return true end
if U.carryActive()then return false,"Already carrying another player"end
local env=getfenv(0)
local press,release=env.keypress,env.keyrelease
local down,up
if type(press)=="function"and type(release)=="function"then
down=function()press(0x47)end up=function()release(0x47)end
else
local ok,input=pcall(function()return game:GetService("VirtualInputManager")end)
if not ok then return false,"G input API unavailable"end
down=function()input:SendKeyEvent(true,Enum.KeyCode.G,false,game)end
up=function()input:SendKeyEvent(false,Enum.KeyCode.G,false,game)end
end
local ok,err=pcall(down)
if ok then task.wait(0.08)end
local released,releaseError=pcall(up)
if not ok then return false,tostring(err)end
if not released then return false,"G release failed: "..tostring(releaseError)end
return true
end
function U.autoBringStep(job,char,hum,targetRoot,now)
if U.autoKill~=job then return end
if char~=job.character or U.autoKillDead(char)then U.autoKillStop("Bring stopped: target died or respawned before pickup")return end
if not U.bringState then
if U.gunOrbit then U.gunOrbitStop()end
if U.gunBodyFollow then U.gunBodyFollowStop()end
if U.gunPurchase then U.gunPurchaseCancel()end
if U.attackRecoveryEnd then U.attackRecoveryEnd()end
humanoid:UnequipTools()
local torso=char:FindFirstChild("UpperTorso")or char:FindFirstChild("Torso")or targetRoot
U.controlHoldStart("bringState",CFrame.new(torso.Position+Vector3.new(0,3,0)),"HuybypassBringLock")
job.phase="pickup" job.pickupDeadline=now+20 job.pressAt=now+0.3 job.pickupAttempts=0 job.retryAt=nil
end
local state=U.bringState
if U.bringCarriesTarget(job)then
if job.phase~="return"then
job.phase="return" job.returnStarted=now state.pose=job.homeCFrame
U.autoKillStatus("Bring: returning with @"..job.target.Name)
end
if now-job.returnStarted>=0.5 and(root.Position-job.homeCFrame.Position).Magnitude<=4 and(targetRoot.Position-root.Position).Magnitude<=14 then
U.autoKillStop("Bring complete; press G to put them down")
U.autoReturnHome(job)
elseif now-job.returnStarted>3 then U.autoKillStop("Bring stopped: arrival was not confirmed")end
return
end
if job.phase=="return"then U.autoKillStop("Bring stopped: target was released during return")return end
if U.carryActive()then U.autoKillStop("Bring stopped: a different player was picked up")return end
if not U.zipAttackKnocked({targetCharacter=char,targetHum=hum})then U.autoKillStop("Bring stopped: target recovered before pickup")return end
if now>job.pickupDeadline then U.autoKillStop("Bring stopped: pickup unconfirmed after "..job.pickupAttempts.." attempts")return end
if job.retryAt then
-- Wait for replicated carry state before moving or sending another toggle.
if now<job.retryAt then U.autoKillStatus("Bring: confirming pickup "..job.pickupAttempts.."/8")return end
if job.pickupAttempts>=8 then U.autoKillStop("Bring stopped: pickup unconfirmed after 8 attempts")return end
job.retryAt=nil job.pressAt=now+0.3
end
state.pose=U.bringPickupPose(job,char,targetRoot)
U.autoKillStatus("Bring: positioning for pickup "..(job.pickupAttempts+1).."/8")
if now>=job.pressAt and(root.Position-state.pose.Position).Magnitude<=1.25 then
job.pickupAttempts=job.pickupAttempts+1
job.retryAt=now+1.5
local ok,err=U.bringPressG(job)
if U.autoKill~=job then return end
if not ok then U.autoKillStop("Bring stopped: "..tostring(err))end
end
end

function U.autoKillRoamBounds(origin)
local bounds={minX=origin.X-750,maxX=origin.X+750,minZ=origin.Z-750,maxZ=origin.Z+750,ground=origin.Y,top=origin.Y+200}
for _,part in ipairs(workspace:GetDescendants())do
if part:IsA("BasePart")and part.Anchored and part.CanCollide and not part:IsDescendantOf(aq)then
local p,size=part.Position,part.Size
if math.abs(p.X-origin.X)<3000 and math.abs(p.Z-origin.Z)<3000 and math.abs(p.Y-origin.Y)<500 and size.X<5000 and size.Z<5000 then
bounds.minX=math.max(origin.X-3000,math.min(bounds.minX,p.X-size.X/2))
bounds.maxX=math.min(origin.X+3000,math.max(bounds.maxX,p.X+size.X/2))
bounds.minZ=math.max(origin.Z-3000,math.min(bounds.minZ,p.Z-size.Z/2))
bounds.maxZ=math.min(origin.Z+3000,math.max(bounds.maxZ,p.Z+size.Z/2))
bounds.top=math.max(bounds.top,p.Y+size.Y/2)
end
end
end
return bounds
end
function U.autoKillRoamPosition(state)
local b,rng=state.bounds,state.random
local floor=workspace.FallenPartsDestroyHeight+40
local y
state.underground=not state.underground
if state.underground and floor<b.ground-30 then y=rng:NextNumber(floor,math.max(floor,b.ground-30))
else y=rng:NextNumber(math.max(floor,b.top+150),math.max(floor+1,b.top+550))end
return Vector3.new(rng:NextNumber(b.minX,b.maxX),y,rng:NextNumber(b.minZ,b.maxZ))
end
function U.autoHideMove(state,now)
if now>=(state.nextMove or 0)then
state.nextMove=now+(bw.TouchEnabled and 0.16 or 0.08)
state.pose=CFrame.new(U.autoKillRoamPosition(state))
end
end
function U.autoKillRoamStop()
local state=U.autoKillRoam
if not state then return end
U.autoKillRoam=nil
U.copyCameraRestore(state)
if state.connection then state.connection:Disconnect()end
game:GetService("ContextActionService"):UnbindAction("HuybypassAutoWaitLock")
if root==state.root and ad==state.character and root.Parent then
if U.emoteNoReturnCharacter~=state.character then root.CFrame=state.returnCFrame end
root.AssemblyLinearVelocity=Vector3.zero root.AssemblyAngularVelocity=Vector3.zero
state.humanoid.WalkSpeed=state.walk state.humanoid.JumpPower=state.jump state.humanoid.JumpHeight=state.height
end
U.gunOrbitRelease(state)
end
function U.autoKillRoamStart(job)
if U.autoKillRoam or U.autoKill~=job or not job.repeatKill then return end
if U.attackRecoveryEnd then U.attackRecoveryEnd()end
local state={root=root,character=ad,humanoid=humanoid,returnCFrame=job.homeCFrame or root.CFrame,safeCFrame=job.homeCFrame or root.CFrame,
walk=humanoid.WalkSpeed,jump=humanoid.JumpPower,height=humanoid.JumpHeight,random=Random.new(),bounds=job.roamBounds,nextMove=0}
U.autoKillRoam=state
U.copyWaitCamera(state)
U.gunOrbitGuardStart(state)
U.zipAttackSetNoclip(state)
game:GetService("ContextActionService"):BindActionAtPriority("HuybypassAutoWaitLock",function()return Enum.ContextActionResult.Sink end,false,10000,table.unpack(Enum.PlayerActions:GetEnumItems()))
state.connection=ae.PreSimulation:Connect(function()
local ok,err=pcall(function()
if U.autoKill~=job or root~=state.root or ad~=state.character or not U.f()or not U.k then U.autoKillRoamStop()return end
U.gunOrbitGuardStep(state)U.zipAttackSetNoclip(state)
state.humanoid.WalkSpeed=0 state.humanoid.JumpPower=0 state.humanoid.JumpHeight=0 state.humanoid.Jump=false state.humanoid:Move(Vector3.zero,false)
U.autoHideMove(state,os.clock())
root.CFrame=state.pose root.AssemblyLinearVelocity=Vector3.zero root.AssemblyAngularVelocity=Vector3.zero
end)
if not ok then U.autoKillStop("Waiting movement stopped: "..tostring(err))end
end)
end
function U.autoKillViewStop()
local state=U.autoKillView
if not state then return end
U.autoKillView=nil
if state.connection then state.connection:Disconnect()end
player.CameraMaxZoomDistance=math.max(state.maxZoom,player.CameraMinZoomDistance)
player.CameraMinZoomDistance=state.minZoom player.CameraMaxZoomDistance=state.maxZoom player.CameraMode=state.mode
local camera=workspace.CurrentCamera
if camera then
camera.CameraType=Enum.CameraType.Custom
local hum=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if hum then camera.CameraSubject=hum end
end
if U.autoKillViewLabel then U.autoKillViewLabel.Text="VIEW SELECTED"end
end
function U.autoKillViewTarget(target)
if not ec.hvh then return end
if U.autoKillView and U.autoKillView.target==target then U.autoKillViewStop()return end
U.autoKillViewStop()
if not target or target==player or target.Parent~=bo then return end
local state={target=target,mode=player.CameraMode,minZoom=player.CameraMinZoomDistance,maxZoom=player.CameraMaxZoomDistance}
U.autoKillView=state
player.CameraMode=Enum.CameraMode.Classic player.CameraMaxZoomDistance=math.max(60,player.CameraMaxZoomDistance)player.CameraMinZoomDistance=8
local function update()
if not U.d or target.Parent~=bo then U.autoKillViewStop()return end
local camera=workspace.CurrentCamera
local char=target.Character local hum=char and char:FindFirstChildOfClass("Humanoid")
if not camera then return end
if hum and hum.Parent then
camera.CameraType=Enum.CameraType.Custom camera.CameraSubject=hum
if U.autoKillViewLabel then U.autoKillViewLabel.Text="STOP VIEW: @"..target.Name end
else
 
camera.CameraType=Enum.CameraType.Scriptable
if U.autoKillViewLabel then U.autoKillViewLabel.Text="VIEW: WAITING FOR RESPAWN"end
end
end
state.connection=ae.RenderStepped:Connect(update)update()
end
function U.autoKillPause()
local job=U.autoKill
if not U.d or not job or not job.repeatKill then return false end
job.awaitLocal=true job.character=nil job.oldCharacter=nil job.phase="ready"
U.autoKillStatus("Waiting for your character to recover / respawn")
return true
end
function U.autoKillStatus(text)
if U.autoKillLabel then U.autoKillLabel.Text=text end
end
function U.autoKillStop(reason)
local job=U.autoKill
if job and job.deathConnection then job.deathConnection:Disconnect()job.deathConnection=nil end
U.autoKillViewStop()
U.autoKill=nil
U.H()
U.autoKillStatus(reason or "Stopped")
end
function U.copyWatchDeath(job,char)
if U.isOriginalDaHood or job.deathCharacter==char then return end
if job.deathConnection then job.deathConnection:Disconnect()job.deathConnection=nil end
job.deathCharacter=char job.deathConfirmed=false
local hum=char and char:FindFirstChildOfClass("Humanoid")
if not hum then return end
job.deathConfirmed=hum.Health<=0
job.deathConnection=hum.Died:Connect(function()
if U.autoKill==job and job.deathCharacter==char then job.deathConfirmed=true end
end)
end
function U.autoKillDead(char)
local job=U.autoKill
if not U.isOriginalDaHood and job and job.deathCharacter==char and job.deathConfirmed then return true end
local hum=char and char:FindFirstChildOfClass("Humanoid")
local effects=char and char:FindFirstChild("BodyEffects")
local dead=effects and effects:FindFirstChild("SDeath")
return (hum and hum.Health<=0)or(dead and dead.Value==true)or false
end
function U.autoKillComplete(job,char)
if job.deathConnection then job.deathConnection:Disconnect()job.deathConnection=nil end
if U.gunOrbit then U.gunOrbitStop()end
if U.gunBodyFollow then U.gunBodyFollowStop()end
if U.gunPurchase then U.gunPurchaseCancel()end
job.completed=(job.completed or 0)+1
if not job.repeatKill then
U.autoKillStop(job.mode=="bring"and"Bring stopped: target died before pickup"or"Single kill finished")
if job.mode~="bring"then
if not U.isOriginalDaHood and U.f()then
U.autoReturnHome(job)
U.voidHideToggle()
U.autoKillStatus("Single kill finished; Void Hide until target respawns")
local hide=U.voidHide
if hide then task.spawn(function()
while U.d and U.voidHide==hide and job.target.Parent==bo and job.target.Character==char do task.wait(0.1)end
if U.voidHide==hide then
U.voidHideStop(true)
U.autoKillStatus("Single kill finished; returned after respawn")
end
end)end
elseif U.autoReturnHome(job)then U.autoKillStatus("Single kill finished; returned to start")
else U.autoKillStatus("Single kill finished; return unavailable after character change")end
end
return
end
job.phase="respawn" job.oldCharacter=char job.character=nil
U.autoKillRoamStart(job)
U.autoKillStatus("Waiting for respawn | Kills: "..job.completed)
end
function U.autoKillStep(job,now)
if not ec.hvh then return end
if U.autoKill~=job then return end
if not U.d or not U.k then U.autoKillStop("Stopped: inactive or unfocused")return end
if job.target.Parent~=bo then U.autoKillStop("Stopped: target left")return end
if not U.f()or ad~=player.Character then
if not job.repeatKill then U.autoKillStop("Stopped: your character unavailable")return end
if not job.awaitLocal then U.autoKillPause()U.H(true)end
return
end
if job.awaitLocal or ad~=job.localCharacter then
if not job.repeatKill then U.autoKillStop("Stopped: your character changed")return end
job.awaitLocal=nil job.localCharacter=ad job.localRoot=root job.homeCFrame=root.CFrame job.phase="ready"
U.autoKillStatus("Respawn ready; resuming @"..job.target.Name)
end
if U.gunPurchase and U.gunPurchase.kind=="armor"then U.autoKillStatus("Buying replacement armor")return end
local char=job.target.Character
if job.character and char~=job.character then
if U.autoKillDead(job.character)then U.autoKillComplete(job,job.character)
elseif not job.repeatKill then U.autoKillStop("Target respawned; kill not confirmed")
else
if U.gunOrbit then U.gunOrbitStop()end
if U.gunBodyFollow then U.gunBodyFollowStop()end
if U.gunPurchase then U.gunPurchaseCancel()end
job.oldCharacter=job.character job.character=nil job.phase="respawn"
if not U.isOriginalDaHood then U.autoKillRoamStart(job)end
U.autoKillStatus("Target changed character; waiting for respawn")
end
return
end
if job.phase=="respawn"then
if not char or char==job.oldCharacter then if not U.isOriginalDaHood then U.autoKillRoamStart(job)end return end
job.phase="ready"
end
if not char then if not U.isOriginalDaHood then U.autoKillRoamStart(job)end U.autoKillStatus("Waiting for target character")return end
local hum=char:FindFirstChildOfClass("Humanoid")
local targetRoot=char:FindFirstChild("HumanoidRootPart")
U.copyWatchDeath(job,char)
if U.autoKillDead(char)then
if job.character then U.autoKillComplete(job,char)
else job.phase="respawn" job.oldCharacter=char U.autoKillStatus("Waiting for respawn")end
return
end
if not hum or not targetRoot then U.autoKillStatus("Waiting for target to load")return end
if char:FindFirstChildOfClass("ForceField")then
if U.bringState then U.autoKillStop("Bring stopped: target protected")return end
if U.gunOrbit then U.gunOrbitStop()end
if U.gunBodyFollow then U.gunBodyFollowStop()end
if U.gunPurchase then U.gunPurchaseCancel()end
job.phase="ready" if not U.isOriginalDaHood then U.autoKillRoamStart(job)end U.autoKillStatus("Waiting for forcefield")return
end
U.autoKillRoamStop()
local knocked=U.zipAttackKnocked({targetCharacter=char,targetHum=hum})
if job.mode=="bring"and(knocked or job.phase=="pickup"or job.phase=="return")then
job.character=char U.autoBringStep(job,char,hum,targetRoot,now)return
end
if knocked then
job.character=char
if job.phase~="stomp"then
local follow=U.gunBodyFollow
if U.gunOrbit then U.gunOrbitStop(nil,true)follow=U.gunBodyFollow end
if not follow then
if U.gunPurchase then U.gunPurchaseCancel()end
local state={root=root,character=ad,humanoid=humanoid,target=job.target,targetCharacter=char,targetRoot=targetRoot,targetHum=hum,safeCFrame=root.CFrame,startCFrame=root.CFrame}
U.gunOrbitGuardStart(state)U.gunOrbitFollow(state)
end
job.phase="stomp" job.stompDeadline=now+12 job.nextStomp=now+0.15
end
U.autoKillStatus("Stomping @"..job.target.Name)
if now>job.stompDeadline then U.autoKillStop("Stopped: stomp was not confirmed")return end
if not U.gunBodyFollow then U.autoKillStop("Stopped: body follow interrupted")return end
if now>=job.nextStomp then
job.nextStomp=now+0.6
local remote=cV:FindFirstChild("MainEvent")
local torso=char:FindFirstChild("UpperTorso")or char:FindFirstChild("Torso")or targetRoot
if remote and remote:IsA("RemoteEvent")and(root.Position-torso.Position).Magnitude<=7 then remote:FireServer("Stomp")end
end
return
end
if job.phase=="stomp"then
if U.gunBodyFollow then U.gunBodyFollowStop()end
job.phase="ready"
end
if U.gunPurchase then U.autoKillStatus("Buying guns / ammo")return end
if U.gunOrbit then U.autoKillStatus("X attacking @"..job.target.Name)return end
if job.phase=="attack"then U.autoKillStop("Stopped: X interrupted or loadout failed")return end
job.character=char job.phase="attack"
U.autoKillStatus((not U.isOriginalDaHood and job.mode=="bring"and "Bring: Revolver on @"or "Starting X on @")..job.target.Name)
U.gunOrbitStart(job.target)
end
function U.autoKillStart(repeatKill,mode)
if not ec.hvh then return end
local target=U.autoKillSelected
if not target or target==player or target.Parent~=bo then U.autoKillStatus("Select a player first")return end
if not U.f()or not U.k or U.carryActive()then U.autoKillStatus("Stand up and put down carried players first")return end
U.H()
local job={target=target,repeatKill=repeatKill and mode~="bring",mode=mode,phase="ready",localCharacter=ad,localRoot=root,completed=0,homeCFrame=root.CFrame}
if repeatKill then job.roamBounds=U.autoKillRoamBounds(root.Position)end
U.autoKill=job
if U.modeEmoteStep then U.modeEmoteStep()end
U.autoKillStatus(mode=="bring"and"Bring: knock down, G pickup, return"or(repeatKill and "Auto Kill starting"or"Single Kill starting"))
task.spawn(function()
while U.autoKill==job do
local ok,err=pcall(U.autoKillStep,job,os.clock())
if not ok then U.autoKillStop("Stopped: "..tostring(err))break end
task.wait(0.1)
end
end)
end
function U.noSitStep()
if not ec.hvh then return end
local hum=humanoid
if not U.d or not hum or not hum.Parent then return end
if U.noSitHum~=hum then
if U.noSitHum and U.noSitHum.Parent then U.noSitHum:SetStateEnabled(Enum.HumanoidStateType.Seated,U.noSitBefore)end
U.noSitHum=hum U.noSitBefore=hum:GetStateEnabled(Enum.HumanoidStateType.Seated)
end
hum:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
hum.Sit=false
local seat=hum.SeatPart local weld=seat and seat:FindFirstChild("SeatWeld")
if weld and weld:IsA("JointInstance")then
local p=weld.Part1
if p and ad and p:IsDescendantOf(ad)then weld:Destroy()end
end
if hum:GetState()==Enum.HumanoidStateType.Seated then hum:ChangeState(Enum.HumanoidStateType.GettingUp)end
end
function U.sentryPlayer(value)
if typeof(value)=="Instance"then
if value:IsA("Player")then return value end
if value:IsA("Model")then return bo:GetPlayerFromCharacter(value)end
elseif type(value)=="number"then return bo:GetPlayerByUserId(value)
elseif type(value)=="string"then
local found=bo:FindFirstChild(value)
if found and found:IsA("Player")then return found end
local id=tonumber(value)if id then return bo:GetPlayerByUserId(id)end
end
end
function U.sentryRemember(attacker,now,kind)
if not attacker or attacker==player or attacker.Parent~=bo then return end
U.sentryEvidence=U.sentryEvidence or {}
U.sentryEvidence[attacker]={target=attacker,time=now,kind=kind,character=attacker.Character}
end
function U.sentryScan(char,hum,effects,now)
local found={}
for _,object in pairs({char=char,hum=hum,effects=effects})do
for _,name in ipairs({"creator","Creator","Attacker","LastAttacker"})do
local tag=object:FindFirstChild(name)
if tag and tag:IsA("ValueBase")then
local value=tag.Value found[tag]=value
if (U.sentryTags or {})[tag]~=value then U.sentryRemember(U.sentryPlayer(value),now,"tag")end
end
end
end
U.sentryTags=found
end
function U.sentryShotOwner(ray,origin)
-- Prefer explicit replicated ownership. Invalid/self owners never fall through.
for _,name in ipairs({"OwnerCharacter","Owner","Shooter","ShooterUserId"})do
local value=ray:GetAttribute(name)
local tag=ray:FindFirstChild(name)
if value==nil and tag and tag:IsA("ValueBase")then value=tag.Value end
if value~=nil then return U.sentryPlayer(value),"owner"end
end
-- Infer only from an equipped gun's muzzle, rejecting crowded/ambiguous origins.
local best,nearest,second=nil,math.huge,math.huge
for _,candidate in ipairs(bo:GetPlayers())do
local char=candidate.Character local distance=math.huge
if char then
for _,tool in ipairs(char:GetChildren())do
local handle=tool:IsA("Tool")and tool:FindFirstChild("Handle")
if handle and handle:IsA("BasePart")and tool:FindFirstChild("Ammo")then
distance=math.min(distance,(handle.Position-origin).Magnitude)
end
end
end
if distance<nearest then second=nearest nearest=distance best=candidate
elseif distance<second then second=distance end
end
if nearest<=10 and second-nearest>=3 then return best,"muzzle"end
end
function U.sentryTrace(ray)
local char=player.Character
if not U.d or not U.sentryEnabled or not char or ray.Name~="BULLET_RAYS"then return end
local deadline=os.clock()+0.3
local beam,first,last
repeat
if not ray.Parent or not U.d or not U.sentryEnabled or player.Character~=char then return end
beam=ray:FindFirstChildWhichIsA("Beam",true)
first=beam and beam.Attachment0 last=beam and beam.Attachment1
if first and last then break end
task.wait(0.02)
until os.clock()>=deadline
-- Some skins replace the Beam; the bullet part still owns endpoint attachments.
if not first or not last then
local attachments={}
for _,item in ipairs(ray:GetChildren())do if item:IsA("Attachment")then attachments[#attachments+1]=item end end
if #attachments~=2 then return end
first,last=attachments[1],attachments[2]
if ray:IsA("BasePart")and(last.WorldPosition-ray.Position).Magnitude<(first.WorldPosition-ray.Position).Magnitude then first,last=last,first end
end
local origin,endpoint=first.WorldPosition,last.WorldPosition
local direction=endpoint-origin local length2=direction:Dot(direction)
if length2<0.01 then return end
local intersects=false
for _,part in ipairs(char:GetChildren())do
if part:IsA("BasePart")then
local t=math.clamp((part.Position-origin):Dot(direction)/length2,0,1)
local localPoint=part.CFrame:PointToObjectSpace(origin+direction*t)
local half=part.Size*0.5+Vector3.new(0.75,0.75,0.75)
if math.abs(localPoint.X)<=half.X and math.abs(localPoint.Y)<=half.Y and math.abs(localPoint.Z)<=half.Z then intersects=true break end
end
end
if not intersects then return end
local attacker,kind=U.sentryShotOwner(ray,origin)
U.sentryRemember(attacker,os.clock(),kind)
end
function U.sentryWatch()
if not ec.hvh then return end
if U.sentryWatching then return end
U.sentryWatching=true
U.b(workspace.DescendantAdded,function(object)
if U.sentryEnabled and object.Name=="BULLET_RAYS"then
task.spawn(function()
local ok,err=pcall(U.sentryTrace,object)
if not ok and aa.Debug then warn("Sentry trace: "..tostring(err))end
end)
end
end)
end
function U.sentryResolve(hitTime,now)
local target
for candidate,record in pairs(U.sentryEvidence or {})do
if now-record.time>1.2 or candidate.Parent~=bo or candidate.Character~=record.character then
U.sentryEvidence[candidate]=nil
elseif math.abs(record.time-hitTime)<=0.65 then
if target and target~=candidate then return nil,"ambiguous"end
target=candidate
end
end
return target
end
function U.sentryStep(hit,char,hum,effects)
if not ec.hvh then return end
local now=os.clock()
if not U.sentryEnabled then U.sentryHit=nil U.sentryPending=nil U.sentryEvidence={} U.sentryScan(char,hum,effects,now)U.sentryEvidence={} return end
U.sentryWatch()
U.sentryScan(char,hum,effects,now)
if hit and hum.Health>0 then U.sentryHit=now end
if U.sentryHit then
local target,reason=U.sentryResolve(U.sentryHit,now)
if target then
U.sentryPending=target U.sentryPendingCharacter=target.Character U.sentryUntil=now+3 U.sentryHit=nil U.sentryEvidence={}
elseif now-U.sentryHit>0.65 then
U.sentryHit=nil U.utilityStatus(reason=="ambiguous"and"Sentry: multiple shooters; attribution unclear"or"Sentry: no replicated attacker/shot evidence")
end
end
local target=U.sentryPending
if not target then return end
local tc=target.Character local th=tc and tc:FindFirstChildOfClass("Humanoid")
if now>U.sentryUntil or target.Parent~=bo or tc~=U.sentryPendingCharacter or not th or th.Health<=0 then U.sentryPending=nil return end
if U.gunPurchase or not U.f()or not U.k or U.carryActive()then return end
if tc:FindFirstChildOfClass("ForceField")or U.zipAttackKnocked({targetCharacter=tc,targetHum=th})then return end
U.sentryPending=nil
if U.sentryTarget==target and U.gunOrbit then return end
U.autoKillStop("Sentry retaliation")
U.sentryTarget=target
U.utilityStatus("Sentry: returning fire at @"..target.Name.."; stop at K.O.")
U.gunOrbitStart(target)
if not U.gunOrbit and not U.gunPurchase then U.sentryTarget=nil end
end
function U.utilityStatus(text)
if U.utilityLabel then U.utilityLabel.Text=text end
end
function U.autoArmorBuy()
if not ec.hvh then return end
if not U.autoArmorEnabled or U.gunPurchase or not U.f()or not U.k or U.carryActive()then return end
U.armorPending=false U.armorNextBuy=os.clock()+1.5
local effects=ad:FindFirstChild("BodyEffects")local armor=effects and effects:FindFirstChild("Armor")
local shops=workspace:FindFirstChild("Ignored")shops=shops and shops:FindFirstChild("Shop")
local shop
if shops then
for _,token in ipairs({"[High-Medium Armor]","[Medium Armor]","[Armor]"})do
for _,candidate in ipairs(shops:GetChildren())do if candidate.Name:find(token,1,true)then shop=candidate break end end
if shop then break end
end
end
local head=shop and shop:FindFirstChild("Head")local detector=shop and shop:FindFirstChildOfClass("ClickDetector")
local click=getfenv(0).fireclickdetector
if not armor or not head or not detector or type(click)~="function"then U.utilityStatus("Armor shop, armor value or click API unavailable")U.armorPending=false return end
local auto=U.autoKill local target=U.gunOrbit and U.gunOrbit.target
U.H(true)
local job={root=root,character=ad,position=root.CFrame,hold=head.CFrame+Vector3.new(0,3,0),humanoid=humanoid,walk=humanoid.WalkSpeed,jump=humanoid.JumpPower,height=humanoid.JumpHeight,kind="armor"}
U.gunPurchase=job U.armorPending=false
if auto then auto.phase="ready"end
U.gunOrbitGuardStart(job)U.zipAttackSetNoclip(job)
game:GetService("ContextActionService"):BindActionAtPriority("HuybypassPurchaseLock",function()return Enum.ContextActionResult.Sink end,false,10000,table.unpack(Enum.PlayerActions:GetEnumItems()))
job.lock=ae.PreSimulation:Connect(function()
if U.gunPurchase~=job or root~=job.root or ad~=job.character then return end
U.gunOrbitGuardStep(job)U.zipAttackSetNoclip(job)
job.humanoid.WalkSpeed=0 job.humanoid.JumpPower=0 job.humanoid.JumpHeight=0 job.humanoid.Jump=false job.humanoid:Move(Vector3.zero,false)
job.root.CFrame=job.hold job.root.AssemblyLinearVelocity=Vector3.zero job.root.AssemblyAngularVelocity=Vector3.zero
end)
U.utilityStatus("Buying armor with in-game cash...")
task.spawn(function()
local function active()return U.gunPurchase==job and U.autoArmorEnabled and root==job.root and ad==job.character and U.f()and U.k end
local before=armor.Value
local ok,err=pcall(function()
if not active()then return end
job.root.CFrame=job.hold job.root.AssemblyLinearVelocity=Vector3.zero
 
task.wait(0.15)
for attempt=1,1 do
if not active()then return end
click(detector)
local deadline=os.clock()+0.6
repeat task.wait(0.05)until not active()or armor.Value>before or os.clock()>=deadline
if not active()or armor.Value>before then return end
end
end)
if U.gunPurchase~=job then return end
local success=armor.Parent and armor.Value>before
U.gunPurchaseCancel()
U.armorNextBuy=os.clock()+1.5
U.utilityStatus(not ok and("Armor error: "..tostring(err))or(success and"Armor purchase confirmed"or"Armor purchase not confirmed; waiting for next hit"))
if U.d and U.f()and U.k and root==job.root and ad==job.character then
if auto and U.autoKill==auto then auto.phase="ready"
elseif not U.autoKill and target and target.Parent==bo then U.gunOrbitStart(target)end
end
end)
end
function U.modeEmoteWanted()
return U.voidHide~=nil or(U.autoKill~=nil and U.autoKill.mode~="bring")
end
function U.modeEmoteStop()
U.modeEmoteToken=(U.modeEmoteToken or 0)+1
U.modeEmoteLoading=nil
local state=U.modeEmote U.modeEmote=nil
if state and state.track then pcall(function()state.track:Stop(0.15)state.track:Destroy()end)end
end
function U.modeEmoteStep()
local hum=humanoid local char=ad
if not U.d or not U.modeEmoteWanted()or not hum or not hum.Parent or hum.Health<=0 or char~=player.Character then
if U.modeEmote or U.modeEmoteLoading then U.modeEmoteStop()end
U.modeEmoteAttempts=0 U.modeEmoteNext=0
return
end
local current=U.modeEmote
if current and current.character==char and current.humanoid==hum then
if not current.track.IsPlaying and os.clock()>=(current.nextPlay or 0)then
current.nextPlay=os.clock()+1
local ok=pcall(function()current.track:Play(0.15)end)
if not ok then U.modeEmoteStop()U.modeEmoteNext=os.clock()+10 end
end
return
end
if current then U.modeEmoteStop()U.modeEmoteAttempts=0 end
if U.modeEmoteLoading or os.clock()<(U.modeEmoteNext or 0)or(U.modeEmoteAttempts or 0)>=3 then return end
U.modeEmoteAttempts=(U.modeEmoteAttempts or 0)+1
U.modeEmoteToken=(U.modeEmoteToken or 0)+1
local token=U.modeEmoteToken U.modeEmoteLoading=token U.modeEmoteNext=os.clock()+10
task.spawn(function()
local track
local ok,result=pcall(function()
local success,resolved=hum:PlayEmoteAndGetAnimTrackById(124573621747512)
if success and resolved then return resolved end
end)
if ok then track=result end
if not track then
local animation=Instance.new("Animation")animation.AnimationId="rbxassetid://124573621747512"
local controller=hum:FindFirstChildOfClass("Animator")
if controller then local loaded,value=pcall(function()return controller:LoadAnimation(animation)end)if loaded then track=value end end
animation:Destroy()
end
if U.modeEmoteToken~=token or not U.d or not U.modeEmoteWanted()or ad~=char or humanoid~=hum or hum.Health<=0 then
if track then pcall(function()track:Stop(0)track:Destroy()end)end
if U.modeEmoteLoading==token then U.modeEmoteLoading=nil end
return
end
U.modeEmoteLoading=nil
if not track then U.utilityStatus("Mode emote unavailable; movement remains active")return end
local played,err=pcall(function()track.Priority=Enum.AnimationPriority.Action4 track.Looped=true track:Play(0.15)end)
if not played then pcall(function()track:Destroy()end)U.utilityStatus("Mode emote failed: "..tostring(err))return end
U.modeEmote={character=char,humanoid=hum,track=track}
end)
end

function U.utilityStep()
U.modeEmoteStep()
if not U.d then return end
local char=player.Character local hum=char and char:FindFirstChildOfClass("Humanoid")
if not char or not hum then return end
local effects=char:FindFirstChild("BodyEffects")local armor=effects and effects:FindFirstChild("Armor")
local amount=armor and armor.Value or nil
if U.utilityCharacter~=char then
U.utilityCharacter=char U.utilityHealth=hum.Health U.utilityArmor=amount U.resetCharacter=nil U.armorPending=false U.sentryRecent=nil U.sentryTags={} U.sentryHit=nil U.sentryPending=nil U.sentryEvidence={} U.sentryPendingCharacter=nil
end
local hit=(U.utilityHealth and hum.Health<U.utilityHealth)or(amount and U.utilityArmor and amount<U.utilityArmor)
U.utilityHealth=hum.Health U.utilityArmor=amount
if U.antiStompEnabled and U.resetCharacter~=char and hum.Health>0 and U.zipAttackKnocked({targetCharacter=char,targetHum=hum})then
U.resetCharacter=char U.armorPending=false
if U.autoKillPause()then U.H(true)else U.autoKillStop("Anti-Stomp: resetting knocked character")end
U.utilityStatus("Anti-Stomp reset requested")
hum.Health=0
return
end
if U.voidHide or U.bringState then return end
U.sentryStep(hit,char,hum,effects)
if not U.autoArmorEnabled then U.armorPending=false return end
if hit and hum.Health>0 and not(U.gunPurchase and U.gunPurchase.kind=="armor")then U.armorPending=true end
if U.armorPending and hum.Health>0 and not U.gunPurchase and os.clock()>=(U.armorNextBuy or 0)then U.autoArmorBuy()end
end
function U.utilityGui()
if not ec.hvh then return end
if U.utilityPanel then return end
local gui=U.ui("ScreenGui",player.PlayerGui,{Name="HuybypassUtilities",ResetOnSpawn=false,DisplayOrder=21})table.insert(U.aa,gui)
local panel=U.ui("Frame",gui,{Position=UDim2.fromOffset(18,80),Size=UDim2.fromOffset(270,390),BackgroundColor3=Color3.fromRGB(12,19,34),BorderSizePixel=0})U.g(panel,12)U.utilityPanel=panel
local screenScale=U.ui("UIScale",panel,{Scale=1})
local function fit()
local viewport=gui.AbsoluteSize
if viewport.X<1 or viewport.Y<1 then return end
screenScale.Scale=math.clamp(math.min((viewport.X-16)/270,(viewport.Y-16)/390),0.25,1)
local pos=panel.AbsolutePosition
panel.Position=UDim2.fromOffset(math.clamp(pos.X,0,math.max(0,viewport.X-270*screenScale.Scale)),math.clamp(pos.Y,0,math.max(0,viewport.Y-390*screenScale.Scale)))
end
U.b(gui:GetPropertyChangedSignal("AbsoluteSize"),fit)task.defer(fit)
U.ui("UIStroke",panel,{Color=Color3.fromRGB(54,72,99),Thickness=1})
local title=U.ui("TextButton",panel,{Text="HUYBYPASS / CONTROLS  •  DRAG",Position=UDim2.fromOffset(12,6),Size=UDim2.fromOffset(220,32),BackgroundTransparency=1,TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=12})
local close=U.ui("TextButton",panel,{Text="×",Position=UDim2.fromOffset(234,6),Size=UDim2.fromOffset(28,28),BackgroundTransparency=1,TextColor3=Color3.new(1,1,1),TextSize=22})U.b(close.Activated,function()panel.Visible=false end)
local function button(text,y,callback)
local b=U.ui("TextButton",panel,{Text=text,Position=UDim2.fromOffset(12,y),Size=UDim2.fromOffset(246,36),BackgroundColor3=Color3.fromRGB(36,51,72),TextColor3=Color3.new(1,1,1),BorderSizePixel=0,Font=Enum.Font.GothamBold,TextSize=12})U.g(b,7)U.b(b.Activated,function()callback(b)end)return b
end
button("OPEN / CLOSE AUTO KILL",46,function()if U.autoKillPanel then U.autoKillPanel.Visible=not U.autoKillPanel.Visible end end)
button("ANTI-STOMP: OFF",90,function(b)
U.antiStompEnabled=not U.antiStompEnabled b.Text="ANTI-STOMP: "..(U.antiStompEnabled and"ON"or"OFF")b.BackgroundColor3=U.antiStompEnabled and Color3.fromRGB(33,108,85)or Color3.fromRGB(36,51,72)
U.utilityStatus(U.antiStompEnabled and"Resets when K.O is detected"or"Anti-Stomp disabled")
end)
button("AUTO ARMOR: OFF",134,function(b)
U.autoArmorEnabled=not U.autoArmorEnabled b.Text="AUTO ARMOR: "..(U.autoArmorEnabled and"ON"or"OFF")b.BackgroundColor3=U.autoArmorEnabled and Color3.fromRGB(33,108,85)or Color3.fromRGB(36,51,72)
if not U.autoArmorEnabled then U.armorPending=false if U.gunPurchase and U.gunPurchase.kind=="armor"then U.gunPurchaseCancel()end end
U.utilityStatus(U.autoArmorEnabled and"Buys armor after damage; uses in-game cash"or"Auto Armor disabled")
end)
button(U.isOriginalDaHood and "WEAPON: LMG + RIFLE"or "WEAPON: REVOLVER",178,function(b)
if not U.isOriginalDaHood then U.utilityStatus("Revolver selected outside original Da Hood")return end
U.autoKillStop("Weapon mode changed; start X or Auto Kill again")
U.flameMode=not U.flameMode b.Text=U.flameMode and"WEAPON: FLAMETHROWER"or"WEAPON: LMG + RIFLE"
U.utilityStatus(U.flameMode and"Flamethrower uses tool activation; live compatibility unverified"or"LMG + Rifle selected")
end)
button("SENTRY: OFF",222,function(b)
U.sentryEnabled=not U.sentryEnabled b.Text=U.sentryEnabled and"SENTRY: ON"or"SENTRY: OFF"
U.sentryHit=nil U.sentryEvidence={} U.sentryPending=nil
if not U.sentryEnabled and U.sentryTarget then U.sentryTarget=nil U.H()end
U.utilityStatus(U.isOriginalDaHood and "Sentry retaliates with LMG + Rifle; no stomp"or "Sentry retaliates with Revolver; no stomp")
end)
U.voidHideButton=button("VOID HIDE: OFF",266,function()U.voidHideToggle()end)
U.utilityLabel=U.i(panel,"Toggles start OFF. Sit lock is always active.",11,UDim2.fromOffset(14,312),UDim2.fromOffset(242,64))U.utilityLabel.TextWrapped=true
local drag
U.b(title.InputBegan,function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then drag={input=input,start=input.Position,position=panel.AbsolutePosition}end end)
U.b(bw.InputChanged,function(input)
if not drag then return end
if input~=drag.input and not(drag.input.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseMovement)then return end
local camera=workspace.CurrentCamera if not camera then return end
local delta=input.Position-drag.start local p=drag.position+Vector2.new(delta.X,delta.Y)
panel.Position=UDim2.fromOffset(math.clamp(p.X,0,math.max(0,camera.ViewportSize.X-panel.AbsoluteSize.X)),math.clamp(p.Y,0,math.max(0,camera.ViewportSize.Y-panel.AbsoluteSize.Y)))
end)
U.b(bw.InputEnded,function(input)if drag and input==drag.input then drag=nil end end)
U.b(ae.Heartbeat,function()
local ok,err=pcall(U.utilityStep)
if not ok then U.armorPending=false if U.gunPurchase and U.gunPurchase.kind=="armor"then U.gunPurchaseCancel()end U.utilityStatus("Controls error: "..tostring(err))end
end)
end

function U.autoKillGui()
if not ec.hvh then return end
if U.autoKillGuiRoot then return end
local gui=U.ui("ScreenGui",player.PlayerGui,{Name="HuybypassAutoKill",ResetOnSpawn=false,DisplayOrder=20})
U.autoKillGuiRoot=gui table.insert(U.aa,gui)
local panel=U.ui("Frame",gui,{Position=UDim2.new(1,-332,0,66),Size=UDim2.fromOffset(320,472),BackgroundColor3=Color3.fromRGB(12,19,34),BorderSizePixel=0})U.g(panel,12)
U.ui("UIStroke",panel,{Color=Color3.fromRGB(54,72,99),Thickness=1})
local scale=U.ui("UIScale",panel,{Scale=1})
local toggle=U.ui("TextButton",gui,{Text="X PANEL",Position=UDim2.new(1,-110,0,20),Size=UDim2.fromOffset(98,34),BackgroundColor3=Color3.fromRGB(40,88,130),TextColor3=Color3.new(1,1,1),BorderSizePixel=0,Font=Enum.Font.GothamBold,TextSize=12})U.g(toggle,8)
U.autoKillPanel=panel panel.Visible=false toggle.Text="CONTROLS"
local function togglePanel()panel.Visible=not panel.Visible end
U.b(toggle.Activated,function()if U.utilityPanel then U.utilityPanel.Visible=not U.utilityPanel.Visible end end)
U.b(bw.InputBegan,function(input,processed)if not processed and not bw:GetFocusedTextBox()and input.KeyCode==Enum.KeyCode.RightShift then togglePanel()end end)
local title=U.ui("TextButton",panel,{Text="HUYBYPASS   /   TARGETS",Position=UDim2.fromOffset(14,8),Size=UDim2.fromOffset(248,34),BackgroundTransparency=1,TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=14,AutoButtonColor=false})
local hide=U.ui("TextButton",panel,{Text="×",Position=UDim2.fromOffset(278,8),Size=UDim2.fromOffset(30,30),BackgroundTransparency=1,TextColor3=Color3.fromRGB(165,180,200),TextSize=24})U.b(hide.Activated,togglePanel)
local chosen=U.i(panel,"SELECT A PLAYER BELOW",11,UDim2.fromOffset(16,45),UDim2.fromOffset(288,22))chosen.TextColor3=Color3.fromRGB(139,166,195)
local list=U.ui("ScrollingFrame",panel,{Position=UDim2.fromOffset(12,73),Size=UDim2.fromOffset(296,188),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=Color3.fromRGB(90,125,165),CanvasSize=UDim2.fromOffset(0,0)})
local rows={} local generation=0
U.autoAvatarCache=U.autoAvatarCache or {}
local function selectTarget(target)
if U.autoKill and U.autoKill.target~=target then U.autoKillStop("Target changed")end
U.autoKillSelected=target chosen.Text="TARGET: @"..target.Name
for _,entry in ipairs(rows)do entry.row.BackgroundColor3=entry.target==target and Color3.fromRGB(35,69,99)or Color3.fromRGB(22,30,44)end
end
local function refresh()
generation=generation+1 local token=generation
for _,entry in ipairs(rows)do entry.row:Destroy()end table.clear(rows)
local targets=bo:GetPlayers()table.sort(targets,function(a,b)return a.Name:lower()<b.Name:lower()end)
local thumbnails={}
for _,target in ipairs(targets)do
if target~=player then
local row=U.ui("Frame",list,{Position=UDim2.fromOffset(0,#rows*60),Size=UDim2.new(1,-7,0,54),BackgroundColor3=U.autoKillSelected==target and Color3.fromRGB(35,69,99)or Color3.fromRGB(22,30,44),BorderSizePixel=0})U.g(row,8)
local avatar=U.ui("ImageLabel",row,{Position=UDim2.fromOffset(6,6),Size=UDim2.fromOffset(42,42),BackgroundColor3=Color3.fromRGB(39,50,66),BorderSizePixel=0,Image=U.autoAvatarCache[target.UserId]or""})U.g(avatar,21)
local name=U.i(row,target.DisplayName,12,UDim2.fromOffset(55,6),UDim2.fromOffset(169,21))name.TextTruncate=Enum.TextTruncate.AtEnd
local username=U.i(row,"@"..target.Name,10,UDim2.fromOffset(55,27),UDim2.fromOffset(169,18))username.TextColor3=Color3.fromRGB(142,159,181)username.TextTruncate=Enum.TextTruncate.AtEnd
local pick=U.ui("TextButton",row,{Text="",BackgroundTransparency=1,Size=UDim2.new(1,-62,1,0)})
pick.Activated:Connect(function()selectTarget(target)end)
local view=U.ui("TextButton",row,{Text="VIEW",Position=UDim2.new(1,-58,0,12),Size=UDim2.fromOffset(51,30),BackgroundColor3=Color3.fromRGB(42,57,77),TextColor3=Color3.new(1,1,1),BorderSizePixel=0,Font=Enum.Font.GothamBold,TextSize=10})U.g(view,6)
view.Activated:Connect(function()U.autoKillViewTarget(target)end)
rows[#rows+1]={row=row,target=target}
thumbnails[#thumbnails+1]={image=avatar,id=target.UserId}
end
end
list.CanvasSize=UDim2.fromOffset(0,#rows*60)
task.spawn(function()
for _,entry in ipairs(thumbnails)do
if token~=generation or not gui.Parent or not U.d then return end
if not U.autoAvatarCache[entry.id]then
local ok,url,ready=pcall(function()return bo:GetUserThumbnailAsync(entry.id,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)
if ok and url then
if ready then U.autoAvatarCache[entry.id]=url end
if token==generation and entry.image.Parent then entry.image.Image=url end
end
end
task.wait(0.03)
end
end)
end
local function button(text,x,y,width,color,callback)
local b=U.ui("TextButton",panel,{Text=text,Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(width,34),BackgroundColor3=color,BorderSizePixel=0,TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=11})U.g(b,7)U.b(b.Activated,callback)return b
end
button("SINGLE KILL",12,272,144,Color3.fromRGB(30,94,147),function()U.autoKillStart(false)end)
button("AUTO KILL",164,272,144,Color3.fromRGB(153,47,69),function()U.autoKillStart(true)end)
button("Bring",12,314,296,Color3.fromRGB(45,105,85),function()U.autoKillStart(false,"bring")end)
U.autoKillViewLabel=button("VIEW SELECTED",12,356,204,Color3.fromRGB(37,50,70),function()
if U.autoKillView then U.autoKillViewStop()else U.autoKillViewTarget(U.autoKillSelected)end
end)
button("STOP",224,356,84,Color3.fromRGB(78,42,54),function()U.autoKillStop("Stopped")end)
U.autoKillLabel=U.i(panel,"Idle · X stops · Right Shift toggles panel",12,UDim2.fromOffset(16,401),UDim2.fromOffset(288,46))U.autoKillLabel.TextWrapped=true
local hint=U.i(panel,"Drag the title to move this panel",10,UDim2.fromOffset(16,447),UDim2.fromOffset(288,18))hint.TextColor3=Color3.fromRGB(105,125,150)
local drag=nil
U.b(title.InputBegan,function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then drag={input=input,start=input.Position,position=panel.AbsolutePosition}end
end)
U.b(bw.InputChanged,function(input)
if not drag then return end
local mouse=drag.input.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseMovement
if not mouse and input~=drag.input then return end
local delta=input.Position-drag.start local camera=workspace.CurrentCamera
if not camera then return end
local pos=drag.position+Vector2.new(delta.X,delta.Y)
panel.Position=UDim2.fromOffset(math.clamp(pos.X,0,math.max(0,camera.ViewportSize.X-panel.AbsoluteSize.X)),math.clamp(pos.Y,0,math.max(0,camera.ViewportSize.Y-panel.AbsoluteSize.Y-40)))
end)
U.b(bw.InputEnded,function(input)if drag and input==drag.input then drag=nil end end)
local lastViewport=nil
U.b(ae.RenderStepped,function()
local camera=workspace.CurrentCamera
if camera and camera.ViewportSize~=lastViewport then
lastViewport=camera.ViewportSize scale.Scale=math.clamp(math.min((lastViewport.X-24)/320,(lastViewport.Y-90)/472),0.5,1)
local p=panel.AbsolutePosition panel.Position=UDim2.fromOffset(math.clamp(p.X,0,math.max(0,lastViewport.X-320*scale.Scale)),math.clamp(p.Y,0,math.max(0,lastViewport.Y-472*scale.Scale-40)))
end
end)
U.b(bo.PlayerAdded,refresh)
U.b(bo.PlayerRemoving,function(leaving)
if U.autoKillSelected==leaving then U.autoKillSelected=nil chosen.Text="SELECT A PLAYER BELOW"end
if U.autoKillView and U.autoKillView.target==leaving then U.autoKillViewStop()end
task.defer(function()if U.d and gui.Parent then refresh()end end)
end)
refresh()
end

task.spawn(function()
if not ec.hvh then return end
while U.d and not U.a do task.wait(0.2)end
if U.d then U.autoKillGui()U.utilityGui()end
end)

do
local players=game:GetService("Players")
local http=game:GetService("HttpService")
local states={}
local running=true
local function restore(state)
 local h=state.humanoid
 if h and h.Parent and h.DisplayName==state.taggedName then h.DisplayName=state.originalName end
 state.humanoid=nil
end
local function apply(p,state)
 if not running or not U.d or states[p]~=state then return end
 local char=p.Character
 local h=char and char:FindFirstChildOfClass("Humanoid")
 if state.humanoid and state.humanoid~=h then restore(state) end
 if ec.namePrefix(p)=="" then restore(state)return end
 if h then
  if state.humanoid~=h then state.humanoid=h state.originalName=h.DisplayName end
  state.taggedName=ec.namePrefix(p)..p.Name
  h.DisplayName=state.taggedName
 end
end
local function check(p,state)
 if state.busy or not running then return end
 state.busy=true
 local settled=false
 task.delay(15,function()if not settled then settled=true state.busy=false end end)
 task.spawn(function()
  local ok,result=pcall(function()
   local env=getfenv(0)
   local request=env.request or env.http_request
   local options={Url="https://huybypass-daily-keys.dayzontwitchtv.workers.dev/beta/profile",Method="POST",Headers={["Content-Type"]="application/json"},Body=http:JSONEncode({userId=p.UserId})}
   local response=type(request)=="function"and request(options)or http:RequestAsync(options)
   return {status=tonumber(response.StatusCode or response.Status),data=http:JSONDecode(response.Body or response.body or "")}
  end)
  if settled then return end
  settled=true state.busy=false
  if not running or not U.d or states[p]~=state then return end
  if ok and type(result.data)=="table"then
   if result.status==200 and type(result.data.allowed)=="boolean"then
    ec.betaApproved[p.UserId]=result.data.allowed or nil
    local prefix=result.data.customPrefix
    ec.customPrefixes[p.UserId]=type(prefix)=="string"and #prefix<=160 and prefix or nil
   end
  end
  apply(p,state)
 end)
end
local function add(p)
 if states[p]or not running then return end
 local state={}states[p]=state
 state.connection=U.b(p.CharacterAdded,function(char)
  task.spawn(function()
   char:WaitForChild("Humanoid",10)
   if p.Character==char then apply(p,state)end
  end)
 end)
 apply(p,state)check(p,state)
end
U.b(players.PlayerAdded,add)
U.b(players.PlayerRemoving,function(p)
 local state=states[p]
 if state then restore(state)state.connection:Disconnect()states[p]=nil end
 ec.betaApproved[p.UserId]=nil ec.customPrefixes[p.UserId]=nil
end)
ec.betaStop=function()
 running=false
 for p,state in pairs(states)do restore(state)state.connection:Disconnect()states[p]=nil end
 table.clear(ec.betaApproved)table.clear(ec.customPrefixes)
end
for _,p in ipairs(players:GetPlayers())do add(p)end
task.spawn(function()
 while running and U.d do
  task.wait(60)
  if not running or not U.d then break end
  for p,state in pairs(states)do check(p,state)end
 end
end)
end

do
local players=game:GetService("Players")
local me=players.LocalPlayer
local busy=false
local lastTrigger=-math.huge
local watched={}
local function isTarget(p)
 return p.UserId==498192060 or p.Name:lower()=="luukemans14"
end
local function status(message)
 warn("Emote monitor: "..message)
 if type(U.h)=="function"then pcall(U.h,message)end
end
local saluteIds={["79649930639024"]=true}
local function identify(track)
 local a=track and track.Animation
 return a and tostring(a.AnimationId):match("%d+")
end
local function resolveEmote(char)
 task.spawn(function()
  local ok,objects=pcall(function()return game:GetObjects("rbxassetid://79649930639024")end)
  local resolved=false
  if ok and type(objects)=="table"then
   for _,object in ipairs(objects)do
    local all=object:GetDescendants()table.insert(all,object)
    for _,item in ipairs(all)do
     if item:IsA("Animation")then local id=tostring(item.AnimationId):match("%d+")if id then saluteIds[id]=true resolved=true end end
    end
    object:Destroy()
   end
  end
  if not resolved then
   local hum=char:WaitForChild("Humanoid",10)
   if not hum or me.Character~=char or not U.d then return end
   local success,played,track=pcall(function()return hum:PlayEmoteAndGetAnimTrackById(79649930639024)end)
   if success and played and track then
    local id=identify(track)if id then saluteIds[id]=true resolved=true end
    track:Stop(0)track:Destroy()
   end
  end
  if not resolved then status("Emote animation ID could not resolve; check console output.")end
 end)
end
U.b(me.CharacterAdded,resolveEmote)
if me.Character then resolveEmote(me.Character)end
local function alive(char,hum)
 return U.d and me.Character==char and char.Parent and hum.Parent and hum.Health>0
end
local function lockForEmote()
 if U.emoteLocked then return end
 U.emoteLocked=true
 U.emoteNoReturnCharacter=me.Character
 if U.voidHideStop then pcall(U.voidHideStop,false)end
 -- End held swing/charge without disabling other controls or anchoring the character.
 if U.o then pcall(U.o,false)end
 if U.y then pcall(U.y)end
 local actions=game:GetService("ContextActionService")
 local action="HuybypassEmoteFiveSecondLock"
 local keys={Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,
  Enum.KeyCode.E,Enum.KeyCode.Q,Enum.KeyCode.F,aa.WebKey,aa.JumpKey,aa.DashKey}
 local bound=pcall(function()
  actions:BindActionAtPriority(action,function()return Enum.ContextActionResult.Sink end,false,10000,table.unpack(keys))
 end)
 local released=false
 local function release()
  if released then return end released=true
  if bound then actions:UnbindAction(action)end
  U.emoteLocked=false U.emoteUnlock=nil
 end
 U.emoteUnlock=release
 task.delay(5,release)
end
local function respond(target,track)
 local animation=track.Animation
 local id=animation and tostring(animation.AnimationId):match("%d+")
 if not isTarget(target)or not saluteIds[id]or busy or os.clock()-lastTrigger<10 or target==me then return end
 local char=me.Character
 local hum=char and char:FindFirstChildOfClass("Humanoid")
 local root=char and char:FindFirstChild("HumanoidRootPart")
 local targetChar=target.Character
 local targetRoot=targetChar and targetChar:FindFirstChild("HumanoidRootPart")
 local animator=hum and hum:FindFirstChildOfClass("Animator")
 if not hum or not root or not targetRoot or not animator or not alive(char,hum)then return end
 busy=true lastTrigger=os.clock()
 lockForEmote()
 task.spawn(function()
  local responseTrack
  local ok,err=pcall(function()
   if not alive(char,hum)or target.Character~=targetChar or not targetRoot.Parent then return end
   local destination=targetRoot.CFrame*CFrame.new(0,0,-5)
   char:PivotTo(CFrame.lookAt(destination.Position,targetRoot.Position))
   root.AssemblyLinearVelocity=Vector3.zero
   root.AssemblyAngularVelocity=Vector3.zero
   status("Emote detected: teleporting in front of @"..target.Name)
   local loaded,played,value=pcall(function()return hum:PlayEmoteAndGetAnimTrackById(94929164198214)end)
   if not loaded or not played or not value then
    local animation=Instance.new("Animation")animation.AnimationId="rbxassetid://94929164198214"
    local fallback,track=pcall(function()return animator:LoadAnimation(animation)end)
    animation:Destroy()
    if not fallback or not track then status("Response emote failed to load; reset cancelled.")return end
    value=track
   end
   responseTrack=value
   responseTrack.Looped=false
   responseTrack.Priority=Enum.AnimationPriority.Action4
   local deadline=os.clock()+5
   responseTrack:Play(0.1)
   while responseTrack.Length<=0 and os.clock()<deadline and alive(char,hum)do task.wait(0.05)end
   if responseTrack.Length<=0 then warn("Emote response animation did not load within 5 seconds.")end
   if responseTrack.Length<=0 or not alive(char,hum)or target.Character~=targetChar or not targetRoot.Parent then return end
   responseTrack.TimePosition=0
   local started=os.clock()
   local duration=responseTrack.Length
   while alive(char,hum)and responseTrack.IsPlaying and os.clock()-started<duration+2 do task.wait(0.05)end
   if alive(char,hum)and os.clock()-started>=math.max(0,duration-0.15)then hum.Health=0 end
  end)
  if responseTrack then pcall(function()responseTrack:Stop(0)responseTrack:Destroy()end)end
  busy=false
  if not ok and U.d then warn("Emote response failed: "..tostring(err))end
 end)
end
local function scheduleHandBurst(p,track)
 local character=p.Character
 local elapsed=tonumber(track.TimePosition)or 0
 local speed=tonumber(track.Speed)or 1
 -- Account for tracks discovered by polling after playback begins.
 local delay=3.72-(speed>0 and elapsed/speed or 0)
 if delay<0 then return end
 task.delay(delay,function()
  if not U.d or not character or p.Character~=character or not character.Parent then return end
  local hand=character:FindFirstChild("LeftHand")or character:FindFirstChild("Left Arm")
  if not hand or not hand:IsA("BasePart")then return end
  local attachment=Instance.new("Attachment")
  attachment.Name="HuybypassLeftHandBurst"
  attachment.Position=Vector3.new(0,-hand.Size.Y*0.4,0)
  attachment.Parent=hand
  local particles=Instance.new("ParticleEmitter")
  particles.Name="DarkBlueBurst"
  particles.Texture="rbxasset://textures/particles/sparkles_main.dds"
  particles.Color=ColorSequence.new(Color3.fromRGB(12,28,100),Color3.fromRGB(3,8,38))
  particles.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(0.25,0.65),NumberSequenceKeypoint.new(1,0)})
  particles.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.1),NumberSequenceKeypoint.new(0.5,0.35),NumberSequenceKeypoint.new(1,1)})
  particles.Lifetime=NumberRange.new(0.3,0.55)
  particles.Speed=NumberRange.new(2,5)
  particles.SpreadAngle=Vector2.new(180,180)
  particles.Rotation=NumberRange.new(0,360)
  particles.RotSpeed=NumberRange.new(-90,90)
  particles.Drag=5
  particles.LightEmission=0.25
  particles.Rate=0
  particles.Parent=attachment
  game:GetService("Debris"):AddItem(attachment,1)
  particles:Emit(22)
 end)
end
local function scheduleEmoteSound(p,track)
 local character=p.Character
 local elapsed=tonumber(track.TimePosition)or 0
 local speed=tonumber(track.Speed)or 1
 local age=speed>0 and elapsed/speed or 0
 if age>=6.39 then return end
 task.delay(math.max(0,1.77-age),function()
  if not U.d or not character or p.Character~=character or not character.Parent then return end
  local root=character:FindFirstChild("HumanoidRootPart")or character:FindFirstChild("Head")
  if not root then return end
  local sound=Instance.new("Sound")
  sound.Name="HuybypassEmoteSound"
  sound.SoundId="rbxassetid://862198133"
  sound.Volume=1
  sound.Looped=false
  sound.RollOffMinDistance=5
  sound.RollOffMaxDistance=60
  sound.Parent=root
  sound.TimePosition=math.max(0,age-1.77)
  sound:Play()
  local remaining=4.62-math.max(0,age-1.77)
  game:GetService("Debris"):AddItem(sound,remaining+0.1)
  task.delay(remaining,function()
   if sound.Parent then sound:Stop()sound:Destroy()end
  end)
 end)
end
local function watch(p)
 if watched[p]then return end
 local connections={}watched[p]=connections
 local function attach(char)
  if connections.animation then connections.animation:Disconnect()connections.animation=nil end
  task.spawn(function()
   local hum,animator
   repeat
    hum=char:FindFirstChildOfClass("Humanoid")
    animator=hum and hum:FindFirstChildOfClass("Animator")
    if animator then break end
    task.wait(0.5)
   until not U.d or watched[p]~=connections or p.Character~=char
   if not U.d or watched[p]~=connections or p.Character~=char or not animator then return end
   local seen=setmetatable({},{__mode="k"})
   local triggered=setmetatable({},{__mode="k"})
   local function inspect(track,restarted)
    local id=identify(track)
    if restarted then triggered[track]=nil end
    if not seen[track]or restarted then
     seen[track]=true
     print("Emote monitor: @"..p.Name.." ["..p.UserId.."] animation="..tostring(id))
    end
    if isTarget(p)and saluteIds[id]and not triggered[track]then
     triggered[track]=true
     scheduleHandBurst(p,track)
     scheduleEmoteSound(p,track)
     respond(p,track)
    end
   end
   connections.animation=U.b(animator.AnimationPlayed,function(track)inspect(track,true)end)
   while U.d and watched[p]==connections and p.Character==char and animator.Parent do
    for _,track in ipairs(animator:GetPlayingAnimationTracks())do inspect(track,false)end
    for track in pairs(seen)do if not track.IsPlaying then seen[track]=nil triggered[track]=nil end end
    task.wait(0.25)
   end
  end)
 end
 connections.character=U.b(p.CharacterAdded,attach)
 if p.Character then attach(p.Character)end
end
U.b(players.PlayerAdded,watch)
U.b(players.PlayerRemoving,function(p)
 local connections=watched[p]
 if connections then
  for _,connection in pairs(connections)do connection:Disconnect()end
  watched[p]=nil
 end
end)
for _,p in ipairs(players:GetPlayers())do watch(p)end
end
 