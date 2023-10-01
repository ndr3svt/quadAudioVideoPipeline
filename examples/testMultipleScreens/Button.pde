class Button {
  float x, y; // position of the button
  float w, h; // width and height of the button
  boolean isPressed; // state of the button
  
  Button(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.isPressed = true; // initial state is Released
  }
  
  void display() {
    // change the color based on the state
    if(isPressed) 
      fill(50); // darker color when pressed
    else
      fill(250); // lighter color when released
      
    rect(x, y, w, h); // draw the button
  }
  
  boolean isOver(float mx, float my) {
    // check whether the mouse is over the button
    return mx > x && mx < x + w && my > y && my < y + h;
  }
  
  void toggle() {
    isPressed = !isPressed; // toggle the state
  }
}
