PImage[] figure=new PImage[10];
int image_index = 0;
int state=0;//starting state

void setup(){
  size(640,480);
  
  
  figure[0] = loadImage("figure1.jpg");
  
}

void draw(){
  background(255);
  
  switch (state)
  {
    case 0:
      starting(); 
    break;    
    case 1:
    
    playing();
    
    break;
  }
  
}


//state == 0
void starting(){  
  /*
  ** display some welcome image here
  */
  println("void starting");
  
  fill(0);
  textSize(20);
  text("Welcome to the game!!",width/2-100,height/2);
    
  if (millis()>5000){
    state++;
  }
  
}

//state==1
void playing(){
  
    imageMode(CENTER);
    image(figure[image_index],width/2,height/2);

  println("void is playing");
  if (isCovered()){
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

//state==3
void levelup(){

}


//determine if the image is covered with human shadow
boolean isCovered(){
  return(true);
}

