class Obstacle {
  int x1, y1;
  int x2, y2;
  
  Obstacle(int x1_, int y1_, int x2_, int y2_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
  }

  void render() {
    fill(200, 0, 0, 200);
    stroke(255, 0, 0, 200);
    rectMode(CORNERS);
    rect(x1, y1, x2, y2);
  }
}