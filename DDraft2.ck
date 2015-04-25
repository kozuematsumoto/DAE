Hid myHid;

HidMsg hmsg;

// Sound from the sound file
SndBuf myM1 => NRev revM1 => Pan2 panM1 => ADSR env => dac;
SndBuf str_sound => NRev revM2 => Pan2 panM2 => ADSR env2 => dac;

// Set up envelops
env.set(0.01 :: second, 0.002 :: second, 1, 0.01 :: second);
1 => env.keyOn;

env2.set(0.01 :: second, 0.002 :: second, 1, 0.01 :: second);
1 => env2.keyOn;

// Sound file location
string path, filenameM1, str_location, str_filename, fn;
me.dir(-1) => path;

"/PAudio/D4.5.wav" => filenameM1;

path + filenameM1 => filenameM1;
filenameM1 => myM1.read;
myM1.samples() => myM1.pos;



///////Added on Apr. 24\\\\\\\\\\
"/PAudio/" => str_location;

path + str_location => str_location;
///////Till here Apr. 24\\\\\\\\\\\\


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
///// Change on Apr. 25 \\\\\
//		float f;
		float str_from_processing;
///// Till here \\\\\
        // Wait for the osc event 
        oscin => now;

        // If there is message extract them
        while( oscin.recv(msg) != 0) {
            // Check our message address, if position set x, y
            if(msg.address == "/cube/crush") {
                // Extract data
                msg.getInt(0) => x;

				if (x == 1) {
					msg.getFloat(1) => str_from_processing;
///// Added on Apr. 25 \\\\\
			        pitchDetection(str_from_processing);
//					f => sound.freq;

	                if (str_from_processing < 7) {
		                0.2 => str_sound.gain;
	                } else {
		                0.5 => str_sound.gain;
	                }
                 
				    // Move time 
                    0.1::second => now;

                } else if (x == 2) {
		            // Set to play the file from a certain point
		            0=> myM1.pos;         
		
		           // Set up the volume
		            0.5 => myM1.gain;            
		
		            // Move time 
		            0.1::second => now;
				} 
            }
        }
    }
}


spork ~ oscPoller();

int str_from_keyboard;
float freq;
float t;

0 => int device;

// open keyboard; or exit if fail to open
if(!myHid.openKeyboard(device))  {
	<<< "Can't open this device!! ", "Sorry." >>>;
	me.exit();
}

// Main loop where we extract our features
while( true ) {
    myHid => now;

	while(myHid.recv(hmsg)) {
		if(hmsg.isButtonDown()) {
			if(hmsg.which == 21) {
				13 => str_from_keyboard;
			} else if (hmsg.which == 23) {
				12 => str_from_keyboard;
				
			} else if (hmsg.which == 28) {
				11 => str_from_keyboard;
				
			} else if (hmsg.which == 24) {
				10 => str_from_keyboard;
				
			} else if (hmsg.which == 7) {
				9 => str_from_keyboard;
				
			} else if (hmsg.which == 9) {
				8 => str_from_keyboard;
			
			} else if (hmsg.which == 10) {
				7 => str_from_keyboard;
			
			} else if (hmsg.which == 11) {
				6 => str_from_keyboard;
			
			} else if (hmsg.which == 13) {
				5 => str_from_keyboard;
			
			} else if (hmsg.which == 6) {
				4 => str_from_keyboard;
			
			} else if (hmsg.which == 25) {
				3 => str_from_keyboard;
			
			} else if (hmsg.which == 5) {
				2 => str_from_keyboard;
			
			} else if (hmsg.which == 17) {
				1 => str_from_keyboard;
			
			} else { 
				Math.random2(1, 17) => str_from_keyboard;
			
			}
			
///////Modified on Apr. 24\\\\\\\\\\
//			pitchDetection(str) => freq;
//			freq => sound.freq;
			pitchDetection(str_from_keyboard);
/*			
            "" => fn;
			"" => str_filename;

            str_location + fn => str_filename;
	<<< str_filename >>>;
	<<< "fn: ", fn >>>;

            str_filename => str_sound.read;
            str_sound.samples() => str_sound.pos;

		            0=> str_sound.pos;         

		
		           // Set up the volume
		            0 => str_sound.gain;            
		
		            // Move time 
		            0.1::second => now;
*/				
///////Till here Apr. 24\\\\\\\\\\\\

			if (str_from_keyboard < 7) {
				0.5 => str_sound.gain;
			} else {
				0.8 => str_sound.gain;
			}
			
	        oscOut("/string", str_from_keyboard);
            oscOut("/freq", freq);
			
            0.1::second => now; 
				
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
}


//fun float pitchDetection(int s) {
fun void pitchDetection(float s) {
//	float freq;
    "" => fn;
	"" => str_filename;
	// Set Frequencies wit position    
	if (s == 13) {
//		130.81 => freq; //C
//		146.83 => freq; //D 
		185.00 => freq; //F# 
//		0.3 => sound.gain;            
        "F#_l.wav" => fn;
	} else if (s == 12) {
		196.00 => freq; //G 
//		0.3 => sound.gain;            
        "G_l.wav" => fn;
	} else if (s == 11) {
		220.00 => freq; //A 
//		246.94 => freq; //B 
//		0.3 => sound.gain;            
        "A_l.wav" => fn;
	} else if (s == 10) {
		233.08 => freq; //Bb 
//		261.63 => freq; //C 
//		0.3 => sound.gain;            
        "Bb_l.wav" => fn;
	} else if (s == 9) {
		293.67 => freq; //D 
//		0.3 => sound.gain;            
        "D_m.wav" => fn;
	} else if (s == 8) {
//		311.13 => freq; //Eb
		//329.63 => freq; //E
		//349.23 => freq; //F
		369.99 => freq; //F#
//		0.3 => sound.gain;            
        "F#_m.wav" => fn;
	} else if (s == 7) {
//		349.23 => freq; //F 
		392.00 => freq; //G 
//		0.3 => sound.gain;            
        "G_m.wav" => fn;
	} else if (s == 6) {
//		392.00 => freq; //G 
		440.00 => freq; //A 
//		0.1 => sound.gain;            
        "A_m.wav" => fn;
	} else if (s == 5) {
		466.16 => freq; //Bb 
//		523.25 => freq; //C 
//		0.1 => sound.gain;            
        "Bb_m.wav" => fn;
	} else if (s == 4) {
		587.33 => freq; //D 
//		0.1 => sound.gain;            
        "D_h.wav" => fn;
	} else if (s == 3) {
		622.25 => freq; //Eb 
		//359.26 => freq; //E 
		//698.46 => freq; //F 
//		739.99 => freq; //F# 
//		0.1 => sound.gain;            
        "Eb_h.wav" => fn;
	} else if (s == 2 ) {
		2 => s;
//		698.46 => freq; //F 
		783.99 => freq; //G 
//		0.2 => sound.gain;            
        "G_h.wav" => fn;
	} else if (s == 1 ) {
		1 => s;
//		880.00 => freq; //A 
//		932.33 => freq; //Bb 
		1046.5 => freq; //Bb 
//		0.1 => sound.gain;                    
        "Bb_h.wav" => fn;
	}
//	return freq;
//    return fn;
    
	str_location + fn => str_filename;
	<<< str_filename >>>;
	<<< "fn: ", fn >>>;

    str_filename => str_sound.read;
    str_sound.samples() => str_sound.pos;

	0=> str_sound.pos;         
}


