// Write a function that takes an integer flight_length (in minutes) and an array of integers movie_lengths (in minutes) and returns a boolean indicating whether there are two numbers in movie_lengths whose sum equals flight_length.

// When building your function:

// Assume your users will watch exactly two movies
// Don't make your users watch the same movie twice
// Optimize for runtime over memory

function inflight(flightLength, movieLengths) {
  // let output = false;
  // for (let movie1 of movieLengths ) {
  //   for (let movie2 of movieLengths ) {
  //     if (movie1 + movie2 === flightLength && movie1 !== movie2) {
  //       output = true;
  //     }
  //   }
  // }
  // return output;
    var movieMap = [];

    for (let movieLength of movieLengths) {
      if (movieMap[flightLength - movieLength]) {
        return true;
      }
      movieMap[movieLength] = true;
    }

    return false;
}

let arr = [45,32,61,62,63,46];

console.log(inflight(123, arr)); //true
console.log(inflight(1000, arr)); //false
console.log(inflight(77, arr)); //true
console.log(inflight(12, arr)); //false
console.log(inflight(90, arr)); //false
console.log(inflight(61, arr)); //false
