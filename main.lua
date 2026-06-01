local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
 
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ALLOWED_PLACE = 104715542330896 -- PlaceId de Block Spin

local ALLOWED_USERS = {
    [8249111649] = true, -- Tu UserId
	[8268942718] = true, -- Tu UserId
	[4127672041] = true, -- Tu UserId
    [10068306280] = true, -- UserId autorizado
	[11024258784] = true, -- UserId autorizado
	[10633233102] = true, -- UserId autorizado
	[5411922989] = true, -- UserId autorizado
	[11022729351] = true, -- UserId autorizado
	[11003008343] = true, -- UserId autorizado
	[8746570119] = true, -- UserId autorizado
	[1780352633725] = true, -- UserId autorizado
}

if game.PlaceId ~= ALLOWED_PLACE then
    return warn("Este script solo funciona en Block Spin.")
end

if not ALLOWED_USERS[LocalPlayer.UserId] then
    return warn("No estás autorizado a usar este script.")
end
 
-- FPS FIX
local UPDATE_DELAY = 0.017
 
-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false
 
local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(0,370,0,370)
Menu.Position = UDim2.new(0.7,0,0.2,0)
Menu.BackgroundColor3 = Color3.fromRGB(15,15,15)
Menu.Active = true
Menu.Draggable = true
Menu.Parent = ScreenGui

local MenuCorner = Instance.new("UICorner")
Menu.ClipsDescendants = false
MenuCorner.CornerRadius = UDim.new(0,12)
MenuCorner.Parent = Menu

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(0,255,255)
MenuStroke.Thickness = 3
MenuStroke.Parent = Menu

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0,255,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,120,255))
}
Gradient.Rotation = 45
Gradient.Parent = MenuStroke
 
-- TABS
local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1,-6,0,30)
Tabs.Position = UDim2.new(0,3,0,3)
Tabs.BackgroundColor3 = Color3.fromRGB(20,20,20)
Tabs.ClipsDescendants = true
Tabs.Parent = Menu

local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0,12)
TabsCorner.Parent = Tabs


 
local VisualTab = Instance.new("TextButton")
VisualTab.Size = UDim2.new(0.4,0,1,0)
VisualTab.Text = "VISUAL"
VisualTab.BackgroundColor3 = Color3.fromRGB(40,40,40)
VisualTab.TextColor3 = Color3.new(1,1,1)
VisualTab.Parent = Tabs

local VisualCorner = Instance.new("UICorner")
VisualCorner.CornerRadius = UDim.new(0,8)
VisualCorner.Parent = VisualTab

local VisualStroke = Instance.new("UIStroke")
VisualStroke.Color = Color3.fromRGB(0,255,255)
VisualStroke.Thickness = 1
VisualStroke.Parent = VisualTab
 
local AimTab = Instance.new("TextButton")
AimTab.Size = UDim2.new(0.4,0,1,0)
AimTab.Position = UDim2.new(0.45,0,0,0)
AimTab.Text = "AIMBOT"
AimTab.BackgroundColor3 = Color3.fromRGB(30,30,30)
AimTab.TextColor3 = Color3.new(1,1,1)
AimTab.Parent = Tabs

local AimCorner = Instance.new("UICorner")
AimCorner.CornerRadius = UDim.new(0,8)
AimCorner.Parent = AimTab

local AimStroke = Instance.new("UIStroke")
AimStroke.Color = Color3.fromRGB(0,255,255)
AimStroke.Thickness = 1
AimStroke.Parent = AimTab
 
-- CLOSE
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,25,0,25)
Close.Position = UDim2.new(0.975,-28,0,2)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Close.Parent = Menu
 
-- FRAMES
local VisualFrame = Instance.new("Frame")
VisualFrame.Size = UDim2.new(1,0,1,-30)
VisualFrame.Position = UDim2.new(0,0,0,30)
VisualFrame.BackgroundTransparency = 1
VisualFrame.Parent = Menu
 
local AimFrame = Instance.new("Frame")
AimFrame.Size = UDim2.new(1,0,1,-30)
AimFrame.Position = UDim2.new(0,0,0,30)
AimFrame.BackgroundTransparency = 1
AimFrame.Visible = false
AimFrame.Parent = Menu
 
-- FLOAT
local Float = Instance.new("TextButton")
Float.Size = UDim2.new(0,40,0,40)
Float.Position = UDim2.new(0,10,0.5,-20)
Float.Text = "GUI"
Float.Visible = false
Float.Active = true
Float.Draggable = true
Float.Parent = ScreenGui
 
Instance.new("UICorner",Float).CornerRadius = UDim.new(0,7)
 
local FloatStroke = Instance.new("UIStroke")
FloatStroke.Thickness = 5
FloatStroke.Color = Color3.fromRGB(255,0,0)
FloatStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FloatStroke.Parent = Float

local FloatGradient = Instance.new("UIGradient")
FloatGradient.Rotation = 45
FloatGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(120,0,0))
}
FloatGradient.Parent = FloatStroke

Close.MouseButton1Click:Connect(function()
Menu.Visible = false
Float.Visible = true
end)
 
Float.MouseButton1Click:Connect(function()
Menu.Visible = true
Float.Visible = false
end)
 
-- TAB SWITCH
VisualTab.MouseButton1Click:Connect(function()

	VisualFrame.Visible = true
	AimFrame.Visible = false

	VisualTab.BackgroundColor3 = Color3.fromRGB(0,40,40)
	AimTab.BackgroundColor3 = Color3.fromRGB(15,15,15)

	VisualStroke.Color = Color3.fromRGB(0,255,255)
	AimStroke.Color = Color3.fromRGB(255,0,0)

end)

AimTab.MouseButton1Click:Connect(function()

	VisualFrame.Visible = false
	AimFrame.Visible = true

	AimTab.BackgroundColor3 = Color3.fromRGB(0,40,40)
	VisualTab.BackgroundColor3 = Color3.fromRGB(15,15,15)

	AimStroke.Color = Color3.fromRGB(0,255,255)
	VisualStroke.Color = Color3.fromRGB(255,0,0)

end)
 
-- TOGGLES
local PlayerESP = true
local NameESP = true
local DistanceESP = true
local HealthESP = true
local WeaponESP = true
local Tracers = true
local HideNameEnabled = true

local ExcludedPlayers = {}
local AimKey = Enum.KeyCode.F
 
local function toggle(text,pos,callback)
 
local b = Instance.new("TextButton")
b.Size = UDim2.new(0,300,0,32)
b.Position = UDim2.new(0,30,0,pos)
b.BackgroundColor3 = Color3.fromRGB(20,20,20)
b.TextColor3 = Color3.fromRGB(0,170,0)
b.Text = text.." : ON"
b.Parent = VisualFrame

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,8)
c.Parent = b

local s = Instance.new("UIStroke")
s.Color = Color3.fromRGB(0,170,0)
s.Thickness = 0.50
s.Parent = b
 
local state = true
 
b.MouseButton1Click:Connect(function()
state = not state
b.Text = text.." : "..(state and "ON" or "OFF")

if state then
	b.TextColor3 = Color3.fromRGB(0,170,0)

	if s then
		s.Color = Color3.fromRGB(0,170,0)
	end

else
	b.TextColor3 = Color3.fromRGB(255,0,0)

	if s then
		s.Color = Color3.fromRGB(255,0,0)
	end

end

callback(state)
end)

return b
 
end
 
toggle("Player ESP",30,function(v)
PlayerESP = v
end)
 
toggle("Show Name",75,function(v)
NameESP = v
end)
 
toggle("Show Distance",120,function(v)
DistanceESP = v
end)
 
toggle("Show Health",165,function(v)
HealthESP = v
end)
 
toggle("Show Weapons",210,function(v)
WeaponESP = v
end)

toggle("Show Tracers",255,function(v)

	Tracers = v

	if not v then
		TracerLine.Visible = false
	end

end)

local HideBtn = toggle("Hide Name",300,function(v)

	HideNameEnabled = v

	if not v then

		local character = LocalPlayer.Character

		if character then

			local humanoid =
				character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.DisplayDistanceType =
					Enum.HumanoidDisplayDistanceType.Viewer
			end

			for _,obj in pairs(character:GetDescendants()) do
				if obj:IsA("BillboardGui") then
					obj.Enabled = true
				end
			end
		end
	end

end)

HideBtn.Text = "Hide Name : ON"
 
-- FUNCTIONS
local function healthColor(percent)
local r = 255*(1-percent)
local g = 255*percent
return Color3.fromRGB(r,g,0)
end
 
local RarityColors = {
	Common = Color3.fromRGB(255,255,255),
	Uncommon = Color3.fromRGB(0,255,0),
	Rare = Color3.fromRGB(0,170,255),
	Epic = Color3.fromRGB(170,0,255),
	Legendary = Color3.fromRGB(255,170,0),
	Mythic = Color3.fromRGB(255,0,0)
}

local Items = game:GetService("ReplicatedStorage"):WaitForChild("Items")

local WeaponRegistry = {}

local function registerItems(folder)

	for _,tool in ipairs(folder:GetChildren()) do

		if tool:IsA("Tool") then

			local handle =
				tool:FindFirstChild("Handle")

			local displayName =
				tool:GetAttribute("DisplayName")
				or tool.Name

			local itemId =
				tool:GetAttribute("ItemId")
				or tool:GetAttribute("Id")
				or tool.Name

			local rarity =
				tool:GetAttribute("RarityName")
				or "Common"

			local key

			if handle then

				local mesh =
					handle:FindFirstChildOfClass("SpecialMesh")

				if mesh and mesh.MeshId ~= "" then

					key =
						mesh.MeshId
						.. (mesh.TextureId or "")
						.. "_RARITY_" .. rarity

				elseif handle:IsA("MeshPart")
				and handle.MeshId ~= "" then

					key =
						handle.MeshId
						.. (handle.TextureID or "")
						.. "_RARITY_" .. rarity
				end
			end

			if not key
			and itemId
			and itemId ~= ""
			and itemId ~= tool.Name then

				key =
					"ITEMID_" .. itemId
					.. "_RARITY_" .. rarity
			end

			if not key then

				key =
					"NAME_" .. displayName
					.. "_" .. tool.Name
					.. "_RARITY_" .. rarity
			end

			WeaponRegistry[key] = {
				Name = displayName,
				Rarity = rarity,
				ToolName = tool.Name
			}
		end
	end
end

local function scanFolders(folder)

	registerItems(folder)

	folder.ChildAdded:Connect(function(child)

		task.wait(0.1)

		if child:IsA("Folder") then
			scanFolders(child)
		else
			registerItems(folder)
		end
	end)

	for _,child in ipairs(folder:GetChildren()) do
		if child:IsA("Folder") then
			scanFolders(child)
		end
	end
end

scanFolders(Items)

local function getItemKey(tool)

	local handle =
		tool:FindFirstChild("Handle")

	local displayName =
		tool:GetAttribute("DisplayName")
		or tool.Name

	local itemId =
		tool:GetAttribute("ItemId")
		or tool:GetAttribute("Id")
		or tool.Name

	local rarity =
		tool:GetAttribute("RarityName")
		or "Common"

	if handle then

		local mesh =
			handle:FindFirstChildOfClass("SpecialMesh")

		if mesh and mesh.MeshId ~= "" then

			return
				mesh.MeshId
				.. (mesh.TextureId or "")
				.. "_RARITY_" .. rarity
		end

		if handle:IsA("MeshPart")
		and handle.MeshId ~= "" then

			return
				handle.MeshId
				.. (handle.TextureID or "")
				.. "_RARITY_" .. rarity
		end
	end

	if itemId
	and itemId ~= ""
	and itemId ~= tool.Name then

		return
			"ITEMID_" .. itemId
			.. "_RARITY_" .. rarity
	end

	return
		"NAME_" .. displayName
		.. "_" .. tool.Name
		.. "_RARITY_" .. rarity
end

local function getWeaponInfo(tool)

	if not tool
	or not tool:IsA("Tool") then
		return nil
	end

	return WeaponRegistry[getItemKey(tool)]
end

local function getWeapons(player)

	local items = {}

	local function scan(container)

		if not container then return end

		for _,tool in ipairs(container:GetChildren()) do

			if tool:IsA("Tool")
			and tool.Name ~= "Fists" then

				local info = getWeaponInfo(tool)

				if info then

    table.insert(items,{
        Name = info.Name,
        Rarity = info.Rarity
    })

end
			end
		end
	end

	scan(player:FindFirstChild("Backpack"))
	scan(player.Character)

	return items
end
 
local LockedTarget = nil
local CurrentTarget = nil

local function hideMyName()

	if not HideNameEnabled then
		return
	end

	local character = LocalPlayer.Character

	if not character then
		return
	end

	local humanoid =
		character:FindFirstChildOfClass("Humanoid")

	if humanoid then

		humanoid.DisplayDistanceType =
			Enum.HumanoidDisplayDistanceType.None
	end

	for _,v in pairs(character:GetDescendants()) do

		if v:IsA("BillboardGui") then
			v.Enabled = false
		end
	end
end

RunService.Heartbeat:Connect(hideMyName)

task.wait(1)

if HideNameEnabled then
	hideMyName()
end

-- ESP
local function createESP(player)
 
if player == LocalPlayer then return end
 
local highlight = Instance.new("Highlight")
highlight.FillTransparency = 1
highlight.OutlineTransparency = 0
highlight.OutlineColor = Color3.fromRGB(255,255,0)
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.Parent = CoreGui
 
local name = Drawing.new("Text")
name.Size = 13.75
name.Font = 0
name.Outline = true
name.Color = Color3.new(1,1,1)
 
local distance = Drawing.new("Text")
distance.Size = 12
distance.Outline = true
distance.Color = Color3.fromRGB(180,180,180)
 
local hp = Drawing.new("Text")
hp.Size = 12.75
hp.Outline = true
 
local weaponDrawings = {}
 
local last = 0
 
RunService.RenderStepped:Connect(function()
 
if tick() - last < UPDATE_DELAY then return end    
last = tick()    
 
local char = player.Character    
 
if not char then    
	highlight.Adornee = nil    
 
	name.Visible = false    
	distance.Visible = false    
	hp.Visible = false    
	for _,draw in pairs(weaponDrawings) do
	draw.Visible = false
end
	return    
end    
 
local head = char:FindFirstChild("Head")    
local root = char:FindFirstChild("HumanoidRootPart")    
local humanoid = char:FindFirstChildOfClass("Humanoid")    
 
if not head or not root or not humanoid then    
	highlight.Adornee = nil    
 
	name.Visible = false    
	distance.Visible = false    
	hp.Visible = false    
	for _,draw in pairs(weaponDrawings) do
	draw.Visible = false
end   
	return    
end

local safe = false
 
local safezones = {
 
Vector3.new(-205.64361572265625,255.30845642089844,-223.425048828125),    
Vector3.new(-122.12987518310547,255.0996856689453,472.05712890625),    
Vector3.new(120.51111602783203,255.4841766357422,486.6929931640625),    
Vector3.new(1049.52880859375,255.09971618652344,-592.4171752929688),    
Vector3.new(1183.316650390625,255.2461700439453,-566.3818969726562),    
Vector3.new(247.08935546875,255.3159637451172,-270.0076904296875)
 
}
 
for _,zone in pairs(safezones) do
 
	local dist = (root.Position - zone).Magnitude    
 
	if dist <= 35 then    
		safe = true    
		break    
	end
 
end

local dead = humanoid.Health <= 0
or humanoid:GetState() == Enum.HumanoidStateType.Dead

if PlayerESP and humanoid.Health > 0 then

	highlight.Adornee = char

	local isTarget = false

if CurrentTarget and CurrentTarget == player then
	isTarget = true
end

	-- RESET COLOR
	name.Color = Color3.new(1,1,1)

	-- TARGET
if isTarget then

	highlight.FillColor = Color3.fromRGB(255,0,0)
	highlight.FillTransparency = 0.35

	highlight.OutlineColor = Color3.fromRGB(255,0,0)
	name.Color = Color3.fromRGB(255,0,0)

-- FRIEND
elseif ExcludedPlayers[player.Name] then

	highlight.FillTransparency = 1
	highlight.OutlineColor = Color3.fromRGB(0,255,0)
	name.Color = Color3.fromRGB(0,255,0)

-- SAFEZONE
elseif safe then

	highlight.FillTransparency = 1
	highlight.OutlineColor = Color3.fromRGB(0,255,0)

-- DEAD
elseif dead then

	highlight.FillTransparency = 1
	highlight.OutlineColor = Color3.fromRGB(120,120,120)

-- NORMAL
else

	highlight.FillTransparency = 1
	highlight.OutlineColor = Color3.fromRGB(255,255,0)

end

else

	highlight.Adornee = nil

	name.Visible = false
	distance.Visible = false
	hp.Visible = false
	for _,draw in pairs(weaponDrawings) do
	draw.Visible = false
end
	return

end

local headPos,headVis = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
local rootPos,rootVis = Camera:WorldToViewportPoint(root.Position - Vector3.new(0,2.3,0))
 
if not headVis or not rootVis or headPos.Z < 0 or rootPos.Z < 0 then    
	name.Visible = false    
	distance.Visible = false    
	hp.Visible = false    
	for _,draw in pairs(weaponDrawings) do
	draw.Visible = false
end    
	return    
end    
 
local height = math.abs(headPos.Y-rootPos.Y)
local width = height/2    
 
local x = rootPos.X-width/2    
local y = headPos.Y    
 
local distanceFromPlayer = 0    
 
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then    
	distanceFromPlayer = (LocalPlayer.Character.HumanoidRootPart.Position-root.Position).Magnitude    
end    
 
local anchorX = x + width + 6    
local anchorY    
 
if distanceFromPlayer > 25 then    
	anchorY = y - 24.5    
else    
	anchorY = y - 12    
end    
 
-- NAME    
if NameESP then    
 
	name.Text = player.Name    
	name.Position = Vector2.new(anchorX,anchorY)    
 
 
	name.Visible = true    
 
else    
	name.Visible = false    
end    
 
-- DISTANCE    
if DistanceESP and LocalPlayer.Character then    
 
	local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")    
 
	if myRoot then    
 
		local dist = math.floor((myRoot.Position-root.Position).Magnitude)    
 
		distance.Text = dist.."m"    
		distance.Position = Vector2.new(anchorX,anchorY+12)    
		distance.Visible = true    
	end    
 
else    
	distance.Visible = false    
end    
 
-- HP    
if HealthESP then    
 
	local percent = humanoid.Health/humanoid.MaxHealth    
 
	local fixedHealth = math.max(0, humanoid.Health)    
 
    hp.Text = math.floor(fixedHealth).."/"..math.floor(humanoid.MaxHealth)    
	hp.Color = healthColor(percent)    
	hp.Position = Vector2.new(anchorX,anchorY+24)    
	hp.Visible = true    
 
else    
	hp.Visible = false    
end    
 
-- WEAPONS
if WeaponESP then

	local items = getWeapons(player)

	for _,draw in pairs(weaponDrawings) do
		draw.Visible = false
	end

	for i,w in ipairs(items) do

		if not weaponDrawings[i] then

			local txt = Drawing.new("Text")
			txt.Size = 11
			txt.Center = true
			txt.Outline = true
			txt.Font = 2

			weaponDrawings[i] = txt
		end

		local draw = weaponDrawings[i]

		draw.Text =
			"["..w.Rarity.."] "..w.Name

		draw.Color =
			RarityColors[w.Rarity]
			or Color3.new(1,1,1)

		draw.Position = Vector2.new(
			x + width/2,
			y + height + 6 + ((i-1)*12)
		)

		draw.Visible = true
	end

else

	for _,draw in pairs(weaponDrawings) do
		draw.Visible = false
	end

end
 
end)
 
end
 
for _,p in ipairs(Players:GetPlayers()) do
createESP(p)
end
 
Players.PlayerAdded:Connect(function(p)
task.wait(1)
createESP(p)
end)
 
local function styleAimButton(btn, isToggle)

	btn.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,8)
	c.Parent = btn

	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(255,170,0)
	s.Thickness = 0.5
	s.Parent = btn

	if isToggle then

	if btn.Text:find("ON") then
		btn.TextColor3 = Color3.fromRGB(0,170,0)
		s.Color = Color3.fromRGB(0,170,0)
	else
		btn.TextColor3 = Color3.fromRGB(255,0,0)
		s.Color = Color3.fromRGB(255,0,0)
	end

		btn.MouseButton1Click:Connect(function()

			if btn.Text:find("ON") then
				btn.TextColor3 = Color3.fromRGB(0,170,0)
				s.Color = Color3.fromRGB(0,170,0)
			else
				btn.TextColor3 = Color3.fromRGB(255,0,0)
				s.Color = Color3.fromRGB(255,0,0)
			end

		end)

	else

		btn.TextColor3 = Color3.fromRGB(255,170,0)

	end

end

-- AIM SETTINGS
local AimEnabled = false
local WallCheck = true
local ShowFOV = true
local FOVRadius = 200
local Smoothness = 1
local TargetPart = "Head"

local AimParts = {
	"Head",
	"UpperTorso"
}

local AimIndex = 1

-- FOV
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = true
FOVCircle.Radius = FOVRadius
FOVCircle.Color = Color3.fromRGB(255,255,0)
FOVCircle.Thickness = 1
FOVCircle.Filled = false

-- TRACER
local TracerLine = Drawing.new("Line")
TracerLine.Visible = false
 
-- FRIEND LIST UI
local FriendToggle = Instance.new("TextButton")
FriendToggle.Size = UDim2.new(0,300,0,32)
FriendToggle.Position = UDim2.new(0,30,0,270)
FriendToggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
FriendToggle.TextColor3 = Color3.new(1,1,1)
FriendToggle.Text = "Friend List"
FriendToggle.Parent = AimFrame
styleAimButton(FriendToggle,false)
local FriendFrame = Instance.new("ScrollingFrame")
FriendFrame.ClipsDescendants = true
FriendFrame.ScrollBarThickness = 4
FriendFrame.ScrollBarImageColor3 = Color3.fromRGB(120,120,120)
FriendFrame.Size = UDim2.new(0,300,0,108)
FriendFrame.Position = UDim2.new(0,30,0,310)
FriendFrame.CanvasSize = UDim2.new(0,0,0,0)
FriendFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
FriendFrame.BorderSizePixel = 0
FriendFrame.Parent = AimFrame
FriendFrame.Visible = false

local FriendCorner = Instance.new("UICorner")
FriendCorner.CornerRadius = UDim.new(0,1.08)
FriendCorner.Parent = FriendFrame
 
 local ffcorner = Instance.new("UICorner")
ffcorner.CornerRadius = UDim.new(0,8)
ffcorner.Parent = FriendFrame

local ffstroke = Instance.new("UIStroke")
ffstroke.Color = Color3.fromRGB(255,170,0)
ffstroke.Thickness = 0.5
ffstroke.Parent = FriendFrame
 
FriendToggle.MouseButton1Click:Connect(function()
 
FriendFrame.Visible = not FriendFrame.Visible
 
end)
 
local layout = Instance.new("UIListLayout")
layout.Parent = FriendFrame
 
local function RefreshFriends()
 
for _,v in pairs(FriendFrame:GetChildren()) do
if v:IsA("TextButton") then
v:Destroy()
end
end
 
local sortedPlayers = Players:GetPlayers()
 
table.sort(sortedPlayers,function(a,b)
return a.Name:lower() < b.Name:lower()
end)
 
for _,plr in pairs(sortedPlayers) do
 
if plr ~= LocalPlayer then
 
local btn = Instance.new("TextButton")    
	btn.Size = UDim2.new(1,0,0,22)    
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)    
	btn.TextColor3 = Color3.new(1,1,1)    
	btn.Text = plr.Name    
	btn.Parent = FriendFrame

	local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(6,6)
    bc.Parent = btn

	if ExcludedPlayers[plr.Name] then

	btn.TextColor3 = Color3.fromRGB(0,255,0)
	btn.BackgroundColor3 = Color3.fromRGB(0,60,0)

else

	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)

end
 
	btn.MouseButton1Click:Connect(function()    
 
		ExcludedPlayers[plr.Name] = not ExcludedPlayers[plr.Name]    
 
		if ExcludedPlayers[plr.Name] then    

	btn.TextColor3 = Color3.fromRGB(0,255,0)
	btn.BackgroundColor3 = Color3.fromRGB(0,60,0)

else    

	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)

end
 
	end)    
end
 
end
 
task.wait()
 
FriendFrame.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
 
end
 
RefreshFriends()
 
Players.PlayerAdded:Connect(RefreshFriends)
Players.PlayerRemoving:Connect(RefreshFriends)
 
-- GET TARGET
local function GetClosestPlayer()
 
local Closest = nil
local ClosestDistance = FOVRadius
 
for _,plr in pairs(Players:GetPlayers()) do
 
local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")

if plr ~= LocalPlayer
and not ExcludedPlayers[plr.Name]
and plr.Character
and plr.Character:FindFirstChild(TargetPart)
and humanoid
and humanoid.Health > 0
and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
	local part = plr.Character[TargetPart]    
 
	local pos,visible = Camera:WorldToViewportPoint(part.Position)    
 
	if visible then    
 
		local center = Vector2.new(
	Camera.ViewportSize.X / 2,
	Camera.ViewportSize.Y / 2
)

local dist = (Vector2.new(pos.X,pos.Y) - center).Magnitude
 
if dist < ClosestDistance then
 
if WallCheck then    
 
				local rayParams = RaycastParams.new()    
				rayParams.FilterType = Enum.RaycastFilterType.Blacklist    
				rayParams.FilterDescendantsInstances = {    
					LocalPlayer.Character    
				}    
 
				local ray = workspace:Raycast(    
					Camera.CFrame.Position,    
					(part.Position - Camera.CFrame.Position).Unit * 500,    
					rayParams    
				)    
 
				if ray and not ray.Instance:IsDescendantOf(plr.Character) then    
					continue    
				end    
			end    
 
			ClosestDistance = dist    
			Closest = plr    
		end    
	end    
end
 
end

LockedTarget = Closest 
return Closest
 
end
 
-- AIMBOT
RunService.RenderStepped:Connect(function()
 
FOVCircle.Visible = ShowFOV
FOVCircle.Radius = FOVRadius
FOVCircle.Position = Vector2.new(
Camera.ViewportSize.X / 2,
Camera.ViewportSize.Y / 2
 
)
 
local target = GetClosestPlayer()

LockedTarget = target
CurrentTarget = target

-- TRACER
if Tracers
and target
and target.Character
and target.Character:FindFirstChild(TargetPart) then

	local tracerPart = target.Character[TargetPart]

	local pos, visible =
		Camera:WorldToViewportPoint(tracerPart.Position)

	if visible and pos.Z > 0 then

		TracerLine.Visible = true
		TracerLine.Thickness = 1
        TracerLine.Transparency = 1
        TracerLine.Color = Color3.fromRGB(255,0,0)

		TracerLine.From = Vector2.new(
			Camera.ViewportSize.X / 2,
			Camera.ViewportSize.Y / 2
		)

		TracerLine.To = Vector2.new(
			pos.X,
			pos.Y
		)

	else
	TracerLine.Visible = false
	TracerLine.From = Vector2.new(0,0)
	TracerLine.To = Vector2.new(0,0)
end

else
	TracerLine.Visible = false
end
 
if AimEnabled
and target
and target.Character
and target.Character:FindFirstChild(TargetPart) then

	local aimPart = target.Character[TargetPart]

	local aimPosition = aimPart.Position

	-- Ajuste cuando vas en vehículo
	if LocalPlayer.Character
	and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	and LocalPlayer.Character.Humanoid.SeatPart then

		aimPosition = aimPosition - Vector3.new(-0.15, 0.05, 0)

	end

	local camPos = Camera.CFrame.Position
local targetPos = aimPosition

if LocalPlayer.Character
and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
and LocalPlayer.Character.Humanoid.SeatPart then

	local velocity =
		LocalPlayer.Character.HumanoidRootPart.Velocity / 12

	targetPos = targetPos + velocity
end

Camera.CFrame = CFrame.lookAt(
	camPos,
	targetPos
)

end

end)
 
AimFrame.Parent = Menu
 
-- AIM TOGGLE
local AimToggle = Instance.new("TextButton")
AimToggle.Size = UDim2.new(0,300,0,32)
AimToggle.Position = UDim2.new(0,30,0,20)
AimToggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
AimToggle.TextColor3 = Color3.new(1,1,1)
AimToggle.Text = "Aim : OFF"
AimToggle.Parent = AimFrame
styleAimButton(AimToggle,true)
 
AimToggle.MouseButton1Click:Connect(function()

	AimEnabled = not AimEnabled

	AimToggle.Text = "Aim : "..(AimEnabled and "ON" or "OFF")

	if AimEnabled then
		FloatStroke.Color = Color3.fromRGB(0,255,0)
	else
		FloatStroke.Color = Color3.fromRGB(255,0,0)
	end

end)
 
-- WALLCHECK
local WallBtn = Instance.new("TextButton")
WallBtn.Size = UDim2.new(0,300,0,32)
WallBtn.Position = UDim2.new(0,30,0,55)
WallBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
WallBtn.TextColor3 = Color3.new(1,1,1)
WallBtn.Text = "WallCheck : ON"
WallBtn.Parent = AimFrame
styleAimButton(WallBtn,true)
 
WallBtn.MouseButton1Click:Connect(function()
 
WallCheck = not WallCheck
 
WallBtn.Text = "WallCheck : "..(WallCheck and "ON" or "OFF")
 
end)
 
-- FOV CIRCLE
local FOVBtn = Instance.new("TextButton")
FOVBtn.Size = UDim2.new(0,300,0,32)
FOVBtn.Position = UDim2.new(0,30,0,90)
FOVBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
FOVBtn.TextColor3 = Color3.new(1,1,1)
FOVBtn.Text = "FOV Circle : ON"
FOVBtn.Parent = AimFrame
styleAimButton(FOVBtn,true)
 
FOVBtn.MouseButton1Click:Connect(function()
 
ShowFOV = not ShowFOV
 
FOVBtn.Text = "FOV Circle : "..(ShowFOV and "ON" or "OFF")
 
end)
 
-- FOV RADIUS
local RadiusBox = Instance.new("TextBox")
RadiusBox.Size = UDim2.new(0,300,0,32)
RadiusBox.Position = UDim2.new(0,30,0,125)
RadiusBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
RadiusBox.TextColor3 = Color3.new(1,1,1)
RadiusBox.PlaceholderText = "FOV Radius"
RadiusBox.Text = tostring(FOVRadius)
RadiusBox.Parent = AimFrame
styleAimButton(RadiusBox,false)
 
RadiusBox.FocusLost:Connect(function()
 
local num = tonumber(RadiusBox.Text)
 
if num then
FOVRadius = num
end
 
end)
 
-- SMOOTH
local SmoothBox = Instance.new("TextBox")
SmoothBox.Size = UDim2.new(0,300,0,32)
SmoothBox.Position = UDim2.new(0,30,0,160)
SmoothBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
SmoothBox.TextColor3 = Color3.new(1,1,1)
SmoothBox.PlaceholderText = "Smooth"
SmoothBox.Text = tostring(Smoothness)
SmoothBox.Parent = AimFrame
styleAimButton(SmoothBox,false)
 
SmoothBox.FocusLost:Connect(function()
 
local num = tonumber(SmoothBox.Text)
 
if num then
Smoothness = num
end
 
end)
 
-- KEYBIND
local BindButton = Instance.new("TextButton")
BindButton.Size = UDim2.new(0,300,0,32)
BindButton.Position = UDim2.new(0,30,0,195)
BindButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
BindButton.TextColor3 = Color3.new(1,1,1)
BindButton.Text = "Bind : F"
BindButton.Parent = AimFrame
styleAimButton(BindButton,false)
 
local WaitingBind = false
 
BindButton.MouseButton1Click:Connect(function()
 
WaitingBind = true
BindButton.Text = "Press any key..."
 
end)
 
UserInputService.InputBegan:Connect(function(input, gpe)

	if gpe then return end

	-- CAMBIAR BIND
	if WaitingBind then

		WaitingBind = false

		-- Detectar teclas normales
		if input.UserInputType == Enum.UserInputType.Keyboard then

			AimKey = input.KeyCode

			BindButton.Text =
				"Bind : "..tostring(input.KeyCode)
				:gsub("Enum.KeyCode.","")

		else

			-- Detectar mouse y botones laterales
			if tostring(input.KeyCode) ~= "Enum.KeyCode.Unknown" then
				AimKey = input.KeyCode

				BindButton.Text =
					"Bind : "..tostring(input.KeyCode)
					:gsub("Enum.KeyCode.","")

			else
				AimKey = input.UserInputType

				BindButton.Text =
					"Bind : "..tostring(input.UserInputType)
					:gsub("Enum.UserInputType.","")
			end
		end

		return
	end

	-- ACTIVAR AIM
	if input.KeyCode == AimKey
	or input.UserInputType == AimKey then

		AimEnabled = not AimEnabled

		AimToggle.Text = "Aim : "..(AimEnabled and "ON" or "OFF")

		local stroke = AimToggle:FindFirstChildOfClass("UIStroke")

		if AimEnabled then

			FloatStroke.Color = Color3.fromRGB(0,255,0)

			FloatGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0,255,0)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0,120,0))
			}

			AimToggle.TextColor3 = Color3.fromRGB(0,170,0)

			if stroke then
				stroke.Color = Color3.fromRGB(0,170,0)
			end

		else

			FloatStroke.Color = Color3.fromRGB(255,0,0)

			FloatGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120,0,0))
			}

			AimToggle.TextColor3 = Color3.fromRGB(255,0,0)

			if stroke then
				stroke.Color = Color3.fromRGB(255,0,0)
			end
		end
	end
end)

-- AIM PART
local AimPartToggle = Instance.new("TextButton")
AimPartToggle.Size = UDim2.new(0,300,0,32)
AimPartToggle.Position = UDim2.new(0,30,0,230)
AimPartToggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
AimPartToggle.TextColor3 = Color3.new(1,1,1)
AimPartToggle.Text = "Aim Part : HEAD"
AimPartToggle.Parent = AimFrame
styleAimButton(AimPartToggle,false)

AimPartToggle.MouseButton1Click:Connect(function()

	AimIndex = AimIndex + 1

	if AimIndex > #AimParts then
		AimIndex = 1
	end

	TargetPart = AimParts[AimIndex]

	if TargetPart == "UpperTorso" then
		AimPartToggle.Text = "Aim Part : CHEST"
	else
		AimPartToggle.Text = "Aim Part : HEAD"
	end
end)
