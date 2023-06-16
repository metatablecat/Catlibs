-- CATLIBS SERVICE RUNNER
-- metatablecat 2023
--[[
	HOW TO USE THIS SCRIPT:

	This script is designed to work on both the server and the client, however it
	should be created as a ModuleScript.

	ScriptModules will load when the game starts. The fundamental principle here
	is that ModuleScripts are loaded like scripts, but can still return objects

	They will only load if they are a descendant of the following services:
	Players
	ReplicatedFirst
	ReplicatedStorage
	ServerScriptService

	Your module must not yield on initialisation, and *should* return a table,
	but this is not enforced
	
	You can disable a ScriptModule from loading by adding the attribute
	"Enabled" and setting it to false. This will not start a script if you enable
	it at runtime
]]

local CollectionService = game:GetService("CollectionService")
local SCRIPT_MODULE_TAG = "ScriptModule"
local ENFORCE_TABLE_RETURNS = false
local VERBOSE = false

local LOAD_FROM = {
	game:GetService("Players"),
	game:GetService("ReplicatedFirst"),
	game:GetService("ReplicatedStorage"),
	game:GetService("ServerScriptService")
}

local LOG_PREFIX = "[ScriptModule]:"

local Package = require(script.Parent.Package)
local ScriptModule = {}
local ScriptModulePackage = Package(ScriptModule, {
	Name = "ScriptModule",
	Version = "0.1.0"
})

local function BAD_LOAD(modName, msg, hint)
	if hint then
		msg ..= `\n  - {hint}`
	end
	
	warn(`{LOG_PREFIX} Failed to load ScriptModule '{modName}' because {msg}`)
	return false
end

local function LOGPOINT(msg)
	if not VERBOSE then return end
	print(`{LOG_PREFIX} {msg}`)
end

local function LoadModuleNoYield(mod: ModuleScript)
	local modName = mod:GetFullName()
	if mod:GetAttribute("Enabled") == false then
		LOGPOINT(`Script {modName} is disabled.`)
		return true
	end
	
	local s, body
	task.spawn(function()
		s, body = pcall(require, mod)
	end)

	if s == nil then
		return BAD_LOAD(modName, "it cannot yield")
	end

	if s == false then
		-- module trace isn't preserved, so this is the best we have
		return BAD_LOAD(modName, "it errored")
	end

	-- assume it loaded fully, dont do anything here
	if ENFORCE_TABLE_RETURNS then
		local retType = typeof(body)
		if retType ~= "table" then
			return BAD_LOAD(
				modName,
				"it did not return a table.",
				"This can be disabled by changing the constant ENFORCE_TABLE_RETURNS"
			)
		end
	end
	
	LOGPOINT(`Loaded ScriptModule '{modName}'`)
	return true
end

local function IsInValidDescendant(inst: Instance): boolean
	for _, service in LOAD_FROM do
		if inst:IsDescendantOf(service) then
			return true
		end
	end
	
	return BAD_LOAD(
		inst:GetFullName(), 
		"is not a member of a valid descendant",
		"Valid descendants can be changed using the constant LOAD_FROM"	
	)
end

local function CollectionServiceTagHandler(inst: Instance)
	if inst:IsA("ModuleScript") then
		LOGPOINT(`Loading ScriptModule '{inst:GetFullName()}'...`)
		
		if IsInValidDescendant(inst) then
			LoadModuleNoYield(inst)
		end
	end
end

function ScriptModule.run()
	LOGPOINT("CatLibs ScriptModule Loader - metatablecat 2023")

	CollectionService:GetInstanceAddedSignal(SCRIPT_MODULE_TAG):Connect(CollectionServiceTagHandler)
	for _, v in CollectionService:GetTagged(SCRIPT_MODULE_TAG) do
		CollectionServiceTagHandler(v)
	end

	LOGPOINT("Done loading")
end

return ScriptModulePackage()