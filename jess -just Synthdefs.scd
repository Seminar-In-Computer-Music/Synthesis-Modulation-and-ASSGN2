(
SynthDef("playbuf",
	{ arg
		buffer,
		rate=1,
		trigger=1,
		startPos=0,
		loop=1,
		envlen =1,
		pan = 0,
		amp = 1,
		lpf = 6600;
	Out.ar(0,
		HPF.ar(LPF.ar(Pan2.ar(
				PlayBuf.ar(1,buffer, BufRateScale.kr(buffer)*rate,trigger,
					BufFrames.ir(buffer)*startPos, loop),0.0, amp*(EnvGen.ar(Env([0, 1, 0], [0.5, 0.5]), 1, 1, 0, envlen, 2))), lpf, 1), 0050, 1))}).store;

////////////////////////////////////////////////////

SynthDef(\cascadefm,
	{arg
		caramp = 0.35,
		freq=440,
		modamp2=100,
		modfreq2=111,
		modamp1=1.01,
		modfreq1=120.01,
		dustratecar =  30,
		ringdelaytimecar = 0.5,
		envlen = 1;
		Out.ar([0,1],
			Ringz.ar(MoogFF.ar(Dust.ar(dustratecar, 0.1), 4*freq, 2), freq
				+
				SinOsc.ar((modfreq2 + Saw.ar(modfreq1, 0, modamp1)), 0, modamp2),
				ringdelaytimecar,
				caramp*(EnvGen.ar(Env([0, 1, 1, 0], [0.05, 0.2, 0.5]), 1, 1, 0, envlen, 2))))}).store;

//////////////////////////////////////////////////////////

SynthDef(\parfm,
	{arg
		caramp = 0.35,
		carfreq=403,
		modfreq1=1442,
		modfreq2=0023.002,
		moddepth1=2220.01,
		moddepth2=03.01,
		dustrate = 154,
			envlen = 1,
			ringdelay = 0.1;

		Out.ar([0, 1],
			SinOsc.ar(
				carfreq
				+
			(moddepth1*Ringz.ar(Dust.ar(dustrate), modfreq1, ringdelay))
			+
			(moddepth2*Pulse.ar(modfreq2))
					,0, caramp*EnvGen.ar(Env.perc(0.01, 0.4), 1, 1, 0, envlen, 2)
	))}).store;



//////////////////////////////////////////////////////////

SynthDef(\filtered,
	{arg
		freq = 500,
		fmult = 1,
		amount= 1,
		amp = 0.5,
		envlen = 1;
		Out.ar([0, 1],
						HPF.ar(LPF.ar(Saw.ar((freq*fmult) +SinOsc.ar(1, 0, amount), amp*(EnvGen.ar(Env([0, 1, 1, 0], [0.8, 0.5, 0.7]), 1, 1, 0, envlen, 2))), 16900), 50))}).store;


//////////////////////////////////////////////////////////




SynthDef(\pulses,
	{arg
		freq = 400,
		freq2 = 300,
		amp = 0.5,
		envlen = 1,
		panspeed = 0,
		wnoise = 0,
		mult = 1;
		Out.ar([0, 1],
			HPF.ar(Pan2.ar(SinOsc.ar((freq), 0, amp*(EnvGen.ar(Env.perc(0.01, 0.5), 1, 1, 0, envlen, 2))), panspeed), 150));}).store;



//////////////////////////////////////////////////////////


SynthDef(\waves,
	{arg
		freq = 400,
		freqadd = 300,
		trem = 1,
		amp = 0.5,
		envlen = 1,
		lpf = 7000,
		mult = 1;
		Out.ar([0, 1],
			MoogFF.ar(
				Saw.ar([freq, (freq + freqadd)], amp*(EnvGen.ar(Env([0, 1, 1, 0], [0.8, 0.3, 0.8], 'lin'), 1, 1, 0, envlen, 2))), lpf))}).store

)
//////////////////////////////////////////////////////////






//    i = Buffer.alloc(s,s.sampleRate*8.0,2, nil, 9); // a 4 second, 1 channel Buffer

//    ( SynthDef(\recSoundIn ,
//  	{RecordBuf.ar(SoundIn.ar([0, 1]), 9, loop:1) }).play;)




















	