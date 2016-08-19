int popDur = 200;
int popSize = 100;
float mutRate = 0.01;

PVector startPos;
int generation = 0;
int life = 0;
int x1, y1;
Goal Goal;
Population Population;
ArrayList<Obstacle> Obstacles = new ArrayList<Obstacle>();
boolean movingGoal;

void setup() {
  size(600, 400);
  Population = new Population(popSize);
  Goal = new Goal(width/2, 40);
  startPos = new PVector(width/2, height-40);
  Population.startNewPopulation(); //<>//
}

void draw() {
  background(0);
  if ( life < popDur) {
    renderObjects();
    Population.updateVehicles();
    markFittest();
    showInfo();
    life++;
  } else {
    Population.nextGen();
    life = 0;
    generation++;
  }
}

void mousePressed() {
  if (dist(Goal.location.x, Goal.location.y, mouseX, mouseY) < Goal.r) {
    movingGoal = true;
  }
  x1 = mouseX;
  y1 = mouseY;
}

void mouseDragged() {
  if (movingGoal) {
    Goal.location.x = mouseX;
    Goal.location.y = mouseY;
  }
}

void mouseReleased() {
  if (movingGoal) {
    movingGoal = false;
    return;
  }
  if (dist(x1, y1, mouseX, mouseY) > 5) {
    Obstacles.add(new Obstacle(x1, y1, mouseX, mouseY));
  } else {
    int obstacleId = checkObstacleCollision(mouseX, mouseY);
    if (obstacleId >= 0) {
      Obstacles.remove(obstacleId);
    }
  }
}

void keyPressed() {
  Population.startNewPopulation();
  life = 0;
}

void renderObjects() {
  Goal.render();
  for (Obstacle o : Obstacles) {
    o.render();
  }
  if(!movingGoal && mousePressed) {
    stroke(0, 0, 255, 200);
    fill(0, 0, 200, 100);
    rectMode(CORNERS);
    rect(x1, y1, mouseX, mouseY);
  }
}

void markFittest() {
  Vehicle fittest = Population.getFittest();
  stroke(0, 255, 0, 200);
  fill(0, 200, 0, 100);
  ellipse(fittest.location.x, fittest.location.y, fittest.r*4, fittest.r*4);
}

int checkObstacleCollision(float x, float y) {
  int obstacleId = -1;
  for (int i = 0; i < Obstacles.size(); i++) {
    Obstacle o = Obstacles.get(i);
    if (x < o.x2 && x > o.x1 || x > o.x2 && x < o.x1) {
      if (y < o.y2 && y > o.y1 || y > o.y2 && y < o.y1) {
        obstacleId = i;
      }
    }
  }
  return obstacleId;
}

void showInfo() {
  String info = "";
  info += "FPS: " + int(frameRate * 10) / 10.0 + "\n";
  info += "Vehicles: " + Population.population.length + "\n";
  info += "Obstacles: " + Obstacles.size() + "\n";
  info += "Frame: " + life + "\n";
  info += "Generation: " + generation + "\n";
  info += "Best fitness: " + Population.getFittest().DNA.fitness;
  fill(255);
  textAlign(LEFT, BOTTOM);
  text(info, 0, height);
}