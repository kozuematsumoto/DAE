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
   lifespan = 100;
   isDead = false;
   if (startLoc.x == 0) {
     velocity = new PVector (25, random(-10, 10));
   } else {
     velocity = new PVector (-25, random(-10, 10));
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

