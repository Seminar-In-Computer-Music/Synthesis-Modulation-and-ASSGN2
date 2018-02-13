(
s.boot;
Server.local.scope(2);
)
(
SynthDef("Dusty", { arg out = 0;
	var env, d, u, s, t;
	env = Linen.kr(Impulse.kr(0), Rand(0.0, Rand(0.1, 10.3)), Rand(0.01, Rand(0.1, 10.3)), Rand(0.01, Rand(0.1, Rand(0.3, 10.3))), doneAction: Done.freeSelf);
	d = Dust.ar(Rand(0.1, 25.0), 1.5, 0.5);
	u = GbmanN.ar(LFNoise0.kr(Rand(1.0, 20000.0), 1, 0), Rand(0.0, 2.0), Rand(0.0, 2.0), 1, 0);
	s = SinOscFB.ar(LinLin.kr(d, 0.0, 1.0, 50.0, 10000.0), LinLin.kr(u, -1.0, 1.0, 0.0, 1.0), 0.5, 0.9);
	t = Ringz.ar(d, Rand(1000.0, 5000.0), Dust.kr(Rand(0.1, 25.0)), 0.25, 0);
	Out.ar(out,
		Pan2.ar(
			Spring.ar(t, s, 0.5), Rand(-1.0, 1.0), env))}
).add;
SynthDef("Hen", { arg out = 0, amp = 0.001;
	var env, a, b, c;
	a = LFNoise2.kr(Crackle.kr(Dust2.kr(Rand(0, 5), 0.0), 0.2, 0.2));
	b = Spring.kr(a, Rand(0.1, 1.0), 0);
	c = GbmanL.ar(Rand(0, 20500), b, Rand(0, 5));
	env = Linen.kr(Impulse.kr(0), Rand(0.0, Rand(0.01, 0.03)), Rand(0.01, Rand(0.02, 0.04)), Rand(0.01, Rand(0.02, 0.04)), doneAction: Done.freeSelf);
	Out.ar(out,
		Pan2.ar(
			HenonL.ar(Rand(0, 20000), c, a, Dust2.ar(2, 1, 0.5), b), Rand(-1.0, 1.0), env))}
).add;
SynthDef("Pops", { arg out = 0;
    var f, sf, g, h, j, env;
	env = Linen.kr(Impulse.kr(0), Rand(0.0, Rand(0.05, 0.07)), Rand(0.05, Rand(0.0525, 15.0725)), Rand(0.01, Rand(0.05, 0.07)), doneAction: Done.freeSelf);
	sf = LFNoise0.ar(Crackle.kr(Dust2.kr(Rand(0, 50), 0.5), 0.2, 0.2));
	j = RHPF.ar(sf, Rand(1000.0, 2000.0), Dust.kr(0.0, 50.0), 1, 0);
	g = Ball.kr(sf, 1, 0, 0.01);
    f = Ball.kr(sf, g, 0, 0.01);
    f = f * 140 + 500;
	Out.ar(out,
			Pan2.ar(
			SinOscFB.ar(j, f, 0.5, 0.9), Rand(-1.0, 1.0), env))
}).add;
SynthDef("Noise", { arg out = 0;
	var f, sf, g, env;
	env = Linen.kr(Impulse.kr(0), Rand(0.0, Rand(0.03, 0.05)), Rand(0.01, Rand(0.03, 20.05)), Rand(0.01, Rand(0.03, 0.05)), doneAction: Done.freeSelf);
	f = LFNoise2.kr(SampleRate.ir/4, 1.5, 0.5);
	sf = CuspN.ar(SampleRate.ir/4, Rand(-3.0, 3.0), Rand(-3.0, 3.0), Rand(0.5, 1.5));
	g = Ball.kr(f, sf, 0, 0.01);
	g = g * 140 + 1000;
	Out.ar(out,
		Pan2.ar(
			SinOscFB.ar(sf, g, 0.5, 0.9), Rand(-1.0, 1.0), env))
}).add;
SynthDef("blippy", { arg out = 0;
	var b, l, i, pp, y, env;
	env = Linen.kr(Impulse.kr(0), Rand(0.0, Rand(0.03, 0.5)), Rand(0.01, Rand(0.03, 20.05)), Rand(0.01, Rand(0.03, 0.05)), doneAction: Done.freeSelf);
	b = Blip.ar(LFNoise0.ar(Rand(0.01, 1000.0), Rand(0.01, 50.0)));
	l = Blip.ar(GrayNoise.ar(Rand(0.01, 100.0), b));
	i = Blip.ar(Crackle.ar(Dust.kr(b), l));
	pp = Blip.ar(PinkNoise.ar(i, SinOscFB.kr(b, l)));
	y = Blip.ar(RLPF.ar(BrownNoise.ar(pp), b, i));
	Out.ar(out,
		Pan2.ar(
			LPF.ar(Blip.ar(pp, y, 0.5), Rand(0.0, 5000.0)), Rand(-1.0, 1.0), env))
}).add;
SynthDef("gray", { arg out = 0;
	var g, r, a, y, env;
	env = Linen.kr(Impulse.kr(0), Rand(0.0, Rand(0.03, 0.05)), Rand(0.1, Rand(0.3, 20.5)), Rand(0.01, Rand(0.03, 0.05)), doneAction: Done.freeSelf);
	g = Rand(0.01, 100.0);
	r = Rand(0.01, 1000.0);
	a = GrayNoise.ar(g);
	y = SineShaper.ar(SinOsc.ar(r), Dust.kr(5));
	Out.ar(out,
		Pan2.ar(Disintegrator.ar(Blip.ar(LinLin.ar(a, 0.0, 1.0, 50.0, 90000.0), LinLin.ar(y, 0.01, 1000.0, 0.0, 1.0), 0.5), LinLin.kr(g, 0.01, 100.0, 0.0, 0.5), LinLin.kr(r, 0.01, 1000.0, -1.0, 0.5), 0.5), Rand(-1.0, 1.0), env))
}).add;
SynthDef("grain", { arg out = 0;
	var g, r, a, i, n, env;
	g = Rand(0.0, 50.0);
	r = Rand(0.01, 1.0);
	a = Rand(0.01, 90000.0);
	i = Rand(0.0, 512.0);
	n = Rand(0.0, r);
	env = Linen.kr(Impulse.kr(0), Rand(0.0, Rand(0.03, 0.075)), Rand(0.01, Rand(0.05, 0.07)), Rand(0.01, Rand(0.03, 0.05)), doneAction: Done.freeSelf);
	Out.ar(out,
		Pan2.ar(Disintegrator.ar(GlitchRHPF.ar(GrainSin.ar(2, Dust.kr(g), n, a, Rand(-1.0, 1.0), -1, i, 0.5), i, g), r, Dust2.kr(10)).tanh, Rand(-1.0, 1.0)))
}).add;
SynthDef("fuzz", {arg out = 0;
    var ctls, mods, chans, freq, env;
    freq = Dust.kr(Rand(0.1, 25.0), 1.5, 0.5).exprange(200, 310);
    ctls = [
        [freq, 0, 1],
        [freq, 0, 1],
        [Crackle.kr(0.5).exprange(3, 80), 0, 1],
        [GrayNoise.kr(SampleRate.ir/4).exprange(3, 800), 0, 1],
        [Dust.kr(0.5).exprange(3, 800), 0, 1],
        [PinkNoise.kr(0.5).exprange(0.3, 10), 0, 1]
    ];
    mods = [
        { LFNoise0.kr(SampleRate.ir/4).max(0) } ! 6 * LFNoise0.kr(0, 3),
        { LFNoise0.kr(SampleRate.ir/4).max(0) } ! 6 * GrayNoise.kr(0.5),
        { LFNoise0.kr(SampleRate.ir/4).max(0) } ! 6 * LFNoise0.kr(SampleRate.ir/4, 1.5, 0.5),
        { LFNoise1.kr(0.5).max(0) } ! 6 * Dust.kr(Rand(0.1, 25.0), 1.5, 0.5),
		{ LFNoise1.kr(0.5).max(0) } ! 6 * Crackle.kr(1.5),
        { LFNoise1.kr(0.5).max(0) } ! 6 * LFNoise2.kr(0, 3)
    ];
	chans = Limiter.ar(Decimator.ar(FM7.ar(ctls, mods).slice([0, 1]) * -12.dbamp, Rand(0.0, 44100.0), Rand(0.1, 24.0), 0.1), 0.3, 0.01);
		env = Linen.kr(Impulse.kr(0), Rand(0.0, Rand(0.03, 0.05)), Rand(0.1, Rand(0.3, 20.9)), Rand(0.01, Rand(0.03, 0.07)), doneAction: Done.freeSelf);
	Out.ar(out,
		Pan2.ar(chans, Rand(-1.0, 1.0), env))
}).add;
SynthDef("fuzz2", {arg out = 0, amp = 0.001;
    var ctls, mods, chans, freq, env;
    freq = Dust.kr(Rand(0.1, 25.0), 1.5, 0.5).exprange(20, 3100);
    ctls = [
        [freq, 0, 1],
        [freq, 0, 1],
        [Crackle.kr(0.5).exprange(3, 80), 0, 1],
		[GrayNoise.kr(SampleRate.ir/(Rand(0.01, 4.0))).exprange(3, 800), 0, 1],
        [Dust.kr(0.5).exprange(3, 800), 0, 1],
        [PinkNoise.kr(0.5).exprange(0.3, 10), 0, 1]
    ];
    mods = [
		{ LFNoise0.kr(SampleRate.ir/Rand(0.01, 10.0)).max(0) } ! 6 * LFNoise0.kr(0, 3),
        { LFNoise0.kr(SampleRate.ir/Rand(0.01, 10.0)).max(0) } ! 6 * GrayNoise.kr(0.5),
		{ LFNoise0.kr(SampleRate.ir/Rand(0.01, 10.0)).max(0) } ! 6 * LFNoise0.kr(SampleRate.ir/Rand(0.01, 4.0), 1.5, 0.5),
		{ LFNoise1.kr(Rand(0.01, 0.5)).max(0) } ! 6 * Dust.kr(Rand(0.1, 25.0), 1.5, 0.5),
		{ LFNoise1.kr(Rand(0.01, 0.5)).max(0) } ! 6 * Crackle.kr(1.5),
        { LFNoise1.kr(Rand(0.01, 0.5)).max(0) } ! 6 * LFNoise2.kr(50, 3)
    ];
	chans = Limiter.ar(GlitchRHPF.ar(Decimator.ar(FM7.ar(ctls, mods).slice([0, 1]) * -12.dbamp, Rand(0.0, 44100.0), Rand(0.1, 24.0), 0.01), Rand(0.01, 10.0), Rand(0.0, 1.0), 0.125), 0.01, 0.01);
	env = Linen.kr(Impulse.kr(0), Rand(0.125, 2.5), Rand(0.5, Rand(1.5, 5.0)), Rand(0.125, 2.5), doneAction: Done.freeSelf);
	Out.ar(out,
		Pan2.ar(chans, Rand(-1.0, 1.0), env))
}).add;
)
(
~fuzz = Pbind(
	\instrument, "fuzz",
	\dur, Pbeta(0.0, 100.0, 1.0, 1.0, inf),
	\tempo, Pbrown(0.25, 100.0, 0.1, inf),
	\stretch, Ppoisson(10.0, inf),
);
~fuzz2 = Pbind(
	\instrument, "fuzz2",
	\dur, Pbeta(0.0, 1.0, 100.0, 1.0, inf),
	\tempo, Pbrown(0.25, 100.0, 0.1, inf),
	\stretch, Ppoisson(10.0, inf),
	\amp, 0.01,
);
~gray = Pbind(
	\instrument, "gray",
	\dur, Pbeta(0.0, 100.0, 1.0, 1.0, inf),
	\tempo, Pwhite(0.25, 100.0, inf),
	\stretch, Ppoisson(10.0, inf)
);
~grain = Pbind(
	\instrument, "grain",
	\dur, Pbrown(0.01, 100.0, 0.1, inf),
	\tempo, Pbeta(0.0, 100.0, 1.0, 1.0, inf),
	\stretch, Pwhite(0.0, 10.0, inf)
);
~blippy = Pbind(
	\instrument, "blippy",
	\dur, Pwhite(0.01, 100.0, inf),
	\tempo, Pwhite(0.25, 100.0, inf),
	\stretch, Pwhite(0.0, 10.0, inf)
);
~noise = Pbind(
	\instrument, "Noise",
	\dur, Ppoisson(100.0, inf),
	\tempo, Pbrown(0.25, 100.0, 0.1, inf),
	\stretch, Pwhite(0.0, 10.0, inf)
);
~pops = Pbind(
	\instrument, "Pops",
	\dur, Pbeta(0.0, 100.0, 1.0, 1.0, inf),
	\tempo, Pwhite(0.5, 100.0, inf),
	\stretch, Pbrown(0.0, 10.0, 0.1, inf)
);
~dusty = Pbind(
	\instrument, "Dusty",
	\dur, Ppoisson(100.0, inf),
	\tempo, Pbeta(0.0, 100.0, 1.0, 1.0, inf),
	\stretch, Pwhite(0.0, 10.0, inf)
);
~hen = Pbind(
	\instrument, "Hen",
	\dur, Pwhite(0.01, 100.0, inf),
	\tempo, Pbrown(0.01, 100.0, 1.0, inf),
	\stretch, Pbeta(0.0, 10.0, 1.0, 1.0, inf)
);
)
(
r = Routine({
    var w, x, y, z, i, j, k, m;
	i = 0;
	j = 0;
	k = 0;
	m = 0;
	w = 0;
	x = 0;
	y = 0;
	z = 0;
    loop {
        x = rrand(0.0, 10.0);
		if (x < 5.0, {a.play;},{b.stop;});
		if (x < 5.0, {i = i + 1;},{i = i - 1;});
		if(i<= 0.0, {g.stop;},{h.play;});
		if(x > 5.0, {t.play;},{t.stop;});
		x = x + rrand(0.0, rrand(0.01, 100.0));
		x.postln;
		"x".postln;
		i.postln;
		"i".postln;
        x.wait;
		y = rrand(0.0, 10.0);
		if(y < 5.0, {c.play;},{d.stop;});
		if (y < 5.0, {j = j + 1;},{j = j - 1;});
		if(j <= 0.0, {e.stop;}, {f.play;});
		if(y > 5.0, {t.play;},{t.stop;});
		y = y + rrand(0.0, rrand(0.01, 100.0));
		y.postln;
		"y".postln;
		j.postln;
		"j".postln;
		y.wait;
		z = rrand(0.0, 10.0);
		if(z < 5.0, {c.stop;},{g.play;});
		if (z < 5.0, {k = k + 1;},{k = k - 1;});
		if(k<= 0.0, {d.play;},{h.stop;});
		if(z > 5.0, {t.play;},{t.stop;});
		z = z+ rrand(0.0, rrand(0.01, 100.0));
		z.postln;
		"z".postln;
		k.postln;
		"k".postln;
		z.wait;
		w = rrand(0.0, 10.0);
		if(w < 5.0, {a.stop;},{e.play;});
		if (w < 5.0, {m = m + 1;},{m = m - 1;});
		if(m<= 0.0, {b.play;},{f.stop;});
		if(w > 5.0, {t.stop;},{t.play;});
		w = w+ rrand(0.0, rrand(0.01, 100.0));
		w.postln;
		"w".postln;
		m.postln;
		"m".postln;
		w.wait;
    }
})
)
(
a = ~noise.play;
b = ~pops.play;
c = ~dusty.play;
d = ~hen.play;
e = ~blippy.play;
f = ~grain.play;
g = ~gray.play;
h = ~fuzz.play;
t = ~fuzz2.play;
a.play;
a.stop;
b.play;
b.stop;
c.play;
c.stop;
d.play;
d.stop;
e.play;
e.stop;
f.play;
f.stop;
g.play;
g.stop;
h.play;
h.stop;
t.start;
t.stop;
)
(
r.play;
)

