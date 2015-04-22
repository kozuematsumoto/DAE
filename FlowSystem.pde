static  ArrayList<Flow> flowCollection = new ArrayList<Flow>();

class FlowSystem {

  FlowSystem() {
  }

  void update() {
    Iterator<Flow> iter = flowCollection.iterator(); // use an iterator to move through our array list - we no longer have to worry about position
    while (iter.hasNext ()) {                                // hasNext returns True if iterator contains another object
      Flow f = iter.next();                              // retrieve next particle and return to temporary object
      if (f.isDead == true) {                                // if our particle is dead remove it
        iter.remove();
      }
    }
  }
}

