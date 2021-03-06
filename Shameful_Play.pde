import processing.video.*;
String PATH = "/Users/Lily/Desktop/Github/Shameful_Play/What Ghost.mp4";
String PATH1 = "/Users/Lily/Desktop/Github/Shameful_Play/Instruction.mp4";
String PATH2 = "/Users/Lily/Desktop/Github/Shameful_Play/endgame.mp4";

String[] path = new String [9];



Movie[] Mov;

Movie mov;
Movie mov1;
Movie mov2;

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer kingk1;
FFT fft;

import processing.video.*;
Capture cam;
int image_index=0;
int mov_index=0;
int threshold=127;

PImage[] figure=new PImage[10];
int state=0;//starting state
String[] cameras;

boolean debugging=false;

void setup(){
  
  for (int i=0; i<9; i++){
    int j = i+1;
    path[i] = "/Users/Lily/Desktop/Github/Shameful_Play/Script"+j+".mp4";
  }
  minim = new Minim(this);
  kingk1 = minim.loadFile("succeed.mp3");
  size(1440, 900);
  
  if (!debugging)
  {
    
    cameras = Capture.list();
    println(Capture.list());
  
    cam = new Capture(this, cameras[18]);
    cam.start();
    
  }
  
  frameRate(30);
  mov = new Movie(this, PATH);
  mov.play();
  mov.speed(1);
  mov.volume(10);
  
  mov2 = new Movie(this, PATH2);
  mov2.speed(1);
  mov2.volume(10);
  
  
  mov1 = new Movie(this, PATH1);
  
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
  
  Mov = new Movie[9];
  for (int i=0;i<9;i++){
    Mov[i] = new Movie(this, path[i]);
  }
}

void draw(){
  background(255);
  
  if ((!debugging)&&cam.available()) {
      cam.read();
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
  
  if (!debugging)
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
    state= 1;
  }
  if (keyCode == RIGHT){
    state = 2;
    kingk1.rewind();
    kingk1.play();
  }
}

void movieEvent(Movie m) {
  m.read();
}

void starting(){
  println("void starting");  
  image(mov,0,0,width,height);
  
  if (mov.duration() == mov.time()){
    
    mov1.play();
    mov1.speed(1);
    mov.volume(20);
    image(mov1,0,0,width,height);
    if (mov1.duration() == mov1.time()){
      println("finished!");
      state++;
    }
  }  
}



//state==1
void playing(){
  
 //println("void playing"+random(1));

 imageMode(CENTER);
 if (image_index<=10){
   image(figure[image_index],width/2,height/2,width,height);
 }

 if ((!debugging)&&isCovered()){
   println("isCovered");
   state ++;
   kingk1.rewind();
   kingk1.play();
 }
 
}

//state==2
void succeed(){
  background(0);
  
  if(image_index==9)
  {
      println("state=3");
      state=3;
      return;
  }

  Mov[mov_index].play();
  Mov[mov_index].speed(1);
  Mov[mov_index].volume(10);
  imageMode(CENTER);
  image(Mov[mov_index],width/2,height/2,width,height);
  
  if (Mov[mov_index].duration() == Mov[mov_index].time()){
    
    mov_index++;
    image_index++;
    println("mov_index is:" + mov_index);
    println("state=1"+random(1));
    state=1; 
  }
  
}


//state==3
void endgame(){
  background(0);
  
  mov2.play();
  
  imageMode(CENTER);
  image(mov2,width/2,height/2,width,height);
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

