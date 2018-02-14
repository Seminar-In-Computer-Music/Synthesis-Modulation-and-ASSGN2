/****************
Welcome to Loui's Synth Library vol. I !!!
*/


//---------------------SYNTHS--------------------


(
SynthDef(\cascadeFMSynth2, {
	var env=  Env.linen(0.5,0.5,0.5,0.2);

	var modFreq1= LFPar.ar(140,0,EnvGen.kr(env,doneAction: 2));
	var modFreq2 = LFPulse.ar(240,0,EnvGen.kr(env,doneAction: 2));
	var carFreq= Saw.ar(550,0,EnvGen.kr(env,doneAction: 2));
	var added = modFreq1+modFreq2;

	Out.ar(0, added+carFreq.dup);

}).add;
)

a= Synth(\cascadeFMSynth2);
c.play;

(
SynthDef(\cascadeFMSynth, {

	arg freq=140, freq2=40, freq3=350;
	var env=  Env.linen(0.1,0.2,0.5,0.2);

	var modFreq1= SinOsc.ar(freq,0,EnvGen.kr(env,doneAction: 2));
	var modFreq2 = SinOsc.ar(freq2,0,EnvGen.kr(env,doneAction: 2));
	var carFreq= SinOsc.ar(freq3,0,EnvGen.kr(env,doneAction: 2));
	var added = modFreq1+modFreq2;

	Out.ar(0, added+carFreq.dup);

}).add;
)

c= Synth(\cascadeFMSynth);
c.play;



(
SynthDef(\ringModSynth, {
	arg freq=441;

	var env = env = Env.linen(0.1,0.5,1.5,0.5);
	var modFreq= SinOsc.ar(freq,0,EnvGen.kr(env,doneAction: 2));
	var carFreq= SinOsc.ar(20,0,EnvGen.kr(env,doneAction: 2));
	var filtered= Resonz.ar(carFreq*modFreq);

	Out.ar(0, filtered.dup);



}).add;


)


t= Synth(\ringModSynth);
t.play;


(SynthDef(\aSynth, {

	arg roomsize=100, revtime=30, taillevel=0, amp=1;

	var env = env = Env.linen(0.1,0.5,1.5,0.5);
	var modFreq= PinkNoise.ar(EnvGen.kr(env,doneAction: 2));
	var modFreq2= SinOsc.ar(70,0,EnvGen.kr(env,doneAction: 2));
	var carFreq= SinOsc.ar(20,0,EnvGen.kr(env,doneAction: 2));
	var added= modFreq+modFreq2;
	var filtered= Resonz.ar(carFreq*added);
	var gverbed= GVerb.ar(filtered,roomsize,revtime,taillevel:taillevel);


	Out.ar(0, amp*gverbed.dup);



}).add;


)


x= Synth(\aSynth);
x.play;



(SynthDef(\synth3,{arg freq=83, freq2=0.5, mul= 0.1, mul2=0.44,roomsize=0.7 ;
	var env= Env.linen(0.1,0.75,5,0.5);
	var modFreq= SinOsc.ar(freq,0,EnvGen.kr(env,doneAction: 2));
	var carFreq= SinOsc.ar(freq2,0,EnvGen.kr(env,doneAction: 2));


	var added=modFreq+carFreq;
	var gverb= GVerb.ar(added,10);

	Out.ar(0, gverb.dup);



}).add;
)


v= Synth(\synth3);


//---------------------PERCUSSION--------------------

(SynthDef(\filteredKick, { arg freq=60;

	var  pulse= LPF.ar(LFPulse.ar(freq));
	var env= EnvGen.ar(Env.perc(0.01,0.1),doneAction:2);

	Out.ar(0, env*pulse.dup);

}).add;
)

a= Synth(\filteredKick);
a.play;

//HiHAT

(SynthDef(\hiHat, {arg freq=3000;

	var bNoise= HPF.ar(BrownNoise.ar,freq);
	var env= EnvGen.ar(Env.perc(0.01,0.1), doneAction:2);

	Out.ar(0,env*bNoise.dup);

}).add;
)

b= Synth(\hiHat);
b.play;


(SynthDef(\filtered,{arg freq= 1000;

	var modFreq= SinOsc.ar(freq,mul:0.1);
	var carFreq= LPF.ar(BrownNoise.ar,freq);
	var fmWave = modFreq+carFreq;
	var env= EnvGen.ar(Env.perc(0.02,0.3,1,-8));

	Out.ar(0, env*fmWave.dup);

}).add;
)

d= Synth(\filtered);
d.play;


//-----------MODULATION------------------------

//parallelFM

(
SynthDef(\parallelFM, {
	var modFreq1= SinOsc.ar(140,0,2pi);
	var modFreq2= SinOsc.ar(160,0,0.5pi);
	var carFreq= SinOsc.ar(300,0,0.75pi);
	var modFreqs= modFreq1+modFreq2;

	Out.ar(0, modFreqs+carFreq.dup);

}).add;
)

y= Synth(\parallelFM);
y.play;
y.free;


//Simple FM

(
SynthDef(\simpleFM, {

	var modFreq= SinOsc.ar(140,0,2pi);
	var carFreq= SinOsc.ar(150,0,0.75pi);
	var env= EnvGen.ar(Env.asr(1,1,1));

	Out.ar(0, env*modFreq+carFreq.dup);

}).add;
)

x= Synth(\simpleFM);
x.play;
x.free;


//ringMod

(
SynthDef(\ringMod, {

	var modFreq= SinOsc.ar(7,mul:0.5);
	var carFreq= SinOsc.ar(1728,mul:0.5);

	Out.ar(0, modFreq*carFreq.dup);



}).add;


)

z= Synth(\ringMod);
z.play;
