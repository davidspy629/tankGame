void reset() {
  //Schüsse löschen
  for (int i = 0; i < shots.size(); i++) {
    shots.remove(i);
  }
  int[][] playerPositions = {{100, 100}, {width-100, height-100}, {100, height-100}, {width-100, 100}, 
    {width/2, 100}, {100, height/2}, {width/2, height-100}, {width-100, height/2}};
  //Alle Spieler löschen
  for (int j = 0; j < players.size(); j++) {
    players.remove(j);
  }
  //Alle Spieler hinzufügen
  for (int i = 0; i < playerNumber; i+= 1) {
    players.add(new Player(playerPositions[i][0], playerPositions[i][1], 0, 
      speed, true, 0, keyButtons[i], i*(255/playerNumber)));
  }
  for (int i = 0; i < players.size(); i++) {
    Player player = players.get(i);
    player.angle = random(TWO_PI);
    player.pointsIndex = i;
    player.xAxis = playerPositions[i][0];
    player.yAxis = playerPositions[i][1];
  }
  //Maschinen hinzufügen
  for (Machine machine : machines){
    machine.designColor=randomPlayerColor();
  }
}
