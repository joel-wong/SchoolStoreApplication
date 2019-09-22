class Checkbox {
  
  //This is a class that creates a checkbox based on a constructor
  
  int xCenter;
  int yCenter;
  int rectWidth;
  int rectHeight;
  String message;
  
  /*
  xCenter - the x position of the checkbox
  yCenter - the y position of the checkbox
  rectWidth - the width of the checkbox
  rectHeight - the height of the checkbox
  
  note: 
  The text will be placed in the middle of the screen.
  The checkmark will automatically scale in size.
  
  message: the message/text beside the check box
  */
  
  Checkbox (int _xCenter,int _yCenter, int _rectWidth, int _rectHeight, String _message) {
    xCenter=_xCenter;
    yCenter=_yCenter;
    rectWidth=_rectWidth;
    rectHeight=_rectHeight;
    message=_message;
  }
  
  boolean respond() {
    if (abs(rMouseX-xCenter)<rectWidth/2+2 && abs(rMouseY-yCenter)<rectHeight/2+2 && mousePressed) {     
      //if the mouse is clicked within the box
      return true;
    }
    else{
      //otherwise
      return false;
    }
  }
  
  //Returns the message
  String returnMessage() {
    return message;
  }
  
  void display(boolean _isChecked) {
    stroke(0,0,255);
    fill(50,50,255);
    textSize(24);
    text(message,width/2,yCenter);
    fill(0);
    if (abs(rMouseX-xCenter)<rectWidth/2+2 && abs(rMouseY-yCenter)<rectHeight/2+2) {
      //highlight box if mouse in box
      fill(0,0,100);
    }
    //make the box
    rect(xCenter,yCenter,rectWidth,rectHeight);
    
    //---------------------------------------------------
    //action specific
    if (_isChecked){
      line(xCenter-rectWidth*0.4,yCenter-rectHeight*0.2,xCenter,yCenter+rectHeight*0.2);
      line(xCenter,yCenter+rectHeight*0.2,xCenter+rectWidth*0.6,yCenter-rectHeight*0.6);
    }    
    
  }
}