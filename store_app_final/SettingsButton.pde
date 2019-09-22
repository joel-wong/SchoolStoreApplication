class SettingsButton {
  
  // this is a class that displays a settings button and responds to clicks
  
  int xCenter;
  int yCenter;
  
  /*
  attributes:
  xCenter: the x position of the button
  yCenter: the y position of the button
  
  */
  
  SettingsButton (int _xCenter, int _yCenter) {
    xCenter=_xCenter;
    yCenter=_yCenter;
  }
  
  boolean respond () {
    if (dist(xCenter,yCenter,mouseX,mouseY)<25 && mousePressed) {     
      //if the mouse is clicked within 25 pixels of the center of the button
      return true;
    }
    return false;
  }  
  
  void display () {
    popMatrix();
  
    strokeWeight(5);
    stroke(100);
    
    //produces 12 lines in a circle around the center
    for (int i=0; i<12; i++) {
      float angle=TWO_PI/12*i;
      line(xCenter,yCenter,xCenter+cos(angle)*20,yCenter+sin(angle)*20);
    }
    
    //also places an ellipse over top of the lines in the circle
    fill(100);
    ellipse(xCenter,yCenter,25,25);
    fill(0);
    ellipse(xCenter,yCenter,20,20);
    
    strokeWeight(2);
    stroke(255);
    
    setMatrix();
  }
}