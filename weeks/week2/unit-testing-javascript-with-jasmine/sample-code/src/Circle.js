function Circle(radius, x, y) {
  this.radius = radius;
  this.diameter = radius * 2;
  this.x = x || 0;
  this.y = y || 0;

  this.area = function() {
    return Math.PI * Math.pow(this.radius, 2);
  };

  this.perimeter = function() {
    return 2 * Math.PI * this.radius;
  };
}
