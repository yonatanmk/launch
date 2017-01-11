class Spaceship {
  constructor (name) {
    this.name = name;
    this.crew = [];
    this.captain = null;
    this.propulsion = null;
  }

  loadCrew (newCrew) {
    for (let person of newCrew) {
      this.crew.push(person);
      console.log(`${person.name} has boarded ${this.name}`);
    }
  }

  makeCaptain () {
    let random_number = Math.floor(Math.random() * this.crew.length);
    this.captain = this.crew[random_number];
    console.log(`The new captain is ${this.captain.name}`);
  }

  mountPropulsion (propulsion) {
    this.propulsion = propulsion;
    console.log("Propulsion has been mouted");
  }

  takeoff () {
    if (this.propulsion.fire()) {
      console.log('FWOOOOSH');
    }
    else {
      console.log('Takeoff was unsucessful');
    }
  }
}

module.exports = Spaceship;
