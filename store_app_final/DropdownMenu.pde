class DropdownMenu {
  
  //This is a class that creates drop down menus based on its constructor.
  
  int xCenter;
  int yCenter;
  int rectWidth;
  int rectHeight;
  boolean menuOpen;
  String[] options;
  String currentOption="";
  String text;
  int num;
  boolean optionSelected=false;
  
  /*
  attributes:
  xCenter: The x position of the drop down menu
  yCenter: The y position of the drop down menu
  rectWidth: The width of the menu
  rectHeight: The height of the menu
  menuOpen: Whether the menu is open (initially, usually false)
  options: The options in the drop down menu
  currentOption: The currently selected option
  text: The description/text beside the drop down menu
  num: the number of the option selected (first option is 0, second option is 1, etc.)
  optionSelected: a boolean that changes to true when the menu is already open and the user just selected an option
  
  
  //Two constructors:
  */
  //Normal drop down menu
  DropdownMenu (int _xCenter,int _yCenter,int _rectWidth, int _rectHeight, String _text, String[] _options) {
    xCenter=_xCenter;
    yCenter=_yCenter;
    rectWidth=_rectWidth;
    rectHeight=_rectHeight;
    menuOpen=false;
    text=_text;
    options=_options;
  }
  
  //Drop down menu with one of the options already selected.
  DropdownMenu (int _xCenter,int _yCenter,int _rectWidth, int _rectHeight, String _text, String[] _options, String _currentOption) {
    xCenter=_xCenter;
    yCenter=_yCenter;
    rectWidth=_rectWidth;
    rectHeight=_rectHeight;
    menuOpen=false;
    text=_text;
    options=_options;
    currentOption=_currentOption;
  }  
  
  boolean respond () {
    
    //first check to ensure that no other dropDownMenus are open.
    for (int i=dropdownMenus.size()-1;i>=0 && i<dropdownMenus.size();i--) {
      DropdownMenu dropdownMenu=dropdownMenus.get(i);
      if (dropdownMenu.menuOpen==true && dropdownMenu!=this) {
        //if there is, return false and take no further action.
        return false;
      }
    }
    
    // if menu is open, check if there is one of the options clicked
    if (menuOpen==true) {
      float y=yCenter-30;
      for (int i = 0; i < options.length; i++) {
        if (!(options[i]==null)) {
          //ensure that the option exists
          y+=30;
          if (abs(rMouseX-xCenter)<rectWidth/2 && abs(rMouseY-y)<rectHeight/2 && mousePressed) {
            //the mousex and mouse y are clicking on one of the options in the open drop down menu

            optionSelected=true;
            
            num=i;
            currentOption=options[i]; //<>// //<>//
            
            menuOpen=false;
            
            return true;
          }
        }
      } 
      
      if (mousePressed) {
        // if the menu is open, close it
        //closes if there is a click outside the menu
        menuOpen=false;
        return true;
      }
      
    } else if (abs(rMouseX-xCenter)<rectWidth/2+2 && abs(rMouseY-yCenter)<rectHeight/2+2 && mousePressed) {
      //if the menu is closed, check is the menu is clicked so that it is opened.
      
      menuOpen=true;
      return true;
    }
    
    return false;
    
  }
  
  String returnText() {
    return currentOption;
  }
  
  int returnNum(){
    return num;
  }
  
  boolean optionSelected(){
    //was an option just selected in the drop down menu?
    //if so, return true
    
    //after checking if the drop down menu was just closed, it has no longer "just" been closed.
    if (optionSelected==true) {
      optionSelected=false;
      return true;
    }
    return false;
  }
  
  void display () {
    textSize(24);
    textAlign(RIGHT,CENTER);
    fill(255,0,0);
    text(text,xCenter-110,yCenter);
    textAlign(CENTER,CENTER);
    stroke(255,0,0);
    fill(0);
    if (abs(rMouseX-xCenter)<rectWidth/2 && abs(rMouseY-yCenter)<rectHeight/2) {
      //if the mouse is over the box,highlight it.
      fill(127,0,0);
    }
    rect(xCenter,yCenter,rectWidth,rectHeight);
    fill(0);
    
    
    
    if (menuOpen==true) {
      //if the menu is open, display it
      float y=yCenter-30;
      for (int i = 0; i < options.length; i++) {
        if (!(options[i]==null)) {
          //for every option...
          y+=30;
          if (abs(rMouseX-xCenter)<rectWidth/2 && abs(rMouseY-y)<rectHeight/2) {
            //if the mouse is over it, highlight the box
            fill(127,0,0);
          }
          else {
            fill(0);
          }
          
          //draw a rectangle around the text
          rect (xCenter,y,rectWidth,rectHeight);
          
          if (currentOption==options[i]) {
            //if this option is the currently selected option, highlight the text.
            fill(255);
          }
          else {
            fill(255,0,0);
          }
          text(options[i],xCenter,y);
        }
      }
    }
    else {
      //if the menu is closed, show the current/selected option.
      fill(255,0,0);
      text(currentOption,xCenter,yCenter);
    }
  }
}