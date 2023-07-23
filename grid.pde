class grid {

  color of;
  float size;

  grid(float s, color bleh) {
    size = s;
    of = bleh;
  }

  void displaygrid() {
 
    noFill();
    strokeWeight(1);
    for (int k = 0; k < width/size; k++) {
      for (int i = 0; i < height/size; i++) {
        stroke(of);
        rect(k*size, i*size, size, size);
        if(k == 0 || k == width/size - 1 || i == 0 || i == height/size - 1) stroke(199,36,177);
        ellipse(k*size +size/2, i*size+size/2, 5, 5);
      }
    }
  }
  void displayStats(Snake snake1, Snake snake2) {
    float margin = 40;
    float space = 20;

    noStroke();
    fill(127);
    rect(20, 20, 280, space*9.5);
    textSize(14);
    fill(255, 255, 255);


    text("Snake Location", margin, space*2);
    text("x: "+snake1.py.x, margin, space*3);
    text("y: "+snake1.py.y, margin, space*4);
    if (snake1.leaderx.size() >= 1 || snake1.leadery.size() >= 1) text("last point saved: "+snake1.leaderx.get(snake1.leaderx.size()-1)+", "+snake1.leadery.get(snake1.leadery.size()-1), margin, space*5);
    text("total points saved: "+(snake1.leaderx.size()+snake1.leadery.size()), margin, space*6);
    text("Snake Location", margin*4, space*2);
    text("x: "+snake2.py.x, margin*4, space*3);
    text("y: "+snake2.py.y, margin*4, space*4);
    text("Snake 1 Heading toward: "+snake1.direction, margin, space*8);
    text("Snake 2 Heading toward: "+snake2.direction, margin, space*9);
  }
}
