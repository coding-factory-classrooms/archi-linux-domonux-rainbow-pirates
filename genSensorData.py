import fileinput
import sys
import random

error_messages = ["Too many conspiracy per mom in your house, please check you mom sanity.",
        "Less than one conspiracy per mom, please check your mom pulse.",
        "Weird number of conspiracy per mom, please check the number of mom."]

for line in fileinput.input():
    print(line)
    if (line == "OK\n"):
        sensor_nbr = str(random.randint(1, 100))
        value = str(random.randint(1, 69))
        print("Sensor#" + sensor_nbr + ";LivingRoom;value=" + value + ";unit=conspiracy/mom;")
    elif (line == "ERROR\n"):
        error_number = str(random.randint(1, 69))
        print("Error#" + error_number + ";" + random.choice(error_messages) + ";")
