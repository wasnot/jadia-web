import firebase from 'firebase';

<login>
  <script>
    this.authed = false;
    this.userId = '';
    this.mixin('obs');
    this.provider = new firebase.auth.GoogleAuthProvider();
    this.provider.setCustomParameters({
        hd: "colorful-board.com"
    });
    firebase.auth().getRedirectResult().then((result) => {
      console.log('getRedirectResult');
      //console.log(result);
      if (result.credential) {
        // This gives you a Google Access Token. You can use it to access the Google API.
        var token = result.credential.accessToken;
      }
      if(result.user){
        this.authed = true;
        this.userId = result.user.email;
        this.obs.trigger('loggedIn', user);
        this.updateLoginButton();
      }
    }).catch((error) => {
      console.log('redirect error');
      console.log(error);
      // Handle Errors here.
      var errorCode = error.code;
      var errorMessage = error.message;
      // The email of the user's account used.
      var email = error.email;
      // The firebase.auth.AuthCredential type that was used.
      var credential = error.credential;
      this.updateLoginButton();
    });
    firebase.auth().onAuthStateChanged((user) => {
      console.log('onAuthStateChanged');
      //console.log(user);
      this.refs.login.classList.remove('hidden');
      if (user) {
        // User is signed in.
        this.authed = true;
        this.uesrId = user.email;
        this.obs.trigger('loggedIn', user);
      } else {
        // No user is signed in.
      }
      this.updateLoginButton();
    });
    this.toggleLogin = (e) => {
      e.preventDefault();
      if (this.authed) {
        firebase.auth().signOut().then(() => {
          this.authed = false;
          this.userId = '';
          this.updateLoginButton();
        }, (error) => {
          // An error happened.
        });
      } else {
        firebase.auth().signInWithRedirect(this.provider);
      }
    }
    this.updateLoginButton = () => {
      if (this.authed) {
        this.refs.loginText.textContent = 'LOGOUT';
      } else {
        this.refs.loginText.textContent = 'LOGIN';
      }
      this.obs.trigger('updateAuth', this.authed);
    }
  </script>

  <li class='hidden' ref='login'><a href="#" onclick={ toggleLogin }>
    <span class='header-button' ref='loginText'>LOGIN</span>
  </a></li>
</login>
