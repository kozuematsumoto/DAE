class BreakSystem {
  // Declare an ArrayList of Particles
  ArrayList<Break> breakCollection = new ArrayList<Break>();

  BreakSystem() {
  }
    
    void update() {
    Iterator<Break> iter = breakCollection.iterator(); // use an iterator to move through our array list - we no longer have to worry about position
    while (iter.hasNext ()) {                                // hasNext returns True if iterator contains another object
      Break b = iter.next();                              // retrieve next particle and return to temporary object
      if (b.isDead == true) {                                // if our particle is dead remove it
        iter.remove();
      } else {
        b.update();                                          // if our particle is alive, update it
      }
    }
  }

  void display() {
    // again using an interator (instead of a for loop) to loop through our
    // particle array list, and call each particles draw() function
    Iterator<Break> iter = breakCollection.iterator();
    while (iter.hasNext ()) {
      iter.next().display();                                             // since we are only calling draw on the particle, we don't need to store in temporary object
                                                                      // next() returns the next particle, so we can call draw directly on it.
    }
//"BREAK ANIMATION HERE!!!!???"
//    for (int i = breakCollection.size ()-1; i >= 1; i--)           // Now we will use nested for loops to iterate through our array list, so we can draw a line between
//    {                                                                 // any particles close to each other.
//      for (int j = 0; j < breakCollection.size()-1; j++)           // We use for loops here so we can check every particle against every other particle
//      {
//        if (i != j) {                                                 // We only want to calculate distance between different particles
//          Particle p1 = breakCollection.get(i);                    // Get particle at first for loop position
//          Particle p2 = particleCollection.get(j);                    // Get particle at second for loop position
//          if (p1.loc.dist(p2.loc) < 100) {                            // Calculate distance between particle locations, if less than 100 draw line
//            float mapped = map(p1.loc.dist(p2.loc), 0, 100, 0, 255);  // use map to scale distance to color value 0-100 to 0-255
//            stroke(255-mapped, 0, 0);                                 // use mapped value to set color
//            line(p1.loc.x, p1.loc.y, p2.loc.x, p2.loc.y);             // draw line
//          }
//        }
//      }
//    }
//    noStroke();
  }

  //called to add new particles
  void addParticles(int amt, PVector breakPos) {
    //loop and create our particles with a bit of randomness...
    for (int i=0; i<amt; i++) {
      PVector rand = new PVector(random(10), random(10));
      breakCollection.add( new Break(PVector.add(breakPos, rand)));
    }
  }
}

