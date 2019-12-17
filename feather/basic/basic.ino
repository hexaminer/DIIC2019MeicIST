#define COUNTER 16

unsigned int counter = 0;

void ICACHE_RAM_ATTR flow ();

void flow()
{
  ++counter;
}

void setup()
{
  Serial.begin(115200);

  pinMode(COUNTER, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(COUNTER), flow, RISING);
}

void loop()
{
  Serial.println("[+] counter: ");
  Serial.print(counter);
  Serial.println();
  delay(1000);
}
