Animation animation1;



void setup() {
  size(640, 360);
  frameRate(10);
  animation1 = new Animation("PT_Starting_",51);
}

void draw() { 
  background(255);
  
  animation1.display(-410,-275);
}
