import processing.sound.*;
import garciadelcastillo.dashedlines.*;
import processing.serial.*;

SoundFile rebote, punto, rebote2, fanfare;
pelota ball;
raqueta j1, j2;
Serial arduino;
DashedLines rayas;

int puntoizda = 0;
int puntodcha = 0;

void juego(){
 
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
      text(puntoizda, width/2 - 40, 60);
      text(puntodcha, width/2 + 40, 60);
      
      if(arduino.available()>2)
      {
        while(arduino.read()!=255);
        j1.movimiento((int)map(arduino.read(), 1, 254, j1.altura/2, height-j1.altura/2));
        j2.movimiento((int)map(arduino.read(), 1, 254, j1.altura/2, height-j1.altura/2));
      }
   if (pantalla == 6 || pantalla == 3 || pantalla == 4)
        fanfare.play();
  }  
