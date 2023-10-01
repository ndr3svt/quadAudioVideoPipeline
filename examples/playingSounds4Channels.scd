
s.boot;

s.quit
s.scope

// Define the SynthDef
(
SynthDef(\sine, {
    arg freq=440, amp=0.5, out=0;
    var sig;
    sig = SinOsc.ar(freq) * amp;
    Out.ar(out, sig);
}).add;
)

x = Synth('\sine', [\out,4, \freq, 65]);
y = Synth('\sine', [\out,5, \freq, 35]);
z = Synth('\sine', [\out,4, \freq, 35]);
r = Synth('\sine', [\out,0, \freq, 35]);
r = Synth('\sine', [\out,1, \freq, 42]);






/* Loading sounds */

// identifying the current path of the running process

(thisProcess.nowExecutingPath).postln

// strips the pathname from the file name
(PathName(thisProcess.nowExecutingPath).pathOnly).postln

~pathToSounds = PathName(thisProcess.nowExecutingPath).pathOnly++"testMultipleScreens/data/"
~pathToSounds
~leftSound = Buffer.read(s, ~pathToSounds++"mono2.wav"); // remember to free the buffer later.
~rightSound = Buffer.read(s, ~pathToSounds++"mono1.wav"); // remember to free the buffer later.
~rightSound.free;
 SynthDef(\playS1,{|out=0, bufnum=0, gate=1, rate =1, start=0|
	var sound = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate,1.0, start, loop: 0.0);
	// var env = EnvGen.ar(Env.adsr(0.01,0.153,0.025,0.25),gate,Done.freeSelf); // 2 let's the synth free itself
	var env = EnvGen.ar( Env.perc(0.01,0.5), gate,1.0, doneAction:2);
	Out.ar(out,sound*env);
		// PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop: 1.0)
}).add

(
Tdef(\play,{
	loop{
		x = Synth(\playS1,[\out,[0,1].choose,\bufnum,[0,0].choose,\start,1000,\rate,[0.25,0.5,0.75,1].choose]);
		// x.set(\gate,0);
	[0.5,0.75,0.85,0.25,0.1].choose.wait;
	}
}).play
)
Tdef(\play).play
Tdef(\play).stop

s.meter;
x.set(\gate,0);
x.stop;
x.play
x.stop
x.free

PlayBuf
/* OSC COMMUNICATION BETWEEN PROCESSING AND SUPER COLLIDER*/

// Initialize the OSC Communication
(
o = NetAddr("127.0.0.1", 12000); // The IP Address and the Port Number
fork {
    5.do {
        o.sendMsg("/freq", (300 + (100 * 1)).asInteger);
        1.wait;
    };
};
)










// Initialize OSC Server
(
p = OSCFunc({ |msg, time, addr, recvPort|
    // msg is an array representing the OSC message
    // msg[0] is the address pattern of the message
    // msg[1], msg[2], ... are the arguments of the message
    "OSC Message Received:".postln;
    msg.postln;

    // If you sent a frequency, for example, you might handle it like this:
    if (msg[0] == '/freq', {
        { SinOsc.ar(msg[1] * 1.0) * 0.5 }.play;
    });
}, '/freq', nil, 12344); // Listening on port 12345 for messages with address pattern '/freq'
)



s.scope(9)