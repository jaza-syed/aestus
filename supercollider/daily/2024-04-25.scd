s.boot;

(
SynthDef(\kick, {
	var snd;
	snd = SinOsc.ar(\freq.kr([40,60 ]));
	snd = snd * Env.perc([0.01, 0.02], [0.3, 0.6], [1, 0.5]).ar;
	// final envelope, gain and pan
	snd = snd * Env.perc(0.0001, 1, curve: -2).ar(doneAction: Done.freeSelf,);
	snd = snd * -15.dbamp;
	snd = snd ! 2;
	Out.ar(\out.kr(0), snd);
}).add;
)


Synth(\kick);

// https://www.youtube.com/watch?v=8eAQ0VdW0Cw - kick synthesis tutorial on Volca drum
// Sine wave with envelope
(
SynthDef(\kick1, {
	var snd;
	snd = SinOsc.ar(\freq.kr(40));
	snd = snd * Env.perc(\att.kr(0.01), \rel.kr(1)).ar(doneAction: Done.freeSelf);
	snd = snd * -15.dbamp;
	snd = snd ! 2;
	Out.ar(\out.kr(0), snd);
}).add;
)

Synth(\kick1)

// sine wave with up-down pitch modulation to create click
(
SynthDef(\kick2,
	// args: level, pitch, eg attack, eg release, mod amount, mod rate, mod type, sound source (stick with sine fo
	var snd;
	snd = SinOsc.ar(Env.new([40, 360, 40], [0, \clickDur.kr(0.01), 1], curve: \lin).ar * \freqScale.kr(1));
	snd = snd * Env.perc(\att.kr(0.01), \rel.kr(1)).ar(doneAction: Done.freeSelf);
	snd = snd * -15.dbamp;
	snd = snd ! 2;
	Out.ar(\out.kr(0), snd);
}).add;
)

Synth(\kick2)

// volca layer kick
// main insight: use fast pitch bend at the start to create attack
// single pitch-modulated oscillator: sound character of kick is set
// by balancing mod amount and mod rate - can emphasize transient vs body
(
SynthDef(\volcalayer, {
	// args: level, pitch, eg attack, eg release, mod amount, mod rate,
	// mod type, sound source (stuck at updown and sine for now)
	var pitch = \pitch.kr(36);
	var rel = \rel.kr(1);
	var modenv = Env.new([0, \modamount.kr(240), 0], [0, 1 / \modrate.kr(100), rel]).ar;
	var snd = SinOsc.ar(pitch + modenv);
	snd = snd * Env.perc(\att.kr(0.01), rel).ar(doneAction: Done.freeSelf);
	snd = snd * -15.dbamp * \level.kr(1);
	snd = snd ! 2;
	Out.ar(\out.kr(0), snd);
}).add;
)

Synth(\volcalayer)
Synth(\volcalayer, [\modamount: 480])
Synth(\volcalayer, [\modamount: 1024])
Synth(\volcalayer, [\modamount: 480, \modrate: 50, \rel: 0.25])
Synth(\volcalayer, [\modamount: 36*200, \modrate: 200, \rel: 0.5, \pitch: 48])

(
SynthDef(\volcalayer2, {
	// args: level, pitch, eg attack, eg release, mod amount, mod rate,
	// mod type, sound source (stuck at updown and sine for now)
	var pitch = \pitch.kr(36);
	var rel = \rel.kr(1);
	var modamount = \modamount.kr(240);
	var modenv = Env.new([0, modamount, 0], [0, 1 / \modrate.kr(100), rel]).ar;
	var snd = LPF.ar(VarSaw.ar(pitch + modenv, width: 0.2), modamount*2);
	snd = snd * Env.perc(\att.kr(0.01), rel).ar(doneAction: Done.freeSelf);
	snd = snd * -15.dbamp * \level.kr(1);
	snd = snd ! 2;
	Out.ar(\out.kr(0), snd);
}).add;
)

// Using two layers, you can separate the amount of kick
(
// soft simple body of kick
Synth(\volcalayer, [\modamount: 36, \rel: 0.5]);
Synth(\volcalayer2, [\pitch: 36, \att: 0.005, \level: 0.4, \rel: 0.02, \modrate: 100, \modamount: 36*24]);
)

// fm kick with sinusoidal modulation
(
SynthDef(\volcalayer3, {
	// args: level, pitch, eg attack, eg release, mod amount, mod rate,
	// mod type, sound source (stuck at updown and sine for now)
	var pitch = \pitch.kr(36);
	var rel = \rel.kr(1);
	var modamount = \modamount.kr(240);
	var modenv = (SinOsc.ar(\modrate.kr(8)) + 1) * 0.5 * modamount;
	// var modenv = Env.new([0, modamount, 0], [0, 1 / \modrate.kr(100), rel]).ar;
	var snd = SinOsc.ar(pitch + modenv, width: 0.2);
	snd = snd * Env.perc(\att.kr(0.01), rel).ar(doneAction: Done.freeSelf);
	snd = snd * -15.dbamp * \level.kr(1);
	snd = snd ! 2;
	Out.ar(\out.kr(0), snd);
}).add;
)

(
Synth(\volcalayer3, [\modrate: 48*6, \modamount: 24]);
Synth(\volcalayer, [\modamount: 36, \rel: 0.5]);
Synth(\volcalayer2, [\pitch: 36, \att: 0.005, \level: 0.4, \rel: 0.02, \modrate: 100, \modamount: 36*24]);
)

// cymbal synthesis
// filtered noisy signal with filter and amplitude modulated
// smooth signal with noisy modulation!


