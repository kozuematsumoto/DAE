Hid myHid;

HidMsg hmsg;


// Sound from the visual
SinOsc sound => NRev revM2 => dac;

// Sound from the sound file
SndBuf myM1 => NRev revM1 => Pan2 panM1 => ADSR env => dac;

// Set up envelops
env.set(0.01 :: second, 0.002 :: second, 1, 0.01 :: second);
1 => env.keyOn;

// Sound file location
string path, filenameM1;
me.dir(-1) => path;

"/PAudio/D2.wav" => filenameM1;

path + filenameM1 => filenameM1;
filenameM1 => myM1.read;
myM1.samples() => myM1.pos;

// Osc output
OscOut osc;

// Create osc input
OscIn oscin;

// Set our port from myRemote Location from Processing
12000 => oscin.port;

// Tell OSC In to listen to all 
oscin.listenAll();

// Creat osc message
OscMsg msg;

osc.dest("127.0.0.1", 12001);

// Variables to store location 
int x;

// Polling function to listen for incoming OSC
fun void oscPoller() {
    while(true) {
		float f;
        // Wait for the osc event 
        oscin => now;

        // If there is message extract them
        while( oscin.recv(msg) != 0) {
            // Check our message address, if position set x, y
            if(msg.address == "/cube/crush") {
                // Extract data
                msg.getInt(0) => x;
//	<<< "x", x >>>;
				if (x == 1) {
//	<<< "HEREBBBBB" >>>;
					msg.getFloat(1) => f;
					f => sound.freq;
//	<<< "msg.getFloat(1)", msg.getFloat(1) >>>;
	                if (f > 350) {
		                0.1 => sound.gain;
	                } else {
		                0.3 => sound.gain;
	                }
                 
				    // Move time 
                    0.1::second => now;
//	<<< "HERECCCCC" >>>;
                } else if (x == 2) {
		            // Set to play the file from a certain point
		            0=> myM1.pos;         
		
		           // Set up the volume
		            0.7 => myM1.gain;            
		
		            // Move time 
		            0.1::second => now;
				} 
            }
        }
    }
}


spork ~ oscPoller();
//njjspork ~ oscPoller2();

int str;
float freq;
float t;

0 => int device;

// open keyboard; or exit if fail to open
if(!myHid.openKeyboard(device))  {
	<<< "Can?t open this device!! ", "Sorry." >>>;
	me.exit();
}

// Main loop where we extract our features
while( true ) {
//	<<< "HEREQBBBB!!" >>>;

    myHid => now;
//	<<< "HEREQAAAA!!" >>>;
	while(myHid.recv(hmsg)) {
//	<<< "HERE!!" >>>;
		
		if(hmsg.isButtonDown()) {
			if(hmsg.which == 21) {
				13 => str;
			} else if (hmsg.which == 23) {
				12 => str;
			} else if (hmsg.which == 28) {
				11 => str;
			} else if (hmsg.which == 24) {
				10 => str;
			} else if (hmsg.which == 7) {
				9 => str;
			} else if (hmsg.which == 9) {
				8 => str;
			} else if (hmsg.which == 10) {
				7 => str;
			} else if (hmsg.which == 11) {
				6 => str;
			} else if (hmsg.which == 13) {
				5 => str;
			} else if (hmsg.which == 6) {
				4 => str;
			} else if (hmsg.which == 25) {
				3 => str;
			} else if (hmsg.which == 5) {
				2 => str;
			} else if (hmsg.which == 17) {
				1 => str;
			} else { 
				Math.random2(1, 17) => str;
			}
			
			//    pitchDetection(str) => sound.freq;
			pitchDetection(str) => freq;
			freq => sound.freq;
			if (str < 7) {
				0.3 => sound.gain;
			} else {
				0.5 => sound.gain;
			}
			
	        oscOut("/string", str);
            oscOut("/freq", freq);
//	<<< "Starting" >>>;
//	<<< "freq", freq >>>;
//	<<< "string", str >>>;

            Math.random2f(0.1, 0.5) => t;

            // move time by hop size
            //    hop_size::samp => now; 
            0.1 ::second => now; 
	
		} else {
			0.1:: second => now;
		}
	}
}


// Osc sending function
fun void oscOut(string addr, float val) {
    osc.start(addr);
    osc.add(val);
    osc.send();
///	<<< "addr", addr >>>;
// 	<<< "val", val >>>;
}


fun float pitchDetection(int s) {
	float freq;
	
	// Set Frequencies wit position    
	if (s == 13 || s == 17) {
		130.81 => freq; //C
//		146.83 => freq; //D 
//		185.00 => freq; //F# 
//		0.3 => sound.gain;            
	} else if (s == 12 || s == 16) {
		196.00 => freq; //G 
//		0.3 => sound.gain;            
	} else if (s == 11 || s == 15) {
//		220.00 => freq; //A 
		246.94 => freq; //B 
//		0.3 => sound.gain;            
	} else if (s == 10 || s == 14) {
//		233.08 => freq; //Bb 
		261.63 => freq; //C 
//		0.3 => sound.gain;            
	} else if (s == 9) {
		293.67 => freq; //D 
//		0.3 => sound.gain;            
	} else if (s == 8) {
		311.13 => freq; //Eb
		//329.63 => freq; //E
		//349.23 => freq; //F
//		369.99 => freq; //F#
//		0.3 => sound.gain;            
	} else if (s == 7) {
		349.23 => freq; //F 
//		392.00 => freq; //G 
//		0.3 => sound.gain;            
	} else if (s == 6) {
		392.00 => freq; //G 
//		440.00 => freq; //A 
//		0.1 => sound.gain;            
	} else if (s == 5) {
//		466.16 => freq; //Bb 
		523.25 => freq; //C 
//		0.1 => sound.gain;            
	} else if (s == 4) {
		587.33 => freq; //D 
//		0.1 => sound.gain;            
	} else if (s == 3) {
		622.25 => freq; //Eb 
		//359.26 => freq; //E 
		//698.46 => freq; //F 
//		739.99 => freq; //F# 
//		0.1 => sound.gain;            
	} else if (s == 2 ) {
		2 => s;
		698.46 => freq; //F 
//		783.99 => freq; //G 
//		0.2 => sound.gain;            
	} else if (s == 1 ) {
		1 => s;
//		880.00 => freq; //A 
//		932.33 => freq; //Bb 
		1046.5 => freq; //Bb 
//		0.1 => sound.gain;                    
	}
	return freq;
}


