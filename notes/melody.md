# Manual arpeggios
Basic to specify a sequence of notes : `n "c a f e"`. As an aside,
`n :: Pattern Note -> ControlPattern` - interesting.

Useful function: `off` adds a transformed offset copy to the pattern.
`off :: P Time -> (P a -> P a) -> P a -> P a` : takes a pattern of offsets,
transformation function and pattern to apply it

# Arp function
`arp :: Pattern String -> Pattern a -> Pattern b`. First argument patterns the
arp type, second argument is the chord to arpeggiate.

arp types:
```
up down updown downup up&down down&up converge
diverge disconverge pinkyup pinkyupdown
thumbup thumbupdown
```

# Scales
A scale is a numbered list of notes.
- basic function `scale :: Fractional a => Pattern String -> Pattern Int -> Pattern a`
  takes a pattern of scale type and pattern of note numbers and creates a pattern
- `scaleList` - gets list of scales
- `scaleTable` - gets string -> note list for the scale
- `getScale` - gets the note list from the table
- `toScale` - create an anonymous scale which can be applied to a `Pattern Int`
list of not numbers once the first argument (note list) has been applied

# note syntax
- `c` corresponds to `0`
- we go up `c d e f g a b` in each octave
- you use `n <pattern>` to specify notes
- you can add / subtract like `<pattern> |+ n 12`
- can use `c7` to specify octave directly
- can use `octave <pattern>` to pattern increments of 12

# chord syntax
- `<tonic>'<type>['<num>]` - num specifiies the number of notes
- Chords can be patterned independently of notes using normal pattern combination functions with pattern strings!
  Example: `d1 $ n ("c e f" |+ "<'maj 'min>") # s "supermandolin"` !!
