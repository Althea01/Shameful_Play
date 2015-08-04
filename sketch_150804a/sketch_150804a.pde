import processing.video.*;
Movie[] mov;

void setup(){
  size(800,600);
  mov = new Movie[2];
  mov[0] = new Movie(this, PATH);
  mov[1] = new Movie(this, PATH1);
}
