

(
b = Buffer.read(s,"/Users/jesstambellini/Desktop/sounds/fbsdf.wav", nil, nil, nil, 1);
c = Buffer.read(s,"/Users/jesstambellini/Desktop/sounds/Untitled.wav", nil, nil, nil, 2);
d = Buffer.read(s,"/Users/jesstambellini/Desktop/sounds/cc chords/FS 1 Violin SESH .wav", nil, nil, nil, 3
);
r = Buffer.read(s,"/Users/jesstambellini/Desktop/sounds/bass/AB 6.wav", nil, nil, nil, 4);
t = Buffer.read(s,"/Users/jesstambellini/Desktop/sounds/bass/b 3.wav", nil, nil, nil, 5);
y = Buffer.read(s,"/Users/jesstambellini/Desktop/sounds/bass/b 5.wav", nil, nil, nil, 6);
	i = Buffer.alloc(s,s.sampleRate*8.0,2, nil, 9);
)
(

{



	10.do({{Pbind(
	\instrument, \filtered,
		\amp, 0.04,
	\freq, Pseq([300.rand, 210, 217], inf),
	\fmult, Pseries(0.2, 0.10, 9),
	\envlen, 01.0,
		\dur, 03.401,).play;}.defer(10.0.rand)});
	1.wait;

Pbind(
	\amp, Pseq([1], 35),
	\buffer, Pseq([d, b, c, d, c, b, c, b, c, b], inf),
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1337*44100, 134*44100, 54440, 2644, 4344*44100, 31], 1)], inf),
	\dur, Pseq(
		[(Pseries(0.2, 0.4, 8)), Prand([0.9, 0.3, 0.6, 0.1, 0.3, 0.71, 2, 1.2, 1], inf)], inf),
	\rate, Pseq([Pseries((1), 10.5.rand, 14)], inf),
	\envlen, Pseq([Pseq(([14.2.rand, 13.131.rand, 14.26.rand, 11.17.rand]/1.2), 1)], inf)).play;



22.wait;


20.do({{Pbind(\instrument, \cascadefm,
	\caramp, 01.6,
	\freq, Pseq([215, 800, 2400, 2480,  770, 190, 201], inf),
	\dustratecar, Pseq([3, 7, 2], inf),
	\ringdelaytimecar, Pseq([132], inf),
	\modfreq1, Pseq([122, 500, 301, 3001], 15),
	\modfreq2, Pseq([42, 700], inf),
	\modamp2, Pseq([112], inf),
	\dur, Pseq([0.62, 0.41, 0.2], inf),
	\envlen, Pseq([00.20, 0.13, 0.2], inf)).play;}.defer(10.0.rand)});



18.do({{Pbind(\instrument, \parfm,
	\dur, Pseq([1.2, 0.2, 1.3, 0.3], 9),
	\envlen, Pseq([0.2, 0.2, 0.3, 0.3], inf),
			\caramp, 0.03,
	\ringdelay, 0.1,
		\carfreq, Pseq([300, 700, 660, 200], inf),
		\modfreq1, Pseq([46, 64], inf),
		\modfreq2, Pseq([4233,344,  35, 7, 2], inf),
		\moddepth1, Pseq([3, 35, 2333, 74, 2], inf),
		\moddepth2, Pseq([322, 7, 122, 42], inf),
		\dustrate, Pseq([3, 7, 2], inf),
	\carfreq, Pseq([67, 464, 220, 100, 88], inf)).play;}.defer(10.0.rand)});

9.5.wait;
//31.8

	Pbind(
	\instrument, \waves,
		\lpf, 400,
		\fold, 20,
		\amp, 09.44,
	\freq, Pseq([470, 1210, 2217, 600]/0.4, inf),
		\freqadd, 60,
	\fmult, Pseries(0.2, 0.10, 9),
	\envlen, 04.0,
		\dur, 0.401,).play;



3.wait;
//34.5
		Pbind(
	\instrument, \waves,
		\lpf, 1000,
		\amp, 0.04,
	\freq, Pseq([800, 1310, 2217, 900]/1.35, inf),
		\freqadd, 6,
	\fmult, Pseries(0.2, 0.10, 9),
	\envlen, 04.0,
		\dur, 0.401,).play;


	5.wait;
//35.5


18.do({{Pbind(
	\amp, Pseq([0.8], 35),
		\lpf, 3000,
	\buffer, Pseq([t, y, r, y, t, r], 2),
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1*44100, 1, 1], 1)], inf),
		\dur, Pwhite(0.01, 0.7),
	\rate, Pwhite(20, 30.7),
	\envlen, Pseq([Pseq(([1.rand, 2.rand, 1.rand, 1.rand]/1.2), 1)], inf)).play;}.defer(2.0.rand)});

		28.do({{(SynthDef(\recSoundIn ,
		{RecordBuf.ar(SoundIn.ar([0, 1]), 9, 0, 2, loop:1) }).play;)}.defer(40.rand)});

	3.wait;
//38.5

		9.do({{Pbind(
	\amp, Pseq([0.4], 35),
	\buffer, i,
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1337*44100, 134*44100, 54440, 2644, 4344*44100, 31], 1)], inf),
	\dur, Pseq(
		[(Pseries(0.2, 0.4, 2)), Prand([0.8, 0.3, 0.6, 0.1, 0.3, 0.71, 2, 1.2, 1], inf)], inf),
	\rate, Pseq([Pseries((0.4), 0.7, 14)], inf),
	\envlen, Pseq([Pseq(([1.2.rand, 1.131.rand, 0.26.rand, 0.67.rand]/1.2), 1)], inf)).play;}.defer(2.rand)});

	18.do({{Pbind(
	\amp, Pseq([1], 35),
	\buffer, Pseq([t, y, r, y, t, r], 2),
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1*44100, 1, 1], 1)], inf),
		\dur, Pwhite(0.8, 1.2),
	\rate, Pwhite(10, 13.7),
	\envlen, Pseq([Pseq(([1.rand, 2.rand, 1.rand, 1.rand]/1.2), 1)], inf)).play;}.defer(2.0.rand)});


	2.do({{Pbind(
	\amp, Pseq([1.605, 1.905], 35),
	\buffer, Pseq([t, t, y, t, y], 8),
		\lpf, 9400,
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1*44100, 1, 1], 1)], inf),
		\dur, Pwhite(0.01, 0.7),
	\rate, Pwhite(0.7, 3.7),
	\envlen, Pseq([Pseq(([2.rand, 1.rand, 1.rand, 2.rand]/1.2), 1)], inf)).play;}.defer(1.0.rand)});


	1.wait;
//41.5

	10.do({{Pbind(
	\instrument, \filtered,
		\amp, 0.015,
	\freq, Pseq([300.rand, 210, 217], inf),
	\fmult, Pseries(2.2, 0.10, 1),
	\envlen, 03.0,
		\dur, 0.01,).play;}.defer(10.0.rand)});


	1.wait;
//42.5


Pbind(\instrument, \pulses,
	\dur, Pseq([Pwhite(0.07, 0.12, 6), Pseq([Rest(1.8.rand)], 1), Pseq([0.12], 8), Pseq([Rest(1.3)], 1)], 3),
	\envlen, 0.1,
	\amp, 0.2,
		\mult, 1,
	\fold, Pseries(2340, 0.1, inf),
	\panspeed, Pseq([-1, 0, 1, 0.1], inf),
	\freq, Pseq([Pseq([1230], 12), Pseq([Pseq([178])], 8), Pseq([Pseq([2120])], 6)], inf)).play;

	18.do({{Pbind(
	\amp, Pseq([0.8, 0.7], 35),
	\buffer, Pseq([t, y, r, y, t, r], 8),
		\lpf, 3800,
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1*44100, 1, 1], 1)], inf),
		\dur, Pwhite(1.3, 1.7),
	\rate, Pwhite(2.7, 3.7),
	\envlen, Pseq([Pseq(([2.rand, 1.rand, 1.rand, 2.rand]/0.8), 1)], inf)).play;}.defer(2.0.rand)});

		4.wait;
	//46.6

	Pbind(\instrument, \cascadefm,
		\caramp, 0.07,
	\freq, Pwhite(1700, 4000, 12),
		\dustratecar, Pseq([5, 30], inf),
	\ringdelaytimecar, Pseq([132], inf),
	\modfreq1, Pseq([1, 53], 20),
	\modfreq2, Pseq([1, 23], inf),
	\modamp2, Pseq([1], inf),
	\dur, Pseq([5.rand], inf),
	\envlen, Pseq([8], inf)).play;


		9.do({{Pbind(\instrument, \pulses,
		\dur, Pseries(0.0007, 0.002, 3900),
	\envlen, 0.1,
		\amp, Pseries(0.00008, 0.001, 23),
		\mult, 1,
	\fold, Pseries(40, 0.1, inf),
	\panspeed, Pseq([1, 0, 1, 0.1], inf),
	\freq, Pseq([Pseq([630], 1), Pseq([Pseq([878])], 1), Pseq([Pseq([920])], 1)], inf)).play;}.defer(0.4.rand)});

	0.4.wait;

	//47

		2.do({{9.do({{Pbind(\instrument, \pulses,
		\dur, Pseries(0.0007, 0.002, 3900),
	\envlen, 0.1,
		\amp, Pseries(0.000001, 0.0001, 163),
		\mult, 1,
	\fold, Pseries(40, 0.1, inf),
	\panspeed, Pseq([1, 0, 1, 0.1], inf),
		\freq, Pseq([Pseq([2230], 1), Pseq([Pseq([3378])], 1), Pseq([Pseq([6320])], 1)], inf)).play;}.defer(0.4.rand)});}.defer(0.8.rand)});



		Pbind(
	\instrument, \waves,
		\lpf, 224,
		\amp, 1.9,
	\freq, Pseq([600, 701, 713, 722, 480], inf),
	\freqadd, Pseries(2, 7, 29),
	\envlen, 01.90,
		\dur, Pseq([0.401, 1.3, 0.2], inf)).play;

	5.wait;
//52
	28.do({{(SynthDef(\recSoundIn ,
		{RecordBuf.ar(SoundIn.ar([0, 1]), 9, 0, 0.4, loop:1) }).play;)}.defer(40.rand)});

	//    ( SynthDef(\recSoundIn ,
//  	{RecordBuf.ar(SoundIn.ar([0, 1]), 9, loop:1) }).play;)

	/*
	12.do({{Pbind(
	\amp, Pseq([0.6], 35),
	\buffer, i,
		\lpf, 8000,
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1337*44100, 134*44100, 54440, 2644, 4344*44100, 31], 1)], inf),
	\dur, Pseq(
		[(Pseries(0.2, 0.4, 2)), Prand([0.8, 0.3, 0.6, 0.1, 0.3, 0.71, 2, 1.2, 1], inf)], inf),
	\rate, Pseq([Pseries((0.3), 0.5, 14)], inf),
	\envlen, Pseq([Pseq(([0.2.rand, 0.131.rand, 0.26.rand, 0.17.rand]/1.2), 1)], inf)).play;}.defer(25.rand)});

	*/

		10.do({{Pbind(
	\amp, Pseq([0.3], 35),
	\buffer, i,
		\lpf, 2000,
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1337*44100, 134*44100, 54440, 2644, 4344*44100, 31], 1)], inf),
	\dur, Pseq(
		[(Pseries(0.2, 0.4, 2)), Prand([0.8, 0.3, 0.6, 0.1, 0.3, 0.71, 2, 1.2, 1], inf)], inf),
	\rate, Pseq([Pseries((0.3), 0.5, 14)], inf),
	\envlen, Pseq([Pseq(([1.2.rand, 1.131.rand, 1.26.rand, 1.17.rand]/1.0), 1.2)], inf)).play;}.defer(25.rand)});

	10.wait;
	//62

			15.do({{Pbind(
	\amp, Pseq([0.3], 35),
	\buffer, i,
		\lpf, 2000,
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1337*44100, 134*44100, 54440, 2644, 4344*44100, 31], 1)], inf),
	\dur, Pseq(
		[(Pseries(0.2, 0.4, 2)), Prand([0.8, 0.3, 0.6, 0.1, 0.3, 0.71, 2, 1.2, 1], inf)], inf),
	\rate, Pseq([Pseries((0.3), 0.5, 14)], inf),
	\envlen, Pseq([Pseq(([2.2.rand, 1.131.rand, 1.26.rand, 1.17.rand]/1.4), 1)], inf)).play;}.defer(8.rand)});

	5.wait;
	//67

		15.do({{Pbind(
	\amp, Pseq([0.3], 35),
	\buffer, i,
		\lpf, 2000,
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1337*44100, 134*44100, 54440, 2644, 4344*44100, 31], 1)], inf),
	\dur, Pseq(
		[(Pseries(0.2, 0.4, 2)), Prand([0.8, 0.3, 0.6, 0.1, 0.3, 0.71, 2, 1.2, 1], inf)], inf),
	\rate, Pseq([Pseries((1.2), 0.5, 14)], inf),
	\envlen, Pseq([Pseq(([2.2.rand, 1.131.rand, 1.26.rand, 1.17.rand]/2.4), 1)], inf)).play;}.defer(8.rand)});

		5.wait;


		15.do({{Pbind(
	\amp, Pseq([0.3], 35),
	\buffer, i,
		\lpf, 2000,
	\instrument, \playbuf,
	\startPos, Pseq([Pseq([1*44100, 2*44100, 4*44100, 31], 1)], inf),
	\dur, Pseq(
		[(Pseries(0.2, 0.4, 2)), Prand([0.8, 0.3, 0.6, 0.1, 0.3, 0.71, 2, 1.2, 1], inf)], inf),
	\rate, Pseq([Pseries((1.2), 0.5, 14)], inf),
	\envlen, Pseq([Pseq(([2.2.rand, 1.131.rand, 1.26.rand, 1.17.rand]/2.4), 1)], inf)).play;}.defer(8.rand)});




}.fork
)

