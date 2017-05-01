import Player from 'controller/player.js';
import event from 'event.js';

<player>
  <style>
    .player {
      width: 100%;
    }
  </style>

  <script>
    this.mixin('obs')
    this.player = null;
    this.on('mount', () => {
      // player initialize
      this.player = new Player("youtube-player");
      // Cue the first video of playlist when the page is loaded.
      //this.player.setVideo();
    })
    this.obs.on(event.song.add, (song) => {
      if (this.player == null) {
        return;
      }
      this.player.playlist.push(song);
    })
    this.obs.on(event.song.removeAll, () => {
      if (this.player == null) {
        return;
      }
      this.player.playlist = [];
    })
    this.obs.on(event.playlist.select, song => {
    })
    this.obs.on(event.playlist.changed, (playlist, playing) => {
      this.player.changePlaylist(playlist);
    })
    this.obs.on(event.song.click, (song) => {
      if (this.player == null) {
        return;
      }
      console.log(song);
      const index = this.player.playlist.indexOf(song);
      console.log(`index: ${index}`);
      this.player.setVideo(this.player.playlist.indexOf(song));
      //this.player.cueVideoById(song.id);
    });
  </script>

  <div id="youtube-player" class='player'/>
</player>