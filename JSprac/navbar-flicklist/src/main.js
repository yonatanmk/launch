import './main.scss';
import 'babel-polyfill';
import $ from "jquery";
import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';

ReactDOM.render(
  <App />,
  document.getElementById('app')
);
