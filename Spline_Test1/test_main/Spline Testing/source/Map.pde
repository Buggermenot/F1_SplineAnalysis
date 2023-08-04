class Map {
  ArrayList<PVector> inside_edge, outside_edge;
  String name;
  Map (String name){
    this.name = name;
    this.resetTrack();
  }
  
  void resetTrack(){
    this.inside_edge = new ArrayList<>();
    this.outside_edge = new ArrayList<>();
  }
  
  // File Functions
  void loadFromFile(String fname) {
    // Load Map from file
    String savePoints[] = loadStrings(fname);
    if (savePoints != null) {
      this.resetTrack();
      
      int ni = int(savePoints[0]);
      for (int i = 1; i <= ni; i++){
        String s[] = split(savePoints[i], ",");
        int x = int(s[0]), y = int(s[1]);
        
        this.insert(true, new PVector(x, y));
      }
      
      for (int i = ni + 1; i < savePoints.length; i++){
        String s[] = split(savePoints[i], ",");
        int x = int(s[0]), y = int(s[1]);
        
        this.insert(false, new PVector(x, y));
      }
    }
  }
  
  void dumpToFile(String fname) {
    // Dump map to file
    String savePoints[] = new String[1 + this.inside_edge.size()
                                      + this.outside_edge.size()];
    
    savePoints[0] = "" + this.inside_edge.size();
    int i = 1;
    for (PVector p: this.inside_edge) {
      savePoints[i++] = "" + p.x + "," + p.y;
    }
    
    for (PVector p: this.outside_edge) {
      savePoints[i++] = "" + p.x + "," + p.y;
    }
    
    saveStrings(fname, savePoints);
  }
  
  void insert(Boolean edge, PVector point){
    if (edge){
      this.inside_edge.add(point);
    } else {
      this.outside_edge.add(point);
    }
  }
  
  void display(){
    // Draw Inside Loop
    beginShape();
    for (PVector p: this.inside_edge){
      // Points
      fill(255);
      noStroke();
      circle(p.x, p.y, 10);
      
      // Line b/w points
      noFill();
      stroke(200, 50, 50);
      strokeWeight(2);
      vertex(p.x, p.y);
    } endShape();
    
    // Draw Outside Loop
    beginShape();
    for (PVector p: this.outside_edge){
      // Points
      fill(255);
      noStroke();
      circle(p.x, p.y, 10);
      
      // Line b/w points
      noFill();
      stroke(200, 50, 50);
      strokeWeight(2);
      vertex(p.x, p.y);
    } endShape();
  }
  
}
