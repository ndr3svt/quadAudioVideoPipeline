import beads.*;
import processing.video.*;
import processing.javafx.*;
Movie myMovie;

SecondApplet sa;
Button btn;
boolean play= false;
int sharedMouseX, sharedMouseY;

void setup() {
  size(300, 200);
  //frameRate(30);
  String[] args = {"TwoFrameTest"};
  
  btn = new Button(width/2 - 150, height/2 - 25, 50, 25);
  //println(dataPath(""));
  String path = dataPath("") +"/movie.mp4";
  println(path);

  // Initialize the Movie object
  myMovie = new Movie(this, path);
  myMovie.loop();
  // myMovie.loop(); // Make the video loop
  
  sa = new SecondApplet();
  runSketch(args, sa);
  println(myMovie);
}

void draw() {
  background(0);
  fill(255, 0, 99);
  //ellipse(width / 2, height / 2, 100, 100); // Draw a circle in the main window
  sharedMouseX = mouseX;
  sharedMouseY = mouseY;
  //image(myMovie, 0, 0, 180, 320); // Display the frame

  
  btn.display();
}


void movieEvent (Movie myMovie) {
  myMovie.read();
}
void mousePressed() {
  if (btn.isOver(mouseX, mouseY)) {
    btn.toggle();
    play = btn.isPressed;
  }
}
public class SecondApplet extends PApplet {
  public void settings() {
    size(1280, 720,FX2D);
  }

  public void setup() {
    background(255);
    frameRate(30);
  }

  public void draw() {
    background(0);
      image(myMovie,0,0,width,height);
    fill(255, 0, 99);
    if (play)
      ellipse(random(width), random(height), 50, 50); // Draw a circle in the second window
    else
      ellipse(width / 2, height / 2, 50, 50); // Draw a circle in the second window
    textSize(24);
    text("hello w o r l d", sharedMouseX, sharedMouseY);
    textSize(12);
    text("fr:"+frameRate,20,20);

  }
}



