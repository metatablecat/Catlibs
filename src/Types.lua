-- Types Module (only public exports need to go here)

-- Action.lua
export type Action<I..., O...> = {
	_signal: (I...) -> O...,
	_threads: {[thread]: thread},
	Name: string,
	await: (Action<I..., O...>, I...) -> (boolean, O...),
	cancel: (Action<I..., O...>, optmsg: string?) -> (),

	handleAsync: (Action<I..., O...>, func: (boolean, O...) -> (), I...) -> ()
}

-- Result.lua
export type Ok<T> = {
	IsOk: true,
	Ok: T,
}

export type Err<T> = {
	IsOk: false,
	Err: T
}

export type OkErr<O, E> = Ok<O>|Err<E>

export type Result<O, E> = {
	Ok: (Result<O, E>, ok: O) -> Ok<O>,
	Err: (Result<O, E>, err: E) -> Err<E>,
	FromLuaError: (Result<O, E>, msg: string) -> Err<E>,
	FromPcall: <A...>(
		Result<O, E>,
		f: (A...) -> O,
		A...
	) -> OkErr<O, E>
}

-- ResultedAction.lua
export type ResultedAction<O, E, A...> = {
	_action: Action<(Result<O, E>, A...), (OkErr<O, E>)>,
	_result: Result<O, E>,
	await: (ResultedAction<O, E, A...>, A...) -> OkErr<O, E>,
	handleAsync: (
		ResultedAction<O, E, A...>,
		callback: (OkErr<O, E>) -> (),
		A...
	) -> ()
}

-- Util doesn't export types
return nil