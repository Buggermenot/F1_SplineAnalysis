Map track1;
Boolean InsertInside = true;
String trackFile = "Track1.txt";


void setup(){
  fullScreen();
  reload();
}

void reload(){
  track1 = new Map();
  track1.loadFromFile(trackFile);
}

void keyPressed(){
  switch (key){
    case 'q':
      InsertInside = !InsertInside; break;
    case 's':
      track1.dumpToFile(trackFile); break;
    case 'z':
      track1.undo(InsertInside); break;
  }
}

void mousePressed() {
  PVector pos = new PVector(mouseX, mouseY);
  track1.insert(InsertInside, pos);
}

void draw() {
  background(0);
  track1.display();
}
