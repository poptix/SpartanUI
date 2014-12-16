local addon = LibStub("AceAddon-3.0"):NewAddon("SpartanUI","AceConsole-3.0");
local AceConfig = LibStub("AceConfig-3.0");
local AceConfigDialog = LibStub("AceConfigDialog-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("SpartanUI", true)
addon.SpartanVer = GetAddOnMetadata("SpartanUI", "Version")
addon.CurseVersion = GetAddOnMetadata("SpartanUI", "X-Curse-Packaged-Version")
----------------------------------------------------------------------------------------------------
addon.opt = {
	name = "SpartanUI", type = "group", childGroups = "tab", args = {
		General = {name = "General", type = "group",order = 0, args = {}};
		Artwork = {name = "Artwork", type = "group", args = {}};
		PlayerFrames = {name = "Player Frames", type = "group", args = {}};
		PartyFrames = {name = "Party Frames", type = "group", args = {}};
		RaidFrames = {name = "Raid Frames", type = "group", args = {}};
		SpinCam = {name = "Spin Cam", type = "group",order = 900, args = {}};
		FilmEffects = {name = "Film Effects", type = "group", order = 950, args = {}};
	}
}


local FontItems = {Primary={},Core={},Party={},Player={},Raid={}}
local FontItemsSize = {Primary={},Core={},Party={},Player={},Raid={}}
local fontdefault = {Size = 0, Face = "SpartanUI", Type = "outline"}
local MovedDefault = {moved=false;point = "",relativeTo = nil,relativePoint = "",xOffset = 0,yOffset = 0}
local frameDefault1 = {movement=MovedDefault;AuraDisplay=true,display=true,Debuffs="all",buffs="all",style="large",Auras={NumBuffs=5,NumDebuffs = 10,size = 20,spacing = 1,showType=true,onlyShowPlayer=false}}
local frameDefault2 = {movement=MovedDefault;AuraDisplay=true,display=true,Debuffs="all",buffs="all",style="medium",Auras={NumBuffs=0,NumDebuffs = 10,size = 15,spacing = 1,showType=true,onlyShowPlayer=false}}

DBdefault = {
	SUIProper = {
		Version = addon.SpartanVer,
		HVer = "",
		yoffset = 0,
		xOffset = 0,
		yoffsetAuto = true,
		scale = .92,
		alpha = 1,
		viewport = true,
		Styles = {
			Classic = {
				Artwork = true,
				PlayerFrames = true,
				PartyFrames = true,
				RaidFrames = true
			}
		},
		ChatSettings = {
			enabled = true
		},
		BuffSettings = {
			disableblizz = true,
			enabled = true,
			Manualoffset = false,
			offset = 0
		},
		PopUP = {
			popup1enable = true,
			popup2enable = true,
			popup1alpha = 100,
			popup2alpha = 100,
			popup1anim = true,
			popup2anim = true
		},
		XPBar = {
			enabled = true,
			text = true,
			ToolTip = "click",
			GainedColor	= "Blue",
			GainedRed	= 0,
			GainedBlue	= 1,
			GainedGreen	= .5,
			GainedBrightness= .7,
			RestedColor	= "Light_Blue",
			RestedRed	= 0,
			RestedBlue	= 1,
			RestedGreen	= .5,
			RestedBrightness= .7,
			RestedMatchColor= false
		},
		RepBar = {
			enabled = true,
			text = false,
			ToolTip = "click",
			GainedColor	= "AUTO",
			GainedRed	= 0,
			GainedBlue	= 0,
			GainedGreen	= 1,
			GainedBrightness= .6,
			AutoDefined	= true
		},
		MiniMap = {
			ManualAllowUse = false,
			ManualAllowPrompt = "",
			AutoDetectAllowUse = true,
			MapButtons = true,
			MapZoomButtons = true
		},
		ActionBars = {
			Allalpha = 100,
			Allenable = true,
			popup1 = {anim = true, alpha = 100, enable = true},
			popup2 = {anim = true, alpha = 100, enable = true},
			bar1 = {alpha = 100, enable = true},
			bar2 = {alpha = 100, enable = true},
			bar3 = {alpha = 100, enable = true},
			bar4 = {alpha = 100, enable = true},
			bar5 = {alpha = 100, enable = true},
			bar6 = {alpha = 100, enable = true},
		},
		font = {
			Primary = fontdefault,
			Core = fontdefault,
			Player = fontdefault,
			Party = fontdefault,
			Raid = fontdefault,
		}
	},
	Modules = {
		Artwork = {
			Style = "Classic",
			FirstLoad = true,
			VehicleUI = true,
			Viewport = 
			{
				enabled = true,
				offset = 
				{
					top = 0,bottom = 2.3,left = 0,right = 0
				}
			}
		},
		SpinCam = {
			enable = true,
			speed = 8
		},
		FilmEffects = {
			enable = false,
			animationInterval = 0,
			anim = "",
			vignette = nil
		},
		PartyFrames  = {
			Portrait3D = true,
			threat = true,
			preset = "dps",
			FrameStyle = "large",
			showAuras = true,
			partyLock = true,
			showClass = true,
			partyMoved = false,
			castbar = true,
			castbartext = true,
			showPartyInRaid = false,
			showParty = true,
			showPlayer = true,
			showSolo = false,
			Portrait = true,
			scale=1,
			Auras = {
				NumBuffs = 0,
				NumDebuffs = 10,
				size = 16,
				spacing = 1,
				showType = true
			},
			Anchors = {
				point = "TOPLEFT",
				relativeTo = "UIParent",
				relativePoint = "TOPLEFT",
				xOfs = 10,
				yOfs = -20
			},
			bars = {health={textstyle="dynamic", textmode=1},mana={textstyle="dynamic", textmode=1}},
			display = {pet = true,target=true,mana=true},
		},
		PlayerFrames = {
			style = "theme",
			Portrait3D = true,
			showClass = true,
			focusMoved = false,
			global = frameDefault1,
			player = frameDefault1,
			target = frameDefault1,
			targettarget = frameDefault2,
			pet = frameDefault2,
			focus = frameDefault2,
			focustarget = frameDefault2,
			bars = {
				health = {textstyle = "dynamic",textmode=1},
				mana = {textstyle = "longfor",textmode=1},
				player = {color="dynamic"},
				target = {color="reaction"},
				targettarget = {color="dynamic",style="large"},
				pet = {color="happiness"},
				focus = {color="dynamic"},
				focustarget = {color="dynamic"},
			},
			Castbar = {player=1,target=1,targettarget=1,pet=1,focus=1,text={player=1,target=1,targettarget=1,pet=1,focus=1}},
			BossFrame = {movement=MovedDefault,display=true,scale=1},
			ArenaFrame = {movement=MovedDefault,display=false,scale=1},
			ClassBar = {movement=MovedDefault},
			TotemFrame = {movement=MovedDefault},
			AltManaBar = {movement=MovedDefault},
		},
		RaidFrames  = {
			HideBlizzFrames = true,
			threat = true,
			mode = "group",
			preset = "dps",
			FrameStyle = "small",
			showAuras = true,
			showClass = true,
			moved = false,
			showRaid = true,
			maxColumns = 4,
			unitsPerColumn = 10,
			columnSpacing = 5,
			scale=1,
			Anchors = {
				point = "TOPLEFT",
				relativeTo = "UIParent",
				relativePoint = "TOPLEFT",
				xOfs = 10,
				yOfs = -20
			},
			bars = {
				health = {textstyle="dynamic", textmode=1},
				mana = {textstyle="dynamic", textmode=1}
			},
			debuffs = {display=true},
			Auras={size=10,spacing=1,showType=true}
		}
	}
}
DBdefaults = {char = DBdefault,realm = DBdefault,class = DBdefault,profile = DBdefault}
DBGlobals = {Version = addon.SpartanVer}

function addon:comma_value(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1' .. _G.LARGE_NUMBER_SEPERATOR):reverse())..right
end

function addon:ResetConfig()
	addon.db:ResetProfile(false,true);
	ReloadUI();
end

function addon:FormatFont(element, size, Module)
	--Set Font Outline
	flags = ""
	if DB.font[Module].Type == "monochrome" then flags = flags.."monochrome " end
	
	-- Outline was deemed to thick, it is not a slight drop shadow done below
	--if DB.font[Module].Type == "outline" then flags = flags.."outline " end
	
	if DB.font[Module].Type == "thickoutline" then flags = flags.."thickoutline " end
	--Set Size
	sizeFinal = size + DB.font[Module].Size;
	--Create Font
	if DB.font[Module].Face == "SpartanUI" then
		element:SetFont("Interface\\AddOns\\SpartanUI\\media\\font-cognosis.ttf", sizeFinal, flags)
	elseif DB.font[Module].Face == "FrizQuadrata" then
		element:SetFont("Fonts\\FRIZQT__.TTF", sizeFinal, flags)
	elseif DB.font[Module].Face == "ArialNarrow" then
		element:SetFont("Fonts\\ARIALN.TTF", sizeFinal, flags)
	elseif DB.font[Module].Face == "Skurri" then
		element:SetFont("Fonts\\skurri.TTF", sizeFinal, flags)
	elseif DB.font[Module].Face == "Morpheus" then
		element:SetFont("Fonts\\MORPHEUS.TTF", sizeFinal, flags)
	end
	if DB.font[Module].Type == "outline" then
		element:SetShadowColor(0,0,0,.9)
		element:SetShadowOffset(1,-1)
	end
	--Add Item to the Array
	local count = 0
	for _ in pairs(FontItems[Module]) do count = count + 1 end
	FontItems[Module][count+1]=element
	FontItemsSize[Module][count+1]=size
end

function addon:FontRefresh(Module)
	for a,b in pairs(FontItems[Module]) do
		--Set Font Outline
		flags = ""
		if DB.font[Module].Type == "monochrome" then flags = flags.."monochrome " end
		if DB.font[Module].Type == "outline" then flags = flags.."outline " end
		if DB.font[Module].Type == "thickoutline" then flags = flags.."thickoutline " end
		--Set Size
		size = FontItemsSize[Module][a] + DB.font[Module].Size;
		--Update Font
		if DB.font[Module].Face == "SpartanUI" then
			b:SetFont("Interface\\AddOns\\SpartanUI\\media\\font-cognosis.ttf", size, flags)
		elseif DB.font[Module].Face == "FrizQuadrata" then
			b:SetFont("Fonts\\FRIZQT__.TTF", size, flags)
		elseif DB.font[Module].Face == "ArialNarrow" then
			b:SetFont("Fonts\\ARIALN.TTF", size, flags)
		elseif DB.font[Module].Face == "Skurri" then
			b:SetFont("Fonts\\skurri.TTF", size, flags)
		elseif DB.font[Module].Face == "Morpheus" then
			b:SetFont("Fonts\\MORPHEUS.TTF", size, flags)
		end
	end
end

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New("SpartanUIDB", DBdefaults);
	addon.db.profile.playerName = UnitName("player")
	DBGlobal = addon.db.global
	DB = addon.db.profile.SUIProper
	DBMod = addon.db.profile.Modules
	addon.opt.args["Profiles"] = LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db);
	-- Add dual-spec support
	local LibDualSpec = LibStub('LibDualSpec-1.0')
	LibDualSpec:EnhanceDatabase(self.db, "SpartanUI")
	LibDualSpec:EnhanceOptions(addon.opt.args["Profiles"], self.db)
	addon.opt.args["Profiles"].order=999
	-- Spec Setup
	addon.db.RegisterCallback(self, "OnNewProfile", "InitializeProfile")
	addon.db.RegisterCallback(self, "OnProfileChanged", "UpdateModuleConfigs")
	addon.db.RegisterCallback(self, "OnProfileCopied", "UpdateModuleConfigs")
	addon.db.RegisterCallback(self, "OnProfileReset", "UpdateModuleConfigs")
end

function addon:InitializeProfile()
	self.db:RegisterDefaults(DBdefaults)
end

function addon:UpdateModuleConfigs()
	self.db:RegisterDefaults(DBdefaults)
end

function addon:OnEnable()
	a={ name = "SpartanUI", type = "group",args={
		n1={type="description", fontSize="medium", order=1, width="full", name="Options have moved into their own window as this menu was getting a bit crowded."},
		n3={type="description", fontSize="medium", order=3, width="full", name="Options can be accessed by the button below or by typing /sui or /spartanui"},
		Close={name = "Launch Options",width="full",type = "execute",order = 50,
			func = function()
				InterfaceOptionsFrame:Hide();
				AceConfigDialog:SetDefaultSize("SpartanUI", 850, 600);
				AceConfigDialog:Open("SpartanUI");
			end	}
		}
	}
    AceConfig:RegisterOptionsTable("SpartanUIBliz", a)
	AceConfigDialog:AddToBlizOptions("SpartanUIBliz", "SpartanUI")
	
    AceConfig:RegisterOptionsTable("SpartanUI", addon.opt)
	if not addon:GetModule("Artwork_Core", true) then addon.opt.args["Artwork"].hidden = true end
	if not addon:GetModule("FilmEffect", true) then addon.opt.args["FilmEffects"].hidden = true end
    if not addon:GetModule("PartyFrames", true) then  addon.opt.args["PartyFrames"].hidden = true end
    if not addon:GetModule("PlayerFrames", true) then addon.opt.args["PlayerFrames"].hidden = true end
    if not addon:GetModule("RaidFrames", true) then addon.opt.args["RaidFrames"].hidden = true end
    if not addon:GetModule("SpinCam", true) then addon.opt.args["SpinCam"].hidden = true end
    
    self:RegisterChatCommand("sui", "ChatCommand")
    self:RegisterChatCommand("spartanui", "ChatCommand")
end

function addon:ChatCommand(input)
	if input == "version" then
		addon:Print("SpartanUI "..L["Version"].." "..GetAddOnMetadata("SpartanUI", "Version"))
		addon:Print("SpartanUI Curse "..L["Version"].." "..GetAddOnMetadata("SpartanUI", "X-Curse-Packaged-Version"))
	elseif input == "b" then
		InterfaceOptionsFrame_OpenToCategory("SpartanUI")
		InterfaceOptionsFrame_OpenToCategory("SpartanUI")
	else
		AceConfigDialog:SetDefaultSize("SpartanUI", 850, 600)
		AceConfigDialog:Open("SpartanUI")
    end
end