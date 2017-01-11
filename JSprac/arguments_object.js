function destroyer(arr) {
  var args = [];
  for (var key in arguments) {
    args.push(arguments[key]);
  }
  for (i=0;i<arr.length;i++) {
    for (j=0;j<args.length;j++) {
      if (arr[i] === args[j]) {
        delete arr[i];
      }
    }
  }
  return arr.filter(Boolean);
}

destroyer([1, 2, 3, 1, 2, 3], 2, 3);
