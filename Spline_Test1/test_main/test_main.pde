ArrayList<SPoint> points;
ArrayList<PVector> grid[][];
int dx, dy, dv = 10;

String trackPath = "trackpath.txt";
String mapFile = "Track1.txt";

Map track;
                           // Keybinds
boolean Loop = false,      // q
        AddPoint = true,   // w
        DrawGrid = false,  // g
        DrawPoints = true; // c

void setup() {
  fullScreen();
  dx = width / dv;
  dy = height / dv;
  
  reload();
  
  // Map
  track = new Map();
  track.loadFromFile(mapFile);
}

void reload() {
  grid = new ArrayList[dx][dy];    // Grid for faster point selection
  for (int x = 0; x < dx; x++) {
    for (int y = 0; y < dy; y++) {
      grid[x][y] = new ArrayList<PVector>();
    }
  }
  
  points = new ArrayList<SPoint>();     // All SPoints
  loadSplines();    // From filename
}

void addToGrid(PVector p) {
  grid[int(p.x/dv)][int(p.y/dv)].add(p);
}

void removeFromGrid(PVector p) {
  int i = int(p.x / dv), j = int(p.y / dv);
  for (int _i = 0; _i < grid[i][j].size(); _i++) {
    if (p.dist(grid[i][j].get(_i)) == 0) grid[i][j].remove(_i);
  }
}

PVector checkSelectedIn(int i, int j) {
  if (i < 0 || i > dx || j < 0 || j > dy) return null;
  if (grid[i][j].size() == 0) return null;
  
  PVector m = new PVector(mouseX, mouseY);
  for (PVector p: grid[i][j]) {
    if (p.dist(m) < 10) return p;
  }
  return null;
}

PVector getPoint() {
  int x = mouseX / dv, y = mouseY / dv;
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      PVector sel_point = checkSelectedIn(x+i, y+j);
      if (sel_point != null) return sel_point;
    }
  } return null;
}

PVector selectedPoint;
void mousePressed() {
  if (!DrawPoints) return;
  
  selectedPoint = getPoint();
  if (selectedPoint != null) return;
  
  if (AddPoint) {points.add(new SPoint()); return;}
}

void mouseDragged() {
  if (!DrawPoints) return;
  if (selectedPoint == null) return;
  selectedPoint.x = mouseX;
  selectedPoint.y = mouseY;
  
  removeFromGrid(selectedPoint);
  addToGrid(selectedPoint);
}

void drawBezier(SPoint p1, SPoint p2){
  bezier(p1.cp.x, p1.cp.y,    // Anchor 1
         p1.c2.x, p1.c2.y,    // Control for Anchor 1
         p2.c1.x, p2.c1.y,    // Control for Anchor 2
         p2.cp.x, p2.cp.y);   // Anchor 2
}

void drawCurve(){
  noFill();
  stroke(100, 200, 100);
  strokeWeight(2);
  
  for (int i = 0; i < points.size() - 1; i++) {
    SPoint p1 = points.get(i), p2 = points.get(i+1);
    drawBezier(p1, p2);
  }
  
  if (Loop){
    drawBezier(points.get(points.size() - 1), points.get(0));
  }
}

void drawGrid() { 
  stroke(200);
  strokeWeight(1);
  for (int x = 0; x < width; x+=dv) {
    line(x, 0, x, height);
  }
  
  for (int y = 0; y < height; y+=dv) {
    line(0, y, width, y);
  }
}

void hilightCell(){
  int x = mouseX / dv, y = mouseY / dv;
  noFill();
  stroke(255, 0, 0, 80);
  strokeWeight(3);
  rectMode(CORNER);
  
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      square((x+i) * dv, (y+j) * dv, dv);
    }
  }
}

void draw() {
  background(100);
  track.display();
  if (DrawGrid){
    drawGrid();
    hilightCell();
  }
  
  if (points.size() > 1){
    drawCurve();
  }
  
  if (DrawPoints){
    for (int i = 0; i < points.size(); i++){
      SPoint p = points.get(i);
      p.display();
      fill(0);
      textSize(14);
      text(i+1, p.cp.x, p.cp.y - 10);
    }
    
    // Hilight Selected Point
    PVector p = getPoint();
    if (p != null) {
    fill(0);
    circle(p.x, p.y, 10);
    }
  }
}

void undo() {
  if (points.size() == 0) return;
  
  SPoint _p = points.get(points.size() - 1);
  removeFromGrid(_p.cp);
  removeFromGrid(_p.c1);
  removeFromGrid(_p.c2);
  
  points.remove(points.size() - 1);
}

void keyPressed() {
  switch (key){
    case 'q':
      Loop = !Loop; break;
    case 'w':
      AddPoint = !AddPoint; break;
    case 'g':
      DrawGrid = !DrawGrid; break;
    case 'c':
      DrawPoints = !DrawPoints; break;
    case 's':
      savePathSpline(); break;
    case 'r':
      reload(); break;
    case 'z':
      undo(); break;
  }
}

void loadSplines() {
  String splines[] = loadStrings(trackPath);
  if (splines == null) return;
  
  for (int i = 0; i < splines.length; i+=3){
    String cp[] = split(splines[i], ","),
           c1[] = split(splines[i+1], ","),
           c2[] = split(splines[i+2], ",");
    
    points.add(new SPoint(int(cp[0]), int(cp[1]),
                          int(c1[0]), int(c1[1]),
                          int(c2[0]), int(c2[1])));
    
  }
}


void savePathSpline(){
  //File f;
  //while (true) {
  //  f = dataFile(filename + ".txt");
  //  if (!f.isFile()) break;
    
  //  filename = filename + "(1)";
  //}
  
  String splines[] = new String[points.size() * 3];
  for (int i = 0; i < points.size(); i++) {
    PVector cp = points.get(i).cp,
            c1 = points.get(i).c1,
            c2 = points.get(i).c2;
    
    int _i = i * 3;
    splines[_i] = "" + int(cp.x) + "," + int(cp.y); 
    splines[_i+1] = "" + int(c1.x) + "," + int(c1.y); 
    splines[_i+2] = "" + int(c2.x) + "," + int(c2.y);
  }
  
  saveStrings(trackPath, splines);
}
