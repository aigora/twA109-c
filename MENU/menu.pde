import processing.sound.*;
SoundFile start_sound;

int contador = 0;
int estado = 0;
int milisegundos;
int blink = 255;
int iteraciones = 0; 
int pantalla = 0;
int state = 0;
int selector=0; 
int retraso;
int tiempo = 100;


void setup(){
 
 frameRate(120);
 size(1360,768); // Establece dimensiones de la ventana de ejecución
 stroke(255); // Establece color del trazo en blanco
 background(0);
 rebote = new SoundFile(this, "pom.mp3");
 punto = new SoundFile(this, "punto.mp3");
 rebote2 = new SoundFile(this, "pim.mp3");
 fanfare = new SoundFile(this, "fanfare.mp3");
 
 rayas = new DashedLines(this);
 rayas.pattern(20, 30);
 
 ball = new pelota();
 
 j1 = new raqueta(true);
 j2 = new raqueta(false);
 
 arduino = new Serial(this, Serial.list()[1],9600);
 printArray(Serial.list());
 
}

void draw() {

  switch(pantalla) 
  {  
    case 0: 
    inicio();
    break;
    
    case 1:
    menu();
    break;
    
    case 2:
    juego();
    break;
   
    case(3):
    background(0);
    fill(255);
    textSize(90);
    textAlign(CENTER);
    text("LEFT    PLAYER    WINS!", width/2 ,height/2);   
    break;
  
    case(4):
    background(0);
    fill(255);
    textSize(90);
    textAlign(CENTER);
    text("RIGHT    PLAYER    WINS!", width/2 ,height/2);
    break;
    
    case (5):
    juego();
    textAlign(CENTER);
    textSize(40);
    text(retraso + tiempo - millis()/1000, width-40, 40);
   
    break;
    
    case(6):
    background(0);
    fill(255);
    textSize(90);
    textAlign(CENTER);
    text("DRAW!", width/2 ,height/2);
    break;
  }
}
  
void inicio()//Función para dibujar rectángulo
{
  PFont font= createFont("ArcadeClassic",64);//añadimos una fuente para ser Aesthetic 
  fill (255-blink);//máquina de estados, la cual resta 0 o 255 para así obtener sendos colores
  rect(540, 300, 280, 130, 20); //siendo cada numero x y anchura y algura, el último int es la curvatura de las esquinas
  fill(blink);
  textFont(font);//aquí llamamos a la fuente
  textSize(60);
  textAlign(CENTER);

  text("START !",1360/2 ,768/2);
  // Control de estados
  if (estado == 1)  // Tras pulsar intro
  {
    if (millis()-milisegundos>100)  // Si han transcurrido 0,1 sg
    {
       milisegundos = millis();  // Toma nueva referencia
       blink = 255-blink;  // Alterna entre 0 y 255
       iteraciones++;          // Incrementa iteraciones
     }
     
    if (iteraciones==15)   // Si se alcanzan las iteraciones máximas
    {
       estado=0;
       iteraciones=0;
       pantalla = 1;
    }
  }
}

void menu(){

   
   background(0);
   PFont font= createFont("ArcadeClassic",64);
   fill(255);
   textFont(font);//aquí llamamos a la fuente
   textSize(50);
   textAlign(CENTER);
   text("TIME !", width/2 ,height/3);
   text("SCORE !", width/2, height*2/3);
   
     switch(key)
   {
     case 'w':
       selector = 0;
     break;
     
     case 's':
       selector = 1;
     break;
   }
   
   if (selector == 1)
      ellipse(1360/2-110, 768*2/3 -15, 22, 22);
   else
      ellipse(width/2-110, 768/3-15, 22, 22);
         
}


void keyPressed() {
  if (key == ENTER){
    blink  = 0;
    estado = 1;

    milisegundos = millis();
    
    if(contador == 0)
    {
    start_sound = new SoundFile(this, "START!.mp3");//incluimos el sonido de mp3 para el start 
    start_sound.play();// cada vez que se pulse intro se reproducirá tanto el parpadeo como el sonido
    contador++;
    }
    if(selector == 1 && pantalla == 1)
    {
      crono = false;
      arduino.clear();
       pantalla = 2;
    }
    if (selector == 0 && pantalla == 1)
    {
     crono = true;
     arduino.clear();
     pantalla = 5;
     retraso = millis()/1000;
    }
    if (pantalla ==3 || pantalla == 4 || pantalla == 6)
    {
      pantalla = 1;
      puntodcha = 0;
      puntoizda = 0;
      fanfare.stop();
    }
  }
}
