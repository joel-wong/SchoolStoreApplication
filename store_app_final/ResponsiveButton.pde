class ResponsiveButton {
  //this is a class that creates a button that, on click, goes to a specific location or performs an action.
  
  float xCenter, yCenter;
  float xLength, yLength;
  color colour;
  String message;
  char location;
  int textsize;
  int rowNumber;
  TableRow row;
  
  /*
  xCenter: the x position of the button
  yCenter: the y position of the button
  xLength: the width of the button
  yLength: the height of the button
  colour: the button's fill colour
  message: the buttons message (inside it)
  location: a place that the button goes to when it is clicked
            if the location that the button goes to is 'z' or 'x', the button will perform an action
            otherwise, the location is a state, and the new state will be intiialized
  
  textsize: the textsize of the button
  
  rowNumber: this is a variable which holds information about a row from the order table, price table, or inventory table  
             rowNumber is the number of the row (in the spreadsheet, the row occurs on line rowNumber+2)
             
  row: This is the TableRow that contains the data from the row at position rowNumber in the appropriate table.
  */
  
  ResponsiveButton(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, String _message, char _location, int _textsize) {
    xCenter=_xCenter;
    yCenter=_yCenter;
    xLength=_xLength;
    yLength=_yLength;
    colour=_colour;
    message=_message;
    location=_location;
    textsize=_textsize;
  } 
  
  ResponsiveButton(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, String _message, char _location, int _textsize,int _rowNumber) {
    xCenter=_xCenter;
    yCenter=_yCenter;
    xLength=_xLength;
    yLength=_yLength;
    colour=_colour;
    message=_message;
    location=_location;
    textsize=_textsize;
    rowNumber=_rowNumber;
     
    if (state=='w') {
      //price menu
      row = priceTable.getRow(rowNumber);
    }
    else if (state=='i') {
      //inventory menu
      row = inventoryTable.getRow(rowNumber);
    }
    else {
      //printing menu or pickup menu
      row = orderTable.getRow(rowNumber);
    }
  } 
  
  boolean respond (float mousePositionX, float mousePositionY) {
    //if there is a click within the confines of the button or on its stroke
    if (abs(mousePositionX-xCenter)<xLength/2+2 && abs(mousePositionY-yCenter)<yLength/2+2 && mousePressed) {
      
      
      if (location!='z' && location!='x') {
        //if this does not perform an action
        //go to a new state, as specified by the location
        state=location;
        stateSetup.setupState(state,true);
      }     

      
      
      else if (location=='z') {
        //opens an order/clothing/price details panel, with information that depends on the state
        
        
        //first, ensure that only 1 order details panel is open
        while (staticTextboxes.size()>2) {
          staticTextboxes.remove(staticTextboxes.size()-1);
          int k=1;
          
          if (state=='p' && row.getString("Order Picked Up").equals("No") && row.getString("Order Printed").equals("Yes"))  {
            k+=1;
          }
          else if (state=='r'){
            k+=1;
          }
          else if (state=='i' || state=='w') {
            k+=1;
            sliders.remove(sliders.size()-1);
          }
          for (int i=0;i<k;i++) {
            responsiveButtons.remove(responsiveButtons.size()-1);
          }
        }

        //pickup menu action:
        //opens full order with all its details
        //from here, you can return to the pickup menu (without resetting zoom/translate), mark the item as picked up, or go back to the main menu.
        if (state=='p') {
          staticTextboxes.add(new StaticTextbox(width/2,height/2+20,width-20,height-160,color(150,150,150),color(0),"Order Details",false,rowNumber));
          responsiveButtons.add(new ResponsiveUnmovingButton(120,height-33,100,40,color(255,150,150),"Back",'x',24,rowNumber));
          
          if (row.getString("Order Picked Up").equals("No") && row.getString("Order Printed").equals("Yes")) {
            //if the order has been printed, but not yet picked up, then it can be picked up.
            responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-33,200,40,color(100,255,100),"Order Picked Up",'x',24,rowNumber));
          }
        }
        
        //printing menu action:
        //opens full order - the order has been placed, but not yet printed.
        //from here, you can return to the printing menu (without resetting zoom/translate), mark the item as printed, or go back to the main menu.
        else if (state=='r') {
          staticTextboxes.add(new StaticTextbox(width/2,height/2+20,width-20,height-160,color(150,150,150),color(0),"Order Details",false,rowNumber));
          
          responsiveButtons.add(new ResponsiveUnmovingButton(120,height-33,100,40,color(255,150,150),"Back",'x',24,rowNumber));
          responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-33,200,40,color(100,255,100),"Order Printed",'x',24,rowNumber));
        }
        
        //inventory menu action:
        //opens the details about an item in the inventory
        //from here, you can return to the inventory menu (without resetting zoom/translate), change the amount of inventory of a given item, or go back to the main menu.
        else if (state=='i') {
          staticTextboxes.add(new StaticTextbox(width/2,height/2+20,width-20,height-160,color(150,150,150),color(0),"Item Details",false,rowNumber));
          responsiveButtons.add(new ResponsiveUnmovingButton(80,height-33,150,40,color(255,150,150),"Back",'x',24,rowNumber));
          sliders.add(new Slider(400, width/2, 400, 0, max_clothing, "Adjust Amount of Clothing", inventoryTable.getRow(rowNumber).getInt("Clothing Amount"),false));
          responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-33,250,40,color(100,255,100),"Save",'x',24,rowNumber));
        }
        
        //price menu action:
        //opens the details about the price of an item
        //from here, you can return to the price menu (without resetting zoom/translate), change the price of a given item, or go back to the main menu.
        else if (state=='w') {
          staticTextboxes.add(new StaticTextbox(width/2,height/2+20,width-20,height-160,color(150,150,150),color(0),"Clothing Type Details",false,rowNumber));
          responsiveButtons.add(new ResponsiveUnmovingButton(80,height-33,150,40,color(255,150,150),"Back",'x',24,rowNumber));
          sliders.add(new Slider(400, width/2, 400, 0, max_price, "Adjust Clothing Price", priceTable.getRow(rowNumber).getInt("Clothing Price"),false));
          responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-33,250,40,color(100,250,100),"Set Price",'x',24,rowNumber));
        }
      }
      
      
      
      
      
      
      else if (location=='x') {       
        //performs a specific action based on the message of the button.
        //this will make an action, but does not necessarily go to a specific menu/reset any menu.
        
        
        //closes the order/item/price details menu, and returns to the previous menu.   
        //this is completed by resetting the state, but not translating back to the original position
        if (message=="Back") {
          stateSetup.setupState(state,false);
        }
        
        
        //The window is currently showing a confirmation message. 
        //Reset the state but only resets the translation if in the order menu.
        else if (message=="Okay") {
          if (state=='o') {
            stateSetup.setupState(state,true);
          }
          else {
            stateSetup.setupState(state,false);
          }
        }
        
        
        //Save inventory menu changes
        //A slider has been moved and now the amount of inventory needs to be changed
        else if (message=="Save") {
         
          //find what the inventory amount should be changed to  
          int new_clothing_amount=sliders.get(0).returnIntValue();
          
          //set the value in the inventory table, then save the table and reload it.
          inventoryTable.setInt(rowNumber,"Clothing Amount",new_clothing_amount);
          saveTable(inventoryTable,"data/inventory.csv");
          inventoryTable=loadTable("inventory.csv","header");     
          
          
          //close inventory area
          for (int i=0;i<2;i++) {
            responsiveButtons.remove(responsiveButtons.size()-1);
          }
          staticTextboxes.remove(staticTextboxes.size()-1);
          sliders.remove(sliders.size()-1);
          
          //Confirm that inventory has been updated
          staticTextboxes.add(new StaticTextbox(width/2, height/2+28, width, height-184, color(50), color(255), "Inventory Updated", false));
          responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"Okay",'x',24));
        }
        
        
        //Save price menu changes
        //A slider has been moved and the price of an item needs to be changed
        else if (message=="Set Price") {
          
          //find what the price should be changed to
          int new_clothing_price=sliders.get(0).returnIntValue();
          
          //set the value in the price table, then save the table and reload it.
          priceTable.setInt(rowNumber,"Clothing Price",new_clothing_price);
          saveTable(priceTable,"data/prices.csv");
          priceTable=loadTable("prices.csv","header");     
          
          //change the clothing price in the clothing combinations to the new price
          clothingCombinations[rowNumber][0][1]=""+new_clothing_price;
          
          //close the price area
          for (int i=0;i<2;i++) {
            responsiveButtons.remove(responsiveButtons.size()-1);
          }
          staticTextboxes.remove(staticTextboxes.size()-1);
          sliders.remove(sliders.size()-1);
          
          //Confirm that the price has been changed.
          staticTextboxes.add(new StaticTextbox(width/2, height/2+28, width, height-184, color(50), color(255), "Price Set", false));
          responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"Okay",'x',24));
        }
        
        
        //The order has now been picked up
        //Edit the order table to mark it as picked up.
        else if (message=="Order Picked Up") {
          
          //mark that the oprder has been picked up
          orderTable.setString(rowNumber,"Order Picked Up","Yes");
          //put the date of pickup
          orderTable.setString(rowNumber,"Order Pickup Date",month()+"/"+day()+"/"+year());
          //save the table
          saveTable(orderTable,"data/orders.csv");
          orderTable=loadTable("orders.csv","header");
          
          //Provide a confirmation message
          staticTextboxes.add(new StaticTextbox(width/2, height/2+28, width, height-184, color(50), color(255), "The Order Has Been Completed!", false));
          responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"Okay",'x',24));
          
        }
        
        
        //The order has now been printed
        //Provide feedback to assur it's printed
        else if (message=="Order Printed") {
          
          //first, check if the inventory exists
          findInventoryLoop: {
            
            
            for (int i=0;i<inventoryTable.getRowCount();i++) {
              
              TableRow inventoryRow = inventoryTable.getRow(i);
              
              //if there is clothing in the inventory in the correct type, colour, and size. (With an amount of clothing ranging from 0 to 200)
              if (row.getString("Type").equals(inventoryRow.getString("Clothing Type")) 
              && row.getString("Colour").equals(inventoryRow.getString("Clothing Colour"))
              && row.getString("Size").equals(inventoryRow.getString("Clothing Size"))) {
                
                //remove the boxes showing the order
                for (int j=0;j<2;j++) {
                  responsiveButtons.remove(responsiveButtons.size()-1);
                }
                staticTextboxes.remove(staticTextboxes.size()-1);
                
                
                //if there is clothing available (there is at least 1 of that type of clothing)
                if (inventoryRow.getInt("Clothing Amount")>0) {
                  
                  //then print that order
                  orderTable.setString(rowNumber,"Order Printed","Yes");
                  orderTable.setString(rowNumber,"Order Printing Date",month()+"/"+day()+"/"+year());
                  
                  saveTable(orderTable,"data/orders.csv");
                  orderTable=loadTable("data/orders.csv","header");
                  
                  //and remove 1 inventory item of that type (and save that in a table).
                  inventoryRow.setInt("Clothing Amount",inventoryRow.getInt("Clothing Amount")-1);
                  saveTable(inventoryTable,"data/inventory.csv");
                  inventoryTable=loadTable("data/inventory.csv","header");
                  
                  //provide a confirmation message
                  staticTextboxes.add(new StaticTextbox(width/2, height/2+28, width, height-184, color(50), color(255), "Thank You for Printing!", false));
                  responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"Okay",'x',24));
                }
                
                
                //otherwise, if there is none of that type of clothing in stock
                else if (inventoryRow.getInt("Clothing Amount")==0) {
                  //tell them its not in stock, but they can still override the system
                  staticTextboxes.add(new StaticTextbox(width/2, height/2-3.5, width, height-247, color(50), color(255), "No inventory to print. Proceed?", false));
                  responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-95,width-2,60,color(150,150,150),"Yes",'x',24,rowNumber));
                  responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"No",'x',24));
                  
                }
                
                //if the correct type of inventory is available, stop looking for inventory
                break findInventoryLoop;
              }
            }
            
            
            //this is surpassed if the type of clothing has been inputted/has 0 quantity
            
            //otherwise, there is no such type of clothing available
            
            //close the detail panel
            for (int j=0;j<2;j++) {
              responsiveButtons.remove(responsiveButtons.size()-1);
            }
            staticTextboxes.remove(staticTextboxes.size()-1);
            
            //tell them its not inputted, but they can still override the system
            staticTextboxes.add(new StaticTextbox(width/2, height/2-3.5, width, height-247, color(50), color(255), "No inventory to print. Proceed?", false));
            responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-95,width-2,60,color(150,150,150),"Yes",'x',24,rowNumber));
            responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"No",'x',24));
            
          }
        }
        
        
        
        //Answering yes on questions involving order, inventory, etc.
        else if (message=="Yes") {
          
          //remove the yes/no boxes
          staticTextboxes.remove(staticTextboxes.size()-1);
          for (int k=0;k<2;k++) {
            responsiveButtons.remove(responsiveButtons.size()-1);
          }
          
          
          //order menu
          //They were asked something like: "Are you sure you want to print this order?"
          //They answered yes, so place the order.
          if (state=='o') {
            
            //add the order tot he order table
            for (int j=0;j<parseInt(textInputBoxes.get(1).returnText());j++){
              //textInputBox(1) will return quantity - this adds (quantity) rows to the orderTable
              
              //create a new row
              row=orderTable.addRow();
              //add all parts of the order to the new row data
              row.setString("Name",textInputBoxes.get(0).returnText());
              row.setString("Type",dropdownMenus.get(0).returnText());
              row.setString("Colour",dropdownMenus.get(1).returnText());
              row.setString("Size",dropdownMenus.get(2).returnText());
              row.setString("Design",dropdownMenus.get(3).returnText());
              row.setString("Notes",textInputBoxes.get(2).returnText());
              row.setString("Email",textInputBoxes.get(3).returnText());
              row.setString("Cell Number",textInputBoxes.get(3).returnText());
              row.setString("Date Order Placed",month()+"/"+day()+"/"+year());
              row.setString("Order Picked Up","No");
              row.setString("Order Pickup Date","None");
              row.setString("Order Printed","No");
              row.setString("Order Printing Date","None");
            }
            
            //save the orders
            saveTable(orderTable,"data/orders.csv");
            orderTable=loadTable("orders.csv","header");
            
            //add the amount of money paid to the cash requisition menu
            int quantity=parseInt(textInputBoxes.get(1).returnText());
            cash_requisition_amount+=parseInt(clothingCombinations[dropdownMenus.get(0).returnNum()][0][1])*quantity;
            
            //Provide a confirmation message
            staticTextboxes.add(new StaticTextbox(width/2, height/2+28, width, height-184, color(50), color(255), "Order Placed!", false));
            responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"Okay",'x',24));
          }
          
          
          //printing menu
          //They were asked something like: "There is no inventory for this order. Proceed?"
          //They answered yes, so mark the order as printed.
          else if (state=='r') {
            
            //mark it as printed
            orderTable.setString(rowNumber,"Order Printed","Yes");
            orderTable.setString(rowNumber,"Order Printing Date",month()+"/"+day()+"/"+year());
            
            //save the information in the table
            saveTable(orderTable,"data/orders.csv");
            orderTable=loadTable("data/orders.csv","header");
            
            //write a confirmation message
            staticTextboxes.add(new StaticTextbox(width/2, height/2+28, width, height-184, color(50), color(255), "Thank You for Printing!", false));
            responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"Okay",'x',24));
          }
        }
        
        
        
        
        // The user has responded "no" to a question
        else if (message=="No") {
          
          //remove text boxes asking yes/no
          staticTextboxes.remove(staticTextboxes.size()-1);
          responsiveButtons.remove(responsiveButtons.size()-1);
          responsiveButtons.remove(responsiveButtons.size()-1);
          
          if (state=='o') {
            //put the cost text box back to where it shoudl be after moving it to the top of the screen.
            int quantity=parseInt(textInputBoxes.get(1).returnText());
            staticTextboxes.set(2,new StaticTextbox(width/2+150,200,250,40,color(150,150,150),color(0,0,255),"Cost: $"+parseInt(clothingCombinations[dropdownMenus.get(0).returnNum()][0][1])*quantity+".00",true));
          }
        }
        
        
        
        
        //In the order menu, the user has placed the order.
        else if (message=="Place Order") {
          
          //first check if there is inventory available
          findInventoryLoop: {
            for (int i=0;i<inventoryTable.getRowCount();i++) {

              TableRow inventoryRow = inventoryTable.getRow(i);
              
              //if clothing of the correct type, colour, and size is inputted into the inventory menu
              if (dropdownMenus.get(0).returnText().equals(inventoryRow.getString("Clothing Type")) 
              && dropdownMenus.get(1).returnText().equals(inventoryRow.getString("Clothing Colour"))
              && dropdownMenus.get(2).returnText().equals(inventoryRow.getString("Clothing Size"))) {
                
                //the type of clothing exists
                
                //if there is at least 1 of this type of clothing available
                if (inventoryRow.getInt("Clothing Amount")>0) {
                  staticTextboxes.add(new StaticTextbox(width/2, height/2-3.5, width, height-247, color(50), color(255), "Have you received $"+parseInt(clothingCombinations[dropdownMenus.get(0).returnNum()][0][1])*parseInt(textInputBoxes.get(1).returnText())+".00?", false));
                  responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-95,width-2,60,color(150,150,150),"Yes",'x',24));
                  responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"No",'x',24));
                }
                
                //it has been inputted, but none are available
                else {
                  staticTextboxes.add(new StaticTextbox(width/2, height/2-3.5, width, height-247, color(50), color(255), "No inventory for this order. Proceed?", false));
                  responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-95,width-2,60,color(150,150,150),"Yes",'x',24));
                  responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"No",'x',24));
                }
  
                //stop looking for more of this clothing
                break findInventoryLoop;
              }
            }
            
            //there is none of this type/colour/size of clothes in inventory
            staticTextboxes.add(new StaticTextbox(width/2, height/2-3.5, width, height-247, color(50), color(255), "No inventory for this order. Proceed?", false));
            responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-95,width-2,60,color(150,150,150),"Yes",'x',24));
            responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"No",'x',24));
          }                  
          
        }       
        
        //In the add inventory menu, someone has filled in all the fields to add inventory        
        else if (message=="Add Inventory") {         
          
          //check if the type of clothing already exists
          findInventoryLoop: {
            
            
            for (int i=0;i<inventoryTable.getRowCount();i++) {
              
              TableRow inventoryRow = inventoryTable.getRow(i);
              
              //check if there is clothing of the correct size, type, and colour
              if (textInputBoxes.get(0).returnText().equals(inventoryRow.getString("Clothing Type")) 
              && textInputBoxes.get(1).returnText().equals(inventoryRow.getString("Clothing Colour"))
              && textInputBoxes.get(2).returnText().equals(inventoryRow.getString("Clothing Size"))) {
                
                //if the inputted type of clothing already exists in inventory
                //add the new amount to the current amount
                inventoryRow.setInt("Clothing Amount",inventoryRow.getInt("Clothing Amount")+parseInt(textInputBoxes.get(3).returnText()));
                //update its last updated date
                inventoryRow.setString("Last Updated",month()+"/"+day()+"/"+year());
                 
                //and save it
                saveTable(inventoryTable,"data/inventory.csv");
                inventoryTable=loadTable("inventory.csv","header");
                
                //write a confirmation message
                staticTextboxes.add(new StaticTextbox(width/2, height/2+28, width, height-184, color(50), color(255), "Inventory Added to Current Inventory", false));
                responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"Okay",'x',24));
                
                //stop looking for more inventory
                break findInventoryLoop;
              }
            }
            
            //this is a new combination of clothing, so add a new row
            row=inventoryTable.addRow();
            
            //add the data of the new row
            row.setString("Clothing Type",textInputBoxes.get(0).returnText());
            row.setString("Clothing Colour",textInputBoxes.get(1).returnText());
            row.setString("Clothing Size",textInputBoxes.get(2).returnText());
            row.setString("Clothing Amount",textInputBoxes.get(3).returnText());
            row.setString("Last Updated",month()+"/"+day()+"/"+year());

            //save the row
            saveTable(inventoryTable,"data/inventory.csv");
            inventoryTable=loadTable("inventory.csv","header");
            
            //Confirmation message.
            staticTextboxes.add(new StaticTextbox(width/2, height/2+28, width, height-184, color(50), color(255), "Clothing Added! Set Price in Price Menu.", false));
            responsiveButtons.add(new ResponsiveUnmovingButton(width/2,height-32,width-2,60,color(150,150,150),"Okay",'x',24));
            
          }          
          
          //if this is a new type of clothing
          if (!(Arrays.asList(clothingTypes)).contains(textInputBoxes.get(0).returnText())) {
            
            TableRow newItem=priceTable.addRow();
            
            //add the new item to the price table
            newItem.setString("Clothing Type",textInputBoxes.get(0).returnText());
            newItem.setString("Clothing Price","0");
            newItem.setString("Last Updated",month()+"/"+day()+"/"+year());
            
            //save the price table
            saveTable(priceTable,"data/prices.csv");
            priceTable=loadTable("prices.csv","header");
          }
          
          //reset the clothing Combinations string[][][] and clothing type string[]
          stateSetup.startup();
        }
      }
      
      //in all cases, a button has been clicked so, return true
      return true;
    }
    
    
    
    
    //In the order menu, the place order button needs to respond for every action, regardless of whether the button is clicked or not.
    else if (state=='o') {
      
      //only place order button
      if (message=="Place Order" || message=="Missing Something...") {
        
        //check if the whole order has been filled in
        
        //assume its true unless there is a field not filled in
        boolean orderComplete=true;
        
        //check drop down menus
        for (int i=0;i<4;i++) {
          if (dropdownMenus.get(i).returnText().equals("")) {
            orderComplete=false;
          }
        }

        //check text input boxes
        for (int i=0;i<2;i++){
          if (textInputBoxes.get(i).returnText().equals("")){
            orderComplete=false;
          }
        }
        
        //ensure quantity>0
        int quantity=parseInt(textInputBoxes.get(1).returnText());

        if (quantity<1){
          orderComplete=false;
          quantity=1;
        }
        
        if (staticTextboxes.size()<4) {
        //also, set cost to the correct amount
        staticTextboxes.set(2,new StaticTextbox(width/2+150,200,250,40,color(150,150,150),color(0,0,255),"Cost: $"+parseInt(clothingCombinations[dropdownMenus.get(0).returnNum()][0][1])*quantity+".00",true));
        }
        else {
          //if there is a confirmation message on screen, ensure that the cost staticTextBox is at the top of the screen and cannot move
          staticTextboxes.set(2,new StaticTextbox(width/2+150,80,250,40,color(150,150,150),color(0,0,255),"Cost: $"+parseInt(clothingCombinations[dropdownMenus.get(0).returnNum()][0][1])*quantity+".00",false));
        }
        //if the order is still complete, then it can be placed.
        if (orderComplete==true) {
          message="Place Order";
        }
        else {
          message="Missing Something...";
        }
      }
      
      
      return false;
    }  
    
    
    //In the add inventory menu, the add inventory button needs to respond for every action, regardless of whether the button is clicked or not.
    else if (state=='j') {
      
      //only add inventory button
      if (message=="Add Inventory" || message=="Missing Something...") {
        
        //asume the order is fully filled in
        boolean orderComplete=true;

        //text input boxes
        for (int i=0;i<3;i++) {
          if (textInputBoxes.get(i).returnText().equals("")) {
            orderComplete=false;
          }
        }

        //ensure quantity>0
        if (parseInt(textInputBoxes.get(3).returnText())<1) {
          orderComplete=false;
        }

        //if order is still complete, then the inventory can be added.
        if (orderComplete==true) {
          message="Add Inventory";
        }
        else {
          message="Missing Something...";
        }
      }
      
      return false;
    }
    
    return false;

  }  
  
  void display(float mousePositionX, float mousePositionY) {
    textAlign(CENTER,CENTER);
    stroke(0);
    fill(colour);
    
    if (abs(mousePositionX-xCenter)<xLength/2+2 && abs(mousePositionY-yCenter)<yLength/2+2) {
      //highlight if mouse is over top
      stroke(255);
    }
    
    //if missing something, you can't click on the button.
    if (message=="Missing Something...") {
      noStroke();
      fill(200);
    }
    
    //show the rectangular button
    rect(xCenter,yCenter,xLength,yLength);
    
    fill(0);
    textSize(textsize);
    text(message,xCenter,yCenter);
    noStroke(); 
  }
}

//The moving button responds to movement and rMouseX/rMouseX
class ResponsiveMovingButton extends ResponsiveButton {
  
  ResponsiveMovingButton(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, String _message, char _location, int _textsize) {
    super(_xCenter, _yCenter, _xLength, _yLength, _colour, _message, _location, _textsize);
  }
  
  ResponsiveMovingButton(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, String _message, char _location, int _textsize, int _rowNumber) {
    super(_xCenter, _yCenter, _xLength, _yLength, _colour, _message, _location, _textsize, _rowNumber);
  }
  
  boolean respond(float a, float b) {
    return (super.respond(rMouseX,rMouseY));
  }
  
  void display(float a, float b) {
    super.display(rMouseX,rMouseY);
  }
}

//The subclass responsiveUnmovingButton gets it's display and matrix pop/pushed each frame, and responds to mouseX and mouseY
class ResponsiveUnmovingButton extends ResponsiveButton {
  
  ResponsiveUnmovingButton(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, String _message, char _location, int _textsize) {
    super(_xCenter, _yCenter, _xLength, _yLength, _colour, _message, _location, _textsize);
  }
  
  ResponsiveUnmovingButton(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, String _message, char _location, int _textsize, int _rowNumber) {
    super(_xCenter, _yCenter, _xLength, _yLength, _colour, _message, _location, _textsize, _rowNumber);
  }
  
  boolean respond(float a, float b) {
    return (super.respond(mouseX,mouseY));
  }
  
  void display(float a, float b) {
    popMatrix();
    super.display(mouseX,mouseY);
    setMatrix();
  }
  
}