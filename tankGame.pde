PFont mono;
float playerSize = 35;
int border = 25;
float speed = playerSize/12; //Schussgeschwindigkeit = 3*speed
char[] keyButtons = {'q', 'm', 'y', 'p', 'a', 'l', 'c', 'm'}; //KANN genutzt werden um die Tasten anzugeben
int[] playerColours = {0, 255, 30, 230, 60, 200, 90, 170, 120, 140, 100, 
  110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 
  250, 260}; //Kann genutzt werden um Teams zu erstellen
int playerNumber = 8; //max 8 (für mehr die oberen zwei Listen entfernen)
int[] points = new int[playerNumber];
int timerWinner = 0;
int winPoints = 4; //Punkte um zu gewinnen

//Arraylisten für Spieler, Schüsse, Feld, Maschinen und Power-Ups
ArrayList<Player> players;
ArrayList<PlayerShot> shots;
ArrayList<Field> fields;
ArrayList<Machine> machines;
ArrayList<PowerUp> powerUps;

void setup() {
  frameRate(60);
  size(1200, 800); 
  colorMode(HSB);
  noStroke();
  rectMode(CENTER);
  mono = createFont("Arial Black.ttf", 20);
  textFont(mono);

  players = new ArrayList<Player>();
  shots = new ArrayList<PlayerShot>();
  fields = new ArrayList<Field>();
  machines = new ArrayList<Machine>();
  powerUps = new ArrayList<PowerUp>();

  //Felder
  rectWorld();
  //Spieler
  int[][] playerPositions = {{100, 100}, {width-100, height-100}, {100, height-100}, {width-100, 100}, 
    {width/2, 100}, {100, height/2}, {width/2, height-100}, {width-100, height/2}};
  for (int i = 0; i < playerNumber; i+= 1) {
    players.add(new Player(playerPositions[i][0], playerPositions[i][1], random(TWO_PI), 
      speed, true, i, keyButtons[i], i*(255/playerNumber)));
  }
  for (int i = 0; i < playerNumber; i++) {
    points[i] = 0;
  }
  //Power-Ups
  powerUps.add(new PowerUp(100, height/2, 90, 60, "icons/speed1.png", "speed"));
  powerUps.add(new PowerUp(width-100, height/2, 120, 60, "icons/tripleShoot.png", "tripleShot"));
  powerUps.add(new PowerUp(width/2, height-100, 180, 60, "icons/rainbowShield.png", "shield"));
  powerUps.add(new PowerUp(width/2, 100, 180, 60, "icons/checkpointMachine.png", "machine"));
  //Maschinen
  machines.add(new Machine(width/2, height/2, randomPlayerColor(), 60));
}

void draw() {
  //Hintergrund und Spielfeld
  fill(100, 255, 255);
  rect(width/2, height/2, width, height);
  fill(0, 0, 50);
  rect(width/2, height/2, width-2*border, height-2*border);
  //Punkteanzahl um zu gewinnen
  textAlign(CENTER, CENTER);
  textSize(20);
  text(str(winPoints)+" points to win.", width/2, border/2) ;

  strokeWeight(2);
  stroke(0);
  for (Machine machine : machines) {
    for (PowerUp powerUp : powerUps) {
      if (powerUp.name == "machine") {
        line(machine.xAxis, machine.yAxis, powerUp.xAxis, powerUp.yAxis);
      }
    }
  }
  //Jedes Power-Up updaten
  for (PowerUp powerUp : powerUps) {
    powerUp.drawing();
    for (Player player : players) { 
      //Power-Up an Spieler im Feld geben
      if (dist(player.xAxis, player.yAxis, powerUp.xAxis, powerUp.yAxis)<=powerUp.size/2) {
        //Geschwindigkeit verdoppeln
        if (powerUp.name == "speed") {
          player.speed = speed*2;
        } 
        //Dreifach-Schuss
        else if (powerUp.name == "tripleShot") {
          player.powerUp = "tripleShot";
        } 
        /*Alle Maschinen bekommen die Farbe des Spielers, 
         welcher somit nicht davon abgeschossen werden kann*/
        else if (powerUp.name == "machine") {
          for (Machine machine : machines) {
            machine.designColor = player.designColor;
          }
        } 
        //Schild wird eingeschalten
        else if (powerUp.name == "shield") {
          player.shield = true;
        }
      }
    }
  }
  //Schild Power-Up löschen nach 400 Iterationen
  for (Player player : players) {
    if (player.time < 400 & player.shield == true) {
      player.time ++;
    }
    if (player.time >= 400) {
      player.shield = false;
      player.time = 0;
    }
  }
  //Jeden Spieler updaten
  for (int i = 0; i < players.size(); i++) {
    Player player = players.get(i);
    pushMatrix();
    //Wenn der Spieler Taste drückt, dann bewegen
    if (player.moving) {
      player.movement();
    } else {
      //Sonst drehen
      player.rotation();
    }
    player.drawing();
    popMatrix();
    //Punktestand über dem Spieler anzeigen
    textAlign(CENTER);
    textSize(playerSize/2);
    fill(player.designColor, 255, 255);
    text(points[player.pointsIndex], player.xAxis, player.yAxis-playerSize);
  }
  //Jedes Feld zeichnen
  for (int j = 0; j < fields.size(); j++) {
    pushMatrix();
    Field field = fields.get(j);
    field.drawing(field.xPos, field.yPos, field.xPos2, field.yPos2);
    popMatrix();
  }
  //Jede Machine updaten
  for (Machine machine : machines) {
    machine.drawing();
    //Errechnet den nähesten Spieler zur Maschine
    float xAxisPlayer = 0;
    float yAxisPlayer = 0;
    float dist = width*height;
    for (Player player : players) {
      if (dist(machine.xAxis, machine.yAxis, player.xAxis, player.yAxis)<=dist) {
        dist = dist(machine.xAxis, machine.yAxis, player.xAxis, player.yAxis);
        xAxisPlayer = player.xAxis;
        yAxisPlayer = player.yAxis;
      }
    }
    //Schießt den nähesten Spieler ab, und auch in die entgegengesetzte Richtung
    if (frameCount % 120 == 0) {
      machine.shoot(radians(getAngle(machine.xAxis, machine.yAxis, xAxisPlayer, yAxisPlayer)));
      machine.shoot(radians(getAngle(machine.xAxis, machine.yAxis, xAxisPlayer, yAxisPlayer))+PI);
    }
    //Kreiselschuss
    /*if (frameCount % 30 == 0) {
     machine.shoot(radians(frameCount));
     }*/
  }
  //Jeden Schuss updaten
  for (int i = 0; i < shots.size(); i++) {
    PlayerShot shot = shots.get(i);
    pushMatrix();
    shot.update();
    //Löscht Schüsse welche nicht im Feld sind
    if ((checkBordersX(shot.xAxis, shot.size/2)|
      checkBordersY(shot.yAxis, shot.size/2))|
      (checkField(shot.xAxis, shot.yAxis, shot.size/2) != "move")) {
      shots.remove(i);
    }
    //Löscht Spieler welche abgeschossen worden sind
    for (int j = 0; j < players.size(); j++) {
      Player player = players.get(j);
      if ((dist(player.xAxis, player.yAxis, shot.xAxis, shot.yAxis)<playerSize*2/3 &
        player.designColor != shot.designColor) & player.shield == false) {
        players.remove(j);
      }
    }
    popMatrix();
  }
  noStroke();
  //Sobald die Runde vorbei ist stoppt das Spiel und der WINNER wird angezeigt
  for (int point : points) {
    if (point >= winPoints) {
      textSize(100);
      Player player = players.get(getIndexOfLargest(points));
      fill(player.designColor, 255, 255);
      text("WINNER!", width/2, height/2);
      stop();
    }
  }
  //Runde wird bei einem übrigen Spieler neugestartet
  if (players.size() <= 1) {
    try {
      Player player = players.get(0);
      fill(player.designColor, 255, 255);
    }
    catch(IndexOutOfBoundsException e) {
      fill(0);
    }
    textSize(100);
    textAlign(CENTER);
    timerWinner++;
    text("ROUND OVER!", width/2, height/2);
    if (timerWinner > 300) {
      timerWinner=0;
      for (Player player : players) {
        points[player.pointsIndex]++;
      }
      reset();
    }
  }
}

void keyPressed() {
  //Schüsse der Spieler hinzufügen
  for (Player player : players) {
    if (key == player.keyButton) {
      if (!player.moving) {
        shots.add(new PlayerShot(player.angle, player.xAxis, player.yAxis, player.speed, player.designColor));
        if (player.powerUp == "tripleShot") {
          shots.add(new PlayerShot(player.angle+.05, player.xAxis, player.yAxis, player.speed, player.designColor));
          shots.add(new PlayerShot(player.angle-.05, player.xAxis, player.yAxis, player.speed, player.designColor));
        }
      }
      player.moving=true;
    }
  }
}

void keyReleased() {
  //Drehrichtung ändern wenn man Taste auslässt
  for (int i = 0; i < players.size(); i++) {
    Player player = players.get(i);
    if (key == player.keyButton) {
      player.moving= false;
      player.directionRotation = !player.directionRotation;
    }
  }
}

int getIndexOfLargest(int[] array) {
  if (array == null || array.length == 0) return -1;
  int largest = 0;
  for (int i = 1; i < array.length; i++) {
    if (array[i] > array[largest]) largest = i;
  }
  return largest;
}

float getAngle(float pX1, float pY1, float pX2, float pY2) {
  return atan2(pY2 - pY1, pX2 - pX1)* 180/PI;
}

int randomPlayerColor() {
  int playerColor;
  int[] playerColors = new int[playerNumber];
  for (int i = 0; i < playerNumber; i++) {
    Player player = players.get(i);
    playerColors[i] = int(player.designColor);
  }
  playerColor = playerColors[int(random(0, playerNumber))];
  return playerColor;
}
