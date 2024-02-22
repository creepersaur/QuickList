# QuickList Documentation

QuickList is a Lua (class) library for managing arrays efficiently. It provides a set of functions for manipulating arrays in a concise and expressive manner.
This was made by creepersaur. Go and subscribe to him on [Youtube](https://youtube.com/c/creepersaur).

# Usage
Just `require(path)` to the QuickList module. Then use the returned value to make lists. Name the variable anything, but it's best to name it something short (such as ql or underscore)
```lua
local _ = require('QuickList')
local myTable = _{
    'Hello',
    "World,
    123
}

print(myTable)
```
```md
> {Hello, World}
```

## QuickList Class

### `require('QuickList')`

Returns `ql.new` by default. 

### `ql.new(_table)`

Creates a new 'QuickList' array. Use `ql{values}` to make it easier to create a QuickList.

**Parameters:**
- `_table`: A QuickList or table (optional).

**Returns:**
- QuickList: A new QuickList array.

### `self.copy()`

Creates a shallow copy of the table.

**Returns:**
- QuickList: A copy of the QuickList.

### `self.insert(pos, value)`

Inserts a value at a specific index. Anything in front will be pushed forward.

**Parameters:**
- `pos`: Index to insert the value.
- `value`: Value to insert.

**Returns:**
- QuickList: Modified QuickList.

### `self.append(value)`

Inserts a value at the end of the table.

**Parameters:**
- `value`: Value to append.

**Returns:**
- QuickList: Modified QuickList.

### `self.join(sep)`

Joins the table using a separator. (Optional)

**Parameters:**
- `sep`: Separator (optional).

**Returns:**
- string: Joined string.

### `self.split(index)`

Splits the table into two tables using an index.

**Parameters:**
- `index`: Index to split the table.

**Returns:**
- QuickList: Two tables resulting from the split.

### `self.sort(comp)`

Returns a sorted copy of the table. Use the parameter "descending" to sort descending or provide a custom comparison function.

**Parameters:**
- `comp`: Comparison function or "descending" (optional).

**Returns:**
- QuickList: Sorted copy of the table.

### `self.forEach(func)`

Loops through the list. Callback `(v:Value)`.

**Parameters:**
- `func`: Callback function.

**Returns:**
- QuickList: Modified QuickList.

### `self.enumerate(func)`

Loops through the list. Callback `(i:Index, v:Value)`.

**Parameters:**
- `func`: Callback function.

**Returns:**
- QuickList: Modified QuickList.

### `self.merge(tab)`

Merges a copy of this table with another. Appends the values to the end.

**Parameters:**
- `tab`: Another QuickList or table.

**Returns:**
- QuickList: Merged QuickList.

### `self.rep(value, times)`

Adds a value multiple times to the end.

**Parameters:**
- `value`: Value to repeat.
- `times`: Number of times to repeat (optional, default is 1).

**Returns:**
- QuickList: Modified QuickList.

### `self.remove(pos)`

Removes a value at a specific position.

**Parameters:**
- `pos`: Position to remove.

**Returns:**
- QuickList: Modified QuickList.

### `self.pop(pos)`

Removes the value at a specific position and returns it.

**Parameters:**
- `pos`: Position to pop.

**Returns:**
- Value: Removed value.

### `self.move(pos1, pos2)`

Moves a value from one position/index to another.

**Parameters:**
- `pos1`: Source position.
- `pos2`: Destination position.

**Returns:**
- QuickList: Modified QuickList.

### `self.reverse()`

Returns a reversed copy of the table.

**Returns:**
- QuickList: Reversed copy of the table.

### `self.string(str, sep)`

Splits a string into a QuickList.

**Parameters:**
- `str`: Input string.
- `sep`: Separator (optional).

**Returns:**
- QuickList: Resulting QuickList.

### `self.find(value)`

Checks if a value exists in the table. Returns the index if found, otherwise returns nil.

**Parameters:**
- `value`: Value to find.

**Returns:**
- Index or nil.

### `self.occurrences(value)`

Gets the number of times a value shows up in the table.

**Parameters:**
- `value`: Value to count.

**Returns:**
- Count of occurrences.

### `self.unique()`

Returns a copy of the table with unique values.

**Returns:**
- QuickList: Modified QuickList.

### `self.get_dictionary()`

Returns a dictionary where values are indexed by [1], [2], etc.

**Returns:**
- table: Dictionary.

### `self.shuffle()`

Returns a shuffled copy of the table.

**Returns:**
- QuickList: Shuffled copy of the table.

### `self.random()`

Gets a pseudo-random value from the table.

**Returns:**
- Value: Random value.

### `self.flatten()`

Returns a new QuickList by flattening nested tables.

**Returns:**
- QuickList: Flattened QuickList.

### `self.average()`

Gets the average of all number values inside the table.

**Returns:**
- number: Average value.

### `self.startsWith(tab)`

Checks if the QuickList starts with a given sequence (table) of elements.

**Parameters:**
- `tab`: Sequence to check.

**Returns:**
- boolean: True if the QuickList starts with the sequence, otherwise false.

### `self.endsWith(tab)`

Checks if the QuickList ends with a given sequence (table) of elements.

**Parameters:**
- `tab`: Sequence to check.

**Returns:**
- boolean: True if the QuickList ends with the sequence, otherwise false.

### `self.checkql(tab)`

Checks if a given table is a QuickList.

**Parameters:**
- `tab`: Table to check
**Returns:**
- boolean: True if it is a QuickList, false if not.
