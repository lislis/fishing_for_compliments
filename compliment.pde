class Compliment {
  PVector location;
  PVector velocity;
  PVector acceleration;
  String text;
  boolean outside;
  String[] pool = {"Nice shirt!", "You make delicious fried rice!", "You're a great friend!"};
  
  Compliment() {
    location = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    text = pool[floor(random(pool.length))];
    outside = false;
  }
  
  void syncLoc(PVector loc) {
    location = loc;
  }
  
  void display() {
      textSize(26);
      fill(255);
      text(text, location.x, location.y, 200, 400);
  }
  
  void update() {
    acceleration = new PVector(0, 0.01);
    velocity.add(acceleration);
    location.add(velocity);
    checkForEnd();
  }
  
  void checkForEnd() {
    if (location.y > height) {
      outside = true;
    }
  }
}
