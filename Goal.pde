class Goal {
  PVector location;
  float r;
  
  Goal(float x, float y) {
    location = new PVector(x, y);
    r = 15.0;
  }
  
  void render() {
    fill(200);
    stroke(255);
    ellipse(location.x, location.y, r*2, r*2);
  }
}