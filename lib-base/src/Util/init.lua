-- util acts as a container for useful unassociated functions
-- Most of this file is constants and helper functions

local Util = {}

-- Subsections
Util.table = require(script.Table)
Util.string = require(script.String)

-- Constants
--[[
	tau = `math.pi * 2`

	You know who you are who made me add this as a joke
]]
Util.TAU = 6.283185307179586

-- Functions
table.freeze(Util)
return Util