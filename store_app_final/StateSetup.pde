class StateSetup {

  // This class sets up all of the buttons to display and respond based on the current state of the program.
  
  //no attributes
  
  StateSetup () {
  }
  
  /*
  This class is activated by different classes in order to reset the buttons for each state
  
  Because this is a high memory/computer processing class, it should be activated minimally 
  (only when a state changes, for example)
  
  For each state, a number of buttons, text boxes, and other variables are created and altered.

  Initially, all arrayLists are cleared.
  If a reset is needed, then translation is set to 0.
  A black box is automatically added to the top of the screen to highlight the banner/menu name.  
  Then, each state will have its own set of buttons that it creates (more documentation below)
  
  Each state also sets its own maxYTranslate, which is a value that tells the 
  controller how far the user can scroll up and down.
  
  All states have a staticTextBox banner and most have a main menu button in the bottom right corner.
  */

  void setupState (char _state, boolean resetTranslation) {

    state=_state;
    
    //reset translation if needed
    if (resetTranslation==true) {
      translateX=0;
      translateY=0;
    }

    //clear all buttons
    dropdownMenus.clear(); 
    responsiveButtons.clear();
    staticTextboxes.clear();
    checkboxes.clear();
    sliders.clear();
    textInputBoxes.clear();

    //automatically add a black box at top of screen
    staticTextboxes.add(new StaticTextbox(width/2, 60, width, 120, color(0), color(0),"",false));



    if (_state=='a') {
      //LOADING SCREEN
      maxYTranslate=1;
    } 
    
    
    
    else if (_state=='l') {
      //LOGIN SCREEN
      maxYTranslate=1;
      //shows a textInput box to enter the password. PAssword is entered by hitting the enter key.
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Walter Murray School Store Login", false));
      staticTextboxes.add(new StaticTextbox(width/2, height/2-30, 200, 40, color(100), color(255), "Password", false));
      textInputBoxes.add(new TextInputBox(width/2, height/2+30, 440, 50, "", color(150, 150, 150), color(255), true,""));
    } 
    
    
    
    else if (_state=='m') {
      //MAIN MENU
      maxYTranslate=1;
      //buttons to each menu
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Walter Murray School Store Main Menu", false));
      responsiveButtons.add(new ResponsiveUnmovingButton(width/2, 150, width/3, 50, color(150, 150, 150), "Order Menu", 'o', 24));
      responsiveButtons.add(new ResponsiveUnmovingButton(width/2, 215, width/3, 50, color(150, 150, 150), "Pickup Menu", 'p', 24));
      responsiveButtons.add(new ResponsiveUnmovingButton(width/2, 280, width/3, 50, color(150, 150, 150), "Printing Menu", 'r', 24));
      responsiveButtons.add(new ResponsiveUnmovingButton(width/2, 345, width/3, 50, color(150, 150, 150), "Cash Req Menu", 'c', 24));
      responsiveButtons.add(new ResponsiveUnmovingButton(width/2, 410, width/3, 50, color(150, 150, 150), "Inventory Menu", 'i', 24));
      responsiveButtons.add(new ResponsiveUnmovingButton(width/2, 475, width/3, 50, color(150, 150, 150), "Price Menu", 'w', 24));
    } 
    
    
    
    else if (_state=='o') {
      //ORDER MENU
      
      //set up clothing types for clothing type drop down menu
      
      ArrayList clothingTypeSetup=new ArrayList<String>(10);
      for (int i=0;i<inventoryTable.getRowCount();i++) {
        
        TableRow row=inventoryTable.getRow(i);
        
        //for each clothing type
        String newClothingType=row.getString("Clothing Type");
        
        if (!clothingTypeSetup.contains(newClothingType)) {
          //if the clothing type isn't included in the clothingTypes variable, add it.
          clothingTypeSetup.add(newClothingType);
        }
      }
      
      //convert arrayList to array.
      clothingTypes=new String[clothingTypeSetup.size()];
      clothingTypeSetup.toArray(clothingTypes);
      
      //the y translation depends on the height of the window.
      maxYTranslate=constrain(632.0/height,1,1000);
      
      
      //buttons that allow orders to be inputted
      textInputBoxes.add(new TextInputBox(width/2+40, 150, 400, 40, "", color(150, 150, 150), color(255), true, "Full Name"));
      dropdownMenus.add(new DropdownMenu(width/2-100, 200, 200, 30, "Type", clothingTypes));
      
      
      //main menu and banner
      responsiveButtons.add(new ResponsiveUnmovingButton(width-100, height-33, 150, 40, color(100, 100, 255), "Main Menu", 'm', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Order Menu", false)); 
    } 
    
    
    
    else if (_state=='p') {
      //PICKUP MENU

      //starting place for information
      int place=150;

      //for each row in the order table
      for (int i=0; i<orderTable.getRowCount(); i++) {
        
        TableRow row=orderTable.getRow(i);
               
        if (!(row.getString(orderParts[orderParts.length-1])==null)) {
          //if the row is fully filled in
                         
          if (
            (row.getString("Order Printed")).equals("Yes") &&  (row.getString("Order Picked Up")).equals("No") || 
            //natural state - any order that is not picked up but is printed is diplayed
            ((row.getString("Order Picked Up")).equals("No") && showNotPrinted==true) ||
            // if the showNotPrinted button is pressed, show anything that has not been picked up
            ((row.getString("Order Printed")).equals("Yes") && showPickedUp==true) ||
            // if the showPickedUp button is pressed, show anything that has been printed
            (showNotPrinted==true && showPickedUp==true)
            // if both the showNotPrinted and showPickedUp button are pressed, show everything
            ) {
              
            //if the order is ready for pick up or the settings say that the order is to be displayed
  
            //make a short blurb to display
            String shortOrder="";  
            
            //the blurb includes the name, type of clothing, whether its printed, and whether its picked up.
            for (int j=0; j<2; j++) {
              if (j>0) {
                shortOrder+=" | ";
              }
              shortOrder+=(row.getString(orderParts[j]));
            }
            //add whether or not the order has been printed
            if (row.getString("Order Printed").equals("Yes")) {
              shortOrder+=" | Printed";
            } else {
              shortOrder+=" | Not Printed";
            }
            //add whether or not the order has been picked up
            if (row.getString("Order Picked Up").equals("Yes")) {
              shortOrder+=" | Picked Up";
            } else {
              shortOrder+=" | Not Picked Up";
            }
            
            //add the button to the list of buttons
            responsiveButtons.add(new ResponsiveMovingButton(width/2, place, width-40, 30, color(150, 150, 150), shortOrder, 'z', 20, i));
  
            //next information is displayed down a line (down 32)
            place+=32;
          }
        }
      }

      //the maxYtranslate is based on the number of lines
      maxYTranslate=constrain((50.0+parseFloat(place))/height, 1, 100);
      
      
      responsiveButtons.add(new ResponsiveUnmovingButton(width-100, height-33, 150, 40, color(100, 100, 255), "Main Menu", 'm', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Pickup Menu", false));
    }
    
    
    
    else if (_state=='r') {
      //PRINTING MENU


      //starting place for information
      int place=150;

      //for each row in the ordertable
      for (int i=0; i<orderTable.getRowCount(); i++) {
        
        TableRow row=orderTable.getRow(i);
        
        //ensure that the row is fully filled in
        if (!(row.getString(orderParts[orderParts.length-1])==null)) {

          //only display order that are not yet printed
          if ((row.getString("Order Printed")).equals("No")) {
            
            //create a variable for displaying information about the order
            String shortOrder="";
            
            for (int j=0; j<4; j++) {
              if (j>0) {
                shortOrder+=" | ";
              }
              shortOrder+=(row.getString(orderParts[j]));
            }
  
            //create a button that will display the order
            responsiveButtons.add(new ResponsiveMovingButton(width/2, place, width-40, 30, color(150, 150, 150), shortOrder, 'z', 20, i));
  
            //next information is displayed down a line (down 32)
            place+=32;
          }
        }
      }
      
      //alter y tranlsate so that the screen can be moved to the bottom of the list
      maxYTranslate=constrain((50.0+parseFloat(place))/height, 1, 100);
      
      //banner and main menu button
      responsiveButtons.add(new ResponsiveUnmovingButton(width-100, height-33, 150, 40, color(100, 100, 255), "Main Menu", 'm', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Printing Menu", false));
    } 
    
    else if (_state=='c') {
      //CASH REQUISITION MENU
      
      maxYTranslate=1;
      responsiveButtons.add(new ResponsiveUnmovingButton(width-100, height-33, 150, 40, color(100, 100, 255), "Main Menu", 'm', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Cash Requisition Menu", false));
      
      //write how to complete cash requisition
      staticTextboxes.add(new StaticTextbox(width/2, 150, 590, 60, color(0,0,255), color(0, 0, 255), "Instructions for Cash Requisition:", 20,true));
      staticTextboxes.add(new StaticTextbox(width/2, 200, 590, 30, color(150, 150, 150), color(150, 150, 150), "1. Count ALL of the money in the float (use pen and paper to help!)", 14,true));
      staticTextboxes.add(new StaticTextbox(width/2, 230, 590, 30, color(150, 150, 150), color(150, 150, 150), "2. Subtract the amount originally in the float and leave that money in the float", 14,true));
      staticTextboxes.add(new StaticTextbox(width/2, 260, 590, 30, color(150, 150, 150), color(150, 150, 150), "(the amount is labelled on the float) - try to leave $0.25, $1, $2, and $5 ONLY", 14,true));
      staticTextboxes.add(new StaticTextbox(width/2, 290, 590, 30, color(150, 150, 150), color(150, 150, 150), "3. Ensure that the amount counted is equal to the amount below.", 14,true));
      staticTextboxes.add(new StaticTextbox(width/2, 320, 590, 30, color(150, 150, 150), color(150, 150, 150), "4. Place the cash earned in a brown cash requisition envelope", 14,true));
      staticTextboxes.add(new StaticTextbox(width/2, 350, 590, 30, color(150, 150, 150), color(150, 150, 150), "5. Complete all fields on the cash requisition envelope.", 14,true));
      
      //show how much is to be in the cash requisition
      staticTextboxes.add(new StaticTextbox(width/2, 410, 590, 60, color(0,0,255), color(0, 0, 255), "CASH REQUISITION AMOUNT: $"+cash_requisition_amount+".00", 20,true));
    } 
    
    else if (_state=='i') {
      //INVENTORY MENU

      //starting place for information
      int place=150;

      //for row in the inventory table
      for (int i=0; i<inventoryTable.getRowCount(); i++) {
        TableRow row=inventoryTable.getRow(i);
        
        //if the row is fully complete
        if (!(row.getString(inventoryParts[inventoryParts.length-1])==null)) {
          
          //create a variable to show some of the details of the order
          String shortOrder="";
          
          for (int j=0; j<4; j++) {
            if (j>0) {
              shortOrder+=" | ";
            }
            shortOrder+=(row.getString(inventoryParts[j]));
          }
  
          //make it into a button
          responsiveButtons.add(new ResponsiveMovingButton(width/2, place, width-40, 30, color(150, 150, 150), shortOrder, 'z', 20, i));
  
          //next information is displayed down a line (down 32)
          place+=32;
        }
      }

      //alter y tranlsate so that the screen can be moved to the bottom of the list
      maxYTranslate=constrain((50.0+parseFloat(place))/height, 1, 100);
      
      //button to add new inventory types, to go to the main menu, and display the banner
      responsiveButtons.add(new ResponsiveUnmovingButton(width/2, height-33, 200, 40, color(100,255,100), "New Inventory", 'j', 24));
      responsiveButtons.add(new ResponsiveUnmovingButton(width-80, height-33, 150, 40, color(100,100,255), "Main Menu", 'm', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Inventory Menu", false));
    } 
    
    else if (_state=='j') {
      //ADD INVENTORY MENU
      
      maxYTranslate=1;
      
      //for each part of the inventory, allow the user to enter the details in a text box
      textInputBoxes.add(new TextInputBox(width/2+100, 150, width-275, 40, "", color(150, 150, 150), color(255), true, "Clothing Type"));
      textInputBoxes.add(new TextInputBox(width/2+100, 200, width-275, 40, "", color(150, 150, 150), color(255), false, "Clothing Colour"));
      textInputBoxes.add(new TextInputBox(width/2+100, 250, width-275, 40, "", color(150, 150, 150), color(255), false, "Clothing Size"));
      textInputBoxes.add(new TextInputBox(width/2+100, 300, width-275, 40, "", color(150, 150, 150), color(255), false, "Clothing Amount"));
      
      //button to confirm details of the addition of the inventory
      responsiveButtons.add(new ResponsiveMovingButton(width/2-10,400,250,40,color(100,255,100),"Add Inventory",'x',24));
      
      //buttons to go to other menus/the banner
      responsiveButtons.add(new ResponsiveUnmovingButton(width-120, height-33, 200, 40, color(100,100,255), "Inventory Menu", 'i', 24));
      responsiveButtons.add(new ResponsiveUnmovingButton(120, height-33, 200, 40, color(100,100,255), "Price Menu", 'w', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Add New Inventory Menu", false));
      
    } 
    
    else if (_state=='w') {
      //PRICES MENU

      //starting place for information
      int place=150;
      
      //for each clothing type
      for (int i=0; i<clothingTypes.length; i++) {
        
        //summary of clothing type/price
        String shortOrder="";

        for (int j=0; j<2; j++) {
          if (j>0) {
            shortOrder+=" | ";
          }
          //add its name and its price
          shortOrder+=(clothingCombinations[i][0][j]);
        }

        //make this into a button for further details
        responsiveButtons.add(new ResponsiveMovingButton(width/2, place, width-40, 30, color(150, 150, 150), shortOrder, 'z', 20, i));
        
        //next information is displayed down a line (down 32)
        place+=32;
      }
      
      //alter y tranlsate so that the screen can be moved to the bottom of the list
      maxYTranslate=constrain((50.0+parseFloat(place))/height, 1, 100);
      
      //main menu button and banner
      responsiveButtons.add(new ResponsiveUnmovingButton(width-80, height-33, 150, 40, color(100, 100, 255), "Main Menu", 'm', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Price Menu", false));
      
      
    }
    
    
    else if (_state=='1') {
      //MAIN MENU SETTINGS
      
      maxYTranslate=1;
      
      //fullscreen/non-fullscreen checkbox
      checkboxes.add(new Checkbox (width/2-200, 200, 50, 50, "Fullscreen"));
      
      //convert all possible window sizes into strings to be displayed
      String[] oneDimensionalWindowSizes = new String[allWindowSizes.length];
      for (int i=0;i<allWindowSizes.length;i++){
        oneDimensionalWindowSizes[i]=allWindowSizes[i][0]+" x "+allWindowSizes[i][1];
      }
      
      //create a drop down menu with these strings of the window sizes
      dropdownMenus.add(new DropdownMenu(width/2, 300, 200, 30, "Window Size", oneDimensionalWindowSizes, width+" x "+height));
      
      //zoom increase/decrease slider
      sliders.add(new Slider(400, width/2, 400, min_zoom, max_zoom, "Zoom", current_zoom,true));
      
      //main menu button and banner
      responsiveButtons.add(new ResponsiveUnmovingButton(width-100, height-33, 150, 40, color(100, 100, 255), "Main Menu", 'm', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Main Menu Settings", false));
    } 
    
    else if (_state=='2') {
      //PICKUP MENU SETTINGS
      
      maxYTranslate=1;
      
      //checkboxes to show/not show non-printed order and picked up orders
      checkboxes.add(new Checkbox (width/2-200, 200, 50, 50, "Show Non-Printed Orders"));
      checkboxes.add(new Checkbox (width/2-200, 400, 50, 50, "Show Picked Up Orders"));
      
      //pickup menu button and banner
      responsiveButtons.add(new ResponsiveUnmovingButton(width-100, height-33, 180, 40, color(150, 150, 150), "Pickup Menu", 'p', 24));
      staticTextboxes.add(new StaticTextbox(width/2, 60, width, 60, color(50, 50, 255), color(255,255,255), "Pickup Menu Settings", false));
      
    } 
    
    else {
      //otherwise you have gone to an unknown state
      println("ERROR in setupState");
    }
    
    
    
  }


  void startup() {
    //THIS IS THE FUNCTION THAT LOADS EVERYTHING
    //run during the loading screen
    //also run when called by stateSetup.startup() through some responsive buttons.
       
    //------------------------------------------------------------
    //load the headers of the inventory, order and price spreadsheets 
    
    
    //loads the headers of the inventory spreadsheet --
    inventoryTable = loadTable("data/inventory.csv");
    
    inventoryParts=new String[inventoryTable.getColumnCount()];
    for (int i=0;i<inventoryTable.getColumnCount();i++) {
      inventoryParts[i]=inventoryTable.getRow(0).getString(i);
    }

    //loads the headers of the orders spreadsheet --
    orderTable = loadTable("data/orders.csv");
    
    orderParts=new String[orderTable.getColumnCount()];
    for (int i=0;i<orderTable.getColumnCount();i++) {
      orderParts[i]=orderTable.getRow(0).getString(i);
    }
    
    //loads the headers of the price spreadsheet -- 
    priceTable = loadTable("data/prices.csv");
    
    priceParts=new String[priceTable.getColumnCount()];
    for (int i=0;i<priceTable.getColumnCount();i++) {
      priceParts[i]=priceTable.getRow(0).getString(i);
    }

    //------------------------------------------------------------
    //setup inventory table, order table, and schedule table, with the headers
    inventoryTable = loadTable("data/inventory.csv", "header");
    orderTable = loadTable("data/orders.csv", "header");
    priceTable=loadTable("data/prices.csv","header");   
    designTable=loadTable("data/designs.csv","header");    
    sizeTable=loadTable("data/sizes.csv","header");
        
    //----------------------------------------------------------------------------------------------------------------------------------------------------------
    //set up clothing types for clothing type drop down menu and price menu based on the priceTable
    
    clothingTypes=new String[priceTable.getRowCount()];
    
    for (int i=0;i<priceTable.getRowCount();i++) {
      TableRow row=priceTable.getRow(i);
      
      String newClothingType=row.getString("Clothing Type");
      
      clothingTypes[i]=newClothingType;
    }
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------
    //setup the clothing combinations 3-dimensional array
    //completed using an 3-dimensional arrayList, since the number of colours, for example, for a given type of clothing is unknown.
    //this arrayList iss converted to an array at the end.

    //initialize the 3D arrayList
    ArrayList<ArrayList<ArrayList<String>>> clothingCombinationsSetup = new ArrayList<ArrayList<ArrayList<String>>>(10);
    
    //for each type of clothing
    for (int i=0;i<clothingTypes.length;i++) {
      
      //get its pice
      TableRow row=priceTable.getRow(i);
      
      //create a 2D arrayList so that the details of the clothing can be added
      ArrayList<ArrayList<String>> currentClothing=new ArrayList<ArrayList<String>>(10);
      
      //create a 1D arrayList with the clothing Type/Name and its price
      ArrayList<String> thisArrayList0=new ArrayList<String>(10);
      thisArrayList0.add(row.getString("Clothing Type"));
      thisArrayList0.add(row.getString("Clothing Price"));
      
      //add the type and price array to the current clothing details.
      currentClothing.add(thisArrayList0);
      
     //create a 1D arrayList so that the colours of the clothing can be added
      ArrayList<String> thisArrayList1=new ArrayList<String>(10);
      
      //for each row in the invetory table, if it contains the clothing type, then add its clothing colour to the list of clothing clolours
      for (int j=0;j<inventoryTable.getRowCount();j++) {
        row=inventoryTable.getRow(j);
        if (row.getString("Clothing Type").equals(currentClothing.get(0).get(0)) && !thisArrayList1.contains(row.getString("Clothing Colour"))) {
          //but only if the clothing colour is not already included
          thisArrayList1.add(row.getString("Clothing Colour"));
        }
      }
      
      //add the clothing colours array to the current clothing details.
      currentClothing.add(thisArrayList1);
      
      //create a 1D arrayList so that the sizes of the clothing can be added
      ArrayList<String> thisArrayList2=new ArrayList<String>(10);
      
      //find default sizes in the size table
      for (int j=0;j<sizeTable.getRowCount();j++) {
        thisArrayList2.add(sizeTable.getRow(j).getString("Size"));
      }
      
      //add any custom sizes that were inputted through the inventory menu
      for (int j=0;j<inventoryTable.getRowCount();j++) {
        row=inventoryTable.getRow(j);
        if (row.getString("Clothing Type").equals(currentClothing.get(0).get(0)) && !thisArrayList2.contains(row.getString("Clothing Size"))) {
          thisArrayList2.add(row.getString("Clothing Size"));
        }
      }
      
      //add the clothing size arrayList to the current clothing details.
      currentClothing.add(thisArrayList2);
      
      //add designs
      ArrayList<String> thisArrayList3=new ArrayList<String>(10);
      
      //find designs in the design table
      for (int j=0;j<designTable.getRowCount();j++) {
        thisArrayList3.add(designTable.getRow(j).getString("Design"));
      }

      //add the clothing design arrayList to the current clothing details.
      currentClothing.add(thisArrayList3);
      
      //add all the details of that clothings to the clothingCombinations arrayList
      clothingCombinationsSetup.add(currentClothing);
      //repeat for all other types of clothing
    }

    //initialize the clothingCombinations 3D array
    //each type of clothing gets its own 2D array
    clothingCombinations=new String[clothingTypes.length][4][10];
    
    //for each 1D arrayList in the clothing combinations, add its items to the clothingCombinations array.
    for (int i=0;i<clothingCombinationsSetup.size();i++){
      //change the size of the 2D array to the size of the 2D arrayList (normally, this is 4)
      clothingCombinations[i]=new String[clothingCombinationsSetup.get(i).size()][10];
      
      for (int j=0;j<clothingCombinationsSetup.get(i).size();j++) {
        //change the size of the 1D array to the size of the 1D arrayList
        clothingCombinations[i][j]=new String[clothingCombinationsSetup.get(i).get(j).size()];
        //add the strings
        clothingCombinationsSetup.get(i).get(j).toArray(clothingCombinations[i][j]);
      }
    }
    
        
    //setup Password -----------------------------------------------------------------------------------------
    
    //this loads the bytes, which are later checked against the hashed version of the password
    byte[] p = loadBytes("p.txt"); 

    for (int i=0; i<(p.length)/2; i++) {
      int j;
      int k;
      if (int(p[2*i])<58) {
        j=p[2*i]-48;
      } else {
        j=p[2*i]-87;
      }
      if (int(p[2*i+1])<58) {
        k=p[2*i+1]-48;
      } else {
        k=p[2*i+1]-87;
      }
      byte newByte = byte(j*16+k);
      password[i]=newByte;
    }


    //setup Window Size Options ----------------------------------------------------------------------------------
    
    //for each window size option, test whether the screen is large enough to run that width and heihgt
    int maximumWidth=displayWidth;
    int maximumHeight=displayHeight-54;

    int numWindowWidths=0;
    int numWindowHeights=0;

    for (int i=0; i<allWindowSizes.length; i++) {
      //test if too wide
      if (allWindowSizes[i][0]<maximumWidth) {
        numWindowWidths+=1;
      }
      //test if too high
      if (allWindowSizes[i][1]<maximumHeight) {
        numWindowHeights+=1;
      }
    }
    //take the minimum of the number of window widths an the number of window heights
    numWindowSizes = min(numWindowWidths, numWindowHeights);
    
    //put this into a new 2D int array to replace allWindowSizes.
    int[][] possibleWindowSizes = new int[numWindowSizes][2];
    possibleWindowSizes =  Arrays.copyOfRange(allWindowSizes, 0, numWindowSizes);
    allWindowSizes = possibleWindowSizes;
  
  
  //end of startup
  }
  
  
  
  
  
}