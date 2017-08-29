
int Wsize = 600;
int Hsize = 600;
int borderSize = int(.1 * float(Wsize));
int cellSize = int(.8 * float(Wsize) / 3);
PShape X;
PShape O;
boolean firstRun = true;
int game[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
char player = '?';
char winner = '?';

void setup(){
  background(0);
  surface.setSize(Wsize, Hsize);
  X = makeX(120);
  O = makeO(100);
  print(cellSize, "  ");
  println(borderSize, "  ", 1.5 * cellSize + borderSize);
  println(borderSize + .5 * cellSize);
  println(cellX(0), " ", cellX(4), " ", cellX(8));
  print(cellY(0), " ", cellY(4), " ", cellY(8));
 
}

void draw(){
  if((player == '?')){
      firstPlayer();
  }
  else if(firstRun){
      drawBoard();
      firstRun = false;
    }
/*  play(X, 4);
  play(O, 3);
  play(X, 5);
  play(X, 6);
  play(X, 0);
  play(O, 1);
  play(O, 8);
  play(O, 2);
  play(X, 7); */
  //noLoop();
}

int cellX(int c){
  int cX = borderSize + c % 3 * cellSize + cellSize / 2;  
  return cX;
}

int cellY(int c){
  int cY = borderSize + int(c / 3) * cellSize + cellSize / 2;  
  return cY;
}

void firstPlayer(){
  stroke(255);
  line(Wsize / 2, borderSize, Wsize / 2, Hsize -  borderSize);
  stroke(0,255,0);
  shape(X, Wsize / 3, Hsize / 2);
  stroke(255, 255, 0);
  shape(O, 2 * Wsize / 3, Hsize / 2);
  textAlign(CENTER, BOTTOM);
  fill(0,255,0);
  text("Select first player", Wsize/2, borderSize/2);
  
  }

void play(PShape S, int cell){
  shape(S, cellX(cell), cellY(cell));
}

//void playY(int cell){
//  shape(Y, cellX(cell), cellY(cell));
//}

void drawBoard(){
  background(0);
  stroke(255, 0, 255);
  strokeWeight(4);
  int xL = borderSize;
  int xR = Wsize - xL;
  int yT = borderSize + cellSize;
  line(xL, yT, xR, yT);  //Top Line
  yT = borderSize + 2 * cellSize;
  line(xL, yT, xR, yT);  //Bottom Line
  xL = borderSize + cellSize;
  yT = borderSize;
  int yB = Hsize - yT;
  line(xL, yT, xL, yB);  //Left Line
  xR = borderSize + 2 * cellSize;
  line(xR, yT, xR, yB);  //Right Line
  textAlign(CENTER, BOTTOM);
  fill(0,255,0);
  text(player + "'s Turn", Wsize/2, borderSize/2);
}

PShape makeX(int xW){
  int xR = xW / 2;
  PShape X;
  X = createShape();
  X.beginShape();
  X.fill(0,255,0);
  X.noStroke();
  X.vertex(-(xR-10),-xR);
  X.vertex(0,-10);
  X.vertex(xR-10,-xR);
  X.vertex(xR,-(xR-10));
  X.vertex(10,0);
  X.vertex(xR,xR-10);
  X.vertex(xR-10,xR);
  X.vertex(0,10);
  X.vertex(-(xR-10),xR);
  X.vertex(-xR,xR-10);
  X.vertex(-10,0);
  X.vertex(-xR,-(xR-10));
  X.endShape(CLOSE);
  return X;
}

PShape makeO(int xW){
  stroke(255,255,0);
  noFill();
  strokeWeight(13);
  PShape O;
  O = createShape(ELLIPSE, -(xW / 2), -(xW * 6 / 10), xW, xW*6/5);
  O.translate(xW / 2, xW * 6 / 10);  
  return O;
}

void mouseClicked(){
  if ((mouseX > borderSize && mouseX < (Wsize - borderSize))
  && (mouseY > borderSize && mouseY < (Hsize - borderSize))) {
    if(player == '?'){
      if(mouseX < Hsize / 2) {
        player = 'X';
        fill(0,255,0);
        text("X's Turn", Wsize/2, borderSize/2);
      }
      else {
        player = 'O';
        fill(0,255,0);
        text("O's Turn", Wsize/2, borderSize/2);
      }
    return;
    }
    int x = int((mouseX - borderSize) / cellSize) ;
    int y = int((mouseY - borderSize) / cellSize) ;
    print("MX = ", x, "MY = ", y);
    println("  Cell = ", y * 3 + x);
    int cell = y * 3 + x;
    if(game[cell] == 0){
      if(mouseButton == LEFT && player == 'X'){
        play(X, cell);
        game[cell] = 1;
        player = 'X';
        //noStroke();
        //fill(0);
        //rect(Wsize/2-50, 0, 100, borderSize);
        textAlign(CENTER, BOTTOM);
        fill(0,0,0);
        text("X's Turn", Wsize/2, borderSize/2);
        fill(0,255,0);
        text("O's Turn", Wsize/2, borderSize/2);
        if(winner == '?')
          checkWin();
        player = 'O';
      }
      else if(mouseButton == LEFT && player == 'O'){
        play(O, cell);
        game[cell] = 2;
        player = 'O';
        //noStroke();
        //fill(0);
        //rect(Wsize/2-50, 0, 100, borderSize);
        textAlign(CENTER, BOTTOM);
        fill(0,0,0);
        text("O's Turn", Wsize/2, borderSize/2);
        fill(0,255,0);
        text("X's Turn", Wsize/2, borderSize/2);
        if(winner == '?')
          checkWin();
        player = 'X';
      }
//      if(winner == '?')
//        checkWin();
    }
    loop();
  }
}

void checkWin(){
  for(int i = 0; i < 3; i ++){
    if(!(game[i] == 0) && game[i] == game[i + 3] && game[i] == game[i + 6]){
      stroke(0, 0, 255);
      strokeWeight(8);
      line(borderSize + cellSize / 2 + i * cellSize, borderSize,
          borderSize + cellSize / 2 + i * cellSize, Hsize - borderSize);
      println("Player ", player, " is the WINNER");
      winner = player;
      return;
    }
    if(!(game[i * 3] == 0) && game[i * 3] == game[i * 3 + 1] 
          && game[i * 3] == game[i * 3 + 2]){
        stroke(255, 0, 0);
        strokeWeight(8);
        line(borderSize, borderSize + cellSize / 2 + i * cellSize, 
          Wsize - borderSize, borderSize + cellSize / 2 + i * cellSize);    
        println("Player ", player, " is the WINNER");
        winner = player;
        return;
    }
  }
  if(!(game[0] == 0) && game[0] == game[4] && game[0] == game[8]){
    println("Player ", player, " is the WINNER");
    winner = player;
    stroke(250, 153, 48);
    strokeWeight(8);
    line(borderSize, borderSize, Wsize - borderSize, Hsize - borderSize);
    return;
  }
  if(!(game[2] == 0) && game[2] == game[4] && game[2] == game[6]){
    println("Player ", player, " is the WINNER");
    winner = player;
    stroke(250, 153, 48);
    strokeWeight(8);
    line(Wsize - borderSize, borderSize, borderSize, Hsize - borderSize);
    return;
  }
}