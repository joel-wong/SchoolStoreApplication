class TextInputBox {
  
  // this class takes in user input through the keyboard and displays it/relays it to other classes.
  
  int xCenter;
  int yCenter;
  int xLength;
  int yLength;
  int maxTextLength;
  String currentText="";
  color fillColour;
  color strokeColour;
  boolean takingInput;
  String cursorBlink="|";
  int blinkTime=500;
  int currentTime=0;
  String description="";
  
  /*
  xCenter: the x position of the center of the textInputBox.
  yCenter: the y position of the center of the textInputBox
  xLength: the horizontal length of the textInputBox
  yLength: the vertical length of the textInputBox
  maxTextLength: the maximum amount of characters that can fit in the box
  currentText: the current text that the user has inputted 
  (or that has been automatically placed in the box)
  fillColour: the fill colour of the box
  strokeColour: the stroke colour of the box
  takingInput: whether the box starts by taking user input
  cursorBlink: the character that appears when the box is taking inPut
  blinkTime: the time between when the cursor blink is turning on and off
  currentTime: the time since cursorBlink was last displayed
  description: the description besdie the text box
  */
   
  TextInputBox(int _xCenter, int _yCenter, int _xLength, int _yLength, String _currentText, color _fillColour, color _strokeColour, boolean _takingInput, String _description) {
    xCenter=_xCenter;
    yCenter=_yCenter;
    xLength=_xLength;
    yLength=_yLength;
    currentText=_currentText;
    fillColour=_fillColour;
    strokeColour=_strokeColour;
    takingInput=_takingInput;
    description=_description;
    
    //the max text length is equal to the width of the box divided by 15.
    maxTextLength=int(xLength/15);
  }
  
  
  boolean respond(float mousePositionX,float mousePositionY) {
    
    
    if (takingInput==false) {
      //if the mouse has been clicked on top of this box, and it's not taking input, then take input
      if (abs(mousePositionX-xCenter)<xLength/2+2 && abs(mousePositionY-yCenter)<yLength/2+2 && mousePressed) {
        takingInput=true;
      }
      //by returning false, other buttons can cancel being open/used.
      return false;
    }
    
    
    else if (takingInput==true && keyPressed) {
      //when the user is typing into this using the keyboard
      
      if (key==BACKSPACE) {
        //remove 1 character on backspace
        if (currentText.length()>0) {
          //ensure that the keys entered is larger than 0
          currentText=currentText.substring(0,currentText.length()-1);
        }
      } else if (key==ENTER || key==RETURN) {
        if (state=='l') {
          //if in the lgin screen, use the password checker.
          passwordChecker.checkPassword(currentText);
          //ideally add here if password has been changed and this was previous password
          //nevertheless reset the keys entered
          currentText="";
        }
        else {
          //otherwise, just canel taking input.
          takingInput=false;
        }
      } 
      
      else if (key==TAB) {
        //move to takingInput in the next text box.
        takingInput=false;
        if (textInputBoxes.indexOf(this)<textInputBoxes.size()-1) {
          textInputBoxes.get(textInputBoxes.indexOf(this)+1).takingInput=true;
        }
      } 
      
      else {
        //otherwise add the key that was just pressed to the current text.
        if (byte(key)>30 && byte(key)<123) {
          //also make sure that the key actually makes sense
          if (currentText.length()<maxTextLength) {
            currentText+=key;
          }
        }
      }
      return true;
    }
    
    else {
      //if there is a click outside this box, no longer take input.
      if ((abs(mousePositionX-xCenter)>xLength/2+2 || abs(mousePositionY-yCenter)>yLength/2+2) && mousePressed) {
        takingInput=false;
      }
      return false;
    }
  }
  
  String returnText() {
    return currentText;
  }
  
  
  void display() {
    
    if (takingInput==false) {
      //when not taking input, don't blink
      cursorBlink="";
    }
    
    else if (cursorBlink.equals("|")) {
      //if the cursorBlink is showing, check if it shouldn't be showing
      if ((millis()-currentTime)>blinkTime) {
        cursorBlink="";
        currentTime=millis();
      }
    }
    else if (cursorBlink.equals("")) {
      //if the cursorBlink isn't showing and the textInputBox is takigin input, then show it after 500 milliseconds.
      if ((millis()-currentTime)>blinkTime) {
        cursorBlink="|";
        currentTime=millis();
      }
    }
    
    //show the rectangle as well as the description.
    textSize(24);
    fill(fillColour);
    stroke(strokeColour);
    rect(xCenter,yCenter,xLength,yLength);
    textAlign(RIGHT,CENTER);
    text(description,xCenter-xLength/2-5,yCenter);
    
    textAlign(LEFT,CENTER);
    fill(255);
    
    if (state=='l') {
      //in the login screen, don't show the password - put stars instead
      String hiddenKeys="";
      for (int i=0;i<currentText.length();i++) {
        hiddenKeys+="*";
      }
      text(hiddenKeys+cursorBlink,xCenter-xLength/2+5,yCenter);
    }
    
    else {
      //otherwise, show the text (and the cursor blinking)
      text(currentText+cursorBlink,xCenter-xLength/2+5,yCenter);
    }
  
  }
}