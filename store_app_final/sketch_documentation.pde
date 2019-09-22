/*

Thank you for using the school store application.

This document provides information about how to edit this program and its data.

____________________________________________________

There are a few parts of this program that can be updated without editing the code, only the spreadsheets.
These are all related to the actual data (orders, inventory, designs, and sizes) entered into the program.
To edit these, you require no knowledge of computer science or prgoramming.

These are:
Editing the default clothing sizes
Editing/Adding designs/logos
Deleting/refunding orders
Deleting inventory

For instructions about completing these tasks, see 1.1 (Updating the data) below.

Any updates/improvements to the actual program and its functionality must be completed by updating the code of this program.
Anything else has to be completed by updating the code of this program.
To update the code, you will need computer science experience, especially with java or processing (computer science 30 at Walter Murray Collegiate)

A list of common code updates can be found in 2.2 (Updating the code) below.



_______________________________________________________________________________________________________________________________________________________________________________
1.1 
Updating the data (no programming experience required)
1.11: Editing the default clothing sizes
1.12: Editing/Adding Designs/Logos
1.13: Deleting/Refunding Orders
1.14: Deleting Inventory

____________________________________________________

1.11:
Editing the default clothing sizes

1. Open the folder, "data"
2. Click on the "sizes" spreadsheet

3. To delete a size:
Right click on the box that you want to delete.
Go to delete -> Delete entire row

3. To add a size
Type the size on the bottom of the list

4. Save the file. When the document asks you to save it as a .xls file, click NO. (it only works in .csv file format) 

____________________________________________________

1.12:
Editing/Adding Designs/Logos

1. Open the folder, "data"
2. Click on the "designs" spreadsheet

3. To delete a design:
Right click on the box that you want to delete.
Go to delete -> Delete entire row

3. To add a design:
Type the size on the bottom of the list

4. Save the file. When the document asks you to save it as a .xls file, click NO. (it only works in .csv file format) 
____________________________________________________

1.13:
Deleting/Refunding Order

1. Open the folder, "data"
2. Click on the "orders" spreadsheet
3. Use the find function (Control+f) to find the name of the customer.
4. Right click on the order/row that you want to delete 
5. Go to delete -> Delete entire row
6. Save the file. When the document asks you to save it as a .xls file, click NO. (it only works in .csv file format) 

____________________________________________________

1.14:
Deleting Inventory

1. Open the folder, "data"
2. Click on the "inventory" spreadsheet
3. Use the find function (Control+f) to find the correct type of clothing (including the size and colour).
4. Right click on the order/row that you want to delete 
5. Go to delete -> Delete entire row
6. Save the file. When the document asks you to save it as a .xls file, click NO. (it only works in .csv file format) 

_______________________________________________________________________________________________________________________________________________________________________________

2.0 
Code guidelines/documentation

There is modertely complicated programming involved with this application, but this documentation should make it much easier to edit and improve it.

____________________________________________________

2.11
General Programming Guidelines

- The main frame initalizes all of the global variables.
- stateSetup has a function known as startup, which places values in all of the global variables when it is initalized.
- The controller receives all input from the user and "controls" the entire operation.
- The main frame, in every frame, activates controller.display(state), which activates the stateDisplay for the appropriate menu.
- The main frame, upon any user input, relays this to the controller.respond(state), which activates stateRespond.
- When a button is pressed, it will react and generate other buttons (inside of it), or setup a new state in setupstate
- setupState generates the buttons for each state to display and respond.

The main frame should be used to initialize all global variables. It already relays all fuctions to the controller.
The controller should be used to activate the approriate void in stateDisplay (through void display) and stateRespond (through handle ____).
The stateDisplayer should merely display all buttons in order of priority.
The StateResponder should check (through boolean respond) if each button has been clicked/pressed based on the controller's message to the stateResponder,
then create new buttons/take actions if one of the buttons has been activated. (the responsiveButton class defies this principle - a future improvement)

All other classes are buttons (buttons are classes that can be displayed on screen and respond to the mouse and/or keyboard)
- They change/respond based on input that is put into them by the stateResponder through their boolean respond.
- They display through their void display, which is requested by stateDispalyer. Their can be highlighted if the mouse is over top of them.

See 2.2 for editing instructions.
IF YOU MAKE ANY CHANGES, PLEASE, PLEASE, PLEASE SAVE IT AS A NEW VERSION

____________________________________________________
2.12

Other general programming information:
- When calling functions on responsive buttons, they must be followed by two dummy integers (e.g. (1,1) )
- A ResponsiveUnmovingButton does not respond to translation or scaling, but a ResponsiveMovingButton does.
- The classes Checkbox, DropDownMenu, PasswordChecker, SettingsButton, and Slider are all generalist classes, and editing them should be avoided.
- The responsiveButton class should be edited to be a generalist function, with the stateResponder performing most of its functions.
- All other classes are specific classes, and can/should be edited when changes are needed.
____________________________________________________
2.13
Hierarchy of functions:

Highest
1. Main
2. Controller
3. stateDisplay=stateRespond=stateSetup
4. Checkbox=DropDownMenu=PasswordChecker=ResponsiveButton=SettingsButton=Slider=staticTextBox=TextInputBox
Lowest

____________________________________________________
2.14
Hierachy of controls:

main -> Controller
Controller -> stateSetup
Controller -> stateDisplay
Controller -> stateRespond

stateSetup -> generate buttons for stateDisplay and stateSetup

stateSetup -> activates Constructors on all other classes
StateDisplay -> activates void display on all other classes
StateRespond -> activates boolean respond on all other classes

all other classes -> can activate setupState to change the state.

____________________________________________________

2.15
Possible States

There are many different states for this program:
'a': Setup/Loading screen
'l': Login
'm': Main Menu
'o': Ordering Menu (to place orders)
'p': Pickup Menu (orders to pickup)
'r': Printing Menu (orders to print)
'i': Inventory Menu
'j': Add Inventory Menu
'c': Cash Requisition Menu
'w': Price Menu
'1': Main Menu Settings
'2': Pickup Menu Settings

Action locations:
In the responsive button code, these letter will take actions, rather than going to a specific state.
'z': Opens a order details or item details box, depending on the state
'x': Performs all other actions

____________________________________________________

2.16
rMouseX/rMouseY.

rMouseX means relative mouseX, used to compensate for xzoom
rMouseY means relative mouseY, used to compensate for yzoom

On any buttons with the property that they translate/zoom, their position must be checked with rMouseX and rMouseY, rather than mouseX and mouseY.

_______________________________________________________________________________________________________________________________________________________________________________


2.2
TO EDIT (for future operators/editors):

IF YOU EDIT THIS, PLEASE, PLEASE, PLEASE, PLEASE, PLEASE SAVE IT AS A DIFFERENT FILE AND A NEW VERSION
Do not delete this old file, archive it instead
Write your changes in the patch notes (3.1).
Add any new features to 3.0.

- The main frame should be edited when new global variables are needed.
- The controller should only be edited when a new state is added.
- The stateDisplay functions should be edited when a new state is added, or when there are new classes of buttons added to an already existing state
- The stateRespond functions should be edited whenever there is a change needed in functionality (this is where most changes should occur)
- The stateSetup function should be edited whenever there is new buttons needing to be initialized when a state is initally opened (most changes will also occur here)
- All other classes should be edited minimally

Once you edit the code, you must export the application again. See 2.26 for details.

___________________________________________________________________________________________
2.21
Adding a new button

If a button is to appear in a menu when a state is initalized:
- Place the appropriate contructor with the required information in the stateSetup.

If a button is to appear fter a certain action has been taken:
- Activate the appropriate contructor in stateRespond when the requirements are met

In both cases:
- If the button type was not already displayed through stateDisplay, then display it through there.
- If the button type was not already responding through stateRespond, then respond to it through there.
- Ensure that the button takes the corect actions by using stateRespond to take its action.

___________________________________________________________________________________________
2.22
Adding a new class of button

There are several key pieces of all types of buttons:
- An x position and y position, as well as other attributes
- One or more constructors, which set them up
- a boolean respond function, which returns true if the button is clicked or false if an action has no relation to the button
- a void display, which displays the button.

Include these functions in your new type of button

___________________________________________________________________________________________
2.23 Adding a new state

How to add a new state:

1. Decide on a character (char) for the new state, eg. 'e'. (example)
(Make sure the character hasn't already been used)

-----

2. In the controller:

In void display, add 

} else if (state=='e) {
  stateDisplay.___________MenuDisplay();

In void respond, add

} else if (state=='e) {
  stateRespond.___________MenuRespond();

-----

3. In stateSetup, add

else if (_state=='e') {
  
  maxYtranslate=(whatever the maximum y translation is)
  
  //then put in the constructors for all buttons here
  
}

-----

4. In stateDisplay, put functions to display all of the buttons used in the new state (follow the example used in stateDisplay), like so:

void ___________MenuDisplay(){ 

  //put any other button here
  
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

-----

5. In stateRespond, put functions to respond tp all of the buttons used in the new state (follow the example used in stateRespond), like so:

void ___________MenuRespond() {
  outerloop: {
    for (int i=staticTextboxes.size()-1;i>=0 && i<staticTextboxes.size();i--) {
      StaticTextbox staticTextbox=staticTextboxes.get(i);
      if (staticTextbox.respond(mouseX,mouseY)==true) {
        break outerloop;
      }
    }
    for (int i=responsiveButtons.size()-1;i>=0 && i<responsiveButtons.size();i--) {
      ResponsiveButton responsiveButton=responsiveButtons.get(i);
      if (responsiveButton.respond(1,1)==true) {
        break outerloop;
      }
    }
    
    //put any other buttons here
    
  }
} 

___________________________________________________________________________________________

2.24
Changing the password

How to change the password:

1. Select a new password.
2. Add the following characters to the new password:
Ru8_*x>3*+idZsnF<-d$:0y>5{BzB&
3. Place the "salted password" in a SHA-256 encrypter and get its "hash value"
(here's some suggested websites:
http://hash.online-convert.com/sha256-generator
http://passwordsgenerator.net/sha256-hash-generator/
http://www.xorbin.com/tools/sha256-hash-calculator
4. In the data of this program, there's a file called "p.txt" - *It may be hidden or read only.* Open the file.
5. Copy and paste the "hash" value into p.txt and save it. (re-hide the file and change it back into read-only)
6. Remember the password!

___________________________________________________________________________________________
2.25
Changing the possible window sizes

1. Find int[][] allWindowSizes in the main tab (store_app_v...)
2. add {width you want, length you want}
___________________________________________________________________________________________

2.26
Exporting the Application

1. Once you have changed the code, save the file under a new name.
2. Click File->Export Apllication
3. Check Windows and Embed Java for Windows (64 bit)



________________________________________________________________________________________________________________________________________________________________________________________________________________________________
3.0 List of features
This is a current list of features (when code is updated, update this list).
When the code is updated, please also write updates in 3.1 (Patch notes/updates).


GENERAL FEATURES:

Login Menu:
- The password can be any combination of lowercase or uppercase letters and numbers.
- It is salted, so it is at the highest possible modern security level.

Order Menu:
- A sequential manner in which to place orders
- The cost is shown on screen
- After all parts of the order have been completed, the order can be placed and will be saved
- Saved orders, as per before, will show up on the pickup and printing menus
- Can order multiple items of the same tiype at the same time.

Pickup Menu:
- The user of the program can see an overview of all orders
- They are also able to see the details of each order by clicking on it's button in the menu.
- They can mark when an order has been picked up
- Settings:
They can show orders if they are not yet printed (using a checkbox/boolean)
They can show orders that have already been picked up (using a checkbox/boolean)

Printing Menu:
- The user of the program can see an overview of all orders that are not yet printed
- They are also able to see the details of each order by clicking on it's button in the menu.
- They can mark when an order has been printed

Cash Requisition Menu:
- Includes instructions about completing cash requisition
- Also lists the amount of money earned since the application was opened

Price Menu:
- Lists all prices for clothing
- Allows each type of clothing to have its price adjusted.
- Maximum price: $100 (slider limits it)

Main Menu Settings:
- User can change screen size, zoom, and change to full screen.

Pickup Menu Settings:
- Can show orders that have already been picked up, as well as orders that are not yet printed
(but cannot pick these up)

OTHER FEATURES:
All user input involving order is saved in a spreadsheet.
The buttons only respond upon user input - saving valuable computing power.
The program responds to scrolling of the mousewheel.
If shift is pressed while scrolling, the program will translate in the x direction.
The program can zoom with control and the mouse.

______________________________________________________________________________________________________________

3.1
Patch/Code Updates

This is designed to be an extensive/exhaustive lists of updates made to the code.

If you update the code, please name it as a new version, and document all of your changes.

Each set of patch notes contains 3 parts:
New features
Changes
Bugfixes

The new features are new pieces of code that have significantly altered or added a new piece of functionality to the program.
The changes are new /updated pieces of code that are not significantly altered, but still represent a change in the application
Bugfixes are updates to the code that fix/solve errors that occur in the program.

____________________________________________________
Version 1.0
June 13th, 2016
Produced for Joel Wong's Major Project 
In association with the requirements of the school store.

NEW FEATURES:


All assets are loaded by the program, rather than manually typed in. 
All menus have continuity/communication (they all affect each other in an appropriate manner).

Added a cash requisition menu
- Includes instructions about completing cash requisition
- Also lists the amount of money earned since the application was opened

Added an inventory menu
- Lists all inventory from inventory spreadsheet
- Allows amount of each type of clothing to be adjusted using a slider
- Maximum amount of each type of clothing: 200 (slider limits it)

Added a Price Menu
- Lists all prices for clothing
- Allows each type of clothing to have its price adjusted.
- Maximum price: $100 (slider limits it)

Improved Order Menu:
- Added a quantity input
- Added Email and Cell Number Text Boxes

Andrew Kim completed processing/computer science student alpha testing
- Found several bugs, which were later fixed (see bugfixes below).

Nicolaus Goertzen performed alpha testing
- Found 2 bugs and provided several pieces of feedback regarding functionality
- Was confused about Cancel vs. Refund order
- Showed the necessity of confirmation messages
- Would like tabs to move to next text input box (added)
- Showed the lack of functionality of the inventory menu (functionality added)
- Would like notification if an option is out of stock
- Suggested stopping scrolling if an order detail panel is open (added)
- Suggested a scrollbar (I told him that clicking a dragging is implemented and just as effective)

Mr. Spurr performed beta testing 
- Found no bugs, but provided some feedback about ordering system
- Would like multiple items to be ordered at once (added)

Richard Cao performed alpha/beta testing
- Would like a yes/no confirmation message to be clicked on important actions (this would be difficult to implement - added to future developments)

Sydney Boulton performed beta testing
- Would like contact information (mail/cell number) to be added to orders (added)

Ms. T. Laverty performed beta testing
- Would like multiple items to be ordered at once (added)
- Would like the main menu button to be more visible/an distinguishable colour (added)

Nicolas Goertzen performed (more) alpha testing:
- Commented about colour scheme

Andrew Kim performed (more) alpha testing



CHANGES:

Created/Edited a variable to appropriately create a min/max y translation for each menu.
Changed the order details and printing details from a responsiveButton to a staticTextBox (since it doesn't respond).
Deleted the debugger printing of information.
Reduced max zoom to 200% from 300%.
Increased the size of the order details pane in the printing and pick up menus.
Changed "Name" on the order menu to "Full Name".
Stopped and/or clicking and draggin scrolling when an order details or item details panel is open.
Added a confirmation message when orders are placed, orders are printed, orders are picked up, inventory is added, and the amount of inventory is changed.
Added email and cell numbers as part of the order menu.
Ensured that there was continuity between all menus.
The tab button will move to the next textInputbox.



BUGFIXES:

(Found by Andrew Kim)
Fixed an error where the pickup settings menus would reset the zoom
Fixed an error where changing options in the order menu would cause the program to stop
Fixed an error where the user could click through the cancel  button in the printing and pickup menus
Fixed an error where the return to main menu button would be hidden under orders and could not be clicked.

(Found by Nicolaus Goertzen)
Fixed an error where the pickup men options would not show its banner.
Fixed an error where clicking on save in the inventory menu would also open the add inventory menu.



______________________________________________________________________________________________________________________
Version 0.2
Produced for Joel Wong's Array of Objects Assignment
April 22nd, 2016

NEW FEATURES:

The password is now stored in SHA-256 format
(which is esentially impossible to crack with a regular computer!)
*** The password is schoolstorepass6no2j7

Created a full functional pickup menu:
- The user of the program can see an overview of all orders
- They are also able to see the details of each order by clicking on it's button in the menu.
- They can mark when an order has been picked up

Created a settings buttons for the pickup menu:
- They can show orders if they are not yet printed (using a checkbox/boolean)
- They can show orders that have already been picked up (using a checkbox/boolean)

Created a fully functional printing menu:
- The user of the program can see an overview of all orders that are not yet printed
- They are also able to see the details of each order by clicking on it's button in the menu.
- They can mark when an order has been printed

Created a list of all attributes of the spreadsheets, making it easy
to display the text of the spreadsheets, or organize/update the text.

Changed cursor to crosshairs

Started to work on the order menu:
- Order menu allows for name to be placed in a text box
- Responds to clothing type selections
- Uses arrays to create a "decision tree"

Unfortunately, the order menu can not yet record/save any data to a spreadsheet.

CHANGES:
Changed the ResponsiveButton class into a superclass and two subclasses
When calling functions on responsive buttons, they must be followed by two dummy integers (e.g. (1,1) )
This uses the principles of both inheritance (and polymorphism).

Made the objects into arraylists

Made the window sizes into a 2 dimensional array


______________________________________________________________________________________________________________________
Version 0.1
Produced for Joel Wong's Object Oriented Programming Assignment
April 5th, 2016

NEW FEATURES:

A login menu has been created!
The password for this program is. 

(This password can be strengthened at a later date - for now, it is simply designed 
such that a person with access to the document in which the password is stored 
cannot access the password)
This password input assumes that the user cannot change the code but can access the password document.
Because of this method of storing passwords, it takes a while for the program to load.

The menu names have changed and a new menu has been added (but there are still no applications within the menus)

The buttons now only respond upon user input - saving valuable computing power.

The program now respond to scrolling of the mousewheel 
If shift is pressed while scrolling, the program will translate in the x direction.

Added a slider to change zoom level (which can be reused for other functions later)

Added order table and schedule table in data.

CHANGES:
All functions from the state variables version of this assignment are now located in objects.

Only the settings can now be translated.

______________________________________________________________________________________________________________________
Version 0.0
Produced for Joel Wong's State Variables assignment
March 8th, 2016

Currently, this program only functions as a menu for the school store.
It is programmed such that more features can be added later in this course.

The main menu and settings can be translated. (Intentionally designed to showcase features)

The settings contains useful/effective resizing commands for the window.
The program interprets data from the inventory table (the csv file) and prints it in the debug console (will later be displayed on screen).


________________________________________________________________________________________________________________________________________________________________________________________________________________________________
4.0
Areas for future development

This is a non-exhaustive list of future developments that could be compelted to this program.


Content:
- Add in actual data (inventory, orders)
- Record orders by date on another speadsheet for later analysis in cash requisition menu
- Price of items based on order menu selections (size, design, etc.)
- Previews of orders on order menu, printing menu, and pickup menu (pictures)
- Record the amount that a customer paid for their clothing

Code Quality/Efficiency:
- Remove highlighting of two responsive buttons when the mouse covers both.
- Change all types of user response buttons into a button superclass
- Change all variables in classes to be inputted variables (this is a general programming idea - all classes should be self-contained)


*/