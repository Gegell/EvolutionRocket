class Vehicle {
  DNA DNA;
  boolean stuck;
  boolean finished;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float distStartEnd;

  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector();
    location = new PVector(x, y);
    r = 3.0;
    maxspeed = 3;
    maxforce = 0.05;
    distStartEnd = location.dist(Goal.location);
    DNA = new DNA();
  }

  void update() {
    if (!stuck && !finished && life < popDur) { 
      updateLocation();
      collision();
      applyForce(DNA.information[life]);
    }
    render();
  }

  void fitness() {
    int fitness = int(map(location.dist(Goal.location), 0, distStartEnd, 25, 0));
    if (finished) fitness *= 5;
    else if (stuck) fitness /= 5;
    DNA.fitness = fitness;
  }

  void updateLocation() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  //Triangle render code from Daniel Shiffman because laziness
  void render() {
    float theta = velocity.heading() + radians(90);
    fill(200, 100);
    stroke(255);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void collision() {
    if (location.x < -r || location.y < -r || location.x > width+r || location.y > height+r) {
      stuck = true;
    }
    if (location.dist(Goal.location) < Goal.r) {
      finished = true;
    }
    if (checkObstacleCollision(location.x,location.y) >= 0) {
      stuck = true;
    }
  }
}