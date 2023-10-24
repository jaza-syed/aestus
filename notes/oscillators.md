# Continuous oscillators

Oscillators are continuous patterns, which means they don't have any structure,
and must be used with a pattern that does.
For example `d1 $ sound "bd*8" >| pan sine` won't work well, because the `>|`
operator instructs Tidal to take structure from the right, and sine doesn't have
any structure, so Tidal will simply trigger events at a fixed rate
(depending on your configuration, this might be very fast).
`d1 $ sound "bd*8" |> pan sine` is better, because `|>` takes structure from the
left, so eight kick drums will play, with pan values sampled from the sine wave
for each of the eight events.

- scaling operators `range x y <op>` qa
