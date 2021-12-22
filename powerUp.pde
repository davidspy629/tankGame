class PowerUp {
  float xAxis, yAxis, designColor, size;
  String img, name;
  PImage image;
  int time;
  boolean taken, off;
  PowerUp(float x, float y, float c, float s, String i, String n) {
    xAxis = x;
    yAxis = y;
    designColor = c;
    size = s;
    img = i;
    name = n; //tripleShot, oder speed, oder shield
  };
  void drawing() {
    image = loadImage(img);
    pushMatrix();
    translate(xAxis, yAxis);
    fill(designColor, 255, 255);
    rect(0, 0, size, size);
    fill(20, 255, 255);
    rect(0, 0, size*5/6, size*5/6);
    imageMode(CENTER);
    image(image, 0, 0, size*3/4, size*3/4);
    popMatrix();
  }
}
