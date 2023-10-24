# Pattern combination
The most common way of combining patterns is with the `#` operator.
There are multiple ways of combining patterns with different operators that do
slightly different thdings.

Before getting into it properly, here are some useful tricks to use:

- `n "[0 1 2 3] # sound "cpu"` is equivalent to `sound "cpu:0 cpu:1 cpu:2 cpu:3"`
- `sound "kick!8" # n "0 1 2 3 4 5 6 7"` is equivalent to `s "kick:0 kick:1 ....."`

The type of `s "bd sn"` is a `ControlPattern`. The `#` operator is an infix binary
operator on two of these. It is left-assosciative and has high precedence (9).

The `#` operator takes rhythmic structure from the left but values from the right.
The pattern on the right is overlayed over the left and the values are moved from
the right onto the rhythmic structure of the left.
Remember a tidal pattern is basically just a list of symbols and times and we can 
think of infix operators on these patterns as ways of combining them. The symbols are *not*
necessarily samples to play to play, they are more complicated than that to encode structure.
Strings in tidal are interpreted as `Pattern String` which is actually a list of times 
and symbols again - but the symbols are strings rather than control variables.

\# is actually shorthand, for '|>'. There's a whole family of these:

- `|>` is structure from the left, values from the right
- `<|` is values from the left, structure from the right
- `|<` is structure from the left, values from the left
- `>|` is structure from the right, values from the right
- `|<|` is values from the right, structure from both sides
- `|>|` is values from the left, structure from both sides

- < points to where the values come from, and | goes on the side where the rhythmic structure comes from.

Structure from both sides is interesting - it means that where there is conflict
between the patterns, the output pattern is split - so no timing information is lost.
which tell Tidal how to combine the values.
The available arithmetic operators are `+`, `*`, `-`, `/` and `%`, which behave
as you'd expect. They work on pattern strings as well as control patterns

Structure from both sides
```
"2 3" + "4 5 6"

  |  2  |  3  |
+ | 4 | 5 | 6 |
= | 6 |7|8| 9 |
```
You get a new event on every new event in both patterns.
The values are the sum of the values at each start of each event.
```
"2 3" |+ "4 5 6"

  |  2  |  3  |
+ | 4 | 5 | 6 |
= | 6   | 8   |
```
You get a new event on every new event in the left pattern (same structure)
The values are the sum of the values at the start each event.
```
"2 3" +| "4 5 6"

  |  2   |  3   |
+ | 4 |  5  | 6 |
= | 6 | 7  | 9  |
```
