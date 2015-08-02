Animation animation1;

import processing.video.*;
Capture cam;
int threshold=127;

PImage[] figure=new PImage[10];
int image_index = 0;
int state=0;//starting state

void setup(){
  size(640, 480);

  frameRate(10);
  animation1 = new Animation("PT_Starting_",51);
  
  figure[0] = loadImage("figure1.jpg");
  figure[1] = loadImage("figure2.jpg");
  figure[2] = loadImage("figure3.jpg");
  
}

void draw(){
  background(255);
  
//  if (cam.available() == true) {
//    cam.read();
//    cam.loadPixels();
//  }
//  
  
  
  switch (state)
  {
    case 0:
      starting(); 
    break;    
    case 1:
      playing();  
    break;
    case 2:
      succeed();
    break;
    default:
      println("nothing at all");
    break;
  }
  
  //image(cam,0,0);
}


//state == 0


void starting(){  
    background(255);

  println("void starting");
  
  
  animation1.display(-410,-220);
    
  if (millis()>15000){
    state++;
  }
  
}


//state==1
void playing(){
  
    imageMode(CENTER);
    image(figure[image_index],width/2,height/2);

  println("void playing");
  if (isCovered()){
    println("isCovered");
    state ++;
  }
}


//state==2
void succeed(){
  /*
  ** display some success image here
  */
  
  image_index++;
  state=1;  
}


//determine if the image is covered with human shadow
boolean isCovered(){
  String[] cameras = Capture.list();
  println(Capture.list());
  
  cam = new Capture(this, cameras[1]);
  cam.start();
  int blacknum = 0;
  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
  }
  
  for(int i=0;i<cam.width*cam.height;i++)
  {  
    float brightNum = brightness(cam.pixels[i]);
    if (brightNum>threshold)
    {
      cam.pixels[i]=color(255);
    }
    else
    {
      cam.pixels[i]=color(0);
      blacknum++;
    }    
  }
  
  cam.updatePixels();
  image(cam, 0, 0);
  if (blacknum > 0.95*cam.width*cam.height){
    return(true);
  }
  return(false);
}

