import route from 'riot-route';

<room>
  <script>
    this.mixin('obs');
    this.authed = false
    this.room = 'party'
    this.on('mount', () => {
      switch (location.pathname) {
        case '/room':
          this.room = 'party';
          break;
        case '/playlist':
          this.room = 'playlist';
          break;
      }
    })
    this.obs.on('updateAuth', (authed) => {
      if (authed) {
        this.authed = true;
        if (location.pathname === '/') {
          route('playlist');
          this.room = 'playlist';
        }
      } else {
        this.authed = false;
        route('room');
        this.room = 'party';
      }
      this.updateRoomButton();
    })
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

  <li class='hidden' ref='room'><a href="#" onclick={ changeRoom }>
    <span class='header-button' ref='roomText'>PARTY MODE</span>
  </a></li>
</room>
