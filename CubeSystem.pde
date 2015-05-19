class CubeSystem {

  ArrayList<Cube> cubeCollection = new ArrayList<Cube>();

  CubeSystem() {
  }

  void update() {
    Iterator<Cube> iter = cubeCollection.iterator(); 
    int i =0;
    while (iter.hasNext ()) { 
      Cube c = iter.next();  
//      println("c.isDead: " + c.isDead);
      if (c.isDead == true) {  
        iter.remove();
      } else {
        c.update(i);  
        i++;
      }
    }
  }

  void display() {
    fill(255);
    text(cubeCollection.size(), 20, 40);
    Iterator<Cube> iter = cubeCollection.iterator();
    while (iter.hasNext ()) {
      iter.next().display();
    }

    //CUBE ANIMATION HERE
    for (int i=0; i < cubeCollection.size (); i++) {
      Cube cb = cubeCollection.get(i);
      float x = map((cb.velocity.x)/3, 0, TWO_PI, 0, 2);
      float y = map((cb.velocity.y)/3, 0, TWO_PI, -3, 0);
      float z = map((cb.velocity.z)/3, 0, TWO_PI, 0, 5);
      stroke(cb.r, cb.g, cb.b, 50);
      fill(cb.r, cb.g, cb.b, 80);
      pushMatrix(); 
      translate(cb.location.x, cb.location.y, 0); 
      rotateX(x);
      rotateY(y);
      rotateZ(z);
      box(cb.size);
      popMatrix();
    }
  }
  
  //called to add new particles
  void addParticles(float str, float x, float y, float z, float f) {
    cubeCollection.add( new Cube(str, x, y, z, f));
  }
}

