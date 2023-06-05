local Types = require(script.Types)

export type Action<I..., O...> = Types.Action<I..., O...>
export type Ok<O> = Types.Ok<O>
export type Err<E> = Types.Err<E>
export type OkErr<O, E> = Types.OkErr<O, E>
export type Result<O, E> = Types.Result<O, E>
export type ResultedAction<O, E, A...> = Types.ResultedAction<O, E, A...>

return {
	Action = require(script.Action),
	Result = require(script.Result),
	ResultedAction = require(script.ResultedAction),
	Util = require(script.Util)
}