class Wave {

  PVector location;
  PVector velocity;
  PVector acceleration;
  // Maximum speed
  float maxspeed;
  // Now we also have maximum force.
  float maxforce;

  float r;
  boolean isDead;

  float red, green, blue;

  Wave(PVector l, float rr, float gg, float bb) {
    acceleration = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
    location = new PVector(l.x, l.y, l.z);
    red = rr;
    green = gg;
    blue = bb;
    r = 3.0;
    // force; try varying these!
    maxspeed = 3;
    maxforce = 0.1;
    isDead = false;
  }

  // Our standard “Euler integration” motion model
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  // Newton’s second law; we could divide by mass if we wanted.
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  // What else do we need to add?
  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
    desired.normalize();
    // If we are closer than 100 pixels...
    if (d < 100) {

      // according to how close we are.
      float m = map(d, 0, 100, 0, maxspeed);

      desired.mult(m);
    } else {
      // Otherwise, proceed at maximum speed.
      desired.mult(maxspeed);
    }

    // Reynolds’s formula for steering force
    PVector steer = PVector.sub(desired, velocity);

    // Limit the magnitude of the steering force.
    steer.limit(maxforce);

    // Using our physics model and applying the force
    // to the object’s acceleration
    applyForce(steer);
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



  void checkEdges() {
    if (location.x > width || location.x < 0 || location.y > height || location.y < 0) {
      isDead = true;
    }
  }

  void hitTest(Wave w) {
    if (location.dist(w.location) < 1 ) {
      velocity.mult(-1);
      location = new PVector(location.x+5, location.y+5);
    }
  }

  // velocity used to be vel
  void separate (Wave w) {
    // This variable specifies how close is too close.
    float desiredseparation = 6;
    PVector sum = new PVector();  //[bold]
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

