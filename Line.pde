class Line {
  PVector startLoc;
  PVector endLoc;
  float lifespan;
  boolean isDead;

  PVector velocity;
  PVector acceleration;
  float mass;
  float size;
  int topSpeed;
  float r, g, b;

  int soundType;

  float freq;
  float string;

  Line(PVector info) {
    startLoc = info;
    endLoc =  new PVector(info.x, info.y);
    lifespan = 73;
    isDead = false;
    if (startLoc.x == 0) {
      velocity = new PVector (30, random(-7, 7));
    } else {
      velocity = new PVector (-30, random(-7, 7));
    }
  }

  void update() {
    endLoc.add(velocity);
    if (lifespan == 0) {
      isDead = true;
    } else {
      lifespan = lifespan -1;
    }
  }

  void display() {
  }
}

