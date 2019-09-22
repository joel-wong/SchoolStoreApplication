class PasswordChecker {
  
  //this is a class that checks the password for the password menu
  
  String keysEntered;
  String message="";
  int lastCheckedTime=millis();
  
  PasswordChecker () {
  }
  
  /*
  keysEntered: the string that is attempting to be checked if it is a password
  message: the message to be displayed
  lastCheckedTime: the last time that a password was checked
  */
  
  //this uses SHA-256 encryption and a built in function of java/processing, message digester.
  

  
  void checkPassword(String _keysEntered) {
    
    
    try {
      
      //create a object that will change the input into SHA-256
      MessageDigest digester = MessageDigest.getInstance("SHA-256");
      
      //take the keysEntered, then add a "salt," which makes it more difficult to crack
      //take this "salted" password and change it into a 32 bit "hased value"
      byte[] hash = digester.digest((_keysEntered+"Ru8_*x>3*+idZsnF<-d$:0y>5{BzB&").getBytes(StandardCharsets.UTF_8));
      
      //if the hash is the same as the value in the password file, then allow the user to go to the main menu
      if (Arrays.equals(password,hash)) {
        state='m';
        stateSetup.setupState(state,true);
       
      } 
      
      //otherwise, tell the user the password is wrong 
      else {
        message="incorrect password!";
        lastCheckedTime=millis();
        
        //to avoid brute force hacks, delay the password validation by 100 milliseconds.
        delay(100);
      }
      
    } catch (Exception e) {
      //if there is an error, it will be printed in the debug console.
      println("There has been an error in the password validation of this program (PasswordChecker). Please speak to the computer science teacher for details."); 
      println("Error Details:" );
      println(e.getMessage());
    }
  }
  
  void displayMessage() {
    //display the incorrect password message.
    if (millis()-lastCheckedTime<1000) {
      textAlign(CENTER,CENTER);
      fill(255);
      text(message,width/2,150);
      fill(0);
    }
  }
}