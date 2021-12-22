class Machine {
  float xAxis, yAxis, designColor, size;
  Machine(float x, float y, float c, float s) {
    xAxis = x;
    yAxis = y;
    designColor = c;
    size = s;
  };
  void drawing() {
    pushMatrix();
    translate(xAxis, yAxis);
    fill(designColor, 255, 255);
    rect(0, 0, size, size);
    fill(120, 255, 255);
    rect(0, 0, size*5/6, size*5/6);
    fill(170, 255, 255);
    rotate(PI/4);
    rect(0, 0, size*5/12, size*5/12);
    popMatrix();
  }
  void shoot(float angle) {
    //Fügt Schüsse hinzu, sie sind langsamer damit man ausstellen kann
    shots.add(new PlayerShot(angle, xAxis, yAxis, speed/6, designColor));
  }
}
