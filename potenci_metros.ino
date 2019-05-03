int valor1, valor2;

void setup() {
  //Inicializamos la comunicación serial
  Serial.begin(9600);
}
 
void loop() {
  
  valor1 = map(analogRead(A0), 0, 1023, 1, 254);//mapeamos la lectura analógica
  valor2 = map(analogRead(A1), 0, 1023, 1, 254);

  Serial.write(255);
  Serial.write(valor1);//mandamos por el serial los valores que se imprimirán en las raquetas
  Serial.write(valor2);
  delay(40);
 
}
