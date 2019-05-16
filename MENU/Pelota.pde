boolean crono;
class pelota{
 
 float x = width/2;
 float vx;// siendo vx (velocidad de la x)
 float y = height/2;
 float vy;//siendo vy (velocidad de la y)
 float radio = 12;
 int speed = 8;

  
  pelota()// lo que hace esta función de constructor es con coordenadas polares tomar un ángulo aleatorio e imprimir siempre la misma velociad.
  {
      resetear();
  }
  
  void choqueRaquetaIzda (raqueta raqueta)//Futura explicación esquematizada en un pdf para su correcta comprensión
  {
     if (y <raqueta.y + raqueta.altura/2 && y > raqueta.y - raqueta.altura/2 && x - radio < raqueta.x + raqueta.anchura/2)
     {
       rebote2.play();
         if (x > raqueta.x)//este if soluciona bugs del rebote, a veces los atravesaba la raqueta
         {
             float dimensiones = y - (raqueta.y - raqueta.altura/2);//calcula la distancia del final de la paleta a la mitad para hacer un mapeado de los ángulos (se adjunta imagen de explicación para el rebote de la pelota)
             float angulo = map(dimensiones, 0, raqueta.altura, -PI/4, PI/4);
             vx = speed * cos(angulo);
             vy = speed * sin(angulo);
             x = raqueta.x + raqueta.anchura/2 + radio;
         }
     }   
  }
  
  void choqueRaquetaDcha (raqueta raqueta)//Futura explicación esquematizada en un pdf para su correcta comprensión
  {
     if (y <raqueta.y + raqueta.altura/2 && y > raqueta.y - raqueta.altura/2 && x + radio > raqueta.x - raqueta.anchura/2)
     {
       rebote2.play();
         if (x < raqueta.x)
         {        
             float dimensiones = y - (raqueta.y - raqueta.altura/2);//calcula la distancia del final de la paleta a la mitad para hacer un mapeado de los ángulos (se adjunta imagen de explicación para el  de la pelota)
             float angulo = map(dimensiones, 0, raqueta.altura, 5*PI/4, 3*PI/4);
             vx = speed * cos(angulo);
             vy = speed * sin(angulo);
             x = raqueta.x - raqueta.anchura/2 - radio;
         }  
     }       
  }
  
  void resetear()//Esta función resetea la pelota al centro de la pantalla, al punto de inicio de la partida y a su vez con coordenadas polares con la misma velocidad siempre toma un ángulo aleatoio entre -45 y +45 grados
  {
      y = height/2;
      x = width/2;
      float angulo = random(-0.785398, 0.785398);
      vx = speed * cos(angulo);
      vy = speed * sin(angulo);
      
      if(random(1) < 0.5)//hace que la pelota comience en ambas direcciones con los ángulos pi/4 y -pi/4, que se definene en el random de lineas anteriores
        vx = vx * -1;
  }
 

  void posicion()// esta función posición va actualizando la posición con la velocidad que se le esté imprimientdo
  {
      x = x + vx; //ecuación de movimiento rectilineo uniforme
      y = y + vy;
  }
  
  void bordes()//esta función nos permite invertir la velocidad de la y para así obtener el efecto de rebote
  {
      if(y > height || y < 0)// si toca el lado superior o inferior invierte la velocidad y
      {
        vy = vy*(-1);
        rebote.play();
      }
      if (x - radio > width)// en caso de que atraviese los bordes resetea la pelota al medio
      {
        puntoizda++;
        if(puntoizda == 7 && pantalla ==2 )
        {
          pantalla = 3;
        }
        punto.play();
        resetear();
      }
      if (x + radio < 0)//el motivo de esta separación principalmente es para facilitar las cosas en un futuro para contar los puntos
      {
        puntodcha++;
        if(puntodcha == 7 && pantalla == 2)
        {
          pantalla = 4; 
        }
        punto.play();
        resetear();
      }
      if(crono)
      {
        if (retraso + tiempo - millis()/1000<=0 && puntodcha>puntoizda)
          pantalla = 4; 

        if (retraso + tiempo - millis()/1000<=0 && puntodcha<puntoizda)
          pantalla = 3;
      
        if (retraso + tiempo - millis()/1000<=0 && puntodcha == puntoizda)
          pantalla = 6;  
      }
      

  }
   
  void dibujar()//función que nos dibuja la pelota
  {
     fill(255);
     ellipse(x,y, radio*2, radio*2);
  }
}
