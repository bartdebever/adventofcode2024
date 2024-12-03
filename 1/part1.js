const fs = require("fs");
const allLines = fs.readFileSync("./input.txt", "utf-8").split('\n');
const input = [[], []]
for (const line of allLines) {
    const split = line.replace('\r', '').split('   ');
    input[0].push(parseInt(split[0]));
    input[1].push(parseInt(split[1]));
}

const sortFunction = (a, b) => a - b;
input[0].sort(sortFunction);
input[1].sort(sortFunction);
console.log(input);

const getHigherDistance = (a, b) => a > b ? a - b : b - a;


const sum = input[0].reduce(
    (accumulator, currentValue, index) => accumulator + getHigherDistance(currentValue, input[1][index]),
    0
)

console.log(sum)