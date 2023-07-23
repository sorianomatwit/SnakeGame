//Snake game
/*
Author: Manyeruis Soriano
Date Completed: January 22, 2021
Verision: 1.00
Powers:

red - nothing

*/
ArrayList<Snake> python;
Apple honeycrisp;
grid graph;


int sec = 0;
int min = 0;
int start = 0;

float count = 0;
float r, g, b;

PFont coolfont;
String[] fontList = PFont.list();


boolean ready = false;
int go = 0;
int score = 0;
int finaltime = 0;

int[] applebunch = new int[5];
void setup() {
  size(750, 510);
  frameRate(60);
  
  python = new ArrayList<Snake>();
  honeycrisp = new Apple(30);
  graph = new grid(30, 255);
  coolfont = createFont("DEBROSEE.tff", 50);
}
int ho = fontList.length;
void draw() {
  background(0);
  //graph.displaygrid();

  //start screen
  

  if (ho <= fontList.length){
    printArray(fontList);
    ho++;
  }
  if (!ready && finaltime == 0) {
    pushMatrix();
    stroke(255);
    fill(23, 242, 132);
    rect(180, 150, 390, 150, 12, 12, 12, 12);
    popMatrix();
    if ((frameCount*2)/30 == count) {
      r = random(255);
      g = random(255);
      b = random(255);
      count++;
    }
    pushMatrix();
    stroke(0);
    fill(r, g, b);
    textAlign(CENTER);
    textSize(50);
    //textFont();
    text("Snake Frenzy", 375, 230);
    textAlign(CENTER);
    textSize(20);
    text("click space to start", 375, 265);
    popMatrix();
  }
  //game 
  if (key == ' ' && !ready) {
    finaltime = 0;
    score = 0;
    for (int j = 0; j < applebunch.length; j++) applebunch[j] = 0;
    python.clear();
    ready = true;
    start = frameCount;
    honeycrisp.spawn();
    honeycrisp.timer = frameCount;
    python.add(new Snake(width/2, height/2));
  }
  // score keeper and time keeper
  if (ready) {
    if ((frameCount - start)/60 == sec && python.get(0).control) {
      sec++;
    }
    pushMatrix();
    stroke(255);
    fill(0, 0, 255);
    rect(0, 0, 90, 30);
    popMatrix();
    pushMatrix();
    stroke(255);
    fill(255);
    textAlign(TOP);
    textSize(13);
    text("Score: "+score, 5, 12);
    text("Sec: "+sec, 5, 24);
    popMatrix();

    // stats viewer
    //pushMatrix();
    //stroke(255);
    //fill(0, 255, 255);
    //rect(0, 60, 90, 30);
    //popMatrix();
    //pushMatrix();
    //stroke(255);
    //fill(0);
    //textAlign(TOP);
    //textSize(13);
    //text("Speed: "+python.get(0).spd, 5, 72);
    //popMatrix();

    //snake mechanics
    // head of the snake

    python.get(0).body();
    if (!python.get(0).collision(0, 0, width, height)) {
      if (go == 4 || go == 2 || go == 0) {
        if (keyCode == UP || key == 'w') {
          go = 1;
        }
        if (keyCode == DOWN || key == 's') {
          go = 3;
        }
      }
      if ((go == 1 || go == 3 || go == 0)) {
        if (keyCode == LEFT || key == 'a') {
          go = 4;
        }
        if (keyCode == RIGHT || key == 'd') {
          go = 2;
        }
      }
      python.get(0).pyDir(go);
    } else {
      python.get(0).died();
      reset();
    }

    //body of the snake
    for (int i = 0; i <= python.size()-1; i++) {
      Snake p = python.get(i); 
      //graph.displayStats(p);
      if (p != python.get(0)) {
        p.species = python.get(0).species;
        p.body();
        //p.hitbox();
        if (python.size() >= 2) {
          if (p != python.get(1)) {
            if (honeycrisp.acheive != 3 || !honeycrisp.mhmm) {
              if (python.get(0).collision(p)) {
                python.get(0).died();
                python.get(1).died();

                // world commands
                reset();
              }
            }
          }
        }
        if (python.get(0).control == false) p.died();
        p.follow(python.get(i-1));
      }
    }

    //apple code
    int temp = 0;
    if (honeycrisp.count >= 0) {
      //System.out.print("hello");
      temp = honeycrisp.count;
      fill(255, 255, 255);
      textAlign(CENTER);
      textSize(25);
      text("Ability: "+temp, width/2, 75);
      textAlign(CENTER);
    }
    honeycrisp.seed(python.get(0));

    if (honeycrisp.eaten(python.get(0))) {
      score++;
      applebunch[honeycrisp.power]++;
      honeycrisp.spawn();

      // body spawn
      if (honeycrisp.acheive != 2) {
        if (python.get(python.size()-1).direction == 1) python.add(new Snake(python.get(python.size()-1).py.x, python.get(python.size()-1).py.y+45));
        if (python.get(python.size()-1).direction == 2) python.add(new Snake(python.get(python.size()-1).py.x-45, python.get(python.size()-1).py.y));
        if (python.get(python.size()-1).direction == 3) python.add(new Snake(python.get(python.size()-1).py.x, python.get(python.size()-1).py.y-45));
        if (python.get(python.size()-1).direction == 4) python.add(new Snake(python.get(python.size()-1).py.x+45, python.get(python.size()-1).py.y));
        python.get(python.size()-1).saving();
      } else {
        if (python.size() > 1) {
          python.remove(python.size()-1);
        }
      }
    }
  }

  //game end screen
  if (!ready && finaltime > 0) {

    pushMatrix();
    stroke(255);
    fill(23, 242, 132);
    rect(180, 150, 390, 150, 12, 12, 12, 12);
    popMatrix();

    if (((frameCount - start)*2)/30 == count) {
      r = random(255);
      g = random(255);
      b = random(255);
      count++;
    }
    pushMatrix();
    stroke(0);
    fill(r, g, b);
    textAlign(CENTER);
    textSize(30);
    text("Final Score: "+score, 375, 140);
    popMatrix();

    pushMatrix();
    stroke(0);
    fill(255);
    textAlign(LEFT);
    int tsize = 15;
    textSize(tsize);
    int min = finaltime/60;
    text("Time Lasted:", 250, 180 + tsize*0);
    text(min+" min "+(finaltime - (60*min))+" sec", 355, 180 +tsize*0);
    text("Snake length:", 250, 180 + tsize*1);
    text(python.size(), 355, 180 + tsize*1);
    // aple count
    text("Red Apples:", 250, 180 + tsize*2);
    text(applebunch[0], 355, 180 + tsize*2);
    text("Yellow Apple:", 250, 180 + tsize*3);
    text(applebunch[4], 355, 180 + tsize*3);
    text("Pink Apple:", 250, 180 + tsize*4);
    text(applebunch[1], 355, 180 + tsize*4);
    text("Brown Apple:", 250, 180 + tsize*5);
    text(applebunch[2], 355, 180 + tsize*5);
    text("White Apple:", 250, 180 + tsize*6);
    text(applebunch[3], 355, 180 + tsize*6);

    popMatrix();
    pushMatrix();
    stroke(0);
    fill(0);
    textAlign(CENTER);
    textSize(15);
    text("Try Again? Press Space", 375, 290);
    popMatrix();
    if (key == ' ') {
      System.out.print("hi");
    }
  }
}

void reset() {
  honeycrisp.count = -1;
  start = frameCount;
  finaltime = sec;
  ready = false;
  sec= 0;
  count = 0;
  go = 0;
}
