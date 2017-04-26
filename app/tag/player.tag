import YouTubePlayer from 'youtube-player';

<player>
  <style>
    .player {
      width: 100%;
    }
  </style>

  <script>
    const PlayerState = {
      NOTSTART: -1,
      ENDED: 0,
      PLAYING: 1,
      PAUSED: 2,
      BUFFERING: 3,
      CUED: 5,
    };

    this.mixin('obs')
    this.prepared = false;
    this.player = null;
    this.on('mount', () => {
      this.player = YouTubePlayer("youtube-player");
      this.player.on('stateChange', (event) => {
        const playlist = this.opts.playlist;
        const playing = this.opts.playing;
        const playingIndex = playlist.findIndex((x) => x.id === playing);

        // Play a next video automatically when the previous video ended.
        if (event.data === PlayerState.ENDED) {
          // All methods of youtube-player return Promise.
          this.player.getVolume()
                .then(volume => {
                  if (volume !== playlist[playingIndex].volume) {
                    playlist[playingIndex].volume = volume;
                  }
                  return Promise.resolve(this.player);
                })
                .then(() => {
                  const playIndex = playlist.findIndex((x) => x.id === playing);
                  const nextPlayingMusic = playlist[(playIndex + 1) % playlist.length];
                  this.opts.onNextMusic(nextPlayingMusic.id, playlist, true);
                });
        // When player started after the first video is added to empty playlist.
        } else if (event.data === PlayerState.NOTSTART) {
          if (!this.prepared && playlist.length > 0) {
            this.player.cueVideoById(playlist[0].videoId);
            this.player.setVolume(playlist[0].volume);
            this.prepared = true;
          }
        }
      })
      // Cue the first video of playlist when the page is loaded.
      if (!this.prepared && this.props.playlist.length > 0) {
        this.player.cueVideoById(this.props.playlist[0].videoId);
        this.player.setVolume(this.props.playlist[0].volume);
        this.prepared = true;
      }
    })
    this.obs.on('changePlaylist', (playlist, playing) => {
      const playingIndex = playlist.findIndex((x) => x.id === playing);

      if (nextProps.playing !== this.props.playing) {
        this.player.getVolume()
              .then(volume => {
                if (volume !== playlist[playingIndex].volume) {
                  playlist[playingIndex].volume = volume;
                }
                this.props.onNextMusic(playing, playlist, false);
              })
              .then(() => {
                const nextPlayIndex = playlist.findIndex((x) => x.id === nextProps.playing);
                this.player.loadVideoById(playlist[nextPlayIndex].videoId);
                this.player.setVolume(playlist[nextPlayIndex].volume);
              });
      }
    })
  </script>

  <div id="youtube-player" class='player'/>
</player>