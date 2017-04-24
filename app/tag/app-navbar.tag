import firebase from 'firebase';
import route from 'riot-route';

<app-navbar>
  <style scoped>
    .navbar {
      background-color: black;
      border-color: black;
      margin-bottom: 0;
      z-index: 3;
      border-radius: 0px;
    }
    .navbar-brand {
      position: absolute;
      width: 100%;
      padding: 0;
    }
    .brand-logo {
      max-height: 70%;
      text-align: center;
      left: 0;
      margin: 0 auto;
    }
    .header-button {
      border:solid 1px white;
      color: white;
      padding: 5px 40px;
    }
    .header-button:hover {
      color: gray;
    }
  </style>

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
      }
      this.updateLoginButton();
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
        route('playlist');
        this.room = 'playlist';
      } else {
        this.refs.loginText.textContent = 'LOGIN';
        route('room');
        this.room = 'party';
      }
      this.updateRoomButton();
    }

    this.room = 'party'
    this.changeRoom = (e) => {
      e.preventDefault();
      if (this.room === 'party') {
        route('playlist');
        this.room = 'playlist';
      } else {
        route('room');
        this.room = 'party';
      }
      this.updateRoomButton();
    }
    this.updateRoomButton = () => {
      if (this.authed) {
        this.refs.room.classList.remove('hidden');
        if (this.room === 'party'){
          this.refs.roomText.textContent = 'PLAYLIST';
        } else {
          this.refs.roomText.textContent = 'PARTY MODE';
        }
      } else {
        this.refs.room.classList.add('hidden');
      }
    }
  </script>

  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">
          <img alt="JADIA" src="img/jadia_logo0307.png" class="brand-logo">
        </a>
      </div>
      <ul class="nav navbar-nav navbar-right">
        <li class='hidden' ref='login'><a href="#" onclick={ toggleLogin }>
          <span class='header-button' ref='loginText'>LOGIN</span>
        </a></li>
        <li class='hidden' ref='room'><a href="#" onclick={ changeRoom }>
          <span class='header-button' ref='roomText'>PARTY MODE</span>
        </a></li>
      </ul>
    </div>
  </nav>
</app-navbar>
