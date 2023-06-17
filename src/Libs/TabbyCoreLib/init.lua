local Types = require(script.Types)
local TabbyCoreLib = {}

TabbyCoreLib.Action = require(script.Action)
export type Action<A..., R...> = Types.Action<A..., R...>

TabbyCoreLib.Event = require(script.Event)
export type Signal<A...> = Types.Signal<A...>
export type Event<A...> = Types.Event<A...>

TabbyCoreLib.Result = require(script.Result)
export type Ok<O> = Types.Ok<O>
export type Err<E> = Types.Err<E>
export type OkErr<O, E> = Types.OkErr<O, E>
export type Result<O, E> = Types.Result<O, E>

return TabbyCoreLib
