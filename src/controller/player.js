import YouTubePlayer from 'youtube-player';

const PlayerState = {
  NOTSTART: -1,
  ENDED: 0,
  PLAYING: 1,
  PAUSED: 2,
  BUFFERING: 3,
  CUED: 5,
};

export default class Player {
  constructor(elid="youtube-player") {
    this.prepared = false;
    this.playlist = [];
    this.playing = 0;
    this.player = YouTubePlayer(elid);
    this.player.on('stateChange', this.stateChanged.bind(this));
  }

  stateChanged(event) {
    console.log(`stateChanged: ${event.data}`)
    const playingIndex = this.getPlayingIndex();
    // Play a next video automatically when the previous video ended.
    if (event.data === PlayerState.ENDED) {
      // All methods of youtube-player return Promise.
      this.player.getVolume()
        .then(volume => {
          if (volume !== this.playlist[playingIndex].volume) {
            this.playlist[playingIndex].volume = volume;
          }
          return Promise.resolve(this.player);
        })
        .then(() => {
          // 次の曲を再生
          const playIndex = this.getPlayingIndex();
          const nextPlayingMusic = this.playlist[(playIndex + 1) % this.playlist.length];
          this.setVideo(nextPlayingMusic);
          // this.opts.onNextMusic(nextPlayingMusic.id, playlist, true);
        });
    // When player started after the first video is added to empty playlist.
  } else if (event.data === PlayerState.NOTSTART) {
      if (!this.prepared) {
        this.setVideo();
      }
    }
  }
  getPlayingIndex() {
    return this.playlist.findIndex(x => x.id === this.playing);
  }
  setVideo(index=0) {
    console.log(`setVideo ${index}`)
    if (!this.prepared && this.playlist.length > 0) {
      console.log(`setVideo`)
      this.player.cueVideoById(this.playlist[index].id);
      this.player.setVolume(this.playlist[index].volume);
      this.prepared = true;
    }
  }
  selectSong(song) {
  }
  changePlaylist(playlist) {
    const playingIndex = this.getPlayingIndex();
    if (playing !== this.playing) {
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
  }
}