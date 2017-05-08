import 'styles/navbar.css';
import event from 'event.js';

<mode>
  <script>
    this.mixin('obs');
    this.mixin('state');
    this.authed = false
    this.obs.on(event.auth.updated, (authed) => {
      if (authed) {
        this.authed = true;
        if (location.pathname === '/') {
          this.state.mode = 'playlist';
        }
      } else {
        this.authed = false;
        this.state.mode = 'room';
      }
      this.updateModeButton();
    })
    this.changeMode = (e) => {
      e.preventDefault();
      if (this.state.mode === 'room') {
        this.state.mode = 'playlist';
      } else {
        this.state.mode = 'room';
      }
      this.updateModeButton();
    }
    this.updateModeButton = () => {
      if (this.authed) {
        this.refs.mode.classList.remove('hidden');
        if (this.state.mode === 'room'){
          this.refs.modeText.textContent = 'PLAYLIST';
        } else {
          this.refs.modeText.textContent = 'PARTY MODE';
        }
      } else {
        this.refs.mode.classList.add('hidden');
      }
    }
  </script>

  <li class='hidden' ref='mode'><a href="#" onclick={ changeMode }>
    <span class='navbar-button' ref='modeText'>PARTY MODE</span>
  </a></li>
</mode>
