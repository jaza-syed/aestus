(
s.reboot { // server options are only updated on reboot
    // configure the sound server: ahere you could add hardware specific options
    // see http://doc.sccode.org/Classes/ServerOptions.html
    s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
    s.options.memSize = 8192 * 32; // increase this if you get "alloc failed" messages
    s.options.numWireBufs = 64; // increase this if you get "exceeded number of interconnect buffers" messages
    s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
    // s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
	// s.options.numOutputBusChannels = 16; // ABLETON
    s.options.numInputBusChannels = 2; // set this to your hardware output channel size, if necessary
	// LIVE
	// s.options.inDevice = "Blackhole 16ch";
	// s.options.outDevice = "BlackHole 16ch"; // For Ableton
	s.options.sampleRate = 48000;
    s.waitForBoot {
		// two output channels, increase if you want to pan across more channels
        ~dirt = SuperDirt(2, s);
		load("/Users/jsyed/Library/Application Support/SuperCollider/synthdefs/mutable-instruments-synthdefs.scd");
        ~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
		// s.sync; // optionally: wait for samples to be read
		// start listening on port 57120, creating 16 buses
		// ~dirt.start(57120, [0, 2, 4, 6, 8, 10, 12, 14]); // For 8 channels out to ableton
	    ~dirt.start(57120, 0 ! 12);
        // optional, needed for convenient access from sclang:
        (
            ~d1 = ~dirt.orbits[0];
			~d2 = ~dirt.orbits[1];
			~d3 = ~dirt.orbits[2];
            ~d4 = ~dirt.orbits[3];
			~d5 = ~dirt.orbits[4];
			~d6 = ~dirt.orbits[5];
            ~d7 = ~dirt.orbits[6];
			~d8 = ~dirt.orbits[7];
			~d9 = ~dirt.orbits[8];
            ~d10 = ~dirt.orbits[9];
			~d11 = ~dirt.orbits[10];
			~d12 = ~dirt.orbits[11];
        );
		// define global effects for mutable instruments effects
        ~dirt.orbits.do { |x|
            var clouds = GlobalDirtEffect(
				\global_mi_clouds,
				[
					\cloudspitch,
					\cloudspos,
					\cloudssize,
					\cloudsdens,
					\cloudstex,
					\cloudswet,
					\cloudsgain,
					\cloudsspread,
					\cloudsrvb,
					\cloudsfb,
					\cloudsfreeze,
					\cloudsmode,
					\cloudslofi
			]);
            var verb = GlobalDirtEffect(
				\global_mi_verb,
				[
					\verbwet,
					\verbtime,
					\verbdamp,
					\verbhp,
					\verbfreeze,
					\verbdiff,
					\verbgain
			]);
            x.globalEffects = x.globalEffects
              .addFirst(clouds)
              .addFirst(verb);
            x.initNodeTree;
        };
		// load tidal-drum-machines
		~drumMachinesDir = Quarks.all.detect({ |x| x.name == "tidal-drum-machines" }).localPath;
        ~dirt.loadSoundFiles(
			~drumMachinesDir +/+ "machines" +/+ "*" +/+ "*",
			namingFunction: { |x| x.basename.replace("-","")}
		);
		~dirt.loadSoundFiles("/Users/jsyed/samples/raw/*");
    };

    s.latency = 0.5; // increase this if you get "late" messages
};
)

Server.killAll


s.meter
// Restore SC pitch model, with tuningName and scaleName to set scales
// SD pitch model:
// ~n = \none; // sample number or note
// ~octave = 5;
// ~midinote = #{ ~note ? ~n + (~octave * 12) };
// ~freq = #{ ~midinote.value.midicps };
(
~dirt.orbits.do { |x|
	var pitchEvent = Event.partialEvents.pitchEvent.copy;
	pitchEvent.use {
		~freq = {
			~n ? { ~note = ~n }; // interpret n as note (might be also degree)
			~scaleName !? {
				var scale = Scale.at(~scaleName);
				scale !? {
					~scale = scale;
					~tuningName !? {
						var tuning = Tuning.at(~tuningName);
						tuning !? { ~scale = ~scale.copy; ~scale.tuning = tuning };

				}f
			};
			// note: (~degree + ~mtranspose).degreeToKey(~scale, ~stepsPerOctave);
            // midinote: ((~note.value + ~gtranspose + ~root) / ~stepsPerOctave + ~octave) * 12.0;
			(~midinote.value + ~ctranspose).midicps * ~harmonic + ~detune;
		};
	};
	[\freq, \midinote, \octave].do(x.defaultParentEvent.removeAt(_));
	x.defaultParentEvent.parent = pitchEvent;
};
)
