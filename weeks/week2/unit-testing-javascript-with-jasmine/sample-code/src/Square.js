function Square(length, x, y) {
  this.length = length;
  this.width = length;
  this.x = x || 0;
  this.y = y || 0;

  this.diameter = function() {
    var length_squared = Math.pow(this.length, 2);
    var width_squared = Math.pow(this.width, 2);
    return Math.sqrt(length_squared + width_squared);
  };

  this.perimeter = function() {
    return this.length * 4;
  };

  this.area = function() {
    return Math.pow(this.length, 2);
  };

  this.containsPoint = function(x, y) {
    var delta = this.width / 2;
    if(((this.x - delta <= x) && (x <= this.x + delta)) &&
      ((this.y - delta <= y) && (y <= this.y + delta))) {
      return true;
    }
    return false;
  };
}
