s.boot;
(
SynthDef(\kick, {
	var snd, env;
	snd = SinOsc.ar(40);
	// Env is an envelope *specification* - list of breakpoints
	// EnvGen is an actual synth playing back the envelope at audio or control rate
    // Env.perc(...).ar(..) is a shorthand for EnvGen.ar(Env.perc(..),..)
	env = Env.perc(\att.kr(0.01), \rel.kr(0.1), 1.0);
	snd = snd * env * -15.dbamp;
	OffsetOut.ar(\out.kr(0), snd ! 2);
}).add;
)
