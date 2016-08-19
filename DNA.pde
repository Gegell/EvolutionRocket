class DNA {
  PVector[] information;
  int fitness;
  
  DNA() {
    information = randomInformation();
  }
  
  DNA(PVector[] information_) {
    information = information_;
  }
  
  void mutate() {
    PVector[] newInformation = new PVector[information.length];
    for (int i = 0; i < information.length; i++) {
      newInformation[i] = (random(1) <= mutRate) ? PVector.random2D() : information[i];
    }
    information = newInformation;
  }
  
  PVector[] randomInformation() {
    PVector[] newInformation = new PVector[popDur];
    for (int i = 0; i < popDur; i++) {
      newInformation[i] = PVector.random2D();
    }
    return newInformation;
  }
}