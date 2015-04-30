class Cube {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float size;
  int topSpeed;
  float r, g, b;
  int bounceNumber;
  int maxBounceNumber;
  boolean isDead;
  int soundType;

  float freq;
  float string;

  Cube(float str, float x, float y, float z, float f) {
    mass = str;
    //    size = random(17, 70); //"Do somewhat relate to Mass"????
    size = (str*1.5)+15; //"Do somewhat relate to Mass"????
    location = new PVector(x, y, z);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    freq = f;
    string = str;
    println("freq: " + freq);
    changeColor();
    bounceNumber = 0;
    maxBounceNumber = int(random(4, 9));
    //    maxBounceNumber = 1;
    isDead = false;
    soundType = 0;
  }

  void update(int i) {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    soundType = bounce();
 //   println("soundType; : "+ soundType );
  }

  void display() {
  }


  int bounce() {
    int boo= 0;

    if (location.x > width) { 
      //     isDead = true;
      //      boo = 0;
      velocity.x *= -1;
      location.x = width;
      changeColor();
      boo = 1;
    }
    if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
      changeColor();
      boo = 1;
    }
    if (location.y > height) {
      //        println("location.y: " + location.y);
      //        println("bounceNumber: " + bounceNumber);
      if (bounceNumber== maxBounceNumber) {
        boo = 2;
        bounceNumber = 0;
        //       println("bounceNumberB: " + bounceNumber);
        isDead = true;
      } else {
        velocity.y *= -1;
        location.y = height;
        changeColor();
        boo = 1;
        println("HERERERERER; : " );
        bounceNumber++;
      }
    }
    return boo;
  }


  PVector getLocation() {
    return location;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  void changeColor() {
    r = random (0, 75);
    g = random (0, 100);
    //        b = random (0, 225);
    //      r = g = 0;
    b = 255;
  }
}

