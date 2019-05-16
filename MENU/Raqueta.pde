class raqueta{
  
   float x, y = height/2; //posición de la raqueta
   float altura = 120, anchura = 20;

   
    raqueta(boolean izquierda)//Uso aquí una función constructor, para pintar las dos raquetas, si es cierto que es la izquierda, píntala, si no lo es, pinta la derecha
    {
      if(izquierda)
        x = anchura/2 + 6;
      else
        x = width - anchura/2 - 6;
    }
    
    void movimiento(int pasos)//por el serial recivirá los movimientos
    {
        y = pasos;
    }
    
    void dibujar()
    {
       rectMode(CENTER);
       fill(255);
       rect(x, y, anchura, altura);
    }
}
