static ArrayList<Wave> waveCollection = new ArrayList<Wave>();

class WaveSystem {
  int num;

  FlowSystem flowsystem;

  WaveSystem() {
  }

  void update() {
    Iterator<Wave> iter = waveCollection.iterator(); // use an iterator to move through our array list - we no longer have to worry about position
    while (iter.hasNext ()) {                                // hasNext returns True if iterator contains another object
      Wave w = iter.next();                              // retrieve next particle and return to temporary object
      if (w.isDead == true) {                                // if our particle is dead remove it
        iter.remove();
        println("Removed! ");
      } else {
        w.update();                                          // if our particle is alive, update it
      }
    }
  }

  void display() {
    Iterator<Wave> iter = waveCollection.iterator();
    while (iter.hasNext ()) {
      iter.next().display();                                             // since we are only calling draw on the particle, we don't need to store in temporary object
    }

    //"WAVE ANIMATION HERE!!!!"
    for (int i = waveCollection.size ()-1; i >= 1; i--) {
      for (int j = 0; j < waveCollection.size ()-1; j++) {
        // This if is not to check the distance with itself
        if (i != j) {
          // Get particle 
          Wave w1 = waveCollection.get(i);                    
          Wave w2 = waveCollection.get(j);  

          // Check if the distance betwen these two particles are closer than 113. If so a line will be drawn between them          
          if (w1.location.dist(w2.location) < 47) {                            
            // Use map to scale distance to color value (0-113 to 0-255)  
            float mapped = map(w1.location.dist(w2.location), 0, 73, 0, 255);  
            stroke(w1.red, w1.green, w1.blue, 80);

            line(w1.location.x, w1.location.y, w2.location.x, w2.location.y);
          }
        }
      }
    }
    noStroke();
  }

  //called to add new particles
  void addParticles(PVector breakPos, float r, float g, float b, int n) {
    num = n;
    for (int i = 0; i < num; i++) {
      waveCollection.add(new Wave(breakPos, r, g, b));
    }

 //   int resolution = int(random(11, 27));
    int resolution = int(random(17, 23));
//    int resolution = int(random(13, 17));
    flowCollection.add( new Flow(resolution));
  }
}

