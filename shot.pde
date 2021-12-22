class PlayerShot{
  float angle, xAxis, yAxis, speed, designColor;
  float size = playerSize/3;
  PlayerShot(float a, float x, float y, float s, float c) {
    angle = a;
    xAxis = x;
    yAxis = y;
    speed = s;
    designColor = c;
  }
  void update() {
    xAxis += cos(angle)*3*speed;
    yAxis += sin(angle)*3*speed;
    fill(designColor, 255, 255);
    ellipse(xAxis, yAxis, size, size);
  }
}
