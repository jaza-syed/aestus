# plan:
- start out messing around with rave sample
- cut and introduce 909 pattern, develop that - make it crazy - remember squiz and waveloss
# actual
909: bd, cp, rim, hh/oh (cut)
808: cb, perc
- random notes on different scales
- couple of notes then get complexity from transforms
transitions: `xf_ cl_ in_jm_`
`echo number interval gain` OR `echoWith number interval func`
```
fast 4 $ randslice 4 $ n "8 4" # s "rave"  # cut 1 -- alternating random slices of two samples
splice "<1 2>*4 3 _ 0*2" $ fast 4 $ randslice 4 $ n "0*2" # s "rave" -- splice a random slice

ghost $ timeLoop 0.125 $ rotL 0.5 $ fast 4 $ randslice 4 $ n "~2 4 0" # s "rave"  # begin 0.25 # end 0.75 # cut 1

```

# Starting points
- euclidean rhythms
- single notes (even slowed down a few times so they only run once a bar?)
- 16th notes with a few changes
# Transitions
- `xf_` - crossfade, `cl_` - clutch, `in_` - interpolate control values, `jm_` - jump on cycle mod of arg
# To use
- samples: rave, hoover, bin(0/1), can, breaks152, feelfx, fm and foo(breakbeats), koy
- tablex (right at the end)
- feel:6
- synths: plaits, supergong
- drum machine: rolandtr909 bd, cp, hh/oh, rim
- drum machine: rolandtr808 perc, cb
# Presets / parameter reminders
- plaits: `s "plaits" # engine 2 # morph 0.6 # timbre 0.5 # harm 0.5 # level 0.9 # lpg 0.5 0.5 # mode 0`
- verb: `verb 0.1 0.1 0.2 0.2` : verb wet time damp smallness. cana
- supergong: defaults are `# voice 0 # decay 1 # accelerate 0`
# Functions
- chop/striate simply for cutting things up, slice/splice for rearranging bits
- bite n pat (cut up and rearrange) -- shuffle n and scramble n (cut up and rearrange randomly)
- inspo: linger, delay, chunk, fix func cond, spreadf,
- inspo: randslice, ghost', ghostWith, timeLoop, slowSqueeze
- `slice num pat` - chop sample without stretching
- `splice num pat` - chop sample with stretching
- `bite num pat` - chop pattern and rearrange by pat, contracting the pattern slices
- `chew num pat` - bite with speed control applied
- `shuffle num`
- `scramble num`

# ideas
