	/* define and boot servers */
	~x = Server.new("two",NetAddr("10.0.9.96", 57110));
   ~x.makeWindow;
	//a list of the servers we want to use
	~z = [~x,Server.internal];

	//a basic synth - iterate through our list of servers and send the synth it to each 
	~z.collect({|z|
	SynthDef("sine-cluster",{|freq=100, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0|
		Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar(  [1,1] * freq,0,3 * amp/(((freq)+256))),pan)) * EnvGen.ar(Env.perc(atk,rel, 1,sus),gate, doneAction:2) );}).send(z);
	});
	//set our default server to the remote server
	Server.default = ~x
	
	//try the synth
	~s = Synth("sine-cluster");
	~s.set(\freq,256);
	~s.set(\amp,64);
	~s.set(\atk,0.001);
	~s.set(\rel,3);
	~s.set(\gate,1);
