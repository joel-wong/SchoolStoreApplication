class StaticTextbox  {
  
  // this class shows text on screen, and highlights it, but does not make any actions.
  
  float xCenter, yCenter;
  float xLength, yLength;
  color colour;
  color strokeColour;
  String message;
  boolean moving;
  int textsize=30;
  int lineSeparator=23;
  int rowNumber;
  TableRow row;
  String[] informationList;
  
  
  /*
  attributes:
  xCenter: the x position of the text box
  yCenter: the y position of the text box
  xLength: the horizontal length of the text box
  yLength: the vertical length of the text box
  colour: the fill colour of the text box
  strokeColour: the stroke colour of the text box
  message: the message inside the text box
  moving: whether the text box translates/zooms
  textsize: the size of the main text/title
  
  //these are used for order details, item details, and price detail boxes.
  lineSeparator: the space between lines in a box
  rowNumber: the number of the row (the line number in the spreadsheet)
  row: the information in the row
  informationList: the different pieces of information in each row (the actual data)
  
  
  Three constructors:
  */
   
  StaticTextbox(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, color _strokeColour, String _message,boolean _moving) {
    //used to create a "Standard" text box (typically for banners
    xCenter=_xCenter;
    yCenter=_yCenter;
    xLength=_xLength;
    yLength=_yLength;
    colour=_colour;
    strokeColour=_strokeColour;
    message=_message;
    moving=_moving;
  }
  

  StaticTextbox(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, color _strokeColour, String _message, int _textsize, boolean _moving) {
    //used to create static text boxes with different (typically smaller) text than normal.
    xCenter=_xCenter;
    yCenter=_yCenter;
    xLength=_xLength;
    yLength=_yLength;
    colour=_colour;
    strokeColour=_strokeColour;
    message=_message;
    textsize=_textsize;
    moving=_moving;
  }
  
  StaticTextbox(float _xCenter, float _yCenter, float _xLength, float _yLength, color _colour, color _strokeColour, String _message,boolean _moving, int _rowNumber) {
    //used to create order detail/item detail/price detail boxes
    xCenter=_xCenter;
    yCenter=_yCenter;
    xLength=_xLength;
    yLength=_yLength;
    colour=_colour;
    strokeColour=_strokeColour;
    message=_message;
    moving=_moving;
    rowNumber=_rowNumber;
    
    //for each type of detail panel, retrieve a different set of information
    if (message=="Order Details") {
      informationList = new String[orderTable.getColumnCount()-1];
      row = orderTable.getRow(rowNumber);
      for (int i=0;i<informationList.length;i++) {
        informationList[i] = row.getString(orderParts[i]);
      }
    }
    else if (message=="Item Details") {
      informationList = new String[inventoryTable.getColumnCount()];
      row = inventoryTable.getRow(rowNumber);
      for (int i=0;i<informationList.length;i++) {
        informationList[i] = row.getString(inventoryParts[i]);
      }
    }
    else if (message=="Clothing Type Details") {
      informationList = new String[priceTable.getColumnCount()];
      row = priceTable.getRow(rowNumber);
      for (int i=0;i<informationList.length;i++) {
        informationList[i] = row.getString(priceParts[i]);
      }
    }
  } 
  
  boolean respond(int mousePositionX, int mousePositionY) {
    //this does not make any actions, but ensures that any static text boxes do not have aything respond that it underneath them.
    if (abs(mousePositionX-xCenter)<xLength/2+2 && abs(mousePositionY-yCenter)<yLength/2+2 && mousePressed) {
      return true;
    }
    return false;
  }
  
  String returnText() {
    return message;
  }
  
  void display() {
    textAlign(CENTER,CENTER);
    
    if (moving==false) {
      popMatrix();
    }
    
    //create a rectangle
    stroke(strokeColour);
    textSize(textsize);
    fill(colour);
    rect(xCenter,yCenter,xLength,yLength);
    fill(255);

    //for eacch panel, retireve each piece of information from the row,
    //then, write that information after the column's header
    
    if (message=="Order Details") {
      //order details panel (printing menu and pickup menu)
      
      //write the title of the panel
      text(message,width/2,133);
      //start at 165
      int place=165;
      textSize(18);
      
      for (int i=0;i<orderTable.getColumnCount()-1;i++) {
        if (orderParts[i].equals("Notes") && informationList[i].length()>40) {
          //since notes can be very long, it may need to be split across two columns.
          text(orderParts[i]+": "+informationList[i].substring(0,informationList[i].length()/2-4),width/2,place);
          place+=lineSeparator-1;
          text(informationList[i].substring(informationList[i].length()/2-4,informationList[i].length()),width/2,place);
        }
        else {
          //normally, write the type of information and then the information.
          text(orderParts[i]+": "+informationList[i],width/2,place);
        }
        //move to the next line
        place+=lineSeparator;
      }
    } 
    
    
    else if (message=="Item Details") {
      //Item Details Panel (Inventory)

      //write the title of the panel
      text(message,width/2,133);
      int place=160;
      textSize(18);
      
      //for each piece of information, write the type of information, then the information itself.
      for (int i=0;i<inventoryTable.getColumnCount();i++) {
        text(inventoryParts[i]+": "+informationList[i],width/2,place);
        place+=lineSeparator;
      }
    }
    
    
    else if (message=="Clothing Type Details") {
      //Clothing Type Detail Panel (Prices)
      
      //write the title of the panel
      text(message,width/2,133);
      int place=160;
      textSize(18);
      
      //for each piece of information, write the type of information, then the information itself.
      for (int i=0;i<priceTable.getColumnCount();i++) {
        text(priceParts[i]+": "+informationList[i],width/2,place);
        place+=lineSeparator;
      }



    }
    else {
      //normal banners/text
      text(message,xCenter,yCenter);
    }
    
    if (moving==false){
      setMatrix();
    }
  }
}