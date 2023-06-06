local CATLIBS_PACKAGE = {}
local PACKAGE_NAME = "Composites"
local TYPES = require(script.Types)

CATLIBS_PACKAGE.Action = require(script.Action)
export type Action<A..., R...> = TYPES.Action<A..., R...>

CATLIBS_PACKAGE.Event = require(script.Event)
export type Signal<A...> = TYPES.Signal<A...>
export type Event<A...> = TYPES.Event<A...>

CATLIBS_PACKAGE.Result = require(script.Result)
export type Ok<O> = TYPES.Ok<O>
export type Err<E> = TYPES.Err<E>
export type OkErr<O, E> = TYPES.OkErr<O, E>
export type Result<O, E> = TYPES.Result<O, E>

CATLIBS_PACKAGE.Util = require(script.Util)

setmetatable(CATLIBS_PACKAGE, {
	__tostring = function() return `CatLibsPackage<{PACKAGE_NAME}>` end
})
table.freeze(CATLIBS_PACKAGE)
return CATLIBS_PACKAGE