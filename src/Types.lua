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

-- Event.lua
export type Signal<A...> = {
	Connect: (Signal<A...>, func: (A...) -> ()) -> () -> (),
	ConnectedFunctions: {(A...) -> ()},
	Wait: (Signal<A...>) -> A...,
	WaitingThreads: {thread}
}

export type Event<A...> = {
	Signal: Signal<A...>,
	Fire: (Event<A...>, A...) -> (),
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

-- Util doesn't export types
return nil