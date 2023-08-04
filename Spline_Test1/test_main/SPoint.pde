class SPoint {
  PVector c1, cp, c2;
  SPoint() {
    this.cp = new PVector(mouseX, mouseY);      // Anchor Point
    this.c1 = new PVector(mouseX - 50, mouseY); // Control point 1
    this.c2 = new PVector(mouseX + 50, mouseY); // Control point 2
    
    addToGrid(this.cp);
    addToGrid(this.c1);
    addToGrid(this.c2);
}
  
  SPoint(int x1, int y1, int x2, int y2, int x3, int y3){
    this.cp = new PVector(x1, y1);
    this.c1 = new PVector(x2, y2);
    this.c2 = new PVector(x3, y3);
    
    addToGrid(this.cp);
    addToGrid(this.c1);
    addToGrid(this.c2);
  }
  
  void display() {
    strokeWeight(2);

    // Lines
    stroke(20);
    line(this.c1.x, this.c1.y, this.cp.x, this.cp.y);
    line(this.c2.x, this.c2.y, this.cp.x, this.cp.y);
    
    
    // Points
    stroke(200);
    
    // C1
    fill(0, 0, 255);
    circle(this.c1.x, this.c1.y, 10);
    
    // CP
    fill(255, 0, 0);
    circle(this.cp.x, this.cp.y, 15);
    
    // C2
    fill(0, 255, 0);
    circle(this.c2.x, this.c2.y, 10);
  }
  
}
