local CATLIBS_PACKAGE = {}
local PACKAGE_NAME = "MetasExtensions"
local TYPES = require(script.Types)

--CATLIBS_PACKAGE.RbxEvent = require(script.RbxEvent)
--export type RbxEvent<A..., R...> = TYPES.RbxEvent<A..., R...>

CATLIBS_PACKAGE.ResultedAction = require(script.ResultedAction)
export type ResultedAction<O, E, A...> = TYPES.ResultedAction<O, E, A...>

setmetatable(CATLIBS_PACKAGE, {
	__tostring = function() return `CatLibsPackage<{PACKAGE_NAME}>` end
})
table.freeze(CATLIBS_PACKAGE)
return CATLIBS_PACKAGE