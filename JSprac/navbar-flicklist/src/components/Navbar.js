import React, { Component } from 'react';
import Dropdown from './Dropdown';

class Navbar extends Component  {
  constructor(props) {
    super(props);
    this.state = {
      openDropdown: null,
      mobileIcon: null,
      mobileDisplay: 'inactive'
    };

    this.setDropdown = this.setDropdown.bind(this);
    this.setMobileIcon = this.setMobileIcon.bind(this);
  }

  setDropdown (target) {
    if (this.state.currentDropdown == target) {
      this.setState({ currentDropdown: null });
    } else {
      this.setState({ currentDropdown: target });
    }
  }

  setMobileIcon () {
    if (this.state.mobileIcon) {
      this.setState({ mobileIcon: null, mobileDisplay: 'inactive' });
    } else {
      this.setState({ mobileIcon: 'active', mobileDisplay: null });
    }
  }

  render () {

    let servicesDropdown = [
      { text: 'Web Design', link: '#!' },
      { text: 'Web Development', link: '#!' },
      { text: 'Graphic Design', link: '#!' },
      { text: 'React.js', link: '#!' },
      { text: 'Ruby on Rails', link: '#!' },
    ];

    let portfolioDropdown = [
      { text: 'Think Pawsitive', link: '#!' },
      { text: 'Schwamit', link: '#!' },
      { text: 'FlickList', link: '#!' },
    ];

    return (
      <nav>
        <div className="nav-mobile">
          <a className={this.state.mobileIcon} onClick={this.setMobileIcon} id="nav-toggle" href="#!">
            <span></span>
          </a>
        </div>
        <ul className={`nav-list ${this.state.mobileDisplay}`}>
          <li>
            <a href="#!">Home</a>
          </li>
          <li>
            <a href="#!">About</a>
          </li>
          <li>
            <Dropdown
              id = { 1 }
              label = 'Services'
              items = { servicesDropdown }
              setDropdown = { this.setDropdown }
              openDropdown = { this.state.currentDropdown }
            />
          </li>
          <li>
            <a href="#!">Pricing</a>
          </li>
          <li>
            <Dropdown
              id = { 2 }
              label = 'Portfolio'
              items = { portfolioDropdown }
              setDropdown = { this.setDropdown }
              openDropdown = { this.state.currentDropdown }
            />
          </li>
          <li>
            <a href="#!">Contact</a>
          </li>
        </ul>
      </nav>
    );
  }

}

export default Navbar;
