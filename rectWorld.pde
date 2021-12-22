void rectWorld() {
  //links oben
  fields.add(new Field(280, 50, 350, 230, random(255)));
  fields.add(new Field(40, 210, 150, 250, random(255)));

  //links unten
  fields.add(new Field(140, 450, 300, 490, random(255)));
  fields.add(new Field(310, 610, 440, 730, random(255)));

  //rechts unten
  fields.add(new Field(770, 580, 810, 750, random(255)));
  fields.add(new Field(770, 485, 1050, 500, random(255)));
  
  //rechts oben
  fields.add(new Field(880, 30, 914, 100, random(255)));
  fields.add(new Field(906, 90, 960, 140, random(255)));
  fields.add(new Field(950, 135, 1010, 150, random(255)));
  fields.add(new Field(1045, 250, 1065, 280, random(255)));
  fields.add(new Field(1045, 270, 1130, 280, random(255)));
  fields.add(new Field(1130, 260, 1170, 300, random(255)));
  
  //Button für machine
  fields.add(new Field(width/2-120, 140, width/2+120, 170, random(255)));
}
