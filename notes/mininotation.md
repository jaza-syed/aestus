# Mini-Notation
Mini-notation is a little language used to specify pattern strings.
`sound` from the tidal prelude has the type `Pattern String -> ControlPattern`
A string specifies one cycle

`a b c d` - four beats in a cycles

`a:0 b:1 c:2 d:3` - tidal plays samples from folders. `a` is short for `a:0`,
meaning the first sample in the folder.

`[a b] [c d e]` - with `[]` you can specify subcyles, so this is a two-step cycles
with a two step cycle on the first step, and a three-step cycle on the second step
If specifying lots of these, you may want to use the equivalent shorthand
`a b . c d e` - the `.` marks out equal rhythmic steps.

`[a b] [c d e]*f` - you can speed up and slow down subcyles by multiplying or
dividing them by a floating point factor. If f is 4/3, on the second half
of each top-level cycle will be `c d` `e c` and `d e` over three cycles.

`[a b] [c d e]/3` - there's a nice trick you can do to divide a cycle by the
number of steps in it, to play one step per cycle. There is a shorthand for this
so the above cycle is equivalent to `[a b] <c d e>`.

`a!2 b!3` - the `!` operator is used to repeat, so this expands to `a a b b b`.
you can equivalently do `a ! b ! !` to repeat manually.

`a@2 b@3` - the `@` operator is used to extend, which allows samples to play
out over more than one step. You can equivalently do `a _ b _ _` to extend manually.

`[a b, c d e]` - The `[,]` operator superimposes two cycles to play polyrhythm.

`{a b, c d e}` - The `{,}` operator offers an alternative form of superposition
where the two patterns are matched stepwise. The patterns play simultaneously
but stretched to match to the leftmost pattern. This is known as "polymeter".
You can use the `%n` operator on a polymetre to warp the patterns to `n`
steps per cycle rather than using the count of the leftmost pattern!

For example
```
t> drawLine $ "[a b, c d e]"
|a--b--|a--b--|a--b--|a--b--|
|c-d-e-|c-d-e-|c-d-e-|c-d-e-|

t> drawLine $ "{a b, c d e}"
|ab|ab|ab|ab|ab|ab|
|cd|ec|de|cd|ec|de|

t> drawLine $ "{c d e, a b}"
|cde|cde|cde|cde|
|aba|bab|aba|bab|

t> drawLine $ "{a b, c d e} % 4"
|abab|abab|abab|abab|
|cdec|decd|ecde|cdec|
```

`~` specifies a rest - empty sample

`[a | b]` - choose randomly between a and b on each cycle

`[a b? c d?]` - The question mark replaces samples with a rest with  
