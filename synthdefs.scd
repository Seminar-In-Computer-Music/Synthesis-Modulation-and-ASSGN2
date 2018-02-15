FreqScope.new(400, 200, 0);

//   Parallel FM
(
SynthDef(\parfm,
	{arg
		caramp = 0.35,
		carfreq=440,
		modfreq1=111,
		modfreq2=111,
		moddepth1=10.01,
		moddepth2=10.01,
		dustrate = 10;

		Out.ar([0, 1],
			SinOsc.ar(
				carfreq
				+
			(moddepth1*Ringz.ar(Dust.ar(dustrate), modfreq1, 0.5))
			+
			(moddepth2*Pulse.ar(modfreq2))
				,0, caramp)
)}).play;
)

(
Ndef(\parfm,
	{arg caramp = 0.35, carfreq=440, modfreq1=111, modfreq2=111, moddepth1=10.01, moddepth2=10.01, dustrate = 10;
			SinOsc.ar(carfreq + (moddepth1*Ringz.ar(Dust.ar(dustrate), modfreq1, 0.5)) + (moddepth2*Pulse.ar(modfreq2)),0,[caramp, caramp])
});
)


Ndef(\parfm).play.gui;

// CascadeFM

(
SynthDef(\cascadefm,
	{arg
				caramp = 0.35,
		carfreq=440,
		modamp2=111,
		modfreq2=111,
		modamp1=10.01,
		modfreq1=10.01,
		dustratemod1 = 30,
		dustratecar =  30,
		ringdelaytimecar = 0.5;

		Out.ar([0, 1],
		Ringz.ar(Dust.ar(dustratecar), carfreq
				+
				SinOsc.ar((modfreq2 + Ringz.ar(Dust.ar(dustratemod1), modfreq1, 0.5, modamp1)), 0, modamp2),

				ringdelaytimecar, caramp))}.play)
)

(
Ndef(\cascadefm,
	{arg
		caramp = 0.35,
		carfreq=440,
		modamp2=111,
		modfreq2=111,
		modamp1=10.01,
		modfreq1=10.01,
		dustratemod1 = 30,
		dustratecar =  30,
		ringdelaytimecar = 0.5;

			Ringz.ar(Dust.ar(dustratecar), carfreq
				+
				SinOsc.ar((modfreq2 + Ringz.ar(Dust.ar(dustratemod1), modfreq1, 0.5, modamp1)), 0, modamp2),

				ringdelaytimecar, [caramp, caramp])})
)


Ndef(\cascadefm).play.gui;














		