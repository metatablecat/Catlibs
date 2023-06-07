local TabbyCoreLib = require(script.Parent.Parent.TabbyCoreLib)
local Types = require(script.Parent.Types)

local Meower: Types.Meower = TabbyCoreLib.Action("Meower", function(name)
	return `Meows aggressively at {name}`
end)

return Meower