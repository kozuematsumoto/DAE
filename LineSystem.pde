
class LineSystem {

  ArrayList<Line> lineCollection = new ArrayList<Line>();
  int num;

  LineSystem() {
  }

  void update() {
    Iterator<Line> iter = lineCollection.iterator(); // use an iterator to move through our array list - we no longer have to worry about position
    while (iter.hasNext ()) {                                // hasNext returns True if iterator contains another object
      Line l = iter.next();                              // retrieve next particle and return to temporary object
      if (l.isDead == true) {                                // if our particle is dead remove it
        iter.remove();
        //println("Removed! ");
      } else {
        l.update();      
      }
    }
  }

  void display() {
    Iterator<Line> iter = lineCollection.iterator();
    while (iter.hasNext ()) {
      iter.next().display();                                             // since we are only calling draw on the particle, we don't need to store in temporary object
    }

    for (int i = 0; i < lineCollection.size (); i++) {
      // Get particle 
      Line l = lineCollection.get(i);

    stroke(255, l.lifespan);
    fill(255);
      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y);
      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y+5);
      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y-5);
      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y+10);
      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y-10);
 
      //println("l.startLoc.x: "+ l.startLoc.x);
      //println("l.startLoc.y: "+ l.startLoc.y);
    }
    noStroke();
  }

  //called to add new particles
  void addParticles(PVector chuckInfo) {
    lineCollection.add(new Line(chuckInfo));
  }
}

