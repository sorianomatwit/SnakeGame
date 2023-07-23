class Snake {

  PVector py;

  float range = 1.7;
  float spd = 3;
  float mass = 30;
  float opac = 1.0;

  boolean control = true;
  FloatList leaderx;
  FloatList leadery;
  color species = color(0, 255, 0);
  int direction = 1;
  Snake(float tempX, float tempY) {
    py = new PVector();
    py.x = tempX;
    py.y = tempY;

    leaderx = new FloatList();
    leadery = new FloatList();
  }

  void body() {
    if (control) {
      if (species != color(0, 255, 0)) {
        if (opac >= 1) {
          opac-= .01;
        } else if (opac <= 0){
          opac+=.01;
        }
      }
      fill(species);
      ellipse(py.x, py.y, mass, mass);
    }
  }
  void hitbox() {
    fill(255, 0, 0);
    ellipse(py.x, py.y, 5, 5); // center
    ellipse(py.x, py.y - mass/2, 5, 5); // Ubound
    ellipse(py.x, py.y + mass/2, 5, 5); // Dbound
    ellipse(py.x - mass/2, py.y, 5, 5); // Lbound
    ellipse(py.x + mass/2, py.y, 5, 5); // Rbound

    ////rect
    //fill(0, 0, 255);
    //ellipse(py.x + mass/2, py.y + mass/2, 5, 5); // center
    //ellipse(py.x + mass/2, py.y, 5, 5); // Ubound
    //ellipse(py.x + mass/2, py.y + mass, 5, 5); // Dbound
    //ellipse(py.x, py.y+ mass/2, 5, 5); // Lbound
    //ellipse(py.x + mass, py.y + mass/2, 5, 5); // Rbound
  }

  void pyDir(int dir) {
    // 1 - N 2 - E 3 - S 4 - W
    if (control) {
      if (dir == 1) {
        py.y-=spd;
      } else if (dir == 2) {
        py.x+=spd;
      } else if (dir == 3) {
        py.y+=spd;
      } else if (dir == 4) {
        py.x-=spd;
      }
      saving();
      direction = dir;
    }
  }
  void follow(Snake cobra) {
    int displace = 1;
    if (control) {
      if (cobra.leaderx.size() > 10 && cobra.leadery.size() > 10) displace = 15;
      if (cobra.leaderx.size() >= 2 && cobra.leadery.size() >= 2) {
        saving();
        py.x = cobra.leaderx.get(cobra.leaderx.size()-(displace));
        py.y = cobra.leadery.get(cobra.leadery.size()-(displace));


        direction = cobra.direction;

        cobra.leaderx.remove(cobra.leaderx.size()-(displace));
        cobra.leadery.remove(cobra.leadery.size()-(displace));
      }
    }
  }

  void saving() { 
    leaderx.append(py.x);
    leadery.append(py.y);
  }
  void died() {
    control = false;
    //System.out.printf("python: %d died%n",index);
  }

  boolean collision(float Ubound, float Lbound, float Rbound, float Dbound) {
    //@args Ubound Lbound Rbound Dbound
    //if(py.y - mass/2 <= Ubound && py.x > Rbound && py.x < Lbound) return true;
    //if(py.y + mass/2 >= Dbound && py.x > Rbound && py.x < Lbound) return true;
    //if(py.x - mass/2 <= Lbound && py.y > Dbound && py.y < Ubound) return true;
    //if(py.x + mass/2 >= Rbound && py.y > Dbound && py.y < Ubound) return true;

    // circle hitbox
    if (py.y - mass/2 <= Ubound || py.y + mass/2 >= Dbound || py.x - mass/2 <= Lbound || py.x + mass/2 >= Rbound) return true;
    // u l r d
    //rect hitbox
    //if (py.y <= Ubound) return true;
    //if (py.y + mass >= Dbound) return true;
    //if (py.x <= Lbound) return true;
    //if (py.x + mass >= Rbound) return true;
    return false;
  }
  boolean collision(Snake body) {
    if (py.y + mass/2 - range >= body.py.y - body.mass/2 && py.y - mass/2 + range <= body.py.y + body.mass/2 && 
      py.x - mass/2 + range <= body.py.x + body.mass/2 && py.x + mass/2 - range >= body.py.x - body.mass/2) {
      return true;
    }
    return false;
  }
}
