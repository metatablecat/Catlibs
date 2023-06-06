local ReplicatedFirst = game:GetService("ReplicatedFirst")
local CatLibs = require(ReplicatedFirst.CatLibs.Base)

export type ResultedAction<O, E, A...> = {
	_action: CatLibs.Action<(CatLibs.Result<O, E>, A...), (CatLibs.OkErr<O, E>)>,
	_result: CatLibs.Result<O, E>,
	await: (ResultedAction<O, E, A...>, A...) -> CatLibs.OkErr<O, E>,
	handleAsync: (
		ResultedAction<O, E, A...>,
		callback: (CatLibs.OkErr<O, E>) -> (),
		A...
	) -> ()
}

return nil