//BUFFERS


~glassy = Buffer.read(s, "C:/Users/Daniel/Documents/Ableton/User Library/Presets/Instruments/Max Instrument/Firth Contact Project/Samples/Processed/Consolidate/1 8-Audio.wav")

{PlayBuf.ar(1, ~glassy, 7)}.play

{PlayBuf.ar(1, ~buff1, , loop: 1)}.play

~glass2 = Buffer.read(s, "C:/Users/Daniel/Documents/Ableton/User Library/Samples/Processed/Crop/1 Glass Samples-3.wav")

{PlayBuf.ar(1, ~glass2, 0.4, loop: 1)}.play


///////////////////////////



//SynthDefs


(
SynthDef(\glassy,{ arg out=0,bufnum=0,rate=(4),trigger=1,startPos=0,loop=0;
	Out.ar(out,
		Pan2.ar(
			PlayBuf.ar(1,~glassy, BufRateScale.kr(~glassy)*rate,trigger,
				BufFrames.ir(bufnum)*startPos, loop),0.0)
	)
}).add;






SynthDef(\glass2,{ arg out=0,bufnum=0,rate=(0.5),trigger=1,startPos=0,loop=0;
	Out.ar(out,
		Pan2.ar(
			PlayBuf.ar(1,~glass2, BufRateScale.kr(~glass2)*rate,trigger,
				BufFrames.ir(bufnum)*startPos, loop),0.0)
	)
}).add;








SynthDef(\wow, {
	var sig = SinOsc.ar( [55,110, 490], 0, Env.triangle(0.4,4).kr(doneAction: 2));
	Out.ar(0,sig)
}).add;





SynthDef(\boop, {
	var sig = SinOsc.ar( [88,90,100,102],0, Env.perc(0.01,1).kr(doneAction: 2));
	Out.ar(0,sig)
}).add;



SynthDef(\swoo, {
	var sig = SinOsc.ar( [88,100,91], 0, Env.linen(0.01,0.5,0.5).kr(doneAction: 2));
	Out.ar(0,sig)
}).add;




(
SynthDef(\kick, {
			arg freq=880, gate=1, amp=0.09, source, pan = 0.0 ;
			source =
			Pan2.ar(
			SinOsc.ar(EnvGen.kr(Env.perc(0.0001, 0.2, 1, -200), gate, 1000, 45, doneAction:2), 1, 1) +
			((BPF.ar([WhiteNoise.ar(8),WhiteNoise.ar(8)],EnvGen.kr(Env.perc(0.001, 0.25, 0.5, -200), gate, 6000, 70), 1.5)).distort * Line.kr(0.3,0,0.1))
			*
			EnvGen.kr(Env.perc(0.001, 0.22, amp, 8)),0);
			Out.ar(0, source);
		})
).add;







SynthDef(\hat, {
			arg freq=110, gate=1, amp=0.2, source, pan = 0.0 ;
			source =
			Pan2.ar(BPF.ar(LFPulse.ar(BPF.ar(WhiteNoise.ar(freq),freq,0.1) * freq + 5500, amp),7000,amp) * EnvGen.kr(Env.perc(0.01, 0.4, 0.5, -6), doneAction:2),0);
			Out.ar(0, source);
}).add;








SynthDef(\chordminor, {
	var sig = SinOsc.ar(midicps([52,67,59]))* (Env.perc(0.01, 0.4,1).kr(doneAction: 2));
	Out.ar(0, sig)
}).add;
)


(
var a, b, c, d;
a = Ppar([

	Pbind(
	\instrument,\kick,
	\degree, Pseq([0,1,2,3],7.5),
	\amp, 0.2,
	\dur, 1),


	Pbind(
	\instrument,\hat,
	\degree, Pseq([0,1,2,3],32),
	\amp, Pexprand(0.09, 0.1, inf),
	\dur, 1/4),

	Pbind(
	\instrument,\wow,
	\degree, Pseq([0,1,2,3],2),
	\amp, 0.05,
	\dur, 4),

]);
b = Ppar([

	Pbind(
	\instrument,\kick,
	\degree, Pseq([0,1,2,3],4),
	\amp, Pexprand(0.09, 0.1, inf),
	\dur, 2),

	Pbind(
	\instrument,\chordminor,
	\degree, Pseq([0,1,2,3],4),
	\amp, 0.005,
	\dur, 1/2),

	Pbind(
	\instrument,\glassy,
	\degree, Pseq([0],1),
	\amp, 0.01,
	\dur, 1/2),

]);
c = Ppar([

	Pbind(
	\instrument,\glass2,
	\degree, Pseq([0,1,2,3],8),
	\amp, Pexprand(0.09, 0.1, inf),
	\dur, 1/8),

	Pbind(
	\instrument,\hat,
	\degree, Pseq([0,1,2,3],16),
	\amp, Pexprand(0.09, 0.1, inf),
	\dur, 1/2),

	Pbind(
	\instrument,\boop,
	\degree, Pseq([0,1,2,3],2),
	\amp, 0.05,
	\dur, 4),

	Pbind(
	\instrument,\swoo,
	\degree, Pseq([0,1,2,3],1),
	\amp, 0.05,
	\dur, 8),

]);

d= Pseq([a,b,c]);
d.play(TempoClock(120/60));
)





//////////MODULATION//////////
(
{
var modf, ind;

modf= MouseX.kr(1,440, 'exponential');
ind=MouseY.kr(0.0,10.0);

Saw.ar(110, SinOsc.ar(modf,0,modf*ind),0.25)
}.play
)














































