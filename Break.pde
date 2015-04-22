//A simple Particle class that defines one particle object

class Break {
  PVector location;     // stores the particles XY position on the screen 
  PVector velocity;     // stores the particles speed of travel
  float size;       // radius (size) of the particle - this will be scaled by age
  float radius;    // store the starting size of particle
  float decay;     // stores the rate at which particles slow down over time

  int age;         // the age (in frames) of the particle
  int lifeSpan;    // paricles life span (how long it can live)
  boolean isDead;  // flag which the ParticleSystem checks to see if it should update or remove the particle
  float ageRad;    // float used to modulate the radius over time in relationship to lifespan

  Break(PVector l) {
    location = l; 
    velocity = new PVector(random(-1, 1), random(-1, 1)); // random speed of travel (play with these)
    decay = 0.95;                                    // how quickly the particles slow down (play with this) - need to multiply velocity to use
    age = 0;                                         // initial age is 0
    lifeSpan = (int)random(550, 1250);               // randomize lifeSpan so each particles dies at slightly different times
    isDead = false;                                  // particle starts alive
    radius = 10.0;                                   // size of our particle
  }

  // update is where all of the particles properties are updated
  // before drawing
  void update() {
    age++;                                            // every frame we update the particles age
    ageRad = 1.0 - (age / (float)lifeSpan);           // update and modulate radius based on age over lifeSpan
//    rad = radius * ageRad;                            // scale the radius
    location.add(velocity);                                     // move particle
    velocity.mult(decay);                                  // uncomment to have particles slow over time

    // check if the age is greater than it's life span, OR if particle is offscreen
    if (age > lifeSpan || location.x > width || location.y > height || location.x < 0 || location.y < 0) {
      isDead = true; // if so, declare particle dead so we can remove it
    }
  }

  void display() {
  }
}

