Animation animation1;

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer kingk1;
FFT fft;

import processing.video.*;
Capture cam;
int image_index=0;
int threshold=127;

PImage[] figure=new PImage[10];
int state=0;//starting state
String[] cameras;

void setup(){
  minim = new Minim(this);
  kingk1 = minim.loadFile("succeed.mp3");
  size(640, 480);
  cameras = Capture.list();
  println(Capture.list());
  
  cam = new Capture(this, cameras[1]);
  cam.start();

  frameRate(10);
  animation1 = new Animation("PT_Starting_",51);
  
  figure[0] = loadImage("figure1.jpg");
  figure[1] = loadImage("figure2.jpg");
  figure[2] = loadImage("figure3.jpg");
  figure[3] = loadImage("figure4.jpg");
  figure[4] = loadImage("figure5.jpg");
  figure[5] = loadImage("figure6.jpg");
  figure[6] = loadImage("figure7.jpg");
  figure[7] = loadImage("figure8.jpg");
  figure[8] = loadImage("figure9.jpg");
  figure[9] = loadImage("figure10.jpg");  
  
}

void draw(){
  background(255);
  println("is drawing!");
  
  if (cam.available()) {
    cam.read();
    println("camera available!");
//    cam.loadPixels();
  }
  
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
    case 3:
      endgame();
    break;
    default:
      println("nothing at all");
    break;
  }
  
  image(cam, width-160,height-120,160,120);
  
}

//controls the threshold value
void keyPressed(){
  if (keyCode == UP){
    threshold +=5;
  }
  if (keyCode == DOWN){
    threshold -=5;
  }
  if (keyCode == LEFT){
    println(threshold);
  }
}

void starting(){
  println("void starting");  
  animation1.display(-410,-220);
  
  if (animation1.frame == 50){
    state++;
  }
  
}


//state==1
void playing(){
  
 println("void playing");

 imageMode(CENTER);
 if (image_index<=10){
   image(figure[image_index],width/2,height/2,width,height);
 }

 if (isCovered()){
   println("isCovered");
   state ++;
 }
}


//state==1
void succeed(){
  background(0);
  kingk1.play();
  delay(5);
  
  image_index++;
  if(state<=10){
    state=1; 
  } else {
    state=3;
  }
  kingk1.rewind();
  
  if (image_index>=10){
    state=3;
  }
}


//state==2
void endgame(){
  fill(255);
  textSize(30);
  text("End of Game",0,0);
}



//determine if the image is covered with human shadow
boolean isCovered(){
  
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
  //image(cam, 0, 0);
  if (blacknum > 0.95*cam.width*cam.height){
    return(true);
  }
  return(false);
}

