import 'styles/navbar.css';
import event from 'event.js';

<mode>
  <script>
    this.mixin('obs');
    this.authed = false
    this.mode = 'room'
    this.on('mount', () => {
      switch (location.pathname) {
        case '/room':
          this.mode = 'room';
          break;
        case '/playlist':
          this.mode = 'playlist';
          break;
      }
    })
    this.obs.on(event.auth.updated, (authed) => {
      if (authed) {
        this.authed = true;
        if (location.pathname === '/') {
          this.mode = 'playlist';
        }
      } else {
        this.authed = false;
        this.mode = 'room';
      }
      this.obs.trigger(event.page.request, this.mode);
      this.updateModeButton();
    })
    this.changeMode = (e) => {
      e.preventDefault();
      if (this.mode === 'room') {
        this.mode = 'playlist';
      } else {
        this.mode = 'room';
      }
      this.obs.trigger(event.page.request, this.mode);
      this.updateModeButton();
    }
    this.updateModeButton = () => {
      if (this.authed) {
        this.refs.mode.classList.remove('hidden');
        if (this.mode === 'room'){
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
