import processing.video.*;
import processing.javafx.*;
Movie myMovie;

SecondApplet sa;
Button btn;
boolean play= true;
int sharedMouseX, sharedMouseY;
int videoFrameCount = 0;
// settings for the main sketch
void settings(){
   size(640,360);

}
// this is the main sketch, it will be used to display the controls for the second window, which will be used to display the video
void setup() {
  //frameRate(30);
  String[] args = {"TwoFrameTest"};
  
  btn = new Button(width/2 - 150, height/2 - 25, 50, 25);
  //println(dataPath(""));
  String path = dataPath("") +"/movie.mp4";
  println(path);

  // Initialize the Movie object
  myMovie = new Movie(this, path);
  myMovie.play();
  // myMovie.loop(); // Make the video loop
  
  sa = new SecondApplet();
  runSketch(args, sa);
  // println(myMovie);
  frameRate(30);
}

void draw() {

  background(0);
  fill(255, 0, 99);
  // sharedMouseX = mouseX;
  // sharedMouseY = mouseY;
  displayTimeMetrics();
  displayTimestamp();
  btn.display();
}


void movieEvent (Movie v) {
  v.read();
  videoFrameCount++;
}
void mousePressed() {
  if (btn.isOver(mouseX, mouseY)) {
    btn.toggle();
    play = btn.isPressed;
  }
  if(play){
    myMovie.play();
  }else{
    myMovie.pause();
  }
}


// Second Applet
// this is done in a separate sketch so that one can easily change the video source without having to recompile the whole sketch

public class SecondApplet extends PApplet {
  // settings for the second sketch
  public void settings() {
    // Fullscreen the second window, makes the window look like a native applet
    size(1280, 720,FX2D);
  }

  public void setup() {
    background(255);
    frameRate(30);
  }

  public void draw() {
    // background(0);
    image(myMovie,0,0,width,height);
    // fill(255, 0, 99);
    // if (play)
      // ellipse(random(width), random(height), 50, 50); // Draw a circle in the second window
    // else
      // ellipse(width / 2, height / 2, 50, 50); // Draw a circle in the second window
    // textSize(24);
    // text("hello w o r l d", sharedMouseX, sharedMouseY);
    textSize(12);
    text("fr:"+frameRate,20,20);

  }
}

void displayTimeMetrics(){

  textSize(12);
  text("frameRate : " + frameRate,20,20);
  text("current frame : " + videoFrameCount, 20, 40);
  
  text(myMovie.frameRate, 20, 80);
}


void displayTimestamp() {
  float seconds = frameCount / myMovie.frameRate;
  int minutes = floor(seconds / 60);
  seconds = seconds % 60;
  int millis = int((seconds - floor(seconds)) * 1000); // Extract milliseconds
  
  fill(255);
  text(nf(minutes, 2) + ":" + nf(floor(seconds), 2) + "." + nf(millis, 3), 20, 100);
  // Displays the timestamp at position (20, 40) in the format MM:SS.mmm Displays the timestamp at position (20, 40)
}

