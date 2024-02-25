ql = {}

function flattenTable(tab)
	local flat = {}
	for i = 1, #tab do
		print(tab[i])
		if type(tab[i]) == 'table' then
			for e,j in ipairs(flattenTable(tab[i])) do 
				table.insert(flat,j)
			end
		else
			table.insert(flat, tab[i])
		end
	end
	return flat
end

function checkql(tab)
	if type(tab) ~= 'table' then return false end
	local mt = getmetatable(tab)
	return mt and mt.__index == ql
end

function getNegativeIndex(tab, index)
	if index < 1 then
		return #tab + index
	end
	return index
end

function concat(tab, sep, scope)
	local str = ""
	for i, v in ipairs(tab) do
		if checkql(v) then
			str = str .. tostring(v)
		elseif type(v) == 'table' then
			str = str .. tostring(ql.new(v))
		else
			str = str .. tostring(v)
		end
		if i < #tab then
			str = str .. sep
		end
	end
	return str
end

function concat_dictionary(tab, sep, scope)
	local str = ''
	for i,v in tab do
		local tabs = string.rep('	', scope + 1)
		local value = tostring(v)
		if typeof(v) == 'table' then
			value = concat_table(v, sep or ',', scope + 1)
		end
		local line = "[" .. '"'..i..'"' .. "] = " .. value .. (sep or ',') .. '\n'
		str = str .. tabs .. line
	end
	return str
end

function concat_table(self, sep, scope)
	local array = true
	for i,v in self do
		if type(i) ~= 'number' then
			array = false
		end
	end

	if array then
		return string.rep('	', scope) .. "{" .. concat(self, sep) .. string.rep('	', scope) .. "}\n"
	else
		return "{\n" .. concat_dictionary(self, sep, scope) .. string.rep('	', scope) .. "}"
	end
end

local customMethods = {}
function setupCustom()
	--[[This creates a shallow copy of the table
    self.copy() : QuickList
    ]]
	function customMethods.copy(self)
		return ql.new(self.t)
	end

    --[[Insert a value at a specific index. Anything infront will be pushed forward.
    () : self
    ]]
	function customMethods.insert(self : typeof(customMethods) & {t:any}, pos, value)
		if pos and (not value) then
			warn('Position was given (ql.insert()) but value was not. Did you want `ql.append()` ?')
		end
		pos = pos or #self.t + 1
		table.insert(self.t, pos, value)
		return self
	end

    --[[Inser a value at the end of the table.
    () : self
    ]]
	function customMethods.append(self, ...)
		for i,v in {...} do
			self.insert(#self.t + 1, v)
		end
		return self
	end

    --[[Join the table using a separator. (Optional)
    () : string
    ]]
	function customMethods.join(self, sep)
		sep = sep or ''
		return concat(self.t, sep)
	end

    --[[Split the table into 2 tables using an index.
    () : QuickList:{QuickList, QuickList}
    ]]
	function customMethods.split(self, index)
		index = index or math.ceil(#self / 2)
		return ql.new { self { 1, index }, self { index + 1, #self } }
	end

    --[[Returns a sorted copy of the table.
    Use the parameter "descending" to sort descending or provide a function(a,b).
    (Comparison:(Optional)) : QuickList
    ]]
	function customMethods.sort(self, comp)
		if comp == "descending" then
			function comp(a, b)
				return b < a
			end
		end

		local copy = self.copy()
		table.sort(copy.t, comp)
		return copy
	end

	--Loop through the list. Callback ( v:Value ).
	function customMethods.forEach(self : typeof(customMethods) & {t:any}, func)
		for i = 1, #self.t do
			if func then func(self.t[i]) end
		end
		return self
	end

	--Loop through the list. Callback ( i:Index, v:Value ).
	function customMethods.enumerate(self : typeof(customMethods) & {t:any}, func)
		for i = 1, #self.t do
			if func then func(i, self.t[i]) end
		end
		return self
	end

    --[[Merge a copy of this table with another. Appends the values to the end.
    () : QuickList
    ]]
	function customMethods.merge(self, tab)
		assert(type(tab) == 'table', 'A QuickList or table must be provided.')
		if not checkql(tab) then tab = ql.new(tab) end

		local copy = self.copy()
		tab.forEach(function(v)
			copy.append(v)
		end)
		return copy
	end

	--Add a value multiple times to the end.
	function customMethods.rep(self : typeof(customMethods) & {t:any}, value, times)
		times = times or 1
		for i = 1, times do
			self.append(value)
		end
		return self
	end

	--Remove a value at position.
	function customMethods.remove(self : typeof(customMethods) & {t:any}, pos)
		if tonumber(pos) then
			table.remove(self.t, pos)
		else
			local index = self.find(pos)
			if index then
				table.remove(self.t, index)
			else
				self.t[pos] = nil
			end
		end
		return self
	end

	--Removes the value at position, but returns it as well.
	function customMethods.pop(self, pos)
		local val = self[pos]
		self.remove(pos)
		return val
	end

	--Move a value from 1 position/index to another.
	function customMethods.move(self : typeof(customMethods) & {t:any}, pos1, pos2)
		self.insert(pos2, self.pop(pos1))
		return self
	end

	--Returns a reversed copy of the table.
	function customMethods.reverse(self)
		local newTable = ql.new()
		for i = #self, 1, -1 do
			newTable.append(self[i])
		end
		return newTable
	end

	--Split a string into a QuickList
	-- (string:string, sep:string) : QuickList
	function customMethods.string(self : typeof(customMethods) & {t:any}, str, sep)
		sep = sep or " "
		local result = ql.new()
		for match in (str .. sep):gmatch("(.-)" .. sep) do
			result.append(match)
		end
		return result
	end

	--Check if a value exists in the table.
	--Returns first index of value if it exists.
	--Returns nil if it doesn't.
	function customMethods.find(self, value)
		local index = nil
		self.enumerate(function(i, v)
			if v == value then
				index = i
				return
			end
		end)
		return index
	end

	--Get how many times a value shows up in the table.
	function customMethods.occurrences(self, value)
		local occurrences = 0
		self.forEach(function(v)
			if v == value then
				occurrences = occurrences + 1
			end
		end)
		return occurrences
	end

	--Return a copy of this table with unique values.
	--If any value is repeated, it will only show up once.
	-- () : QuickList
	function customMethods.unique(self)
		local newTable = ql.new()
		self.forEach(function(v)
			if not newTable.find(v) then
				newTable.append(v)
			end
		end)
		return newTable
	end

	--Return a dictionary. Where values are indexed by [1], [2], etc.
	--E.g {[1] = 'hello', [2] = 'world'}
	function customMethods.get_table(self)
		local dict = {}
		self.enumerate(function(i, v)
			dict[i] = v
		end)
		return dict
	end

	--Returns a shuffled copy of the table.
	function customMethods.shuffle(self)
		local list = self.t
		for i = #list, 2, -1 do
			local j = math.random(i)
			list[i], list[j] = list[j], list[i]
		end
		return ql.new(list)
	end

	--Get a pseudo-random value from the table.
	function customMethods.random(self)
		return self[math.random(#self)]
	end

	--Return a new QuickList by flattening nested tables.
	function customMethods.flatten(self)
		local flat = ql.new(flattenTable(self.t))
		return flat
	end

	--Get the average of all number values inside the table.
	function customMethods.average(self)
		local average = 0
		local n = 0
		self.forEach(function (v)
			if tonumber(v) then
				average = average + v
				n = n + 1
			end
		end)
		return average/n
	end

	--Check if the QuickList starts with a given sequence (table) of elements.
	function customMethods.startsWith(self, tab)
		for i = 1,#tab do
			if tab[i] ~= self[i] then
				return false
			end
		end
		return true
	end

	--Check if the QuickList ends with a given sequence (table) of elements.
	function customMethods.endsWith(self, tab)
		local lenDiff = #self-#tab
		for i = #tab,1,-1 do
			if tab[i] ~= self[i+lenDiff] then
				return false
			end
		end
		return true
	end

	--Check if a table is a QuickList
	function customMethods.checkql(self, tab)
		if type(tab) ~= 'table' then return false end
		local mt = getmetatable(tab)
		return mt and mt.__index == ql
	end

	function customMethods.sum(self)
		local res = 0
		self.forEach(function (v)
			if tonumber(v) then



				res = res + tonumber(v)
			end
		end)
		return res
	end

	function customMethods.setEach(self, func)
		self.enumerate(function (i,v)
			self[i] = func(i,v)
		end)
		return self
	end
end

setupCustom()

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

-- Creates a new 'QuickList' array. Use ql{values} to make it easier to make a QuickList.
--Made by creepersaur. Go subscribe to my youtube channel 😀.
function ql.new(_table) : typeof(customMethods)
	assert(_table == nil or type(_table) == 'table', 'Nil, table or QuickList must be provided.')
	if checkql(_table) then _table = _table.t end

	local self = {t = _table or {}}
	self = setmetatable(self, ql)

	return self
end

function setupql()
	ql.__type = 'QuickList'
	function ql.__index(self, index)
		if tonumber(index) then
			return self.t[getNegativeIndex(self, index)]
		end

		if customMethods[index] then
			return function(...)
				return customMethods[index](self, ...)
			end
		end

		return self.t[index]
	end

	function ql.__call(self, index)
		if type(index) ~= "table" or #index < 1 then return end
		local _start = index[1]
		local _end = #self.t
		local _inter = 1
		if #index > 1 then
			_end = getNegativeIndex(self, index[2])
			if #index == 3 then
				_inter = index[3]
			end
		end

		local newTable = {}
		for i = _start, _end, _inter do
			table.insert(newTable, self.t[i])
		end
		return ql.new(newTable)
	end

	function ql.__len(self)
		return #self.t
	end

	function ql.__tostring(self)
		return concat_table(self.t, ', ', 1)
	end

	function ql.__newindex(self, key, value)
		self.t[key] = value
	end

	function ql.__eq(self,other)
		local res = true
		self.enumerate(function (i,v)
			if v ~= other[i] then
				res = false
				return
			end
		end)
		return res
	end

	function ql.__add(self, other)
		local copy = self.copy()
		copy.enumerate(function(i,v)
			if #other < i then return end
			pcall(function ()
				copy[i] = v + other[i]
			end)
		end)
		return copy
	end

	function ql.lt(self, other)
		if self.sum() < other.sum() then
			return true
		end
		return false
	end

	function ql.le(self, other)
		return ql.lt(self,other) or self.sum() == other.sum()
	end

	function ql.__concat(self, other)
		local copy = self.copy()
		copy.forEach(function (i,v)
			pcall(function ()
				if type(other) == 'table' then
					copy[i] = v..other[i]
				else
					copy[i] = other
				end
			end)
		end)
		return copy
	end
end

setupql()

return ql.new
