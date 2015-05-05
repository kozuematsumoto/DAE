import java.util.*;                           


import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

boolean cubeExist;
boolean breakExist;
boolean lineExist;

int num;

//BreakSystem breaksystem;
CubeSystem cubesystem;
FlowSystem flowsystem;
WaveSystem wavesystem;
LineSystem linesystem;


float string;
float freq;
float kotoPitch;

// native osc function      
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/string") == true) {
    string = msg.get(0).floatValue();
  }
  if (msg.checkAddrPattern("/freq") == true) {
    freq = msg.get(0).floatValue();
  }
  if (msg.checkAddrPattern("/kotoPitch") == true) {
    kotoPitch = msg.get(0).floatValue();
  }

//  println(kotoPicth);
  if (string >0 && freq >0 ) {
    float w = random(2, 2);
    cubesystem.addParticles(string, width/w, height/4, 0, freq);
    cubeExist = true;
  }

  if (kotoPitch != 0) {
    println (kotoPitch);
    if (kotoPitch < 243 || kotoPitch > 244) {
      int side;
      int s = int(random(0, 2));

      if (s == 1) {
        side = 0;
      } else {
        side = width;
      }

      float mapped = map(kotoPitch, 150, 1000, 0, height);  
      linesystem.addParticles(new PVector (side, mapped));


 //     linesystem.addParticles(new PVector (side, mapped));
      lineExist = true;
      kotoPitch = 0;
    }
  }
}


void setup() {
  size(1470, 918, P3D);
//  size(1250, 750, P3D);
  //  size(1680, 1050, P3D);
 //     size(displayWidth, displayHeight, P3D);
  frameRate(37);
  smooth();
  noStroke();                              

  oscP5 = new OscP5(this, 12001);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  cubesystem = new CubeSystem();

  flowsystem = new FlowSystem();
  wavesystem = new WaveSystem();
  linesystem = new LineSystem();

  cubeExist = false;
  breakExist = false;
  lineExist = false;  

  num = 17;
}

void draw() {
  //  background(225);
  //  background(196, 246, 254, 20);
  background(0);

  if (breakExist) {

    Iterator<WaveSet> iterw = waveCollection.iterator(); // use an iterator to move through our array list - we no longer have to worry about position

    int i = 0;
    int j = 0;

    while (iterw.hasNext ()) { 
      Flow f = flowCollection.get(j);
      WaveSet ws = iterw.next();      // retrieve next particle and return to temporary object
      ws.checkEdges();
      //println ("here dead?");
      if (ws.isDead == true) { 
        iterw.remove();
        //            println("Removed! ");
      } else {
        for (int k = 0; k<num; k++) {
          Wave wk = ws.waveSet[k];   

          for (int m = 0; m<num; m++) {
            if (m != k ) {
              Wave wm = ws.waveSet[m]; 
              wk.separate(wm);
            }
          }
          //          wk.follow(f);
          wk.update(f);
        }
      }
      i = i+num;
      j++;
      wavesystem.display();
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

      if (cb.soundType == 1) {
        ///// Change on Apr. 25 \\\\\
        //        sendPos(cb.soundType, cb.freq);
        sendPos(cb.soundType, cb.string);
        ///// Till here \\\\\
        //       println("cb.freq: " + cb.freq);
      } else if (cb.soundType == 2) {
        PVector crushPoint = cb.getLocation();
        wavesystem.addParticles(crushPoint, cb.r, cb.g, cb.b, num);
        sendPos(cb.soundType, 0);
        breakExist = true;
      }
    }
    cubesystem.display();
  }

  if (lineExist) {
    linesystem.update();
    linesystem.display();
  }
  flowsystem.update();
}

//void mousePressed() {
//  int side;
//  int s = int(random(0, 2));
//  if (s == 1) {
//    side = 0;
//  } else {
//    side = width;
//  }
//
//  linesystem.addParticles(new PVector (side, random (10, height-10)));
//  lineExist = true;
////  println ("pressed");
//}

///// Change on Apri. 25 \\\\\
//void sendPos(int bounce, float freq) {
void sendPos(int bounce, float str) {
  // create message with address
  OscMessage msg = new OscMessage("/cube/crush"); 

  // add data
  msg.add(bounce);   
  //  msg.add(freq); 
  msg.add(str); 
  //  println("bounce: " + bounce);
  //  println("str: " + str);

  // send message to ChucK
  oscP5.send(msg, myRemoteLocation);
}

/*
  "WHEN PLUCKED" {
 cubesystem.addParticles("SOMETHING FROM SOUND/VOLUME", width/2, height/4, 0);
 }
 */
