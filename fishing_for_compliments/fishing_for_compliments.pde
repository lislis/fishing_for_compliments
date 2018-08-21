import processing.serial.*;

Serial port;

int waterTop = 70;
int amountFish  = 1;
int fontBodySize = 20;
int fontHeadlineSize = 42;
PFont font;
Game game;
SerialHelper sh;

void setup() {
  size(640, 360);
  font = createFont("Acme-Regular.ttf", fontBodySize);
  textFont(font);
  game = new Game(amountFish);
  port = new Serial(this, Serial.list()[0], 9600);
  sh = new SerialHelper(port);
}

void draw() {
  game.display();
  sh.update(game.joystick);
}

void keyPressed() {
  if (key == CODED) {
    if (game.state == 0 && keyCode == UP) {
      game.state = 1;
    }
    if (game.state == 2 && keyCode == UP) {
      game.state = 0;
    }

    if (game.state == 1) {
      if (keyCode == LEFT) {
        game.rod.moveLeft();
      } else if (keyCode == RIGHT) {
        game.rod.moveRight();
      }
      if (keyCode == UP) {
        game.rod.moveUp();
      } else if (keyCode == DOWN) {
        game.rod.moveDown();
      }
    }
  }
}