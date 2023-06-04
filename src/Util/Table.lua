local Table = {}

--[[
	`const LOCKED_NEW_KEY`

	Blocks new keys from being added
]]
local LOCKED_NEW_KEY = function(self, k)
	return `{k} is not a member of {tostring(self)}`
end

--[[
	Gets a key from the table and removes it from the table
]]
function Table.extract<K,V>(t: {[K]: V}, k: K): V
	local v = t[k]
	t[k] = nil
	return v
end

--[[
	Joins two table using `pairs`. This will work on all tables.

	**Remarks:** This will overwrite keys that are both in `t1` and `t2` to the
	value of `t2`
]]
function Table.join(t1: {[any]: any}, t2: {[any]: any})
	for k, v in t2 do
		t1[k] = v
	end
end

--[[
	Joins two lists using `ipairs`. This only works on lists with
	sequential numeric keys
]]
function Table.joinList(t1: {any}, t2: {any})
	local size = #t1
	for i, v in t2 do
		t1[size + i] = v
	end
end

--[[
	Pushes a list into a single continuous chunk of memory from `table.create`.
	This only works on lists with sequential numeric keys
]]
function Table.listToSingleMemoryChunk<T>(t1: {T}): {T}
	local tSize = #t1
	local newT = table.create(tSize)
	for i, v in t1 do
		newT[i] = v
	end
	
	return newT
end

--[[
	Freezes a table, however, unlike `table.freeze`, this allows rewrites
	of alreay defined keys
]]
function Table.strict(t)
	setmetatable(t, {
		__index = LOCKED_NEW_KEY,
		__newindex = LOCKED_NEW_KEY
	})
end

return Table