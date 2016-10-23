<Cabbage>
form caption("The Crubulator") size(400, 300), colour(80, 10, 0), pluginID("crub")
keyboard bounds(4, 168, 391, 95)
rslider bounds(21, 16, 59, 69), channel("pulsewidth"), range(0.050000000000000002776, 0.94999999999999995559, 0.5, 1, 0.001), text("Pulsewidth"),  colour(238, 110, 4, 255), trackercolour(229, 168, 0, 255), fontcolour(229, 168, 0, 255), textcolour(229, 168, 0, 255), 
vslider bounds(92, 16, 23, 69), channel("attack"), range(0.00001, 5, 0.010000000000000000208, 1, 0.001), text("A"),  colour(238, 110, 4, 255), trackercolour(229, 168, 0, 255), fontcolour(229, 168, 0, 255), textcolour(229, 168, 0, 255), 
vslider bounds(120, 16, 23, 69), channel("decay"), range(0.00001, 5, 0.2000000000000000111, 1, 0.001), text("D"),  colour(238, 110, 4, 255), trackercolour(229, 168, 0, 255), fontcolour(229, 168, 0, 255), textcolour(229, 168, 0, 255), 
vslider bounds(148, 16, 23, 69), channel("sustain"), range(0, 1, 0.6, 1, 0.001), text("S"),  colour(238, 110, 4, 255), trackercolour(229, 168, 0, 255), fontcolour(229, 168, 0, 255), textcolour(229, 168, 0, 255), 
vslider bounds(176, 16, 23, 69), channel("release"), range(0.00001, 5, 1, 1, 0.001), text("R"),  colour(238, 110, 4, 255), trackercolour(229, 168, 0, 255), fontcolour(229, 168, 0, 255), textcolour(229, 168, 0, 255), 
rslider bounds(20, 92, 59, 69), channel("cutoff"), range(40, 10240	, 5120, 0.2999999999999999889, 0.001), text("Cutoff"),  colour(26, 142, 9, 255), trackercolour(229, 168, 0, 255), fontcolour(229, 168, 0, 255), textcolour(229, 168, 0, 255), 
rslider bounds(84, 92, 59, 69), channel("resonance"), range(0, 1, 0, 1, 0.001), text("Resonance"),  colour(26, 142, 9, 255), trackercolour(229, 168, 0, 255), fontcolour(229, 168, 0, 255), textcolour(229, 168, 0, 255), 
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

; instrument will be triggered by keyboard widget
instr 1

; get the control signals from the knobs and sliders
kPulsewidth chnget "pulsewidth"
iAttack chnget "attack"
iDecay chnget "decay"
iSustain chnget "sustain"
iRelease chnget "release"
kCutoff chnget "cutoff"
kResonance chnget "resonance"

; ADSR envelope
kEnv madsr iAttack, iDecay, iSustain, iRelease

; Pulsewidth oscillator 
aOsc vco2 p5, p4, 2, kPulsewidth
aFilt moogladder aOsc, kCutoff, kResonance
aOut compress aFilt, aFilt, -20, 50, 60, 10, 0.0001, 0.4, 0
outs aOut*kEnv, aOut*kEnv
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore>
</CsoundSynthesizer>
