# Sampling

`chop` / `striate` / `slice` / `splice` are all part of the same family, which
chop up a pattern into sections, reorder and play back the results. the first
argument is a `Pattern Int` specifying how many samples to chop up *each sample*
in the pattern for it to be applied.
- `chop` does not reorder the samples, so it doesn't actually sound much different
- `striate` plays the sample fragments in cutting order, but with the samples interlaced
  so `striate 2 $ sound "kick hi"` - is `sound "kick(1/2) hi(1/2) kick(2/2), hi(2/2)"`
- `striateBy` has an additional parameter specifying the length of each part. so
  `striate n` is same as `striateBy n (1/n)`
- `slice` like `chop` / `striate` but an extra argument to give you full control
  over pattern order
- `splice` - same as slice, but samples are pitch shifted (just by speeding up/down)
so that they fit evenly and don't cut eachother off / have silences in between
- `loopAt` - stretch the sample/pattern to fit the given number of cycles
- `segment` - samples pattern at `n` events per cycle - useful for discretising
  continuuus functions for use with pattern combination operators
- `sig` - take a function `Time -> a` and turns it into a pattern
-

# sample effects
## basic
- `amp` - linear volume
- `gain` - power law volume
- `begin`/`end` - playback position in the sample
- `grain` - takes begin and length patterns
- `grain'` - specify begin and end in one pattern
## stretching
- `accelerate` - obvious
- `speed`- obvious
- `sustain` - fix sample playback duration
- `unit` - used with `speed` to allow specifying units in rate, cycles or seconds
- `timescale` - time-stretches by the given factor
