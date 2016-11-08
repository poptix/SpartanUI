local spartan = LibStub("AceAddon-3.0"):GetAddon("SpartanUI");
local L = LibStub("AceLocale-3.0"):GetLocale("SpartanUI", true);
local addon = spartan:NewModule("SpinCam");
local SpinCamRunning = false
local userCameraYawMoveSpeed

function addon:OnInitialize()
	spartan.opt.args["ModSetting"].args["SpinCam"] = {
		name = L["SpinCam"],
		type = "group",
		args = {
			enable = {name=L["Spin/AFKOn"],type="toggle",order=1,width="full",
				get = function(info) return DBMod.SpinCam.enable end,
				set = function(info,val) DBMod.SpinCam.enable = val end
			},
			speed = {name=L["Spin/Speed"],type="range",order=5,width="full",
				min=1,max=230,step=1,
				get = function(info) return DBMod.SpinCam.speed end,
				set = function(info,val) if DBMod.SpinCam.enable then DBMod.SpinCam.speed = val; end if SpinCamRunning then addon:SpinToggle("update") end end
			},
			-- spartan.opt.args["SpinCam"].args["range"] = {name="Spin range",type="range",order=6,width="full",
				-- min=15,max=24,step=.1,
				-- get = function(info) return DBMod.SpinCam.range end,
				-- set = function(info,val) if DBMod.SpinCam.enable then DBMod.SpinCam.range = val; end if SpinCamRunning then addon:SpinToggle("update") end end
			-- }
			spin = {name=L["Spin/Toggle"],type="execute",order=15,width="double",
				desc = L["Spin/ToggleDesc"],
				func = function(info,val) addon:SpinToggle(); end
			}
		}
	}
	userCameraYawMoveSpeed = (GetCVar("cameraYawMoveSpeed"))
end

function addon:OnEnable()
	SetCVar("cameraYawMoveSpeed",userCameraYawMoveSpeed);
	local frame = CreateFrame("Frame");
	frame:RegisterEvent("CHAT_MSG_SYSTEM");
	frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	frame:SetScript("OnEvent",function(self, event, ...)
		if event == "CHAT_MSG_SYSTEM" then
			if (... == format(MARKED_AFK_MESSAGE,DEFAULT_AFK_MESSAGE)) and (DBMod.SpinCam.enable) then
				addon:SpinToggle("start")
			elseif (... == CLEARED_AFK) and (SpinCamRunning) then
				addon:SpinToggle("stop")
			end
		elseif event == "PLAYER_LEAVING_WORLD" or event == "PLAYER_ENTERING_WORLD" then
			addon:SpinToggle("stop")
		end
	end);
end

function addon:SpinToggle(action)
	if (SpinCamRunning and action == nil) or (action=="stop") then
		MoveViewRightStop();
		SetCVar("cameraYawMoveSpeed",userCameraYawMoveSpeed);
		SpinCamRunning = false;
		SetView(1);
	elseif action == "update" then
		SetCVar("cameraYawMoveSpeed", DBMod.SpinCam.speed);
	elseif not SpinCamRunning then
		SaveView(1)
		userCameraYawMoveSpeed = (GetCVar("cameraYawMoveSpeed"))
		SetCVar("cameraYawMoveSpeed", DBMod.SpinCam.speed);
		MoveViewRightStart();
		SpinCamRunning = true;
		SetView(5);
	end
end

SlashCmdList["SPINCAMTOGGLE"] = function(msg)
	if (SpinCamRunning) then DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99SpinCam|r: "..L["Spin/StopMSG"]); end
	addon:SpinToggle(action)
end;
SLASH_SPINCAMTOGGLE1 = "/spin"