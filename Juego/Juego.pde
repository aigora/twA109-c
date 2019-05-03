import processing.sound.*;
import garciadelcastillo.dashedlines.*;
import processing.serial.*;

SoundFile rebote, punto, rebote2, fanfare;
pelota ball;
raqueta j1, j2;
Serial arduino;
DashedLines rayas;

int estado =0;
int puntoizda = 0;
int puntodcha = 0;

void setup(){

 frameRate(60);
 
 size(1360,768); // Establece dimensiones de la ventana de ejecución
 
 rebote = new SoundFile(this, "pom.mp3");
 punto = new SoundFile(this, "punto.mp3");
// rebote2 = new SoundFile(this, "pim.mp3");
 fanfare = new SoundFile(this, "fanfare.mp3");
 
 rayas = new DashedLines(this);
 rayas.pattern(20, 30);
 
 ball = new pelota();
 
 j1 = new raqueta(true);
 j2 = new raqueta(false);
 
 arduino = new Serial(this, Serial.list()[1],9600);
 printArray(Serial.list());
 
}

void draw(){
  switch(estado)
  {
  case(0):
    
      background(0);
      
      PFont font= createFont("ArcadeClassic",64);
      
      ball.choqueRaquetaDcha(j2);
      ball.choqueRaquetaIzda(j1);
      
      j1.dibujar();
      j2.dibujar();
      
      ball.posicion();
      ball.bordes();
      ball.dibujar();
      
      stroke(255);
      rayas.line(width/2, height, width/2, 0);//nos pinta la raya discontinua del medio
      
      fill(255);
      textFont(font);
      textSize(40);
      text(puntoizda, width/2 - 60, 60);
      text(puntodcha, width/2 + 40, 60);
      
      if(arduino.available()>2)
      {
        while(arduino.read()!=255);
        j1.movimiento((int)map(arduino.read(), 1, 254, j1.altura/2, height-j1.altura/2));
        j2.movimiento((int)map(arduino.read(), 1, 254, j1.altura/2, height-j1.altura/2));
      }
   break;
    

  case(1):
    background(0);
    fill(255);
    textSize(90);
    textAlign(CENTER);
    text("LEFT    PLAYER    WINS!", width/2 ,height/2);   
  break;
  
  case(2):
    background(0);
    fill(255);
    textSize(90);
    textAlign(CENTER);
    text("RIGHT    PLAYER    WINS!", width/2 ,height/2);
    
  break;
  }  
}
