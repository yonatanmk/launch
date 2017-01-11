let arr = ['a','b','c','d','e']

for (let [i, char] of arr.entries()) {
  console.log(`${char}${i}`);
}

for (let char of arr) {
  console.log(char);
}
