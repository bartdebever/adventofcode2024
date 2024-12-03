import re
from functools import reduce

file = open('input.txt', 'r')
content = file.read()

matches = re.findall(r'mul\(([0-9]*),([0-9]*)\)', content)

print(reduce(lambda x, y: x + (int(y[0]) * int(y[1])), matches, 0))