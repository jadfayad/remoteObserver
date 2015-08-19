/** Developed by Katerina Skroumpelou
        github.com/mandarini
    
    It uses the oscP5 library, website at http://www.sojamo.de/oscP5
   
    Some comments from the oscP5broadcastClient example by andreas schlegel
    are left intact, because they explain the usage of oscP5 and OSC messages.
    
    It also uses the Ketai Library for Android in Processing, website at http://ketai.org/
/**
    This is the processing sketch that should run on your computer.
    It renders a box. The size, rotation and angle of the box are
    controlled by the android application "RemoteController"
    built using the Android mode of Processing.
    
    Before you run the two applications, you should enter
    your computer's IP to the Android app running
    on your phone.
    
    You can find your phone's private IP address in
    settings > about phone > status > IP address
    
    Your computer's private IP address will show up in the console
    once you run this sketch. It will say something like:
    you (xxx.xxx.xxx.xxx)
    This is you.

 */

import oscP5.*;
import netP5.*;

//these variables will receive the android sensor readings
float light, proximity, rotX, rotY, rotZ, gyrX, gyrY, gyrZ, accX, accY, accZ;
float Size = 10;
float Angle = 0;

OscP5 oscP5;

void setup() {
  size(600,600, P3D);
  frameRate(25);
  stroke(255);
  rectMode(CENTER);
  textAlign(CENTER);
  text("TEST", width/3, height/3);
  lights();
  
  /* create a new instance of oscP5. 
   * 32000 is the port number you are listening for incoming osc messages.
   */
  oscP5 = new OscP5(this,32000);
  
}


void draw() {
    background(0);
    
    /*
    here I am using the values from the light sensor, the finger rotation gesture and the rotation sensor
    the values are updated each time an osc message is received.
    an osc message is received at the same rate the draw function runs in this sketch
    because it is sent from your android device each time the draw function is ran on the
    android application.
    This means that all happens in real time.
    */
    
    fill(light*20, light*5, light*10);     
    pushMatrix();
      translate(width/2, height/2);
      rotateX(rotX);
      rotateY(Angle);
      box(Size);
    popMatrix();
}


/* incoming osc message are forwarded to the oscEvent method. */
//this method runs whenever a message is received

void oscEvent(OscMessage theOscMessage) {

  /* get and print the address pattern and the typetag of the received OscMessage */
  //these are just for checking reasons

  println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
  theOscMessage.print();
  
  /*
  here I am receiving the sensor and gesture values from the android app
  the values are stored in an array, the osc message, and each location of the array contains a value
  the locations are determined in the android application
  */
  
  light=theOscMessage.get(0).floatValue();
  rotX=theOscMessage.get(1).floatValue();
  rotY=theOscMessage.get(2).floatValue();
  rotZ=theOscMessage.get(3).floatValue();
  accX=theOscMessage.get(4).floatValue();
  accY=theOscMessage.get(5).floatValue();
  accZ=theOscMessage.get(6).floatValue();
  gyrX=theOscMessage.get(7).floatValue();
  gyrY=theOscMessage.get(8).floatValue();
  gyrZ=theOscMessage.get(9).floatValue();
  proximity=theOscMessage.get(10).floatValue();
  Size=theOscMessage.get(11).floatValue();
  Angle=theOscMessage.get(12).floatValue();
}