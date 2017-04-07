import React, { Component } from 'react';

class Dropdown extends Component {
  constructor(props) {
    super(props);


    this.setDropdownHover = this.setDropdownHover.bind(this);
    this.setDropdownClick = this.setDropdownClick.bind(this);
  }

  setDropdownHover () {
    if (window.innerWidth > 800) {
      this.props.setDropdown(this.props.id);
    }
  }

  setDropdownClick () {
    if (window.innerWidth <= 800) {
      this.props.setDropdown(this.props.id);
    }
  }

  render () {
    let items;
    let counter = 0;
    if (this.props.id == this.props.openDropdown) {
      items = this.props.items.map((item)=>{
        counter ++;
        return (
          <li key={counter}>
            <a href={item.link}>{item.text}</a>
          </li>
        );
      });
    }

    return (
      <div onMouseLeave={()=>this.props.setDropdown(null)}>
        <a href="#!" onMouseEnter={this.setDropdownHover} onClick={this.setDropdownClick}>
          {this.props.label + ' ▾'}
        </a>
        <ul className="nav-dropdown">
          {items}
        </ul>
      </div>
    );
  }
}

export default Dropdown;
