import firebase from 'firebase';
import config from 'config.js';

export default class Login {
  constructor(callback) {
    this.authed = false;
    this.userId = '';
    this.provider = new firebase.auth.GoogleAuthProvider();
    this.provider.setCustomParameters({
        hd: config.login_host
    });
    firebase.auth().getRedirectResult().then((result) => {
      console.log('getRedirectResult');
      //console.log(result);
      if (result.credential) {
        // This gives you a Google Access Token. You can use it to access the Google API.
        const token = result.credential.accessToken;
      }
      if(result.user){
        this.authed = true;
        this.userId = result.user.email;
        if (typeof callback === 'function'){
          callback();
        }
      }
    }).catch((error) => {
      console.log('redirect error');
      console.log(error);
      // Handle Errors here.
      const errorCode = error.code;
      const errorMessage = error.message;
      // The email of the user's account used.
      const email = error.email;
      // The firebase.auth.AuthCredential type that was used.
      const credential = error.credential;
      if (typeof callback === 'function'){
        callback();
      }
    });
  }

  requestAuth() {
    return new Promise((resolve, reject) => {
      firebase.auth().onAuthStateChanged((user) => {
        console.log('onAuthStateChanged');
        if (user) {
          // User is signed in.
          this.authed = true;
          this.uesrId = user.email;
        } else {
          // No user is signed in.
          this.authed = false;
        }
        resolve(user);
      })
    })
  }

  toggleLogin() {
    return new Promise((resolve, reject) => {
      if (this.authed) {
        firebase.auth().signOut().then(() => {
          this.authed = false;
          this.userId = '';
          resolve();
        }, (error) => {
          // An error happened.
          reject();
        });
      } else {
        firebase.auth().signInWithRedirect(this.provider);
      }
    })
  }
}