/*

Welcome to the School Store Application code!!!

This application provides an interface for the operation of the Walter Murray School Store.

This project was created as a Computer Science 30 Major Project, 
with the goal of applying the information from Computer Science 30.

Created by Joel Wong

With alpha and beta testing by:
Andrew Kim
Nic Goertzen
Mr. Spurr
Sydney Boulton
Richard Cao
Ms. T. Laverty

More programming and editing information is located in the "sketch_documentation" file.

The password is SchoolStorePass6no2j7 (case sensitive)

Created in Processing 3.1.1.

Copyright Joel Wong 2016
Creative Commons Non-Commercial+Attribution License
For commercial use, contact Joel Wong at joelw@sasktel.net

*/

//----------------------------------------------------------------------------

/*
FOR USERS
You can edit any of the variables between the line above and the line below.
*/

String[] sizeOptions = {"Small","Medium","Large","XL","2XL", "3XL"};
//add any additional sizes like so: "Size"

int max_clothing=200;
//maximum amount of inventory that can be inputed

int max_price=100;
//maximum price of a piece of clothing

//----------------------------------------------------------------------------

/*
DO NOT CHANGE ANYTHING PAST THIS POINT UNLESS YOU HAVE READ THE DOCUMENTATION (sketch_documentation) AND HAVE COMPUTER SCIENCE EXPERIENCE

PLEASE SAVE A COPY OF THIS FILE UNDER A NEW NAME WHEN YOU EDIT IT.
*/






import java.security.MessageDigestSpi;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.*;

//These will be automatically completed during startup of the program
//----------------------------------------------------------------------
//All combinations of clothing
String[][][] clothingCombinations;

//The types of clothing are determined by the different types of clothing in the inventory menu
String[] clothingTypes;

//If there is more information needed to be saved, those headers need to be placed on the spreadsheet (and will be loaded during startup).
String[] orderParts;
String[] inventoryParts;
String[] priceParts;

//amount that will be cash requisited if no sales are made
int cash_requisition_amount=0;

//state of app (starts at login)
private char state='a';

//variables for zooming/scaling/moving image
float current_zoom=1;
float zoom_change=1;
float translateX=0;
float translateY=0;

//These can be changed to set the maximum and minimum zoom. 
//Note: Changing the minimum zoom may cause the translation of x and y to function improperly.
//Changing the max_zoom will have no impact on the translation of x and y.
float max_zoom=2.0; //200% maximum
float min_zoom=1.0; //100% minimum

//When Control+Scroll is used to zoom in and out, this is the amount that the zoom is multiplied by 
float mouseZoomFactor=1.1;

//relative mouseX and mouseY
float rMouseX;
float rMouseY;

//Tables for inventory, orders, prices, designs, and sizes.
Table inventoryTable;
Table orderTable;
Table priceTable;
Table designTable;
Table sizeTable;

//password
byte[] password = new byte[32];

//this variable will be later used to determine the maximum y translation of the screen
float maxYTranslate = 1;

//list of all possible pairings of window sizes
int numWindowSizes=0;
int[][] allWindowSizes={{600,512},{768,576},{1024,600},{1280,752},{1536,800},{1600,900},{1720,960},{1920,1080}};
// new window size are in the form {yourWidth,yourHeight}

//window settings
boolean windowIsFullScreen=false;

//pickup menu settings
boolean showNotPrinted=false;
boolean showPickedUp=false;

//global variables for keeping track of user input
boolean mouseIsDow=false;
String keysEntered="";

// several buttons are available - they are in arrayLists for ease of access and programming
ArrayList<DropdownMenu> dropdownMenus = new ArrayList<DropdownMenu>(0);
ArrayList<ResponsiveButton> responsiveButtons = new ArrayList<ResponsiveButton>(0);
ArrayList<StaticTextbox> staticTextboxes = new ArrayList<StaticTextbox>(0);
ArrayList<Checkbox> checkboxes = new ArrayList<Checkbox>(0);
ArrayList<Slider> sliders = new ArrayList<Slider>(0);
ArrayList<TextInputBox> textInputBoxes = new ArrayList<TextInputBox>(0);

//Everything else is a singular object.
SettingsButton settingsButton = new SettingsButton(30,482);
PasswordChecker passwordChecker = new PasswordChecker ();
StateSetup stateSetup = new StateSetup(); 
StateResponder stateRespond = new StateResponder();
StateDisplayer stateDisplay = new StateDisplayer();

// main controller - all keys are inputed into the controller, which handles them and tells each object to respond.
Controller controller = new Controller(state);;



//---------------------------------------------------------------------------------------------------------------------

//The program works as follows:
//Every frame, the display is pasted onto the screen.
// In each frame, if there has been an action taken by a user, this is responded to through the controller's void respond.

void setup() {
  //size starts at 600,512, but can be changed in the program
  size(600,512);
  
  //most of the coordinating in this program is based on center mode.
  ellipseMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  cursor(CROSS);
}

void draw() {
  //origin of all repeating functions
  
  //each frame, the program translates and scales in order to zoom,
  setMatrix();
  
  //then pastes the buttons/information onto the screen based on the state
  controller.display(state);

  //and resets the tranlslation and scaling at the end of the frame.
  popMatrix();
}

void setMatrix() {
  pushMatrix();
  
  // zoom/translation
  translate(translateX,translateY);
  scale(current_zoom);
  
  //relative mouse position calculation
  calculateRelativeMousePositions();
}

void calculateRelativeMousePositions () {
  rMouseX=(mouseX-translateX)/current_zoom;
  rMouseY=(mouseY-translateY)/current_zoom;
}

//---------------------------------------------------------------------------------------------------------------------

//Takes in user input and relays it to the controller.
void mouseDragged() { 
  controller.handleMouseDrag();
}

void mouseWheel(MouseEvent e) {
  controller.handleMouseWheel(e.getCount());  
}

void mouseReleased() {
  controller.handleMouseRelease();
}

void keyPressed () {
  controller.handleKeyPress();
}

void mousePressed() {
  controller.handleMousePress();
}