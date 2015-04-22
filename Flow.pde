class Flow {
  // A flow field is a two-dimensional array of PVectors.
  PVector[][] field;
  int cols, rows;
  int resolution;
  boolean isDead;

  Flow(int r) {
    resolution = r;
//    resolution = int( random (13, 14));
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
//    init(int(random(0,5)));
    init();
    isDead = false;
  }

  void init() {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
        field[i][j] = new PVector(sin(theta), cos(theta));
        yoff += 0.1;
      }
      xoff += 0.1;
    }
  }




  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].get();
  }
}

