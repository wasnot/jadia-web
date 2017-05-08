import Player from 'controller/player.js';
import event from 'event.js';

<player>
  <style scoped>
    .player {
      width: 100%;
    }
    .overlay {
      position: absolute;
      width: 100%;
      height: 100%;
      top: 0px;
      left: 0px;
      background-color: rgba(0, 0, 0, 0.8);
      z-index: 5;
    }
    .overlay-center {
      position: absolute;
      top: 50%;
      left:50%;
      transform: translate(-50%,-50%);
      color: white;
    }
  </style>

  <script>
    this.mixin('obs')
    this.mode = 'room'
    this.player = null;
    this.on('mount', () => {
      switch (location.pathname) {
        case '/room':
          this.mode = 'room';
          break;
        case '/playlist':
          this.mode = 'playlist';
          break;
      }
      // player initialize
      this.player = new Player("youtube-player", this.mode);
    })
    this.obs.on(event.page.changed, (page) => {
      this.mode = page;
      this.player.mode = page;
      //this.updateText();
    })
    this.obs.on(event.song.add, (song) => {
      this.player != null && this.player.addSong(song);
      //this.updateText();
    })
    this.obs.on(event.song.remove, (song) => {
      this.player != null && this.player.removeSong(song);
    })
    this.obs.on(event.song.removeAll, () => {
      this.player != null && this.player.resetPlaylist();
    })
    this.obs.on(event.song.click, (song) => {
      this.player != null && this.player.selectSong(song);
    });
    this.updateText = () => {
      if (this.mode === 'room'){
        this.refs.overlayText.textContent = 'リストの曲を選ぶと\n視聴できます。'
      } else {
        this.refs.overlayText.textContent = '下のフォームから動画を\n追加してください。'
      }
      if (this.player.playlist.length === 0 || this.player.playingIndex === -1) {
        this.refs.overlay.classList.remove('hidden');
      } else {
        this.refs.overlay.classList.add('hidden');
      }
    }
  </script>

  <div ref='overlay' class='overlay hidden'>
    <span ref='overlayText' class='overlay-center'/>
  </div>
  <div id="youtube-player" class='player'/>
</player>