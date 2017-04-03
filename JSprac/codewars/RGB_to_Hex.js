// https://www.codewars.com/trainer/javascript
//
// The rgb() method is incomplete. Complete the method so that passing in RGB decimal values will result in a hexadecimal representation being returned. The valid decimal values for RGB are 0 - 255. Any (r,g,b) argument values that fall out of that range should be rounded to the closest valid value.
//
// The following are examples of expected output values:
//
// rgb(255, 255, 255) // returns FFFFFF
// rgb(255, 255, 300) // returns FFFFFF
// rgb(0,0,0) // returns 000000
// rgb(148, 0, 211) // returns 9400D3

function rgb(r, g, b){
  let output = "";
  for ( let input of arguments) {
    if (input > 255) {input = 255;}
    if (input < 0) {input = 0;}
    let x = input.toString(16).toUpperCase();
    if (x.length === 1) {x = "0" + x}
    output += x;
  }
  return output;
}

console.log(rgb(255, 255, 255));
console.log(rgb(255, 255, 300));
console.log(rgb(0, 0, 0));
console.log(rgb(148, 0, 211));

console.log(rgb(255, 255, 255) === 'FFFFFF');
console.log(rgb(255, 255, 300) === 'FFFFFF');
console.log(rgb(0, 0, 0) === '000000');
console.log(rgb(148, 0, 211) === '9400D3');
