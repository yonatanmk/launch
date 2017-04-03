// https://www.codewars.com/kata/51ba717bb08c1cd60f00002f/train/javascript
//
// A format for expressing an ordered list of integers is to use a comma separated list of either
//
// individual integers
// or a range of integers denoted by the starting integer separated from the end integer in the range by a dash, '-'. The range includes all integers in the interval including both endpoints. It is not considered a range unless it spans at least 3 numbers. For example ("12, 13, 15-17")
// Complete the solution so that it takes a list of integers in increasing order and returns a correctly formatted string in the range format.
//
// Example:
//
// solution([-6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20]);
// // returns "-6,-3-1,3-5,7-11,14,15,17-20"


function solution(list){
  let output=[];
  for (let i = 0; i < list.length; i++) {
    let seq = firstRangeFinder(list.slice(i), []);
    i += seq.length - 1;
    if (seq.length > 2) {
      seq = [`${seq[0]}-${seq[seq.length-1]}`];
    }
    output = [...output, ...seq];
  }
  return output.join(",");
}

function firstRangeFinder(list, output){
  if (list[0] + 1 === list[1]) {
    return firstRangeFinder(list.slice(1), [...output, list[0]] );
  } else {return [...output, list[0]];}
}

let list = [-6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20];

console.log(solution(list));
// returns "-6,-3-1,3-5,7-11,14,15,17-20"


console.log(solution(list) === "-6,-3-1,3-5,7-11,14,15,17-20");
