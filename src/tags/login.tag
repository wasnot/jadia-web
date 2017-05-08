import firebase from 'firebase';
import config from 'config.js';
import 'styles/navbar.css';
import event from 'event.js';
import Login from 'controller/login.js';

<login>
  <script>
    this.mixin('obs');
    this.obs.on(event.auth.request, () => {
      this.login.requestAuth()
        .then((user) => {
          this.refs.login.classList.remove('hidden');
          this.obs.trigger(event.auth.checked, user);
          this.updateLoginButton();
        });
    })
    this.toggleLogin = (e) => {
      e.preventDefault();
      this.login.toggleLogin()
        .then(() => {
          this.updateLoginButton();
        });
    }
    this.updateLoginButton = () => {
      if (this.login.authed) {
        this.refs.loginText.textContent = 'LOGOUT';
      } else {
        this.refs.loginText.textContent = 'LOGIN';
      }
      this.obs.trigger(event.auth.updated, this.login.authed);
    }
    this.login = new Login(this.updateLoginButton);
  </script>

  <li class='hidden' ref='login'><a href="#" onclick={ toggleLogin }>
    <span class='navbar-button' ref='loginText'>LOGIN</span>
  </a></li>
</login>
