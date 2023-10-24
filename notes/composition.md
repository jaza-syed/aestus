# Composition
important: note that an orbit has a global fx chain - certain audio effects
that are not related to sampling e.g. delay time etc only have one value
on a given orbit

## Arrangement
- `stack` - overlay list
- `cat` - concatenate list
- `fastcat` - squash each cycle of each pattern into one cycle
  (so multi-cycle patterns still go over one cycle)
- `seqPLoop` - like `cat` but specify start/end cycles - so you can say
  `a` for 3, `d` for 4 etc
- `ur` - create loops. takes one lookup table of patterns, another lookup table of effects, then a pattern which can refer to the lookup table keys to create
a longer form pattern.

## Transition
- TODO
- `ur`
