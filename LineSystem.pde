
class LineSystem {

  ArrayList<Line> lineCollection = new ArrayList<Line>();
  int num;

  LineSystem() {
  }

  void update() {
    Iterator<Line> iter = lineCollection.iterator(); 
    while (iter.hasNext ()) {  
      Line l = iter.next();    
      if (l.isDead == true) {     
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
      iter.next().display();
    }

    for (int i = 0; i < lineCollection.size (); i++) {
      // Get particle 
      Line l = lineCollection.get(i);

      stroke(255, l.lifespan);
      fill(255, l.lifespan);

      //      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y);
      //      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y+5);
      //      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y-5);
      //      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y+10);
      //      line(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y-10);
      if (l.startLoc.x == 0) {
        rect(l.startLoc.x, l.startLoc.y+100, l.endLoc.x, l.endLoc.y);
//        rect(l.startLoc.x, l.startLoc.y+100, l.endLoc.x, l.endLoc.y+5);
        rect(l.startLoc.x, l.startLoc.y+100, l.endLoc.x, l.endLoc.y-5);
        //      rect(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y+10);
        //      rect(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y-10);
      } else {
//        rect(l.endLoc.x, l.startLoc.y-100, l.startLoc.x, l.endLoc.y);
        rect(l.endLoc.x, l.startLoc.y-100, l.startLoc.x, l.endLoc.y+5);
//        rect(l.endLoc.x, l.startLoc.y-100, l.startLoc.x, l.endLoc.y-5);
      }
    }
    noStroke();
  }

  //called to add new particles
  void addParticles(PVector chuckInfo) {
    lineCollection.add(new Line(chuckInfo));
  }
}

