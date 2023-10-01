import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 12000); // The port number should match the one in SuperCollider
    myRemoteLocation = new NetAddress("127.0.0.1", 12344); // IP Address and port number of SuperCollider

}

void draw() {
  background(120);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.addrPattern().equals("/freq")) {
    int freq = theOscMessage.get(0).intValue(); 
    println("Received frequency: " + freq);
  }
}

void mousePressed() {
  OscMessage myMessage = new OscMessage("/freq");
  myMessage.add(random(8000)); // Example frequency
  oscP5.send(myMessage, myRemoteLocation); // Send the message
}