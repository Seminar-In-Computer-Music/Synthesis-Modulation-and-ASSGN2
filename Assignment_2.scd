
a=(

~freqColl = [441,331,221,111];
~freqColl2 = [41,31,21,11];
~freqColl3 = [441,331,221,111];
Pdef(\voice1,
	Pbind(\instrument, \cascadeFMSynth,
		\freq, Prand(~freqColl,inf),
		\freq2, Prand(~freqColl2,inf),
		\freq3, Prand(~freqColl3,inf),
		\dur, 0.25,
		\legato, Pseq([0.4,0.7,0.5,0.8],inf),
		\amp, 0.25

	)
);
)


Pdef(\voice1).play;
Pdef(\voice1).stop;



b=(

~freqColl = [1441,1331,1221,1111];

Pdef(\voice2,
	Pbind(\instrument, \ringModSynth,
		\freq, Prand(~freqColl,inf),
		\freq2, Prand(~freqColl,inf),
		\freq3, Prand(~freqColl,inf),
		\dur, 0.25,
		\legato, Pseq([0.4,0.7,0.5,0.8],inf),
		\amp, 0.1

	)
);
)


Pdef(\voice2).play;
Pdef(\voice2).stop;



c=(

Pdef(\voice3,
	Pbind(\instrument, \synth3,
		\freq, Pseq([83,183],inf),
		\dur, 7,
		\legato, Pseq([0.5],inf),
		\amp, 0.2

	)
);
)

c=Pdef(\voice3).play;
Pdef(\voice3).stop;




d=(

Pdef(\voice4,
	Pbind(\instrument, \filtered,
		\freq, Pseq([1183,573,573],inf),
		\dur, Pseq([1,0.5,2],inf),
		\amp, 0.2

	)
);
)

Pdef(\voice4).play;
Pdef(\voice4).stop;



e=(

Pdef(\voice5,
	Pbind(\instrument, \aSynth,
		\freq, Pseq([1183,573,573],inf),
		\dur, Pseq([0.5,0.5,2],inf),
		\amp, 1

	)
);
)


Pdef(\voice5).play;
Pdef(\voice5).stop;



Pdef.clear;

t=Ppar([d]).play
t.stop;
u=Ppar([ d,c ]).play
v=Ppar([ e,a ]).play
w=Ppar([ a, b ]).play