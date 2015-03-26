//Class definitions

//A representation of a 3D point with some methods for rotation and drawing
class Point3d {
  float x, y, z;
  
  Point3d(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void rotateAboutZAxis(float angle) {
    float newX = x*cos(radians(angle)) - y*sin(radians(angle));
    float newY = x*sin(radians(angle)) + y*cos(radians(angle));
    x = newX;
    y = newY;
  }
  

  ScreenCoords toScreenCoords(int originX, int originY, int size) {
    return new ScreenCoords(round(originX - (size/2)*sqrt(3)*x + (size/2)*sqrt(3)*y), 
                            round(originY + (size/2)*x + (size/2)*y - size*z));
  }
}

//A polygon in 3D space
class Face {
  Point3d[] points;
  
  //Order of points matter
  Face(Point3d[] points) {
    this.points = points; 
  }
  
  void rotateAboutZAxis(float angle) {
    for(Point3d p: points) {
      p.rotateAboutZAxis(angle);
    } 
  }
  
  void draw(int originX, int originY, int size) {
    for(int i = 0; i < points.length; i++) {
      ScreenCoords sc1;
      ScreenCoords sc2;
      
      sc1 = points[i].toScreenCoords(originX, originY, size);
      if(i < points.length - 1) {
        sc2 = points[i + 1].toScreenCoords(originX, originY, size);
      } else {
        sc2 = points[0].toScreenCoords(originX, originY, size);
      }
      
      line(sc1.x, sc1.y, sc2.x, sc2.y);
    }
  }
}

//Just a 2D point to draw on the screen
class ScreenCoords{
  public int x, y;
 
 ScreenCoords(int x, int y) {
   this.x = x;
   this.y = y;
 } 
}

//Stuff that runs
static int SCREEN_SIZE = 400;
static int GRID_SIZE = 50;
Face[] model;

boolean cycleColor = true;
int hue = 0;

void setup() {
  size (SCREEN_SIZE, SCREEN_SIZE);
  colorMode(HSB, 255);
  background(0);
  frameRate(60);
  
  //Making model of cube
  model = new Face[6];
  //Top
  model[0] = new Face(new Point3d[]{new Point3d( 1,  1,  1),
                                    new Point3d( 1, -1,  1),
                                    new Point3d(-1, -1,  1),
                                    new Point3d(-1,  1,  1)});
  //Bottom
  model[1] = new Face(new Point3d[]{new Point3d( 1,  1, -1),
                                    new Point3d( 1, -1, -1),
                                    new Point3d(-1, -1, -1),
                                    new Point3d(-1,  1, -1)});
  //Sides
  model[2] = new Face(new Point3d[]{new Point3d( 1,  1,  1),
                                    new Point3d( 1,  1, -1),
                                    new Point3d( 1, -1, -1),
                                    new Point3d( 1, -1,  1)});
  model[3] = new Face(new Point3d[]{new Point3d(-1,  1,  1),
                                    new Point3d(-1,  1, -1),
                                    new Point3d(-1, -1, -1),
                                    new Point3d(-1, -1,  1)});
  model[4] = new Face(new Point3d[]{new Point3d( 1, -1,  1),
                                    new Point3d( 1, -1, -1),
                                    new Point3d(-1, -1, -1),
                                    new Point3d(-1, -1,  1)});
  model[5] = new Face(new Point3d[]{new Point3d( 1,  1,  1),
                                    new Point3d( 1,  1, -1),
                                    new Point3d(-1,  1, -1),
                                    new Point3d(-1,  1,  1)});
                                    
  //Rotate it a bit to make stuff look nice at the start.
  updateRotation(10);
}

void updateRotation(float rotationAmount) {
  for(Face f: model) {
    f.rotateAboutZAxis(rotationAmount);
  }
}

void drawCube() {
  for(Face f: model) {
    f.draw(SCREEN_SIZE / 2, SCREEN_SIZE / 2, GRID_SIZE);
  }
}

void draw() {
  background(0);
  stroke(hue, 255, 255);
  
  if(cycleColor) {
    if(hue < 256) {hue++;}
    else {hue = 0;} 
  }
  
  if(keyPressed) {
    if(key == CODED) {
      if(keyCode == LEFT) {
        updateRotation(-1.5);
      }
      
      if(keyCode == RIGHT) {
        updateRotation(1.5);
      }
    }
    
    if(key == ' ') {
      cycleColor = !cycleColor;
    }
  }
  
  drawCube();
}

