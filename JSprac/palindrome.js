
function palindrome(str) {
  // Good luck!
  //return str.replace(/\W/g,"").toLowerCase();
  if (str.replace(/\W/g,"").replace(/\s/g,"").replace(/_/g,"").toLowerCase() === str.replace(/\W/g,"").replace(/\s/g,"").replace(/_/g,"").toLowerCase().split("").reverse().join("")) {
    return true;
  }
  else {
    return false;
  }
}



palindrome("eye");
