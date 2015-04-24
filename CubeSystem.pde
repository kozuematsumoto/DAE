class CubeSystem {
  // Declare an ArrayList of Particles
  ArrayList<Cube> cubeCollection = new ArrayList<Cube>();

  CubeSystem() {
  }

  void update() {
    Iterator<Cube> iter = cubeCollection.iterator(); // use an iterator to move through our array list - we no longer have to worry about position
    int i =0;
    while (iter.hasNext ()) {                                // hasNext returns True if iterator contains another object
      Cube c = iter.next();                              // retrieve next particle and return to temporary object
//      println("c.isDead: " + c.isDead);
      if (c.isDead == true) {  
        iter.remove();
      } else {
        c.update(i);        // if our particle is alive, update it
        i++;
      }
    }
  }

  void display() {
    // again using an interator (instead of a for loop) to loop through our
    // particle array list, and call each particles draw() function
    Iterator<Cube> iter = cubeCollection.iterator();
    while (iter.hasNext ()) {
      iter.next().display();                                             // since we are only calling draw on the particle, we don't need to store in temporary object
      // next() returns the next particle, so we can call draw directly on it.
    }
    //CUBE ANIMATION HERE
    for (int i=0; i < cubeCollection.size (); i++) {
      Cube cb = cubeCollection.get(i);
      float x = map((cb.velocity.x)/3, 0, TWO_PI, 0, 2);
      float y = map((cb.velocity.y)/3, 0, TWO_PI, -3, 0);
      float z = map((cb.velocity.z)/3, 0, TWO_PI, 0, 5);
      stroke(cb.r, cb.g, cb.b, 50);
      fill(cb.r, cb.g, cb.b, 80);
      pushMatrix();                          // pushes current coordinate system to the stack - making all changes to the coordinate system local
      translate(cb.location.x, cb.location.y, 0); 
      rotateX(x);
      rotateY(y);
      rotateZ(z);
      box(cb.size);
      popMatrix();
    }
  }
  //called to add new particles
  // Connect with chuck!!!
  void addParticles(float m, float x, float y, float z, float f) {
    cubeCollection.add( new Cube(m, x, y, z, f));
  }
}

