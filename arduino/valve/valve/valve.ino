#define VALVE_PIN 3

void setup() {
  // put your setup code here, to run once:
  pinMode(VALVE_PIN, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(VALVE_PIN, HIGH);
  Serial.println("[+] On");
  delay(1000);
  digitalWrite(VALVE_PIN, LOW);
  Serial.println("[-] Off");
  delay(5000);
}
