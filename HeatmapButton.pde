class Button {
  int x, y, width, height;
  String label;
  int value;
  boolean over = false;
  
  Button(int x, int y, int width, int height, String label, int value) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.value = value;
  }
  
  void display() {
    textAlign(CENTER, CENTER);
    textSize(12);
    if (over) {
      fill(255, 200, 200);
    } else {
      fill(200);
    }
    rect(x, y, width, height);
    fill(0);
    text(label, x + width/2, y + height/2);
  }
  
  int clicked() {
    if (over) {
      return value;
    } else {
      return 0;
    }
  }
  
  void update() {
    if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
      over = true;
    } else {
      over = false;
    }
  }
}
