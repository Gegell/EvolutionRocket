class Population {
  Vehicle[] population;
  ArrayList<Vehicle> matingPool;
  int popSize = 0;

  Population(int popSize_) {
    popSize = popSize_;
  }

  void startNewPopulation() {
    population = new Vehicle[popSize];
    for (int i = 0; i < popSize; i++) {
      population[i] = new Vehicle(startPos.x, startPos.y);
    }
    evalFitness();
  }

  void generateNewPopulation() {
    Vehicle[] newPopulation = new Vehicle[popSize];
    if (matingPool.size() == 0) {
      startNewPopulation();
      return;
    }
    for (int i = 0; i < newPopulation.length; i++) {
      Vehicle V1 = matingPool.get(floor(random(matingPool.size())));
      Vehicle V2 = matingPool.get(floor(random(matingPool.size())));
      newPopulation[i] = new Vehicle(startPos.x, startPos.y);
      newPopulation[i].DNA = crossOver(V1.DNA, V2.DNA);
      newPopulation[i].DNA.mutate();
    }
    population = newPopulation;
  }

  void nextGen() {
    evalFitness();
    createMatingPool();
    generateNewPopulation();
    evalFitness();
  }

  void evalFitness() {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness();
    }
  }

  void createMatingPool() {
    matingPool = new ArrayList<Vehicle>();
    for (int i = 0; i < population.length; i++) {
      for (int j = 0; j < population[i].DNA.fitness; j++) {
        matingPool.add(population[i]);
      }
    }
  }
  
  void updateVehicles() {
    for (int i = 0; i < population.length; i++) {
      population[i].update();
    }
  }

  DNA crossOver(DNA DNA1, DNA DNA2) {
    PVector[] result = new PVector[popDur];
    int swapGen = 0;
    boolean genA = false;
    for (int i = 0; i < popDur; i++) {
      if(swapGen < 0) {
        genA = !genA;
        swapGen = int(random(10, popDur/3));
      }
      swapGen--;
      result[i] = (genA) ? DNA1.information[i] : DNA2.information[i];
    }
    return new DNA(result);
  }

  Vehicle getFittest() {
    evalFitness();
    Vehicle fittest = population[0];
    for (Vehicle current : population) {
      if (current.DNA.fitness > fittest.DNA.fitness) {
        fittest = current;
      }
    }
    return fittest;
  }
}