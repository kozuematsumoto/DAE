class Wave {

  PVector location;
  PVector velocity;
  PVector acceleration;

  // Maximum speed
  float maxspeed;

  // Now we also have maximum force.
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
    maxspeed = 3;
    maxforce = 0.18;
    isDead = false;
  }

  // Our standard “Euler integration” motion model
  void update(Flow f) {
    follow(f);
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  // Newton’s second law; we could divide by mass if we wanted.
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void follow(Flow flow) {
    // What is the vector at that spot in the flow field?
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);

    // Steering is desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void separate (Wave w) {
    // This variable specifies how close is too close.
    float desiredseparation = 17;
    PVector sum = new PVector();  
    int count = 0; 

    float d = PVector.dist(location, w.location);
    //println("d: " + d);
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

