class Field {
  float xPos, yPos, xPos2, yPos2, colorDesign;
  Field(float x, float y, float x2, float y2, float c) {
    xPos = x;
    yPos = y;
    xPos2 = x2;
    yPos2 = y2;
    colorDesign = c;
  }
  void drawing(float x, float y, float x2, float y2) {
    rectMode(CORNERS);
    stroke(2);
    fill(colorDesign, 255,255);
    rect(x, y, x2, y2);
    rectMode(CENTER);
  }
}
