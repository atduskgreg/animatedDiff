import gab.opencvpro.*;

PImage img, dst;
OpenCVPro opencv;
AnimatedDiff differ;

String inputFilename = "test.jpg";
String gifFilename = "find_sobel_edges_vertical.gif";
String label = "findSobelEdges(2,0)";

void setup() {
  img = loadImage(inputFilename);
  img.resize(800, 0);
  size(img.width, img.height);

  opencv = new OpenCVPro(this, img);
  img = opencv.getSnapshot();
  
  // do processing here:
  opencv.findSobelEdges(2,0);
  
  dst = opencv.getSnapshot();

  PFont f = loadFont("Helvetica-48.vlw");
  textFont(f, 48);
  
  differ = new AnimatedDiff(this, gifFilename);
  differ.setLabel(label);
}

void before() {
  image(img, 0, 0);
}

void after() {
  image(dst, 0, 0 );
}

void both() {}

void draw() {
 if(!differ.isFinished()){
   differ.make();
 } else {
   differ.draw();
 }
}

