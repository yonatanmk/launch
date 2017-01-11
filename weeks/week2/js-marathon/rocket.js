let rocket = {
  fuel: 0,
  addFuel(int) {
    this.fuel += int;
  },
  fire() {
    if (this.fuel > 0) {
      this.fuel -= 1;
      console.log("The engines have been fired");
      console.log(`${this.fuel} gallons of fuel remaining`);
      return true;
    }
    else {
      console.log("The engines have failed to fire");
      return false;
    }
  }
};

module.exports = rocket;
