import java.util.*;                           


import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

boolean cubeExist;
boolean breakExist;
int num;

BreakSystem breaksystem;
CubeSystem cubesystem;
FlowSystem flowsystem;
WaveSystem wavesystem;

float string;
float freq;

// native osc function      
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/string") == true) {
    string = msg.get(0).floatValue();
  }
  if (msg.checkAddrPattern("/freq") == true) {
    freq = msg.get(0).floatValue();
  }
  float w = random(2, 2);
  cubesystem.addParticles(string, width/w, height/4, 0, freq);
  cubeExist = true;
}
void setup() {
  size(1250, 750, P3D);
//  size(displayWidth, displayHeight, P3D);
  frameRate(37);
  smooth();
  noStroke();                              

  oscP5 = new OscP5(this, 12001);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  // cubeCollection = new ArrayList<Cube>();
  cubesystem = new CubeSystem();

  breaksystem = new BreakSystem();
  flowsystem = new FlowSystem();
  wavesystem = new WaveSystem();

  cubeExist = false;
  breakExist = false;

  num = 21;
}

void draw() {
  //  background(225);
//  background(196, 246, 254, 20);
  background(0);

  if (breakExist) {
    breaksystem.update();
    breaksystem.display();

    int i = 0;
    int j = 0;

    //    println("waveCollection.size (): " + waveCollection.size ());
    while (i < waveCollection.size ()) {  

      Flow f = flowCollection.get(j);
      for (int k = (0+i); k<(num+i); k++) {
        Wave wk = waveCollection.get(k);    

        for (int m = (0+i); m<(num+i); m++) {
          if (m != k) {
            Wave wm = waveCollection.get(m); 
            wk.separate(wm);
          }
        }
        wk.follow(f);
        wk.update();
        wk.checkEdges();
      }
      i = i+num;
      //      println("iB: " + i);

      j++;
    }
  }

  if (cubeExist) {
      cubesystem.update();
    for (int i=0; i < cubesystem.cubeCollection.size (); i++) {
      Cube cb = cubesystem.cubeCollection.get(i);  //"DOES THIS WORK HERE???"

      float m = cb.mass;
      PVector gravity = new PVector(0, .25*m, 0);
      PVector wind = new PVector(random(-1.5, 1.5), 0, -2*i);
      // Coefficient of Friction
      float c = 0.1;
      // Create our Friction Vector
      PVector friction = cb.velocity.get();
      // Friction works in opposite direction as velocity
      friction.mult(-1);
      // Normalize force to ensure it is less than 1
      friction.normalize();
      // Finish Friction equation by multiplying Friction by Coefficient
      friction.mult(c);
      // Apply friction
      cb.applyForce(friction);
      cb.applyForce(gravity);
      cb.applyForce(wind);

      //      println("iB: " + i);

//      cubesystem.update();
      //      println("i: " + i);

      println("cb.soundTypeA: " + cb.soundType);
      if (cb.soundType == 1) {
      println("cb.soundTypeB: " + cb.soundType);
        // Send the loation info to ChucK to create sound based on the visual information
///// Change on Apr. 25 \\\\\
//        sendPos(cb.soundType, cb.freq);
        sendPos(cb.soundType, cb.string);
///// Till here \\\\\
//       println("cb.freq: " + cb.freq);
      } else if (cb.soundType == 2) {
        PVector crushPoint = cb.getLocation();
        breaksystem.addParticles(int(random(5.8)), crushPoint);
        wavesystem.addParticles(crushPoint, cb.r, cb.g, cb.b, num);
        sendPos(cb.soundType, 0);
        breakExist = true;
      }
    }
      cubesystem.display();
  }

  wavesystem.display();
  flowsystem.update();
}

void mousePressed() {
  //    cubesystem.addParticles("SOMETHING FROM SOUND/VOLUME", width/2, height/4, 0);
  //      cubesystem.addParticles(15, width/2, height/4, 0, 440.0);
  //      cubeExist = true;
  println ("pressed");
}

// OSC function to send position of ship
///// Change on Apri. 25 \\\\\
//void sendPos(int bounce, float freq) {
void sendPos(int bounce, float str) {
  // create message with address
  OscMessage msg = new OscMessage("/cube/crush"); 

  // add data
  msg.add(bounce);   
//  msg.add(freq); 
  msg.add(str); 
  println("bounce: " + bounce);
  println("str: " + str);

  // send message to ChucK
  oscP5.send(msg, myRemoteLocation);
}

/*
  "WHEN PLUCKED" {
 cubesystem.addParticles("SOMETHING FROM SOUND/VOLUME", width/2, height/4, 0);
 }
 */
