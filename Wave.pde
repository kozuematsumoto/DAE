class Wave {

  PVector location;
  PVector velocity;
  PVector acceleration;

  float maxspeed;
  float maxforce;

  boolean isDead;

  float red, green, blue;

  Wave(PVector l, float rr, float gg, float bb) {

    acceleration = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
    location = new PVector(l.x, l.y-50, l.z);
    red = rr;
    green = gg;
    blue = bb;

    // force; try varying these!
    maxspeed = 3.5;
    maxforce = 0.1;
    isDead = false;
  }

  void update(Flow f) {
    follow(f);
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void follow(Flow flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void separate (Wave w) {
    float desiredseparation = 11;
    PVector sum = new PVector();  
    int count = 0; 

    float d = PVector.dist(location, w.location);

    if ((d > 0) && (d < desiredseparation)) {
      PVector diff = PVector.sub(location, w.location);
      diff.normalize();
      sum.add(diff); 
      count++;
    }
    if (count > 0) { 
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);

      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);

      applyForce(steer);
    }
  }

  void display() {
  }
}

