String checkField(float x, float y, float size) {
  Boolean move = true;
  for (Field field : fields) {
    if (!(x+size < field.xPos|
      x-size > field.xPos2|
      y+size < field.yPos|
      y-size > field.yPos2)) {
      move = false;
    }
  }
  if (move) {
    return "move";
  }
  return "notMove";
}

Boolean checkBordersX(float x, float distance) {
  if (x > width-border-distance|
    x < 0+border+distance) {
    return true;
  }
  return false;
}

Boolean checkBordersY(float y, float distance) {
  if (y > height-border-distance|
    y < 0+border+distance) {
    return true;
  }
  return false;
}
