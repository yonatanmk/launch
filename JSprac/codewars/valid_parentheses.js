// https://www.codewars.com/kata/valid-parentheses/train/javascript
//
// Write a function called validParentheses that takes a string of parentheses, and determines if the order of the parentheses is valid. validParentheses should return true if the string is valid, and false if it's invalid.
//
// Examples:
// validParentheses( "()" ) => returns true
// validParentheses( ")(()))" ) => returns false
// validParentheses( "(" ) => returns false
// validParentheses( "(())((()())())" ) => returns true
//
// All input strings will be nonempty, and will only consist of open parentheses '(' and/or closed parentheses ')'

function validParentheses(parens){
  let stack = 0;
  for (let char of parens.split("")) {
    if (char === ")" && stack === 0) {return false;}
    else if (char === ")") {stack--;}
    else {stack++;}
  }
  return stack === 0;
}

console.log(validParentheses( "()" ) === true);
console.log(validParentheses( "())" ) === false);
console.log(validParentheses( "(" ) === false);
console.log(validParentheses( ")(()))" ) === false);
console.log(validParentheses( "(())((()())())" ) === true);
console.log(validParentheses( "(())((()()()())" ) === false);
