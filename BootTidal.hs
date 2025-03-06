
:set -XOverloadedStrings
:set prompt ""

import Sound.Tidal.Context

import System.IO (hSetEncoding, stdout, utf8)
hSetEncoding stdout utf8

tidal <- startTidal (superdirtTarget {oLatency = 0.05, oAddress = "127.0.0.1", oPort = 57120}) (defaultConfig {cVerbose = True, cFrameTimespan = 1/20})

:{
let only = (hush >>)
    p = streamReplace tidal
    hush = streamHush tidal
    panic = do hush
               once $ sound "superpanic"
    list = streamList tidal
    mute = streamMute tidal
    unmute = streamUnmute tidal
    unmuteAll = streamUnmuteAll tidal
    unsoloAll = streamUnsoloAll tidal
    solo = streamSolo tidal
    unsolo = streamUnsolo tidal
    once = streamOnce tidal
    first = streamFirst tidal
    asap = once
    nudgeAll = streamNudgeAll tidal
    all = streamAll tidal
    resetCycles = streamResetCycles tidal
    setCycle = streamSetCycle tidal
    setcps = asap . cps
    getcps = streamGetcps tidal
    getnow = streamGetnow tidal
    xfade i = transition tidal True (Sound.Tidal.Transition.xfadeIn 4) i
    xfadeIn i t = transition tidal True (Sound.Tidal.Transition.xfadeIn t) i
    histpan i t = transition tidal True (Sound.Tidal.Transition.histpan t) i
    wait i t = transition tidal True (Sound.Tidal.Transition.wait t) i
    waitT i f t = transition tidal True (Sound.Tidal.Transition.waitT f t) i
    jump i = transition tidal True (Sound.Tidal.Transition.jump) i
    jumpIn i t = transition tidal True (Sound.Tidal.Transition.jumpIn t) i
    jumpIn' i t = transition tidal True (Sound.Tidal.Transition.jumpIn' t) i
    jumpMod i t = transition tidal True (Sound.Tidal.Transition.jumpMod t) i
    jumpMod' i t p = transition tidal True (Sound.Tidal.Transition.jumpMod' t p) i
    mortal i lifespan release = transition tidal True (Sound.Tidal.Transition.mortal lifespan release) i
    interpolate i = transition tidal True (Sound.Tidal.Transition.interpolate) i
    interpolateIn i t = transition tidal True (Sound.Tidal.Transition.interpolateIn t) i
    clutch i = transition tidal True (Sound.Tidal.Transition.clutch) i
    clutchIn i t = transition tidal True (Sound.Tidal.Transition.clutchIn t) i
    anticipate i = transition tidal True (Sound.Tidal.Transition.anticipate) i
    anticipateIn i t = transition tidal True (Sound.Tidal.Transition.anticipateIn t) i
    forId i t = transition tidal False (Sound.Tidal.Transition.mortalOverlay t) i
    d1 = p 1 . (|< orbit 0)
    d2 = p 2 . (|< orbit 1)
    d3 = p 3 . (|< orbit 2)
    d4 = p 4 . (|< orbit 3)
    d5 = p 5 . (|< orbit 4)
    d6 = p 6 . (|< orbit 5)
    d7 = p 7 . (|< orbit 6)
    d8 = p 8 . (|< orbit 7)
    d9 = p 9 . (|< orbit 8)
    d10 = p 10 . (|< orbit 9)
    d11 = p 11 . (|< orbit 10)
    d12 = p 12 . (|< orbit 11)
    d13 = p 13
    d14 = p 14
    d15 = p 15
    d16 = p 16
    jm1 m = jumpMod 1 m . (# orbit 0)
    jm2 m = jumpMod 2 m . (# orbit 1)
    jm3 m = jumpMod 3 m . (# orbit 2)
    jm4 m = jumpMod 4 m . (# orbit 3)
    jm5 m = jumpMod 5 m . (# orbit 4)
    jm6 m = jumpMod 6 m . (# orbit 5)
    jm7 m = jumpMod 7 m . (# orbit 6)
    xf1 m = xfadeIn 1 m . (# orbit 0)
    xf2 m = xfadeIn 2 m . (# orbit 1)
    xf3 m = xfadeIn 3 m . (# orbit 2)
    xf4 m = xfadeIn 4 m . (# orbit 3)
    xf5 m = xfadeIn 5 m . (# orbit 4)
    xf6 m = xfadeIn 6 m . (# orbit 5)
    xf7 m = xfadeIn 7 m . (# orbit 6)
    in1 m = interpolateIn 1 m . (# orbit 0)
    in2 m = interpolateIn 2 m . (# orbit 1)
    in3 m = interpolateIn 3 m . (# orbit 2)
    in4 m = interpolateIn 4 m . (# orbit 3)
    in5 m = interpolateIn 5 m . (# orbit 4)
    in6 m = interpolateIn 6 m . (# orbit 5)
    in7 m = interpolateIn 7 m . (# orbit 6)
    cl1 m = clutchIn 1 m . (# orbit 0)
    cl2 m = clutchIn 2 m . (# orbit 1)
    cl3 m = clutchIn 3 m . (# orbit 2)
    cl4 m = clutchIn 4 m . (# orbit 3)
    cl5 m = clutchIn 5 m . (# orbit 4)
    cl6 m = clutchIn 6 m . (# orbit 5)
    cl7 m = clutchIn 7 m . (# orbit 6)

    selPF = select
    selPI = squeeze
    selFF = selectF
    selFI = pickF

    degree = pF "degree"
    ctranspose = pF "ctranspose"
    mtranspose = pF "mtranspose"
    gtranspose = pF "gtranspose"
    harmonic = pF "harmonic"
    etune = pF "detune"
    scalename = pS "scaleName"
    tuning = pS "tuningName"
    stepsPerOctave = pI "stepsPerOctave"
    octaveRatio = pF "octaveRatio"
:}

:{
let getState = streamGet tidal
    setI = streamSetI tidal
    setF = streamSetF tidal
    setS = streamSetS tidal
    setR = streamSetR tidal
    setB = streamSetB tidal
:}

:set prompt "tidal> "
:set prompt-cont ""

:script "fm-params.tidal"
:script "mi-ugens-params.tidal"
:script "tdm.tidal"

default (Pattern String, Integer, Double)
