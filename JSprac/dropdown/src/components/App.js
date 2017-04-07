import React, { Component } from 'react';
import Dropdown from './Dropdown';
import DropdownTrigger from './DropdownTrigger';
import DropdownContent from './DropdownContent';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  render() {

    return (
      <div>
        <div>
          <h1>
            Hello
          </h1>
        </div>
        <Dropdown>
            <DropdownTrigger>Profile</DropdownTrigger>
            <DropdownContent>
                <img src="https://www.shareicon.net/data/128x128/2016/09/15/829451_man_512x512.png" /> Username
                <ul>
                    <li>
                        <a href="/profile">Profile</a>
                    </li>
                    <li>
                        <a href="/favorites">Favorites</a>
                    </li>
                    <li>
                        <a href="/logout">Log Out</a>
                    </li>
                </ul>
            </DropdownContent>
        </Dropdown>
      </div>
    );
  }
}

export default App;
