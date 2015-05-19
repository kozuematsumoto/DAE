static  ArrayList<Flow> flowCollection = new ArrayList<Flow>();

class FlowSystem {

  FlowSystem() {
  }

  void update() {
    Iterator<Flow> iter = flowCollection.iterator(); 
    while (iter.hasNext ()) {  
      Flow f = iter.next();   
      if (f.isDead == true) { 
        iter.remove();
      }
    }
  }
}

