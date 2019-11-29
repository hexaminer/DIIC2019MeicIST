#define DEBUG 1

// Flux controller
#define COUNTER 2

// LED RGB
#define RGB_R 5
#define RGB_G 3
#define RGB_B 4
#define MAX_WATER_CONSUMPTION 1

unsigned int counter = 0;
unsigned long check_time = 0;
float liters = 0;

void flow()
{
  counter++;
}

void count_water(unsigned long now)
{
  check_time = now;
  liters += counter * 1.0 / 450;
  counter = 0;
}

void setColour(int red, int green, int blue)
{
  analogWrite(RGB_R, red);
  analogWrite(RGB_G, green);
  analogWrite(RGB_B, blue);
}

void update_led()
{
  int c = liters * 510 / MAX_WATER_CONSUMPTION;
#if DEBUG
  Serial.print("[+] RGB counter (max: 510): ");
  Serial.println(c);
#endif

  if (c <= 255) {
    setColour(c, 255, 0);
  } else if (c <= 510) {
    setColour(255, 510-c, 0);
  }

}

void setup()
{
#if DEBUG
  Serial.begin(9600);
#endif

  pinMode(COUNTER, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(COUNTER), flow, RISING);

  pinMode(RGB_R, OUTPUT);
  pinMode(RGB_G, OUTPUT);
  pinMode(RGB_B, OUTPUT);

  check_time = millis();

}

void loop()
{
  // Check if 1s has passed, if so, update water spent
  unsigned long now = millis();
  if (now - check_time > 1000) {
    
    count_water(now);
    update_led();

#if DEBUG
    Serial.print("[+] Water spent (liters): ");
    Serial.println(liters);
#endif
  }
  
}
