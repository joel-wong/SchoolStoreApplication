class StateDisplayer {
  
  // this is a class that runs through all buttons for each menu in each frame in order to display them
  
  //no attributes
  StateDisplayer () {
  }
 
  /*
  Each screen works as follows:
  It will be under the title, "____MenuDisplay"
  
  For each arrayList/button type that is used in a given menu, that button is displayed on screen.
  This displaying occurs in every frame.
  Each menu only has certains buttons within it, so it only needs certain buttons to display.
  
  Each arraylist is displayed in reverse order based on priority -
  for example, staticTextBoxes typically overlay everything and are displayed last.
  The most important things are LAST.
  
  For responsiveButtons, you have to put in two "dummy integers" such as (1,1)
  (the subclass needs them since its superclass takes in two integers)
  
  The checkbox class needs a boolean inputted to determine whether it should be checked or not.
  
  All other classes display without any input
  
  Generally, the order of importance is 
  (Most important, listed last    to    least important, listed first) 
  sliders > staticTextBoxes > responsiveButtons > dropDownMenus > textInputBoxes = checkboxes
  */
 
 
 
  void loadingScreenDisplay() {
    
    //shows a display screen/text
    textSize(30);
    text("loading...", width/2,height/2);
    textSize(10);
    text("yes, really, it is loading - this should take 5 seconds or less", width/2, 500);
    
    //on the second frame, load everything then go to the login menu
    if (frameCount>1) {
      stateSetup.startup();
      stateSetup.setupState('l',true);
    } 
    
  }
  
  void loginDisplay() {

    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
    
    popMatrix();
    //ensure that the textInputBox does not move with scrolling/zooming
    
    for (int i=textInputBoxes.size()-1;i>=0 && i<textInputBoxes.size();i--) {
      TextInputBox textInputBox=textInputBoxes.get(i);
      textInputBox.display();
    }
    passwordChecker.displayMessage();
    
    setMatrix();
    
  }  
  
  
  void mainMenuDisplay(){ 
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    settingsButton.display();
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
    
  }
  
  void orderMenuDisplay() {
    for (int i=textInputBoxes.size()-1;i>=0 && i<textInputBoxes.size();i--) {
      TextInputBox textInputBox=textInputBoxes.get(i);
      textInputBox.display();
    }
    for (int i=dropdownMenus.size()-1;i>=0;i--) {
      DropdownMenu dropdownMenu=dropdownMenus.get(i);
      dropdownMenu.display();
    }
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
  }
  
  void pickupMenuDisplay() {
    settingsButton.display();
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
  }  
  
  
  void printingMenuDisplay() {
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
  }    
  void cashRequisitionMenuDisplay() {
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
  }  
  
  void inventoryMenuDisplay() {
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
    for (int i=sliders.size()-1;i>=0 && i<sliders.size();i--) {
      Slider slider=sliders.get(i);
      slider.display();
    }
  }
  
  void addInventoryMenuDisplay() {
    for (int i=textInputBoxes.size()-1;i>=0 && i<textInputBoxes.size();i--) {
      TextInputBox textInputBox=textInputBoxes.get(i);
      textInputBox.display();
    }
    for (int i=dropdownMenus.size()-1;i>=0;i--) {
      DropdownMenu dropdownMenu=dropdownMenus.get(i);
      dropdownMenu.display();
    }    
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
  }
  
  void priceMenuDisplay() {
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
    for (int i=sliders.size()-1;i>=0 && i<sliders.size();i--) {
      Slider slider=sliders.get(i);
      slider.display();
    }
  }  
  
  void mainMenuSettingsDisplay() {
    for (int i=sliders.size()-1;i>=0 && i<sliders.size();i--) {
      Slider slider=sliders.get(i);
      slider.display();
    }
    for (int i=dropdownMenus.size()-1;i>=0;i--) {
      DropdownMenu dropdownMenu=dropdownMenus.get(i);
      dropdownMenu.display();
    }
    checkboxes.get(0).display(windowIsFullScreen);
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
  }
  
  void pickupMenuSettingsDisplay() {
    checkboxes.get(0).display(showNotPrinted);
    checkboxes.get(1).display(showPickedUp);
    for (int i=0;i<responsiveButtons.size();i++) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      responsiveButton.display(1,1);
    }
    for (int i=0;i<staticTextboxes.size();i++) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      staticTextbox.display();
    }
  }
 

  
  
  
  
}