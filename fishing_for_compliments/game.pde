class Game {
  int state;
  int score = 0;
  PImage[] fishImg = new PImage[5];
  Fish[] fish;
  Compliment[] compliments; 
  Rod rod;
  Joystick joystick;
  Water water;

  Game(int amountFish) {
    state = 0;
    fish = new Fish[amountFish];
    compliments = new Compliment[amountFish];
    loadFishImages();
    spawnFish();
    rod = new Rod();
    joystick = new Joystick();
    water = new Water();
    waves.loop();
  }

  void display() {
    water.display();
    if (state == 0) {
      titlescreen();
    } else if (state == 1) {
      gameloop();
    } else if (state == 2) {
      endscreen();
    }
    water.update();
  }

  void endscreen() {
    textAlign(LEFT);
    textSize(fontHeadlineSize);
    fill(51, 63, 66);
    text("You've fished all compliments", 20, 90);
    textSize(fontBodySize);
    textLeading(fontBodySize * 1.5);
    text("I hope you'll have a nice day!", 20, 130, 350, 100);
    text("Press down joystick to return to title screen.", 20, 290, 350, 100);
    waitForStateSwitch();
  }

  void titlescreen() {
    textAlign(LEFT);
    textSize(fontHeadlineSize);
    fill(51, 63, 66);
    text("Fishing for Compliments", 20, 90);
    textSize(fontBodySize);
    textLeading(fontBodySize * 1.5);
    text("Move joystick left and rigtht to move the digital rod.", 20, 130, 350, 100);
    text("Move the physical rod up and down in liquid to sink and pull up the hook.", 20, 190, 350, 100);
    text("Press down joystick to start.", 20, 290, 350, 100);
    waitForStateSwitch();
  }

  void gameloop() {
    drawStats();

    updateMovement();
    rod.update();
    rod.display();
    updateFish();
    updateScore();
  }

  void waitForStateSwitch() {
    if (joystick.clicked == true) {
      if (state == 0) {
        state = 1;
      } else if (state == 2) {
        state = 0;
        reset();
      }
      menu.play();
      delay(100);
    }
  }

  void reset() {
    score = 0;
    fish = new Fish[amountFish];
    compliments = new Compliment[amountFish];
    spawnFish();
    rod = new Rod();
  }

  void updateMovement() {
    if (joystick.right == true) {
      rod.moveRight();
    } else if (joystick.left == true) {
      rod.moveLeft();
    }
  }

  void updateScore() {
    if (score == amountFish -1) {
      // play win music    `
    }
    if (score == amountFish) {
      game.state = 2;
    }
  }

  void loadFishImages() {
    for (int i = 0; i < fishImg.length; i++) {
      fishImg[i] = loadImage("Fish"+ i +".png");
    }
  }

  void spawnFish() {
    for (int i = 0; i < amountFish; i++) {
      fish[i] = new Fish();
      compliments[i] = new Compliment();
    }
  }

  void updateFish() {
    int tmpScore = 0;
    for (int i = 0; i < fish.length; i++) {
      if (fish[i].collided == false) {
        fish[i].update();
        compliments[i].syncLoc(fish[i].location);
        fish[i].collidesWith(rod.hook);
        fish[i].display();
      } else {
        if (compliments[i].outside == false) {
          compliments[i].update();
          compliments[i].display();
        } else {
          tmpScore ++;
        }
      }
    }
    score = tmpScore;
  }

  void drawStats() {
    textAlign(LEFT);
    fill(51, 63, 66);
    textSize(fontBodySize);
    text("Compliments fished: "+ score, 10, 30);
  }
}
