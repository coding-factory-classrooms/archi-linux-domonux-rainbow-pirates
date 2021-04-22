import fileinput
import sys
import random

error_messages = ["Too many conspiracy per mom in your house, please check you mom sanity.",
        "Less than one conspiracy per mom, please check your mom pulse.",
        "Weird number of conspiracy per mom, please check the number of mom."]

for line in fileinput.input():
    if (line == "OK\n"):
        sensor_nbr = str(random.randint(1, 100))
        value = str(random.randint(1, 69))
        sys.stdout.write("Sensor#" + sensor_nbr + ";LivingRoom;value=" + value + ";unit=conspiracy/mom;\n")
        sys.stdout.flush()
    elif (line == "ERROR\n"):
        error_number = str(random.randint(1, 69))
        sys.stderr.write("Error#" + error_number + ";" + random.choice(error_messages) + ";\n")
        sys.stderr.flush()

