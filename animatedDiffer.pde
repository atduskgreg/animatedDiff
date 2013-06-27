import gifAnimation.*;

class AnimatedDiff {
  String label;
  GifMaker gif;
  Gif player;
  boolean useLabel, finished, playing;
  int count;
  int frameDelay = 1000;
  PApplet parent;

  AnimatedDiff(PApplet parent, String filename) {
    this.parent = parent;
    gif = new GifMaker(parent, filename);
    gif.setRepeat(0);
  }  

  void setLabel(String label) {
    this.label = label;
    useLabel = true;
  }

  void setDelay(int delay) {
    this.frameDelay = delay;
  }

  void drawLabel() {
    if (useLabel) {
      fill(125, 200);
      rect(0, (height-textDescent())-textAscent() - 10, textWidth(label) + 30, textAscent() + textDescent() + 10);
      fill(0);
      text(label, 15, height- textDescent() - 5);
    }
  }
  
  boolean isFinished(){
    return finished;
  }
  
  boolean isPlaying(){
    return playing;
  }
  
  Gif getPlayer(){
    return player;
  }
  
  GifMaker getMaker(){
    return gif;
  }

  void draw() {
    if (finished) {
      if (!playing) {
        player = new Gif(parent, gifFilename);
        player.play();
        playing = true;
      }
      parent.image(player, 0, 0);
    }
  }

  void make() {
    if (count < 1) {
      before();
    } 
    else {
      after();
    }

    both();
    drawLabel();

    if (count < 2) {
      println("saving frame: " + count);
      gif.setDelay(frameDelay);
      gif.addFrame();
    } 
    else {
      gif.finish();
      finished = true;
    }

    count++;
  }
}

