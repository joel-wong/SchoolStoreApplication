class Slider {
  
  // this is a class that creates movable sliders
  
  int len;
  int xCenter;
  int yCenter;
  float minimum;
  float maximum;
  String message;
  float ellipseX;
  float current;
  boolean sliderBeingMoved;
  boolean moving;
  
  /*
  attributes: 
  len: the length of the slider
  xCenter: the horizontal center of the slider
  yCenter: the vertical center of the slider
  minimum: The minimum value for the output (the target range minimum)
  maximum: The maximum value for the output (the target range maximum)
  message: the message to be displayed above the slider
  ellipseX: the xposition of the ellipse
  current: the current value of the output (mapped)
  sliderBeingMoved: whether the slider is currently being moved
  moving: if the slider can be translated/zoomed 
  */
 
  Slider (int _len, int _xCenter, int _yCenter, float _minimum, float _maximum, String _message, float _current, boolean _moving) {
    len=_len;
    xCenter=_xCenter;
    yCenter=_yCenter;
    minimum=_minimum;
    maximum=_maximum;
    message=_message;
    current=_current;
    sliderBeingMoved=false;
    ellipseX=map(current,minimum,maximum,xCenter-len/2,xCenter+len/2);
    moving=_moving;
    
  }
  
  boolean respond() {
    
    
    if (mousePressed) {
      
      //first, determine whether the slider should be moving
      
      
      if (moving) {
        //if the slider can be translated/zoomed, check whether it is being clicked based on rMouseX/rMouseY
        if (dist(rMouseX,rMouseY,ellipseX,yCenter)<15) {
          //if the mouse is on the circle and the mouse is clicked
          sliderBeingMoved=true;
        }
      }
      else {
        //if the slider cannot be translated/zoomed, check whether it is being clicked based on mouseX/mouseY
        if (dist(mouseX,mouseY,ellipseX,yCenter)<15) {
          //if the mouse is on the circle and the mouse is clicked
          sliderBeingMoved=true;
        }
      }
      
      //if the slider is being moved
      if (sliderBeingMoved) {
        
        //change the ellipseX to the rMouseX/mouseX
        if (moving) ellipseX=rMouseX;
        else ellipseX=mouseX;
        
        //constrain the ellipseX
        ellipseX=constrain(ellipseX,xCenter-len/2,xCenter+len/2);
        
        //change the current value based on the ellipseX
        current=map(ellipseX,xCenter-len/2,xCenter+len/2,minimum,maximum);
      }
      
      
      //the slider is not clicked, but the screen is being dragged
      else {
        //because a slider responds to mouse dragging, it must be the  only thing that takes in mouse dragging
        //however, if a slider is not moving, there should still be screeen movement.
        translateX = constrain(translateX+mouseX-pmouseX,width-width*current_zoom,0);
        translateY = constrain(translateY+mouseY-pmouseY,height-height*current_zoom*maxYTranslate,0);
      }
      
      return false;
    }
    
    //if mousePressed==false and sliderBeingMoved
    else if (sliderBeingMoved) {
      //mouse is not pressed
      sliderBeingMoved=false;
      // if in the settings menu and adjusting the zoom
      return true;
    }
    
    return false;
  }
  
  
  float returnFloatValue () {
    return current;
  }
  
  int returnIntValue () {
    return int(current);
  }
  

  void display () {
    if (moving==false) {
      popMatrix();
    }
    fill(255);
    text(message,xCenter,yCenter-25);
    noStroke();
    fill(0,120,0);
    rect(xCenter,yCenter,len, 10, 5);
    fill(255);

    //if the mouse is over the ellipse
    if (dist(rMouseX,rMouseY,ellipseX,yCenter)<7.5 || sliderBeingMoved) {
      //highlight it
      stroke(255);
    }
    
    ellipse(ellipseX,yCenter,15,15);
    
    //write the text, with different formats based on the state
    if (state=='1') {
      text(round(current*100)+"%",xCenter,yCenter+25);
    }
    else if (state=='i') {
      text(int(current),xCenter,yCenter+25);
    }
    else if (state=='w') {
      text("$"+int(current),xCenter,yCenter+25);
    }
    
    
    if (moving==false) {
      setMatrix();
    }
  }
  
}