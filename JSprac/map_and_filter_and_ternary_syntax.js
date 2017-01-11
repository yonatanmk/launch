word = "Remdeemable"

var newWord = word
  .toLowerCase()
  .split('')
  .map( function (a, i, w) {
    return w.indexOf(a) == w.lastIndexOf(a) ? '(' : ')'
  })
  .join('');

console.log(newWord)

var filtA = word
  .toLowerCase()
  .split('')
  .filter( function (x) {
    return x == "a" ? "" : x;
  });

console.log(filtA)
