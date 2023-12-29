# 12-12-23 - Tuesday
- Worked out `timeLoop n` - loops the first `n` cycles of the pattern - might be nice to have n midi-controllable

# 29-12-23 - Friday
- When using samples, n refers to the file index in the sample folder, sorted alphabetically (ascending) and counted from 0 (zero).
  It is possible for each sample to correspond to a note, if you have sampled every single note of an instrument.
  However when using note, the sample is pitched up or down (and the sample duration is affected accordingly).
- Chords can be patterned independently of notes using normal pattern combination functions with pattern strings!
  Example: `d1 $ n ("c e f" |+ "<'maj 'min>") # s "supermandolin"` !!
