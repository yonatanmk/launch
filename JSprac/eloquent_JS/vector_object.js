class Vector {
  constructor (x, y) {
    this.x = x;
    this.y = y;
  }
  
  length() {
    return Math.sqrt(this.x**2 + this.y**2);
  }

  add(vector) {
    this.x += vector.x;
    this.y += vector.y;
    return this;
  }

  subtract(vector) {
    this.x -= vector.x;
    this.y -= vector.y;
    return this;
  }

}

let vector = new Vector(3,4);
let vector2 = new Vector(1,1);

console.log(vector);
vector.add(vector2);
console.log(vector);
vector.subtract(vector2);
console.log(vector);
console.log(vector.length());
