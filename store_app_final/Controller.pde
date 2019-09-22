class Controller {
    
  //Controls the entire program. All input and output is controlled by the controller.
  
  
  //no attributes
  
  Controller (char state) {
    //setup the first state when the controller is initialized
    stateSetup.setupState(state,true);
  }
  
  void respond (char state) {
    //respond, depending on state
    
    //each menu has its own respond void in the stateRespond class.
    if (state=='l') {
      stateRespond.loginRespond();
    } else if (state=='m') {
      stateRespond.mainMenuRespond();
    } else if (state=='o') {
      stateRespond.orderMenuRespond();
    } else if (state=='p') {
      stateRespond.pickupMenuRespond();
    } else if (state=='i') {
      stateRespond.inventoryMenuRespond();
    } else if (state=='j') {
      stateRespond.addInventoryMenuRespond();
    } else if (state=='r') {
      stateRespond.printingMenuRespond();
    } else if (state=='c') {
      stateRespond.cashRequisitionMenuRespond();
    } else if (state=='w') {
      stateRespond.priceMenuRespond();
    } else if (state=='1') {
      stateRespond.mainMenuSettingsRespond();
    } else if (state=='2') {
      stateRespond.pickupMenuSettingsRespond();
    } else {
      println("ERROR in respond state - controller");
    }    
  }
 
  void display (char state) {
    //display, according to state
    
    //automatically put a black background
    background(0);
    
    //each menu has its own display void in the stateRespond class.
    if (state=='a') {
      stateDisplay.loadingScreenDisplay();
    } else  if (state=='l') {
      stateDisplay.loginDisplay();
    } else if (state=='m') {
      stateDisplay.mainMenuDisplay();
    } else if (state=='o') {
      stateDisplay.orderMenuDisplay();
    } else if (state=='p') {
      stateDisplay.pickupMenuDisplay();
    } else if (state=='i') {
      stateDisplay.inventoryMenuDisplay();
    } else if (state=='j') {
      stateDisplay.addInventoryMenuDisplay();
    } else if (state=='r') {
      stateDisplay.printingMenuDisplay();
    } else if (state=='c') {
      stateDisplay.cashRequisitionMenuDisplay();
    } else if (state=='w') {
      stateDisplay.priceMenuDisplay();
    }else if (state=='1') {
      stateDisplay.mainMenuSettingsDisplay();
    } else if (state=='2') {
      stateDisplay.pickupMenuSettingsDisplay();
    } else {
      println("ERROR in display state - controller");
    }    
  }

  void handleMouseDrag() {
    
    //translates the screen. The maximum translation is 10 multiplied by the height of the screen.
    
    //because the sliders respond to the mouse being dragged, they get their own mouse drag handle, which is insider their "void respond".
    if (sliders.size()>0) {
      sliders.get(0).respond(); 
    } 
    else {
      //if there are no sliders on the screen
      boolean scrollable=true;
      
      //if there is an order details or an item deatils panel open, do not scroll.
      for (int i=0;i<staticTextboxes.size();i++) {
        StaticTextbox staticTextbox=staticTextboxes.get(i);
        if (staticTextbox.returnText()=="Order Details" || staticTextbox.returnText()=="Item Details" || staticTextbox.returnText()=="Clothing Type Details") {
          scrollable=false;
        }
      }
      
      if (scrollable==true) {
        //otherwise, click and drag
        //also ensure that the clicking and dragging does not exceed the menu limits.
        translateX = constrain(translateX+mouseX-pmouseX,width-width*current_zoom,0);
        translateY = constrain(translateY+mouseY-pmouseY,height-height*current_zoom*maxYTranslate,0);
        //StateSetup is used to determine the maximum value of the maxYTranslate
      }
    }
  }
  
  void handleMousePress() {
    controller.respond(state);
  }
  
  void handleKeyPress() {
    controller.respond(state);
  }
  
  void handleMouseRelease() {
    controller.respond(state);
  }
  
  void handleMouseWheel(int wheelAmount) {

    //if there is an order details or an item deatils panel open, do not scroll/zoom
    boolean scrollable=true;
      for (int i=0;i<staticTextboxes.size();i++) {
        StaticTextbox staticTextbox=staticTextboxes.get(i);
        if (staticTextbox.returnText()=="Order Details" || staticTextbox.returnText()=="Item Details" || staticTextbox.returnText()=="Clothing Type Details") {
          scrollable=false;
        }
      }
    
    if (scrollable) {
      if (keyPressed && keyCode==CONTROL) {
        //Mousewheel+Control will zoom in/out
        
        float previous_zoom=current_zoom;
       
        translateX -= mouseX;
        translateY -= mouseY;
        zoom_change = wheelAmount > 0 ? 1.0/mouseZoomFactor : wheelAmount < 0 ? mouseZoomFactor : 1.0;
        current_zoom = constrain (current_zoom*zoom_change,min_zoom,max_zoom);
        
        //ensures that when zooming or translating, translations do not exceed the screen limits
        translateX = constrain(translateX*current_zoom/previous_zoom+mouseX, constrain(width-width*current_zoom,-999999,1), 0);
        translateY = constrain(translateY*current_zoom/previous_zoom+mouseY, constrain(height-height*current_zoom*maxYTranslate,-999999,1), 0);
        
        
      } else if (keyPressed && keyCode==SHIFT) {
        //move left/right if shift is pressed and mouse is wheeled
        translateX-=wheelAmount*20;
        translateX = constrain(translateX, width-width*current_zoom, 0);
    	
      } else {
        //move up/down (regular mousewheel)
        translateY-=wheelAmount*20;
        translateY = constrain(translateY, height-height*current_zoom*maxYTranslate, 0);
      }
    }
  }
}