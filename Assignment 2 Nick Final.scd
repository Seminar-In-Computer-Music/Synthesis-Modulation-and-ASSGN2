(
SynthDef(\black,{|amp=0.1, amp2=0.1|
	var modulator, carrier, filt, noise, ring, pan, modulator2, carrier2, filt2, noise2, ring2, pan2;
	modulator = SinOsc.ar(0.02, 0, 5);
	carrier = LFSaw.ar(modulator.abs);
	noise = PinkNoise.ar(carrier);
	filt = LPF.ar(noise, modulator.abs*300.0, 0.2);
	ring = filt+Mix(Ringz.ar(filt, [Line.kr(50, 2000, 120, 1, 0, 0), Line.kr(2000, 50, 120, 1, 0, 0), 920, 300, 456], 1, 0.1));
	pan = Pan2.ar(ring, modulator*0.2);
	Out.ar(0,pan*amp);
	modulator2 = SinOsc.ar(0.02, 0.05, 5);
	carrier2 = LFSaw.ar(modulator2.abs);
	noise2 = PinkNoise.ar(carrier2);
	filt2 = LPF.ar(noise2, modulator2.abs*300.0, 0.2);
	ring2 = filt2+Mix(Ringz.ar(filt2, [Line.kr(50, 2000, 120, 1, 0, 0), Line.kr(2000, 50, 120, 1, 0, 0), 950, 290, 459], 1, 0.1));
	pan2 = Pan2.ar(ring2, modulator2* -0.2);
	Out.ar(0,pan2*amp2)
}).add;

SynthDef(\turq,{|amp=0.1, freq=700, length=2, ppan=0|
	var modulator, carrier, carrier2, rev, pan;
	modulator = SinOsc.ar(0.2, 0, 5);
	carrier = LFSaw.ar(modulator.abs);
	carrier2 = LFTri.ar(freq, 0, carrier)*SinOsc.ar(1000);
	rev = FreeVerb.ar(carrier2, 0.50, 10, 0.5)*EnvGen.kr(Env.new([0.0, 0.5, 0.5, 0.0],length*[0.1, 3.0, 1.0]), doneAction: 2);
	pan = Pan2.ar(rev, ppan);
	Out.ar(0,pan*amp)
}).add;

Pdef(\t,
	Pbind(\instrument,\turq,
		\freq,Prand([600, 700, 800, 900, 1000, 1200, 1500, 2000],inf),
		\length,([1, 1.5, 2, 2.5, 3]),
		\dur,Prand([2, 3, 7, 10, 5, 8, 13],inf),
		\ppan,Prand([-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1],inf)
	)
);


SynthDef(\white,{|amp=0.4, freq=1.0, length=1.0|
	var modulator, carrier, filt, pan;
	modulator = Mix(SinOsc.ar(freq*[200, 500, 900, 700], 0, 1).abs);
	carrier = Mix(SinOsc.ar([200*modulator, 300*modulator, 500*modulator]), 0, 1);
	filt = RHPF.ar(freq*carrier*Crackle.ar(2)*EnvGen.kr(Env.new(amp*[0.0, 0.5, 0.5, 0.0],length*[3.0, 4.0, 3.0]), doneAction:2));
	pan = Pan2.ar(filt, ClipNoise.ar(1.0)*0.5*SinOsc.ar(10, 0, 5).poll(4,"dust"));
	Out.ar(0,pan*amp)
}).add;

Pdef(\w,
	Pbind(\instrument,\white,
		\freq,Prand([1, 2, 3, 4, 5, 6, 7],inf),
		\amp,Prand([0.2, 0.3, 0.25],inf),
		\dur,Prand([10, 9, 15, 7, 13],inf),
		\length,Prand([1, 1.5, 2, 2.5],inf),
	)
);

SynthDef(\orange,{|amp=0.4, freq=300, dur=1.0, ind=5.0, sinin=0.2, ppan= 0|
	var index, sig, pan;
	index = SinOsc.ar(sinin, 0, 10)*ind;
	sig = LFPulse.ar(LFSaw.ar(freq, 0, SinOsc.ar(50), freq*index, 440), 10, 0.5, SinOsc.ar(50))*EnvGen.kr(Env.new([0.0, 0.5, 0.5, 0.0],[0.1, 3.0, 0.2]), doneAction: 2);
	pan = Pan2.ar(sig, ppan);
	Out.ar(0, pan*amp)
}).add;

Pdef(\o,
	Pbind(\instrument,\orange,
		\freq,Prand([100, 200, 300, 400, 500, 600, 700, 800],inf),
		\amp,0.4,
		\dur,Prand([10, 5, 15, 8, 13],inf),
		\sinin,Prand([0.1, 0.2, 0.3, 0.4, 0.5],inf),
		\ind,Prand([1, 2, 3, 4, 5],inf),
		\ppan,Prand([-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1],inf)
	)
);

SynthDef(\yellow,{|amp=0.4, freq=300, dur=1.0, ind=5.0, sinin=0.2, ppan= 0|
	var index, sig, pan, filt, rev;
	index = LFSaw.ar(sinin, 0, 10)*ind;
	sig = SinOsc.ar(Impulse.ar(freq, 0, Impulse.ar(500), freq*index, 440), 10, 0.5, SinOsc.ar(50));
	filt = HPF.ar(sig, 500);
	rev = FreeVerb.ar(filt, 0.75, 10, 0.5)*EnvGen.kr(Env.new([0.0, 0.5, 0.5, 0.0],[0.1, 2.0, 3.0]), doneAction: 2);
	pan = Pan2.ar(rev, ppan);
	Out.ar(0, pan*amp)
}).add;

Pdef(\y,
	Pbind(\instrument,\yellow,
		\freq,Prand([100, 200, 300, 400, 500, 600, 700, 800],inf),
		\amp,0.4,
		\dur,Prand([10, 5, 15, 8, 13],inf),
		\sinin,Prand(10*[0.1, 0.2, 0.3, 0.4, 0.5],inf),
		\ind,Prand([1, 2, 3, 4, 5],inf),
		\ppan,Prand([-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1],inf)
	)
);

SynthDef(\clear,{|amp=0.3, freq=1200, freq2=1000 filtfreq=1100, ppan=0, length=1.0|
	var sig, filt, pan;
	sig = SinOsc.ar(freq*LFTri.ar(freq2), 0, EnvGen.kr(Env.new([0.0, 0.6, 0.1, 0.9, 0.3, 0.5, 0.2, 0.7, 0.0],length*[0.2, 0.9, 0.3, 0.8, 0.9, 0.2, 0.8, 0.6, 3.0]), doneAction: 2));
	filt = RHPF.ar(sig, filtfreq);
	pan = Pan2.ar(filt, ppan);
	Out.ar(0, pan*amp)
}).add;

Pdef(\c,
	Pbind(\instrument,\clear,
		\freq,Prand(2*[1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000],inf),
		\freq2,Prand(2.5*[1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000],inf),
		\filtfreq,Prand(2.8*[1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000],inf),
		\amp,Prand([0.1, 0.2, 0.3, 0.4, 0.5],inf),
		\dur,Prand([10, 5, 1, 4, 0.5, 2, 7, 8, 12],inf),
		\sinind,Prand([0.1, 0.2, 0.3, 0.4, 0.5],inf),
		\ind,Prand([1, 2, 3, 4, 5],inf),
		\length,Prand([1, 2, 3, 4, 5],inf),
		\ppan,Prand([-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1],inf)
	)
);

SynthDef(\hit,{|amp=0.6, freq=1.0, freq2=100.0, ffreq=600 ppan=0, dur=10.0|
	var sig, filt, rev, pan;
	sig = Mix(SinOsc.ar(freq*[40, 70, 100, 150, 300]))*(LFPulse.ar(freq2));
	filt = RLPF.ar(sig, ffreq);
	rev = FreeVerb.ar(filt, 0.8, 10, 0.2)*EnvGen.kr(Env.perc(0.05, 5), doneAction: 2);
	pan = Pan2.ar(rev, ppan);
	Out.ar(0, pan*amp)
}).add;

Pdef(\h,
	Pbind(\instrument,\hit,
		\freq,Prand([0.5, 0.75, 1, 1.5, 2, 2.5],inf),
		\freq2,Prand(100*[0.5, 0.75, 1, 1.5, 2, 2.5],inf),
		\ffreq,Prand(300*[0.5, 0.75, 1, 1.5, 2, 2.5],inf),
		\dur,Prand([5, 10, 12, 7, 13, 15],inf),
		\ppan,Prand([-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1],inf)
	)
);

(
~samps = ["C:/Users/Nicholas/Music/ContactRhythms/c3.wav","C:/Users/Nicholas/Music/ContactRhythms/c2.wav","C:/Users/Nicholas/Music/ContactRhythms/c1.wav"];
~buffers = ~samps.collect {|file| Buffer.read(s,file) } ;
);

SynthDef(\grain,{ arg sampbuf=0,rate=1.0,startPos=0, size=0.1, ppan=0, ffreq=1000;
	var bufz, filt, pan, del, rev;
	bufz = PlayBuf.ar(1,sampbuf,
				rate*BufRateScale.kr(sampbuf),1,
				startPos*BufSamples.kr(sampbuf),1)
			*EnvGen.kr(
				Env([0,0.2,0],[size,size],\sine),
				doneAction: 2);
	filt = Ringz.ar(bufz, ffreq, 1, 0.4);
	del = DelayN.ar(filt, 0.2, 0.5);
	rev = FreeVerb.ar(del, 0.5, 10, 3);
	pan = Pan2.ar(rev, ppan);
	Out.ar(0, pan)
}).add;



Pdef(\g,
	Pbind(\instrument,\grain,
		\sampbuf,~buffers[2],
		\rate,Pwhite(0.5,2.0),
		\startPos,Pn(Pseries(0,40.reciprocal,40)),
		\size,Pbrown(0.01,1,0.05),
		\dur,Pstutter(10,Pseq(((1..20)*0.03).mirror2,inf)),
		\ffreq,Prand(2*[1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000],inf),
		\ppan,Prand([-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1],inf)
));
)

/*play each individually, stop each individually. Synth\black needs ctrl+. to stop and has a nasty click at the beginning
*/

Synth(\black);
Pdef(\c).play;
Pdef(\w).play;
Pdef(\t).play;
Pdef(\o).play;
Pdef(\y).play;
Pdef(\h).play;
Pdef(\g).play;

Pdef(\c).stop;
Pdef(\w).stop;
Pdef(\t).stop;
Pdef(\o).stop;
Pdef(\y).stop;
Pdef(\h).stop;
Pdef(\g).stop;


Pdef(\a,Ppar([Pdef(\c),Pdef(\w),Pdef(\t),Pdef(\o),Pdef(\y),Pdef(\h),Pdef(\g)])).play;
Pdef(\a).stop
