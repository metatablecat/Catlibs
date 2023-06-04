--!nolint ImplicitReturn
local String = {}

--[[
	Returns an iterator of characters from the given string
	
	### Code Example
	```lua
	for i, c in String.chars("Hello") do
		print(i, c) --> 1, H  2, e  3, l  4, l  5, o
	end
	```
]]
function String.chars(str: string): (({string}, number?) -> (number, string), {string})
	-- returns an iterator function for iterating characters in a string
	local chars = string.split(str, "")
	
	return function(chars, lastIdx)
		lastIdx = if lastIdx then lastIdx + 1 else 1
		local char = chars[lastIdx]
		if char then
			return lastIdx, char
		end
	end, chars
end

--[[
	Equivalant to `string.split` but uses a pattern instead of a plain match
]]
function String.splitPatterned(str: string, pattern: string): {string}
	-- identical to string.split but uses string patterns instead of plain
	-- strings for splitting
	local out = {}
	
	for match in string.gmatch(str, pattern) do
		table.insert(out, match)
	end
	
	return out
end

--[[
	Convers a string to an array of bytes

	### Code Example
	```lua
	print(String.toByteArray("Hello World!")) --> {72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33}
	```
]]
function String.toByteArray(str: string): {number}
	-- converts a string to numbers
	local output = table.create(string.len(str), 0)
	for i, char in String.chars(str) do
		output[i] = string.byte(char)
	end
	
	return output
end

--[[
	Finds the first match in a string and returns it's value in the match table

	If multiple matches are found, returns the first occurance of any pattern, for example, given `spec` and `story`,
	in the following string: `Action.spec.story`, it returns the value for `spec`, and vice versa for `story`,
	since spec is before story in the string

	### Code Example
	```lua
	local matches = {
		["spec$"] = "TestFile",
		["story$"] = "ComponentStory"
	}

	print(String.findFirstMatch("Action.spec", matches)) --> TestFile
	print(String.findFirstMatch("Action.story", matches)) --> ComponentStory
	print(String.findFirstMatch("Action", matches)) --> nil
	```
]]
function String.findFirstMatch<T>(str: string, match: {[string]: T}): T?
	local matchPos, lastMatchVal

	for pattern, value in match do
		local pos = string.find(str, pattern)
		if not matchPos or pos < matchPos then
			matchPos = pos
			lastMatchVal = value
		end
	end

	return lastMatchVal
end

--[[
	Same as `findFirstMatch`, except as soon as a match is found, it returns that value, instead
	of checking every pattern

	**Remarks:** The order of dictionaries are undefined, try to avoid collisions when using this. If position
	is important, use `findFirstMatch` instead
]]
function String.matchAny<T>(str: string, match: {[string]: T}): T?
	for pattern, value in match do
		if string.match(str, pattern) then return value end
	end

	return nil
end

return String