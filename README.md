<div align="center">

![Quicklist_logo|442x154](Quicklist_logo.png)

[![GitHub|107x32](GitHub.svg)](https://github.com/creepersaur/QuickList/)  [![Library|107x32](Library.png)](https://create.roblox.com/store/asset/16472746617)   [![Wally|107x32](Wally.png)](https://wally.run/package/creepersaur/quicklist)

</div>

QuickList is a Lua (class) library for managing arrays efficiently. It provides a set of functions for manipulating arrays in a concise and expressive manner.
This was made by creepersaur. Go and subscribe to him on [Youtube](https://youtube.com/c/creepersaur).

# Installation
Download the `QuickList.lua` from the source code. Or use releases if an *older* version is there.
Just `require(path)` to the QuickList module. Then use the returned value to make lists. Name the variable anything, but it's best to name it something short (such as ql or underscore)

If you use Wally for managing packages, you can install it using the following line:
```toml
QuickList = "creepersaur/quicklist@^1.0"
```
For anyone willing to use this on Roblox (as intended), copy the contents of `QuickList.lua` and paste them into a ModuleScript. Then `require(path_to_module)`.

# Example
```luau
local ql = require('QuickList')
local myTable: ql.QuickList = ql {
    'Hello',
    "World",
    123
}

print(myTable)
```
Output:
```md
> {Hello, World}
```

## QuickList Class

> [!NOTE]
> #### `require(path_to_quicklist)`
> Returns the `Quicklist` export type and `new()` in the same require.
> ```luau
> local ql = require(path)
> ql.Quicklist -- this is the type
> ql() or ql{} -- create a new quicklist
> ```

> [!NOTE]
> `ql.new(_table)`
> Creates a new 'QuickList' array. Use `ql{values}` to make it easier to create a QuickList.
> > 
> **Parameters:**
> > - `_table`: A QuickList or table (optional).
> 
> **Returns:**
> - `QuickList`: A new QuickList array.

> [!NOTE]
> `self.copy()`
> Creates a shallow copy of the table.
> 
> **Returns:**
> - `QuickList`: A copy of the QuickList.

> [!NOTE]
> `self> .insert(pos, value)`
> Inserts a value at a specific index. Anything in front will be pushed forward.
> > 
> **Parameters:**
> - `pos`: Index to insert the value.
> - `value`: Value to insert.
> 
> **Returns:**
> - `QuickList`: Modified QuickList.

> [!NOTE]
> `self.append(value)`
> Inserts a value at the end of the table.
> 
> **Parameters:**
> - `value`: Value to append.
> 
> **Returns:**
> - `QuickList`: Modified QuickList.

> [!NOTE]
> `self.join(sep)`
> Joins the table using a separator. (Optional)
> 
> **Parameters:**
> - `sep`: Separator (optional).
> 
> **Returns:**
> - `string`: Joined string.

> [!NOTE]
> `self.split(index)`
> Splits the table into two tables using an index.
> 
> **Parameters:**
> - `index`: Index to split the table.
> 
> **Returns:**
> - `QuickList`: Two tables resulting from the split.

> [!NOTE]
> `self.sort(comp)`
> Returns > a sorted copy of the table. Use the parameter "descending" to sort descending or provide a custom comparison function.
> 
> **Parameters:**
> - `comp`: Comparison function or "descending" (optional).
> 
> **Returns:**
> - `QuickList`: Sorted > copy of the table.

> [!NOTE]
> `self.forEach(func)`
> Loops through the list. Callback `(v:Value)`.
> 
> **Parameters:**
> - `func`: Callback function.
> 
> **Returns:**
> - `QuickList`: Modified QuickList> .

> [!NOTE]
> `self.enumerate(func)`
> Loops through the list. Callback `(i:Index, v:Value)`.
> 
> **Parameters:**
> - `func`: Callback function.
> 
> **Returns:**
> - `QuickList`: Modified QuickList.

> [!NOTE]
> `self.merge(tab)`
> Merges a copy of this table with another. Appends the values to the end.
> 
> **Parameters:**
> - `tab`: Another QuickList or table.
> 
> **Returns:**
> - `> QuickList`: Merged QuickList.

> [!NOTE]
> `self.rep(value, times)`
Adds a value multiple times to the en> d.
> 
> **Parameters:**
> - `value`: Value to repeat.
> - `times`: Number of times to repeat (optional, default is 1).
> 
> **Returns:**
> - `QuickList`: Modified QuickList.

> [!NOTE]
> `self.remove(pos)`
Removes a value at a specific positio> n.
> 
> **Parameters:**
> - `pos`: Position to remove.
> 
> **Returns:**
> - `> QuickList`: Modified QuickList.

> [!NOTE]
> `self.pop(pos)`
Removes the value at a specific position and returns i> t.
> 
> **Parameters:**
> - `pos`: Position to pop.
> 
> **Returns:**
> - `Value`: Removed value.

> [!NOTE]
> `self.move(pos1, pos2)`
Moves a value from one position/index to anothe> r.
> 
> **Parameters:**
> - `pos1`: Source position.
> - `pos2`: Destination position.
> 
> **Returns:**
> - `QuickList`: Modified QuickList.

> [!NOTE]
> `self.reverse()`
Returns a reversed copy of the tabl> e.
> 
> **Returns:**
> - `QuickList> `: Reversed copy of the table.

> [!NOTE]
> `self.string(str, sep)`
Splits a string into a QuickLis> t.
> 
> **Parameters:**
> - `str`: Input string.
> - `sep`: Separator (optional).
> 
> **Returns:**
> - `QuickList`: Resulting QuickList.

> [!NOTE]
> `self.> find(value)`
Checks if a value exists in the table. Returns the index if found, otherwise returns > nil.
> 
> **Parameters:**
> - `value`: Value to find.
> 
> **Returns:**
> - `Index` or > `nil`.

> [!NOTE]
> `self.occurrences(value)`
Gets the number of times a value shows up in the tabl> e.
> 
> **Parameters:**
> - `value`: Value to count.
> 
> **Returns:**
> - `number`.

> [!NOTE]
> `self.unique()`
Returns a copy of the table with unique value> s.
> 
> **Returns:**
> - `QuickList`: Modified QuickList.

> [!NOTE]
> `self.get_dictionary()`
Returns a dictionary where values are indexed by [1], [2], et> c.
> 
> **Returns:**
> - `table`: Dictionary.

> [!NOTE]
> `self.shuffle()`
Returns a shuffled copy of the tabl> e.
> 
> **Returns:**
> - `QuickList`: Shuffled copy of the table.

> [!NOTE]
> `self.random()`
Gets a pseudo-random value from the tabl> e.
> 
> **Returns:**
> - `Value`: Random value.

> [!NOTE]
> `self.flatten()`
Returns a new QuickList by flattening nested table> s.
> 
> **Returns:**
> - `QuickList`: Flattened QuickList.

> [!NOTE]
> `self.average()`
Gets the average of all number values inside the tabl> e.
> 
> **Returns:**
> - `number`: Average value> .

> [!NOTE]
> `self.startsWith(tab)`
Checks if the QuickList starts with a given sequence (table) of element> s.
> 
> **Parameters:**
> - `tab`: Sequence to check.
> 
> **Returns:**
> - `boolean`: True if the QuickList starts with the sequence, otherwise false> .

> [!NOTE]
> `self.endsWith(tab)`
> Checks if the QuickList ends with a given sequence (table) of element> s.
>
> **Parameters:**
> - `tab`: Sequence to check.
> 
> **Returns:**
> - `boolean`: True if the QuickList ends with the sequence, otherwise false.

> [!NOTE]
> `self.checkql(tab)`> 
> 
> **Returns: **
> - `boolean`: True if the table provided is a QuickList

> [!NOTE]
> `self.sum()`
> **Returns: **
> - `number`: Adds all the number values in the list and gives the sum.

> [!NOTE]
> `self.retain()`> 
> Deletes the item inside the QuickList if the function returns false for that item.
> 
> **parameters**
> - `func(i: number, v: any)`
