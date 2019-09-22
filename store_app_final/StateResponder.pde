class StateResponder {
  
  // this is a class that runs through all buttons for each menu in order to respond to them
  
  //no attributes
  
  StateResponder () {
  }
  
  /*
  Each screen works as follows:
  It will be under the title, "____MenuRespond"
  
  For each arrayList/button type that is used in a given menu, the program responds to that button in the correct order.
  (It responds to the last displayed button first)
  Because some of these responses take moderate logic/processing/computer power, they are only checked 
  whenever there is a action taken by the user (mouse getting clicked or dragged, keys getting pressed, etc.)
  
  Each menu only has certains buttons within it, so it only needs certain buttons to respond.
  Make sure that the most important/first thing is on the TOP of the list of buttons.
  
  By using a loop ("Outerloop") and having the classes return a boolean, we can have only one button respond in each frame.
  The loop "breaks" when a button is pressed.

  Each arraylist is displayed in order based on priority -
  for example, staticTextBoxes typically overlay everything and are displayed last.
  
  Checkboxes and drop down menus take no input
  The password checker requires the input of the keys that the user has entered
  For responsiveButtons, you have to put in two "dummy integers" such as (1,1)
  (the subclass needs them since its superclass takes in two integers)
  The settings button takes in no input
  The slider is in state responder, but ALSO MUST BE INCLUDED in the controller's handleMouseDrag
  staticTextboxes do not take any action when they respond, but they break the loop so that nothing under them can respond. THey need mouseX and mouseY.
  textInputBoxes need rMouseX and rMouseY.
  
  for the order menu and add inventory menu, the responsive buttons are responded to after every mousePress and keyPress (even when the outloop is broken)
  as a result, they are included in their own loop, rather than the outerloop.
  
  Generally, the order of importance is 
  (Most important, listed FIRST    to    least important, listed LAST) 
  dropDownMenus > sliders > staticTextBoxes > responsiveButtons > textInputBoxes = checkboxes
  
  There is an exception to this list of priorities for the order menu.
  */
  
  void loginRespond() {
    outerloop: {
      for (int i=textInputBoxes.size()-1;i>=0 && i<textInputBoxes.size();i--) {
        TextInputBox textInputBox=textInputBoxes.get(i);
        if (textInputBox.respond(rMouseX,rMouseY)==true) {
          break outerloop;
        }
      }
    }
  }

  void mainMenuRespond() {
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
      if (settingsButton.respond()){
        state='1';
        stateSetup.setupState(state,true);
        break outerloop;
      }
    }
  }


  void orderMenuRespond(){
    outerloop: {
      for (int i=staticTextboxes.size()-1;i>=0 && i<staticTextboxes.size();i--) {
        StaticTextbox staticTextbox=staticTextboxes.get(i);
        if (staticTextbox.respond(mouseX,mouseY)==true) {
          break outerloop;
        }
      }
      
      //responsive button are responded to in the controller for the order menu
      
      for (int i=dropdownMenus.size()-1;i<dropdownMenus.size() && i>=0;i--) {
        DropdownMenu dropdownMenu=dropdownMenus.get(i);
        if (dropdownMenu.respond()==true) {
          if (dropdownMenu.optionSelected()==true) {
            
            //this is action specific - it is included here, rather than the drop down menu class.
            
            int orderPartNum=i;
            
            //for drop down menus 0, 1, and 2, they typically will create a new button
            if (orderPartNum<3) {
              
              
              //orderPartNum 0 is the clothing type. This determines the price, so the price is set and shown on screen.
              if (orderPartNum==0) {
                
                //if there is quantity textInputBox open
                if (textInputBoxes.size()>1) {
                  //multiply the cost by the quantity
                  int quantity=parseInt(textInputBoxes.get(1).returnText());
                  staticTextboxes.set(2,new StaticTextbox(width/2+150,200,250,40,color(150,150,150),color(0,0,255),"Cost: $"+parseInt(clothingCombinations[dropdownMenus.get(0).returnNum()][0][1])*quantity+".00",true));
                }  
                
                //if there is already a cost textbox
                else if (staticTextboxes.size()>2) {
                  staticTextboxes.set(2,new StaticTextbox(width/2+150,200,250,40,color(150,150,150),color(0,0,255),"Cost: $"+clothingCombinations[dropdownMenu.returnNum()][0][1]+".00",true));
                }
                
                //otherwise (normal action)
                else {
                  staticTextboxes.add(new StaticTextbox(width/2+150,200,250,40,color(150,150,150),color(0,0,255),"Cost: $"+clothingCombinations[dropdownMenu.returnNum()][0][1]+".00",true));
                }
              }
              
              //if the person is changing their product/clothing combinations, but their opion has already been inputted
              if (dropdownMenus.size()>orderPartNum+1) {
                
                //try and keep as many of the previously selected choices as possible
                for (int j=orderPartNum;j<dropdownMenus.size()-1;j++) {
                  
                  if (/*the selected option is NOT (!) in the drop down menus that follow this one*/
                  !Arrays.asList(clothingCombinations[dropdownMenus.get(0).returnNum()][j+1]).contains(dropdownMenus.get(j+1).returnText())
                  ){ 
                    //then generate a new box for that part of the order
                    dropdownMenus.set(j+1,new DropdownMenu(width/2-100,250+j*50,200,30,orderParts[j+2],clothingCombinations[dropdownMenus.get(0).returnNum()][j+1]));
                  }
                  
                  else {
                    //make a new box, but leave the text the same as the current text.
                    dropdownMenus.set(j+1,new DropdownMenu(width/2-100,250+j*50,200,30,orderParts[j+2],clothingCombinations[dropdownMenus.get(0).returnNum()][j+1],dropdownMenus.get(j+1).returnText()));
                  }
                }
              }
              
              //the person is going through the boxes in order
              else {
                //add the next drop down menu
                dropdownMenus.add(new DropdownMenu(width/2-100,250+orderPartNum*50,200,30,orderParts[orderPartNum+2],clothingCombinations[dropdownMenus.get(0).returnNum()][orderPartNum+1]));
              }
            }
            
            //if on the fourth dropdown menu
            else if (orderPartNum==3) {
              
              //if this is the first time that the fourth drodown menu has had an option selected
              if (textInputBoxes.size()==1) {
                //Create a bunch of textboxes:
                //Quantity, Notes, Email, and Cell Number
                //Also make a button to place the order
                textInputBoxes.add(new TextInputBox(width/2+40,400,50,40,"1",color(150,150,150),color(255),false,"Quantity"));
                textInputBoxes.add(new TextInputBox(width/2+40,450,width-100,40,"",color(150,150,150),color(255),false,"Notes"));
                textInputBoxes.add(new TextInputBox(width/2+40,500,width-100,40,"",color(150,150,150),color(255),false,"Email"));
                textInputBoxes.add(new TextInputBox(width/2+60,550,width-200,40,"",color(150,150,150),color(255),false,"Cell Number"));
                responsiveButtons.add(new ResponsiveMovingButton(width/2-10,600,250,40,color(100,255,100),"Place Order",'x',24)); 
              }
            }
          }
          
          //if any of the drop down menus have had an action taken, don't respond to anything else.
          break outerloop;
        }
      }
      

      for (int i=textInputBoxes.size()-1;i>=0 && i<textInputBoxes.size();i--) {
        TextInputBox textInputBox=textInputBoxes.get(i);
        if (textInputBox.respond(rMouseX,rMouseY)==true) {
          break outerloop;
        }
      }
    }
    
    
    //the place order button must respond to every action
    responsiveButtonLoop: {
      for (int i=responsiveButtons.size()-1;i>=0 && i<responsiveButtons.size();i--) {
        ResponsiveButton responsiveButton=responsiveButtons.get(i);
        if (responsiveButton.respond(1,1)==true) {
          break responsiveButtonLoop;
        }
      }
    }
  }
  void pickupMenuRespond() {
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
      if (settingsButton.respond()){
        state='2';
        stateSetup.setupState(state,true);
        break outerloop;
      }
    }
  }
  
  void printingMenuRespond() {
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
    }
  }
  
  void cashRequisitionMenuRespond() {
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
    }
  } 
  
  void inventoryMenuRespond() {
    outerloop: {
      for (int i=sliders.size()-1;i>=0 && i<sliders.size();i--) {
        Slider slider=sliders.get(i);
        if (slider.respond()==true) {
          break outerloop;
        }
      }
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
    }
  }
  
  void addInventoryMenuRespond(){
    outerloop: {
      for (int i=staticTextboxes.size()-1;i>=0 && i<staticTextboxes.size();i--) {
        StaticTextbox staticTextbox=staticTextboxes.get(i);
        if (staticTextbox.respond(mouseX,mouseY)==true) {
          break outerloop;
        }
      }
      
      //responsive button are responded to in the controller for the order menu
      
      for (int i=dropdownMenus.size()-1;i>=0 && i<dropdownMenus.size();i--) {
        DropdownMenu dropdownMenu=dropdownMenus.get(i);
        if (dropdownMenu.respond()==true) {
          break outerloop;
        }
      }
      for (int i=textInputBoxes.size()-1;i>=0 && i<textInputBoxes.size();i--) {
        TextInputBox textInputBox=textInputBoxes.get(i);
        if (textInputBox.respond(rMouseX,rMouseY)==true) {
          break outerloop;
        }
      }
    }
    
    //the add inventory button must respond to every action
    responsiveButtonLoop: {
      for (int i=responsiveButtons.size()-1;i>=0 && i<responsiveButtons.size();i--) {
        ResponsiveButton responsiveButton=responsiveButtons.get(i);
        if (responsiveButton.respond(1,1)==true) {
          break responsiveButtonLoop;
        }
      }
    }
  }
  
  void priceMenuRespond() {
    outerloop: {
      for (int i=sliders.size()-1;i>=0 && i<sliders.size();i--) {
        Slider slider=sliders.get(i);
        if (slider.respond()==true) {
          break outerloop;
        }
      }
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
    }
  } 
  
  void mainMenuSettingsRespond() {
    outerloop: {
       for (int i=sliders.size()-1;i>=0 && i<sliders.size();i--) {
        Slider slider=sliders.get(i);
        if (slider.respond()==true) {
          
          //when the slider responds, change the current_zoom to what the slider says.
          current_zoom=slider.returnFloatValue();
          translateX=(width-width*current_zoom)/2;
          translateY=-400*current_zoom+400;
          stateSetup.setupState(state,false);
          break outerloop;
        }
      }
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
      for (int i=checkboxes.size()-1;i>=0 && i<checkboxes.size();i--) {
        Checkbox checkbox=checkboxes.get(i);
        if (checkbox.respond()==true) {
          
          //the checkbox only changes it to full screen or not fullscreen.
          if (windowIsFullScreen==false) {
            //change to fullscreen if not fullscreen
            surface.setSize(displayWidth,displayHeight-70);
            windowIsFullScreen=true;
            stroke(0);
          } else {
            //change to not fullscreen if fullscreen
            surface.setSize(600,512);
            windowIsFullScreen=false;
          } 
          settingsButton = new SettingsButton(30,height-30);
          stateSetup.setupState('1',true);
          
          
          break outerloop;
        }
      }
      for (int i=dropdownMenus.size()-1;i>=0 && i<dropdownMenus.size();i--) {
        DropdownMenu dropdownMenu=dropdownMenus.get(i);
        if (dropdownMenu.respond()==true) {
          if (dropdownMenu.optionSelected()) {
            
            
            //since the only drop down menu changes the window size, take the output and change the window size accordingly
            surface.setSize(allWindowSizes[dropdownMenu.returnNum()][0],allWindowSizes[dropdownMenu.returnNum()][1]);
            windowIsFullScreen=false;
            settingsButton = new SettingsButton(30,height-30);
            stateSetup.setupState('1',true);
            
          }
          break outerloop;
        }
      }
    }
  }
  
  void pickupMenuSettingsRespond() {
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
      for (int i=checkboxes.size()-1;i>=0 && i<checkboxes.size();i--) {
        Checkbox checkbox=checkboxes.get(i);
        if (checkbox.respond()==true) {
          
          //respond to each checkbox by switching the appropriate boolean from true to false or false to true
          if (checkbox.returnMessage().equals("Show Non-Printed Orders")) {
            showNotPrinted=!showNotPrinted;
          }
          else if (checkbox.returnMessage().equals("Show Picked Up Orders")) {
            showPickedUp=!showPickedUp;
          }
          break outerloop;
        }
      }
    }
  }
}