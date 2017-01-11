class Vector {
  constructor (arr) {
    this.coordinates = arr;
  }

  add(vector) {
    if (this.coordinates.length !== vector.coordinates.length) {
      throw new RangeError('Vectors have different number of dimensions');
    }
    let newCoordinates = [];
    for (let i = 0; i < this.coordinates.length; i++) {
      newCoordinates.push(this.coordinates[i] + vector.coordinates[i]);
    }
    return new Vector(newCoordinates);
  }

  subtract(vector) {
    if (this.coordinates.length !== vector.coordinates.length) {
      throw new RangeError('Vectors have different number of dimensions');
    }
    let newCoordinates = [];
    for (let i = 0; i < this.coordinates.length; i++) {
      newCoordinates.push(this.coordinates[i] - vector.coordinates[i]);
    }
    return new Vector(newCoordinates);
  }

  norm() {
    let norm = 0;
    for (let i = 0; i < this.coordinates.length; i++) {
      norm += Math.pow(this.coordinates[i],2);
    }
    return Math.sqrt(norm);
  }

  dot(vector) {
    let dot = 0;
    if (this.coordinates.length !== vector.coordinates.length) {
      throw new RangeError('Vectors have different number of dimensions');
    }
    for (let i = 0; i < this.coordinates.length; i++) {
      dot += this.coordinates[i] * vector.coordinates[i];
    }
    return dot;
  }

  equals(vector) {
    if (this.coordinates.length !== vector.coordinates.length) {
      return false;
    }
    for (let i = 0; i < this.coordinates.length; i++) {
      if (this.coordinates[i] !== vector.coordinates[i]) {
        return false;
      }
    }
    return true;
  }

  toString() {
    let output = '(';
    for (let x of this.coordinates) {
      output += `${x},`;
    }
    output = output.slice(0, output.length - 1);
    return output + ')';
  }

}
