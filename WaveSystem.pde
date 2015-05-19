static ArrayList<WaveSet> waveCollection = new ArrayList<WaveSet>();

class WaveSystem {
  int num;

  FlowSystem flowsystem;
  WaveSystem() {
  }

  void update() {
  }

  void display() {
    Iterator<WaveSet> iter = waveCollection.iterator();
    fill(255);
    text(waveCollection.size(), 20, 60);
    while (iter.hasNext ()) {
      iter.next().display();       
    }
  }

  //called to add new particles
  void addParticles(PVector breakPos, float r, float g, float b, int n) {
    num = n;
      waveCollection.add(new WaveSet(breakPos, r, g, b, n));

    int resolution = int(random(21, 27));
//    int resolution = int(random(11, 27));
//    int resolution = int(random(13, 17));
    flowCollection.add( new Flow(resolution));
  }
}


