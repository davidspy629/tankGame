class Player {
  float xAxis, yAxis, angle, speed, designColor;
  boolean directionRotation, moving, shield;
  int pointsIndex, time;
  char keyButton;
  String powerUp;
  Player(float x, float y, float a, float s, boolean d, 
    int p, char k, float c) {
    xAxis = x;
    yAxis = y;
    angle = a;
    speed = s;
    directionRotation = d;
    pointsIndex = p;
    keyButton = k;
    designColor = c;
  };
  void rotation() {
    if (directionRotation) {
      angle += 0.04;
    } else {
      angle -= 0.04;
    }
    //Um die angle Variable nicht unnötig zu vergrößern
    //wird sie auf 0 gesetzt, nach deiner Umdrehung
    if (angle >= TWO_PI | angle <= -TWO_PI) {
      angle = 0;
    }
  }
  void movement() {
    float size = playerSize/2;
    float xPos = xAxis+cos(angle)*speed;
    float yPos = yAxis+sin(angle)*speed;
    if ((!checkBordersX(xPos, size)&!checkBordersY(yPos, size))) {
      //Wenn der Spieler im Feld ist, bewegt er sich
      if (checkField(xPos, yPos, size)=="move") {
        xAxis += cos(angle)*speed;
        yAxis += sin(angle)*speed;
      }
    } else {
      //Wenn der Spieler am Rand einer Achse ist,
      //bewegt er sich in der anderen Achse.
      if (!checkBordersX(xPos, size)) {
        xAxis += cos(angle)*speed;
      }
      if (!checkBordersY(yPos, size)) {
        yAxis += sin(angle)*speed;
      }
    }
  }
  void drawing() {
    translate(xAxis, yAxis);
    rotate(angle);
    if (shield){
      //helblauer Kreis
      colorMode(RGB);
      fill(0,0,255, 60);
      ellipse(0, 0, playerSize*3/2, playerSize *3/2);
      colorMode(HSB);
    }
    fill(255);
    rect(0, 0, playerSize, playerSize);
    fill(designColor, 255, 255);
    rect(0, -playerSize/2, playerSize*3/4, playerSize/10);
    rect(0, playerSize/2, playerSize*3/4, playerSize/10);
    rect(playerSize/4, 0, playerSize/2, playerSize/4);
    rect(playerSize/2, 0, playerSize/4, playerSize/2);
    //Hintere Linien
    for (int i = 1; i < 5; i++) {
      rect(-i*(playerSize/10), 0, 1, playerSize/2);
    }
  }
}
