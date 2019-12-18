#!/usr/bin/python3

from time import sleep, time
import pigpio
from mfrc522 import MFRC522, SimpleMFRC522
from RPi.GPIO import cleanup as GPIO_cleanup

pi = pigpio.pi() 
reader = MFRC522()
simple_reader = SimpleMFRC522()

# GPIO pins
FLOW = 4 
RGB_R = 24
RGB_B = 23
RGB_G = 18

# Setup
pi.set_mode(RGB_R, pigpio.OUTPUT)
pi.set_mode(RGB_G, pigpio.OUTPUT)
pi.set_mode(RGB_B, pigpio.OUTPUT)

pi.set_mode(FLOW, pigpio.INPUT)
pi.set_pull_up_down(FLOW, pigpio.PUD_DOWN)

# Misc functions
def millis():
    return round(time() * 1000)

# Global variables
counter = 0
check_time = millis()
litres = 0
need_reset = True
MAX_WATER_CONSUMPTION = 1

# Functions
def set_colour(red, green, blue):
    pi.set_PWM_dutycycle(RGB_R, red)
    pi.set_PWM_dutycycle(RGB_G, green)
    pi.set_PWM_dutycycle(RGB_B, blue)

def count_water(now):
    global litres, check_time, counter
    check_time = now
    litres += counter * 1.0 / 450
    counter = 0

def update_led():
    global litres
    c = litres * 510 / MAX_WATER_CONSUMPTION
    if c <= 255:
        set_colour(c, 255, 0)
    elif c <= 510:
        set_colour(255, 510 - c, 0)
    else:
        set_colour(255, 0, 0)

def reset():
    global litres, check_time, counter, need_reset
    litres = 0
    check_time = 0
    counter = 0
    need_reset = False
    set_colour(0, 0, 0)

def flow(gpio, level, tick):
    global counter
    counter += 1

def setup():
    water_flow_callback = pi.callback(FLOW, pigpio.FALLING_EDGE, flow)
    set_colour(0, 255, 0)

def loop():
    global litres, need_reset
    # Scan for cards
    identifier = simple_reader.read_id_no_block()

    if identifier is not None:
        reader.MFRC522_Request(reader.PICC_REQIDL) # runs second time to fix status
        # Update water
        if not need_reset:
            need_reset = True

        now = millis()
        if now - check_time > 1000:
            count_water(now)
            update_led()
            print(f"[+] Litres: {litres}")
            print(f"[+] Identifier: {identifier}")

    elif need_reset:
            reset()
            need_reset == False



if __name__ == "__main__":
    try:
        setup()
        while True:
            loop()
    except KeyboardInterrupt:
        GPIO_cleanup()

        # Scan for cards
        # status, tag_type = reader.MFRC522_Request(reader.PICC_REQIDL)
        # reader.MFRC522_Request(reader.PICC_REQIDL) # runs second time to fix status
        # if status == reader.MI_OK:
        #     uid, _ = simple_reader.read()
        #     print(f"[+] User: {uid}")
