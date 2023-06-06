-- @Composites/ResultedAction.lua
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

return nil