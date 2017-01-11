let Spaceship = require('./Spaceship.js');
let CrewMember = require('./CrewMember.js');
let rocket = require('./rocket.js');

let ourShip = new Spaceship("Apollo");
let crewNames = ['Yonatan', 'Tom', 'Tori', 'Francis', 'Dino', 'Chris', 'Kate', 'Dan', 'Audrey', 'NICK'];

let trainCrew = (crew) => {
  crew = crew.map(function(crewMember){
    return new CrewMember(crewMember);
  }).map(function(crewMember){
    crewMember.trained = true;
    return crewMember;
  });
  return crew;
};

let countdown = (int, ship) => {
  setTimeout(function(){
    if (int === 0) {
      console.log('Blastoff!!!!!');
      ship.takeoff();
    }
    else {
      console.log(int);
      countdown(int - 1, ship);
    }
  }, 1000);
};

let launchpad = (ship, crew, rocket) => {
  console.log(`Welcome to the ${ourShip.name} takeoff!`);
  ship.loadCrew(crew);
  ship.makeCaptain();
  ship.mountPropulsion(rocket);
  ship.propulsion.addFuel(70);
  countdown(10, ship);

};

launchpad(ourShip, trainCrew(crewNames), rocket);
