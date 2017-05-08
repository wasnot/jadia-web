import EventEmmitter from 'events';
import YouTubePlayer from 'youtube-player';

const PlayerState = {
  NOTSTART: -1,
  ENDED: 0,
  PLAYING: 1,
  PAUSED: 2,
  BUFFERING: 3,
  CUED: 5,
};

export default class Player extends EventEmmitter {
  constructor(elementId="youtube-player", mode='room') {
    super();
    this.playlist = [];
    this.playingIndex = -1;
    this.playing = false;
    this.mode = mode;
    this.player = YouTubePlayer(elementId);
    this.player.on('stateChange', this.stateChanged.bind(this));
  }

  stateChanged(event) {
    // console.log(`stateChanged: ${Object.keys(PlayerState).find(k => PlayerState[k] == event.data)}`)
    // Play a next video automatically when the previous video ended.
    if (event.data === PlayerState.ENDED) {
      if (this.mode == 'room') {
        return;
      }
      // 次の曲を再生
      const nextIndex = (this.playingIndex + 1) % this.playlist.length;
      this.setVideo(nextIndex);
    // When player started after the first video is added to empty playlist.
    } else if (event.data === PlayerState.NOTSTART) {
      // this.setVideo();
    } else if (event.data === PlayerState.PLAYING) {
      this.playing = true;
    } else if (event.data === PlayerState.PAUSED) {
      this.playing = false;
    } else if (event.data === PlayerState.CUED) {
      if (this.playing) {
        this.player.playVideo();
      }
    }
  }
  setVideo(index=0) {
    // console.log(`setVideo ${index}`)
    if (this.playlist.length > 0) {
      // console.log(`setVideo`)
      this.playingIndex = index;
      this.player.cueVideoById(this.playlist[index].id);
      // this.player.setVolume(this.playlist[index].volume);
      this.emit('changeIndex', index);
    }
  }
  addSong(song) {
    this.playlist.push(song);
    // Cue the first video of playlist when the page is loaded.
    if (this.playingIndex === -1 && this.mode === 'playlist') {
      this.setVideo();
    }
  }
  removeSong(song) {
    const target = this.playlist.findIndex((v) => v.key == song.key);
    if (target != -1) {
      this.playlist.splice(target, 1);
    }
    // console.log(`removeplay: ${target}`)
  }
  resetPlaylist() {
    this.playlist = [];
  }
  selectSong(song) {
    // console.log(song);
    const index = this.playlist.indexOf(song);
    // console.log(`index: ${index}`);
    this.setVideo(index);
  }
}