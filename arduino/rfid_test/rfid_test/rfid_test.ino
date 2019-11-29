#include <SPI.h> //INCLUSÃO DE BIBLIOTECA
#include <MFRC522.h> //INCLUSÃO DE BIBLIOTECA
 
#define SS_PIN 10 //PINO SDA
#define RST_PIN 9 //PINO DE RESET

MFRC522 rfid(SS_PIN, RST_PIN); //PASSAGEM DE PARÂMETROS REFERENTE AOS PINOS

bool last_card = false;
void setup() {
  Serial.begin(9600); //INICIALIZA A SERIAL
  SPI.begin(); //INICIALIZA O BARRAMENTO SPI
  rfid.PCD_Init(); //INICIALIZA MFRC522
}
 
void loop() {
  if (rfid.PICC_IsNewCardPresent()) {
    last_card = true;
    Serial.println("true");
  }
  /*
  if (!last_card && rfid.PICC_IsNewCardPresent()) {
    last_card = true;
    Serial.println("true");
  }

  if (last_card && !rfid.PICC_IsNewCardPresent()) {
    Serial.println("Im in");
  }

  if (!rfid.PICC_IsNewCardPresent()) {
    last_card = false;
    Serial.println("false");
  }
  */

}
