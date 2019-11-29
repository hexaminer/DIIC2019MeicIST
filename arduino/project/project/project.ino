#define COUNTER 2

unsigned int counter = 0;
unsigned long check_time = 0;
float liters = 0;

void flow() {
  counter++;
//  Serial.println(counter);
}

void setup() {
  
  Serial.begin(9600);
  
  pinMode(COUNTER, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(COUNTER), flow, RISING);

  check_time = millis();
}

void loop() {

  // Check if 1s has passed, if so, update water spent
  unsigned long now = millis();
  if (now - check_time > 1000) {
    check_time = now;
    liters += counter * 1.0 / 450;
    counter = 0;
  }
  
}
