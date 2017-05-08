import firebase from 'firebase/app';
import toastr from 'toastr';
import route from 'riot-route';

import QueryString from 'libs/querystring.js';
import config from 'config.js';
import App from 'controller/app.js';
import "styles/style.css";
import "styles/toastr.css";

// Initialize Firebase
firebase.initializeApp(config.fb_config);
// Initialize route
route.base('/');
// Inisialize toastr
toastr.options = {
  "closeButton": true,
  "timeOut": 2000,
  "positionClass": "toast-bottom-center",
};
// Attach App.
const app = new App();

import $ from 'jquery';
window.$ = $;
window.route = route;
window.firebase = firebase;
window.QueryString = QueryString;

