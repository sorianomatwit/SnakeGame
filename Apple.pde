class Apple {
  float mass = 0;
  float fat = 20;
  float x1, y1;
  float range = 7;

  int r = 255, g = 0, b = 0;
  int acheive = 0;
  int power = 0;
  int sec = 0;
  int count = -1;
  int timer = 0;

  float defaultspd = 3;
  boolean blah = true;
  boolean mhmm = false;
  FloatList pointx, pointy;
  
  color manzana = color(255,0,0);
  PVector app;

  Apple(float size) {
    app = new PVector();
    mass = size;
    pointx = new FloatList();
    pointy = new FloatList();
    SpawnMath();
  }

  void seed(Snake passon) {
    fill(manzana);
    ellipse(app.x, app.y, 20, 20);
    if ((frameCount - timer)/60 == sec) {
      sec++;
      count--;
      //System.out.println("Sec: "+sec);
      //System.out.println("Count: "+count);
      //System.out.println("Acheive: "+acheive);
      //System.out.println("blah: "+blah);
    }
    action(passon);
  }


  //spawn math
  void SpawnMath() {
    for (int k = 0; k < width/mass; k++) {
      for (int i = 0; i < height/mass; i++) {
        if (k != 0 && k != width/mass - 1 && i != 0 && i != height/mass - 1 && k*mass +(mass/2) != 15 &&
          i*mass+(mass/2) != 15 && k*mass +(mass/2) != width-15 && i*mass+(mass/2) != height-15) {
          pointx.append(k*mass +(mass/2));
          pointy.append(i*mass+(mass/2));
        }
      }
    }
  }
  void spawn() {
    x1 = random(pointx.size());
    y1 = random(pointy.size());
    ability();
    app.x = pointx.get((int)x1);
    app.y = pointy.get((int)y1);
      //app.x = x1+50;
      //app.y = y1+50;
    //System.out.printf("Spawned at x: %.2f index: %d y: %.2f index: %d%n", app.x, (int)x1, app.y, (int)y1);
  }
  void ability() {
    float a = random(0, 100000);
    if (a >= 1 && a < 80000) {
      //red
      manzana = color(255,0,0);
      power = 0;
    } else if (a >=80000 && a < 87272) {
      //pink
      manzana = color(255,51,255);
      power = 1;
    } else if (a >= 87272 && a < 94549) {
      //yellow
      manzana = color(255,255,0);
      power = 4;
    } 
    else if (a >= 94549 && a < 98186) {
      //brown
      manzana = color(153,76,0);
      power = 2;
    } 
    else {
      //white
      manzana = color(255,255,255);
      power = 3;
    }
  }

  void action(Snake hero) {
    //pink
    if (acheive == 1) {
      if (blah) {
        count = 5;
        blah = false;
      }
      if (count >= 0) {
        hero.spd = defaultspd+1;
      } else {
        acheive = 0;
        hero.spd = defaultspd;
      }
    } else if (count <= 0) {
      hero.spd = defaultspd;
    }
    //yellow
    if (acheive == 4) {
      if (blah) {
        count = 5;
        blah = false;
      }
      if (count >= 0) {
        hero.spd = defaultspd - 0.5;
      } else {
        acheive = 0;
        hero.spd = defaultspd;
      }
    } else if (count <= 0) {
      hero.spd = defaultspd;
    }
    //white
    if (acheive == 3) {
      if (blah) {
        count = 10;
        hero.spd = defaultspd;
        blah = false;
      }
      if (count <= 0) {
        acheive = 0;
      }
    } else if (count >= 0) {
      mhmm = true;
    } else {
      mhmm = false;
    }
  }


  boolean eaten(Snake mouth) {
    // u l r d
    if (app.y + mass/2 - range >= mouth.py.y - mouth.mass/2 && app.y - mass/2 + range <= mouth.py.y + mouth.mass/2 && 
      app.x - mass/2 + range <= mouth.py.x + mouth.mass/2 && app.x + mass/2 - range >= mouth.py.x - mouth.mass/2) {
      //pink powerup 
      if (power == 0){
        acheive = 0;
        blah = true;
      }
      if (power == 1){
        acheive = 1;
        blah = true;
      }
      if (power == 2){
        acheive = 2;
        blah = true;
      }
      if (power == 3){
        acheive = 3;
        blah = true;
      }
      if (power == 4){
        acheive = 4;
        blah = true;
      }
      return true;
    }
    return false;
  }
}
