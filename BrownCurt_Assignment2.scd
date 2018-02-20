// Assignment2: SynthDefs &etc.

/*
OMB SynthDef & Pdef
*/

(
SynthDef(\omb, {
	|freq=200, out=0|
	var sig;
	sig = Pan2.ar(SinOscFB.ar(freq, LinCongL.ar(freq/50, 5, 15, 1, 50))
	+ Formant.ar(freq*2, freq*5, freq*1200)
		+ LPF.ar(Gendy5.ar(6, 23, 0.05, 0.5, 150, 800, 0.25, 0.5, 12, 9, Rand(0, 10))
			+ SinOsc.ar(Gendy1.ar(5, 12, 0.07, 0.5, 0.005, 1000, -0.9, 0.8, freq/12, freq*12)))
		* EnvGen.kr(Env.perc(0.0023, 0.5), doneAction:2));
	Out.ar(out, sig)
}).add;
) // compile

Synth(\omb) // test

(~fund = 50;
Pdef(\omb,
	Pbind(
		\instrument, \omb,
		\freq, Prand([~fund, ~fund*8192/4725, ~fund*1024/675, ~fund*896/675, ~fund*224/135, ~fund*175/108], ~fund*156/175, ~fund*15/14, ~fund*63/40, inf),
		\dur, Prand([0.5, 0.25, 0.75, 1, 0.75, 0.5, 0.25, 0.05, 0.05, 0.05], inf),
		\amp, Prand([0.8, 1, 0.5, 0.25, 2], inf)
))
) // compile

Pdef(\omb).play(TempoClock(111/60)).postln; // stops playing after a while, cannot figure out why???


/*
ELEC SynthDef & Pdef
w/ Bonus SynthDefs
*/

(
SynthDef(\elec, {
	|freq=200,out=0|
	var sig;
	sig = Pan2.ar(
		  SinOscFB.ar(freq, LinCongL.ar(MouseX.kr(-50, 50), 5, 15, 1, 50))
	    + Formant.ar(freq*2, freq*5, freq*1200, 0.8)
		+ Formant.ar(freq*64/35, freq*112/75, 90)
		+ Gendy5.ar(0, 0, 0, 0, (MouseY.kr(0.005, 150.0)), MouseX.kr(0.5, 500.0), 0.8, 1,23, 12, 0.8)
		+ SinOscFB.ar(Gendy1.ar(50, 120, 0.5, 00.5, 0.5, 0, 1, 0.2, freq/500, freq*100), MouseY.kr(-50, 50)), MouseX.kr(-0.5, 0.5), 0.75, 0.5, 0.8)
	* EnvGen.kr(Env.perc(MouseX.kr(0.005, 1), 0.5), doneAction:2);
	Out.ar(out, sig)
}).add;
) // compile

Synth(\elec) // test


(~fund = 100; // fun to change fundamental & recompile while playing
Pdef(\elec,
	Pbind(
		\instrument, \elec,
		\freq, Prand([~fund, ~fund*4/3, ~fund*2/3, ~fund/9/8, ~fund*9/8, ~fund*3/2, ~fund*243/128, ~fund-243/256, ~fund*243/265, ~fund*1024/729, ~fund/1024/729, ~fund+1024/729, ~fund -200, ~fund-300], inf),
		\dur, Pslide([1, 0.1, 0.001, 0.1, 0.23, 0.46, 0.89, 1, 0.002, 0.005, 000.6, 2, 0.001, 0.01, 0.1, 0.01, 0.008, 0.5], inf)))
) // compile


Pdef(\elec).play; // play w/ mouse

(
SynthDef(\egen, {
	|freq=100,out=0|
	var sig;
	sig= Pan2.ar(
		Gendy5.ar(0, 0, 0, 0, (MouseY.kr(0, 1500)), MouseX.kr(0.5, 500), 0.8, 1,23, 12, 0.8)
		+ Gendy3.ar(0.7, 1, 0.6, 1, 100, 0.8, 0.5, MouseX.kr(0, 120), MouseY.kr(0,80), 0.8)
	)
	* EnvGen.kr(Env.adsr(0.25, 0.3, 0.4, 0.8, 0.9), inf);
	Out.ar(out,sig)
}).add;
) // compile

Synth(\egen) // test
(
SynthDef(\slam, {
	|freq=100,out=0|
	var sig;
	sig= Pan2.ar(
		SinOscFB.ar(freq*8/5, MouseX.kr(0.05, 10.0))
		+ SinOscFB.ar(freq*7/5), MouseX.kr(0.05, 1.0)
		+ SinOscFB.ar(freq*5/3, MouseX.kr(0.05, 5.0))
	)
	* EnvGen.kr(Env.adsr(0.25, 0.3, 0.4, 0.8, 0.9), inf);
	Out.ar(out,sig)
}).add;
) // compile

Synth(\slam) // test

/* PLAY ELEC */

(
{
	Pdef(\elec).play.postln;
	23.wait;
	Synth(\slam).postln;
	25.wait;
	Synth(\egen).postln;
	20.wait;
	Synth(\slam).postln;
	15.wait;
	Synth(\egen).postln;
	10.wait;
	Synth(\egen).postln;
	5.wait;
	Synth(\slam).postln;
	1.wait;
	Synth(\slam).postln;
	1.wait;
	Synth(\slam).postln;
	5.wait;
	Synth(\egen).postln;
}.fork;
) // Play w/ mouse axis, wait for additional synths



/*
FISH DUO SynthDef & Pdef x2
ratios from Doty - intervals less than 2:1 in the Pythagorean diatonic scale
*/

(
(SynthDef(\fish1, {
	|freq=400, out=0|
	var sig;
	sig = Pan2.ar(SinOsc.ar(freq)
			+ SinOscFB.ar(MouseY.kr(-1500, 150000)+MouseX.kr(-1000, 50000), Gendy1.kr(3, 3, 0.6, 0.24, 40, 1200, 0.8, 0.9, 1, 2, 0.8), Pulse.kr(150), 0.8))
		* EnvGen.kr(Env.perc(MouseX.kr(0.005, 1), MouseY.kr(0.05, 5)), doneAction:2);
	Out.ar(out, sig)
}).add;
)
) // compile

Synth(\fish1) // test synth


(
(~fund = 400;
Pdef(\fish1,
	Pbind(
		\instrument, \fish1,
		\freq, Pseq([~fund, ~fund*112/75, ~fund*64/35, ~fund*525/512, ~fund, ~fund*112/75, ~fund*64/35, ~fund*525/512, ~fund*4/3, ~fund*4/3, ~fund*4/3, ~fund*16/9, ~fund, ~fund, ~fund * 112/75, ~fund*112/75, ~fund*64/35, ~fund*532/512], inf),
	\dur, Prand([0.5, 0.8, 0.25, 1, 0.1, 2, 0.1, 0.2], inf),
	\amp, 0.8))
)
) // compile

Pdef(\fish1).play; // play sequence

(
(
SynthDef(\fish2, {
	|freq=200, out=0|
	var sig;
	sig = Pan2.ar(SinOscFB.ar(freq+MouseY.kr(0, 127), MouseX.kr(0, 25)) + SinOscFB.ar(freq-1+SinOsc.ar(MouseY.kr(0, 127), 0)) + SinOscFB.ar(freq-2+MouseX.kr(0, 127), 0))
	* EnvGen.kr(Env.perc(0.023, 2.5), doneAction:2);
	Out.ar(out, sig)
}).add;
)
) // compile


Synth(\fish2) // test synth

(
(~fund = 100;
Pdef(\fish2,
	Pbind(
		\instrument, \fish2,
		\freq, Prand([~fund, ~fund*9/8, ~fund*81/64, ~fund*256/243, ~fund*1/3, ~fund*3/2, ~fund*16/9, ~fund*1024/729, ~fund*243/128], inf),
	\dur, Prand([0.25, 0.5, 1, 0.05, 0.005, 0.005, 1, 2, 0.002], inf),
	\amp, 0.45))
)
) // compile

Pdef(\fish2).play; // play sequence

/* PLAY FISH */

(
{
	Pdef(\fish2).play.postln;
	15.wait;
	Pdef(\fish1).play.postln;
	15.wait;
	Synth(\fish2).postln;
	0.05.wait;
	Synth(\fish2).postln;
	0.05.wait;
	Synth(\fish2).postln;
	0.05.wait;
	Synth(\fish2).postln;
	0.05.wait;
	Synth(\fish2).postln;
	0.05.wait;
	Synth(\fish2).postln;
	0.05.wait;
	Synth(\fish2).postln;
	0.15.wait;
	Synth(\fish2).postln;
	0.005.wait;
	Synth(\fish2).postln;
	0.0005.wait;
	Synth(\fish1).postln;
	0.005.wait;
	Synth(\fish2).postln;
	0.05.wait;
	Synth(\fish2).postln;
	1.wait;
	Pdef(\fish1).play.postln;
	15.wait;
	Synth(\fish2).postln;
	0.15.wait;
	Synth(\fish2).postln;
	0.15.wait;
	Synth(\fish2).postln;
	0.15.wait;
	Synth(\fish2).postln;
	0.15.wait;
	Synth(\fish2).postln;
	0.15.wait;
	Synth(\fish2).postln;
	0.15.wait;
	Synth(\fish1).postln;
	1.wait;
	Synth(\fish1).postln;
	1.5.wait;
	Synth(\fish1).postln;
	0.5.wait;
	Synth(\fish2).postln;
	2.wait;
	Synth(\fish2).postln;
	0.5.wait;
	Synth(\fish2).postln;
	0.5.wait;
	Pdef(\fish2).play.postln;
	1.wait;
	Pdef(\fish1).play.postln;
}.fork;
) // Play w/ mouse axis, wait for additional synths



/*
SWISHER DUO
ratios from Doty - Seven Limit Lattice
*/

(
(SynthDef(\swisher, {
	|freq=200, out=0|
	var sig;
	sig = Pan2.ar(Pulse.ar(freq, Line.kr(25, 100), 0.8)
		+ Pulse.ar(freq*175/108)
		+ Pulse.ar(SinOsc.ar(80), 0.5, 0.8)
		+ Pulse.ar(freq*175/144)
		+ Pulse.ar(~fund, 50)
		+ SinOscFB.ar(freq/6/5, MouseX.kr(0.05, 5), 0.8)
	    + SinOsc.ar(freq/2/3)
		+ SinOsc.ar(freq*25/18, 5))
	* EnvGen.kr(Env.perc(MouseButton.kr(0.008, 5), MouseY.kr(0.025, 0.25), 0.8, 4), doneAction:2);
	Out.ar(out, sig)
}).add;
)
) // compile

Synth(\swisher) // test synth, play w/ mouse axis & button. . . is there a way to lock the mouse  axis? i.e. could you use mouse click (or shortcut) to 'freeze' the axis and then use the mouse w/o it affecting the Synth?


(
(~fund = 200;
Pdef(\swisher,
	Pbind(
		\instrument, \swisher,
		\freq, Prand([~fund*175/108, ~fund*175/144, ~fund*25/18, ~fund*100/63, ~fund*80/63, ~fund*10/9, ~fund*16/9, ~fund*896/675, ~fund*896/75, ~fund, ~fund*62/32, ~fund], inf),
		\dur, Prand([0.2, 0.3, 0.4, 0.2, 0.5, 1, 0.8, 0.9, 0.002, 0.001, 0.002], inf),
		\amp, 0.5))
)
) // compile

Pdef(\swisher).play(TempoClock(85/60)); // play sequence, mouse button for longer envelope

(
(SynthDef(\swisher2, {
	|freq=200, out=0|
	var sig;
	sig = Pan2.ar(Pulse.ar(freq, Line.kr(1, 100), 0.8)
		+ Pulse.ar(freq*2/3)
		+ Pulse.ar(SinOsc.ar(80), 0.5, 0.8)
		+ Pulse.ar(freq*2/3)
		+ SinOscFB.ar(freq*50/49, MouseY.kr(0.0, 5))
		+ SinOsc.ar(freq*8/7, freq*28/25)
		+ SinOsc.ar(freq*49/48, freq*50/49, SinOsc.kr(MouseY.kr(0.05, 50), 500), 0.5)
		+ SinOsc.ar(freq/8/7)
		+ SinOsc.ar(freq*2/4+MouseX.kr(0.005, 200.0)))
	* EnvGen.kr(Env.perc(MouseX.kr(0.005, 1.0), MouseY.kr(0.005, 1.0), 0.8), doneAction:2);
	Out.ar(out, sig)
}).add;
)
) // compile

Synth(\swisher2) // test synth

(
(~fund = 200;
Pdef(\swisher2,
	Pbind(
		\instrument, \swisher2,
		\freq, Pseq([~fund, ~fund*9/5, ~fund*27/16, ~fund*8/7, ~fund* 35/32, ~fund*4725/4096], inf),
		\dur, Prand([0.25, 0.50, 1, 1, 1, 0.25, 0.25, 0.25, 0.50, 0.008, 0.0008, 0.008, 0.08, 0.8], inf),
		\legato, 0.05,
		\amp, 1))
)
) // compile

Pdef(\swisher2).play(TempoClock(85/60)); // play sequence


/* PLAY SWISHER */

({
Pdef(\swisher).play(TempoClock(85/60)).postln;
	30.wait;
Pdef(\swisher2).play(TempoClock(85/60)).postln;
}.fork;
) // play w/ mouse axis, button for longer envelope

