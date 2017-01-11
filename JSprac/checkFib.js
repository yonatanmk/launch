function checkFib(arr) {
  if (arr.length === 2) {
    return true;
  }
  else if (arr[arr.length - 1] === arr[arr.length - 2] + arr[arr.length - 3]) {
    return checkFib(arr.slice(0, arr.length - 1));
  }
  else {
    return false;
  }
}

let arr = [1,1,2,3,5,8,13,21,34];

checkFib(arr);
