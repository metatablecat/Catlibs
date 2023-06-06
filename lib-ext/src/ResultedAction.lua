-- Wrapper library that wraps an Action such that it returns a result
-- We cant define this as an extension of the Action class since we need to
-- return something else from the Action
--[[
	ResultAction<O, E>(resultErrs, f)
		.await -> OkErr<>
		.handleAsync -> OkErr<>
]]--
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local CatLibs = require(ReplicatedFirst.CatLibs.Base)

local Types = require(script.Parent.Types)
local Result = CatLibs.Result
local Action = CatLibs.Action

type Result<O, E> = CatLibs.Result<O, E>
type Action<A..., O...> = CatLibs.Action<A..., O...>
type ResultedAction<O, E, A...> = Types.ResultedAction<O, E, A...>

local function ResultedAction<O, E, A...>(
	actionName: string, 
	errors: {
		default: E?,
		[string]: E
	}, 
	f: (Result<O, E>, A...) -> O
): ResultedAction<O, E, A...>

	local r = {}
	r._action = Action(actionName, f)
	r._result = Result(errors)

	function r.await(self: ResultedAction<O, E, A...>, ...: A...): CatLibs.OkErr<O, E>
		local action: Action<(Result<O, E>, A...), (CatLibs.OkErr<O, E>)> = self._action
		local result: Result<O, E> = self._result

		local s, rState, rReturn = action:await(result, ...)
		if not s then
			return result:FromLuaError(rReturn)
		end

		return rState
	end

	function r.handleAsync(self: ResultedAction<O, E, A...>, callback: (CatLibs.OkErr<O, E>) -> (), ...: A...)
		local action: Action<(Result<O, E>, A...), (CatLibs.OkErr<O, E>)> = self._action
		local result: Result<O, E> = self._result

		action:handleAsync(function(s, rState, rReturn)
			local callBody = if not s
				then result:FromLuaError(rReturn)
				else rState

			callback(callBody)
		end, result, ...)
	end

	return r
end

return ResultedAction