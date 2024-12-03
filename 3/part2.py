import re
from functools import reduce

file = open('input.txt', 'r')
content = file.read()

lines = content.split('do()')

total_sum = 0

for line in lines:
    try:
        dont_index = line.index('don\'t()')
        line = line[0:dont_index]
    except ValueError:
        pass
    matches = re.findall(r'mul\(([0-9]*),([0-9]*)\)', line)
    total_sum = total_sum + reduce(lambda x, y: x + (int(y[0]) * int(y[1])), matches, 0)

print(total_sum)