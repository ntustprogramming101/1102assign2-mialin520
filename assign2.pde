PImage bg, gh, ghRight, ghLeft, ghDown, life1, life2, life3,
  soil, soldier, cabbage, title, gameOver, startNormal,
  startHovered, restartNormal, restartHovered;

float sdX=0, sdY=0, sdW=80 ;

int T=0;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;


float ghX, ghY, ghRightX, ghRightY, ghLeftX, ghLeftY, ghDownX, ghDownY;
float ghSpeed = 80;
float ghW = 80;
float ghI=0,ghII=0;


final int lifeW=50;
float life1X=-60, life2X=10, life3X=80, lifeY=10;
float lifeI=-70, I=0;

final int cabbageW=80;
float cabbageX, cabbageY;


boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;





void setup() {
  size(640, 480, P2D);
  bg=loadImage("img/bg.jpg");
  gh=loadImage("img/groundhogIdle.png");
  ghLeft=loadImage("img/groundhogLeft.png");
  ghRight=loadImage("img/groundhogRight.png");
  ghDown=loadImage("img/groundhogDown.png");
  life1=loadImage("img/life.png");
  life2=loadImage("img/life.png");
  life3=loadImage("img/life.png");
  soil=loadImage("img/soil.png");
  soldier=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  title=loadImage("img/title.jpg");
  gameOver=loadImage("img/gameover.jpg");
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");

  //soldierMoveRandomly
  sdY = floor(random(2, 6))*80; //160,240,320,400

  //cabbage
  cabbageX = floor(random(1, 8))*80;
  cabbageY = floor(random(2, 6))*80;

  ghX = width / 2 ;
  ghY = 80;
}

void draw() {
  frameRate=60;
  switch(gameState) {
  case GAME_START:
    image(title, 0, 0);
    image(startNormal, 248, 360);
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(startHovered, 248, 360);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    }
    break;

  case GAME_RUN:
    //BackgroundAndSoil
    image(bg, 0, 0);
    image(soil, 0, 160);
    //grass
    stroke(124, 204, 25);
    strokeWeight(15);
    line(0, 160, 640, 160);
    //life
    image(life1, life1X+lifeI*I, lifeY);
    image(life2, life2X+lifeI*I, lifeY);
    image(life3, life3X+lifeI*I, lifeY);
    //Sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    circle(590, 50, 120);
    //cabbage
    image(cabbage, cabbageX, cabbageY);
    //groundhog
    image(gh, ghX+ghI, ghY);


    //soldier
    image(soldier, sdX, sdY);
    sdX +=3; //soldierSpeed
    if (sdX>=640) {
      sdX=-40;
    }

    //Play
    if (ghX<sdX+sdW && ghX+ghW>sdX && ghY+ghW>sdY && ghY<sdY+sdW) {
      ghX = width / 2 ;
      ghY = 80;
      I++;
    }
    if (ghX<cabbageX+cabbageW && ghX+ghW>cabbageX
      && ghY+ghW>cabbageY && ghY<cabbageY+cabbageW
      && I<=2 && I>=0) {
      cabbageX=-100;
      cabbageY=-100;
      I--;
    }
    if (I>=3) {
      gameState = GAME_OVER;
    }



   //Groundhog_limit
    if (ghX+ghW>=width) {
      ghX=width-ghW;
    }
    if (ghX<=0) {
      ghX=0;
    }
    if (ghY+ghW>=height) {
      ghY=height-ghW;
    }
    if (ghY<=80) {
      ghY=80;
    }
    break;

  case GAME_OVER:
    image(gameOver, 0, 0);
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(restartHovered, 248, 360);
      if (mousePressed) {
        ghX = width / 2 ;
        ghY = 80;
        sdX=-40;
        sdY = floor(random(2, 6))*80+2;
        cabbageX = floor(random(1, 7))*80;
        cabbageY = floor(random(2, 6))*80;
        I=0;
        gameState = GAME_RUN;
      }
    } else {
      image(restartNormal, 248, 360);
    }
    break;
  }
}

void keyPressed() {
  if (key == CODED ) {
    switch(keyCode) {
    case UP:
      upPressed =true;
      ghI=-800;
      ghY-=ghSpeed;
      break;
    case DOWN:
      downPressed = true ;
      ghI=-800;
      ghY+=ghSpeed;
      break;
    case RIGHT:
      rightPressed = true ;
       ghI=-800;
      ghX+=ghSpeed;
      break;
    case LEFT:
      leftPressed = true ;
      ghI=-800;
      ghX-=ghSpeed;
      break;
    }
  }
}

void keyReleased() {
  if (key == CODED ) {
    switch(keyCode) {
    case UP:
      upPressed = false;
      ghI=0;
      break;
    case DOWN:
      downPressed = false ;
      ghI=0;
      break;
    case RIGHT:
      rightPressed = false ;
      ghI=0;
      break;
    case LEFT:
      leftPressed = false ;
      ghI=0;
      break;
    }
  }
}
