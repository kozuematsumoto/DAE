class WaveSet {

  int num;
  boolean isDead;
  Wave[] waveSet; 

  WaveSet(PVector breakPos, float r, float g, float b, int n) {
    isDead = false;
    num = n;
    waveSet = new Wave[n];

    for (int i = 0; i < num; i++) {
      waveSet[i] = new Wave(breakPos, r, g, b);
    }
  }


  void update() {
  }

  void display() {
    fill(255);
        text(waveCollection.size(), 20, 60);

    //"WAVE ANIMATION HERE!!!!"
    for (int i = 0; i < num; i++) {
      for (int j = 0; j < num; j++) {
        // This if is not to check the distance with itself
        if (i != j) {
          // Get particle 
          Wave w1 = waveSet[i];                    
          Wave w2 = waveSet[j];  

          if (w1.location.dist(w2.location) < 107) {            //87                
            float mapped = map(w1.location.dist(w2.location), 0, 73, 0, 255);  
            stroke(w1.red, w1.green, w1.blue, 80);
            fill(w1.red, w1.green, w1.blue, 80);

            line(w1.location.x, w1.location.y, w2.location.x, w2.location.y);
          }
        }
      }
    }
    noStroke();
  }

  void checkEdges() {
    int counter = 0;
    for (int i = 0; i < num; i++) {
      if (waveSet[i].location.x > width || waveSet[i].location.x < 0 || waveSet[i].location.y > height || waveSet[i].location.y < 0) {
        counter++;
      }
    }
    if (counter == num) {
      isDead = true;
    }
  }
}

