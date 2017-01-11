var maxSequence = function(arr){
  let output = 0;
  for (let i = 0; i < arr.length; i++) {
    let slicedArr = arr.slice(i);
    for (let j = 0; j < slicedArr.length; j++) {
      //console.log(slicedArr.slice(0, slicedArr.length - j))
      let sum = slicedArr.slice(0, slicedArr.length - j).reduce(function(a, b) {
        return a + b;
      }, 0);
      if (sum > output) {
        output = sum;
      }
    }
  }
  //console.log('output')
  //console.log(output)
  return output;

};
