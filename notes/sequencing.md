# Sequencing
rhythm specifications
## Multi-cycle patterns
This is obvious but it's important to emphasize - a pattern can last many
(or infinite!) cycles. This is the most direct way of creating n-bar loops.
- `slow` and `fast` stretch patterns
## speed
- `slow` and `fast` - same effect as `/` and `*` in mini-notation, but pattern-able! Takes *two* patterns and combines them
- `fastGap` like fast but doesn't repeat the pattern like `*` and `/` do
- `hurry` like `fast` but also increases the speed control factor
- `slowSqueeze` and `fastSqueeze` - apply slow/fast according to pattern then

## condition operators
- `every <pattern> <effect>` : apply `effect` according to `pattern`

## Sequencing
- `struct` / `stitch` - create t/f rhythmic structures which sound can be a
  assigned to. stich allows specifying sounds for both `t` and `f`
- `sew` is like `stitch` but
- `step` - step sequencing
- `fit(n, [a], Pattern Int)` - second argument is a list of stuff,
  third argument is a pattern of list indexes for that list. n specifies
  an increment for offset at which the list is rotated - the offset increase
  s by n each cycle.
  combine together in a cycle. equivalent to `slow`/ `fast`


## rhythm
- `off` - add offset copy w/ effect
- `press/pressBy` - shift every event off by a half - equivalent to turning
  every `x` into `[~ x]` in mini-notation for `press`. `pressBy` adds a factor.
- `~>` - offset a pattern by a cycle fraction
