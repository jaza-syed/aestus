// Basic superdirt-conventional synthdef
// SynthDef(\elegiac, {
// 	| out, sustain=1, freq=440, speed=1, begin=0, end=1, pan, accelerate, offset, volume|
// 	var env    = Line.ar(1, 0, sustain, doneAction: Done.freeSelf);
// 	var osc    = RLPF.ar(in: SawDPW.ar([freq, freq/2]), freq: SinOsc.ar(pan).range(200,2000));
// 	OffsetOut.ar(out,DirtPan.ar(osc, ~dirt.numChannels, pan, env))
// }).add;

(
SynthDef(\lead, {
	var snd, env;
	snd = SinOsc.ar(\carrier.kr(440) + \depth.kr(1) * SinOsc.ar(\mod.kr(20)));
	env = Env.adsr(attackTime: \att.kr(0.01), decayTime: \dec.kr(0.3), sustainLevel: \sus.kr(1), releaseTime: \rel.kr(1));
	snd = snd * env.ar(Done.freeSelf, \gate.kr(0));
	OffsetOut.ar(\out.kr(0), Pan2.ar(in: snd, pos: \pan.kr(0)));
}).add;
)

x = Synth(\lead, [carrier: 220, depth: 0.25, mod: 33, att:0.05, dec: 1, sus: 0.5, rel: 0.5, gate:1]);
x.set(\mod, 100)
x.set(\gate, 0)

s.freeAll


