import gab.opencvpro.*;
import gifAnimation.*;

PImage img, dst;
OpenCVPro opencv;
GifMaker gif;
Gif player;

boolean finished, playing;
int count;

String inputFilename = "test.jpg";
String gifFilename = "threshold.gif";
String label = "threshold(50)";

void setup() {
  img = loadImage(inputFilename);
  img.resize(800, 0);
  size(img.width, img.height);

  opencv = new OpenCVPro(this, img);
  img = opencv.getSnapshot();
  
  opencv.threshold(50);

  dst = opencv.getSnapshot();

  PFont f = createFont("Helvetica", 24);
  textFont(f);

  setupGif();
}

void before() {
  image(img, 0, 0);
}

void after() {
  image(dst, 0, 0 );
}

void both() {
  
  fill(125, 200);
  rect(0, height-50, textWidth(label) + 30, 50);
  fill(0);
  text(label, 15, height-15);
}

void setupGif() {
  gif = new GifMaker(this, gifFilename);
  gif.setRepeat(0);
}

void draw() {
  if (count < 1) {
    before();
  } 
  else {
    after();
  }

  both();

  if (count < 2) {
    println("saving frame: " + count);
    gif.setDelay(1000);
    gif.addFrame();
  } 
  else {
    gif.finish();
    finished = true;
  }

  if (finished) {
    if (!playing) {
      player = new Gif(this, gifFilename);
      player.play();
      playing = true;
    }
    image(player, 0, 0);
  }

  count++;
}

