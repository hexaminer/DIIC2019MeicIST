const int buttonPin = 3;
const int redPin = 11;
const int greenPin = 9;
const int bluePin = 10;
int red = 0;
int green = 0;
int blue = 0;
int c = 0;

void setup() {
  pinMode(buttonPin, INPUT);
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  Serial.begin(57600);
}

void loop() {
  int buttonState;
  buttonState = digitalRead(buttonPin);
  
  if (buttonState == LOW){
    c++;
    Serial.println(c);
    delay(100); //alterar delay 
    updateLED(c);
  }
}

void updateLED(int c){
  if (c <= 255){
    setColor(c,255,0);
  } else if (c <= 510){
    setColor(255,510-c,0);
  } 
}

void setColor(int red, int green, int blue)
{
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);  
}
