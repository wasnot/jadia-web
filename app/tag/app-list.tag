<app-list>
  <style scoped>
    .fa {
      color: white;
    }
    .song-list {
      height: 63px;
      padding-left: 5px;
    }
    .song-thumb {
      display: inline-block;
      width: 72px;
      height: 41px;
      background-position: center;
      vertical-align: middle;
    }
    .song-title {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      width: 75%;
      width: calc(100% - 94px);
      display: inline-block;
      vertical-align: middle;
      padding-left: 5px;
    }
    .song-action {
      vertical-align: middle;
      display: inline-block;
    }
  </style>

  <script>
    this.songs = []
    this.mixin('obs')
    this.obs.on('addSong', (song) => {
      this.songs.push(song);
      this.update();
    })
    this.obs.on('removeAllSong', () => {
      this.songs = [];
      this.update();
    })
    this.songClick = (song, e) => {
      this.obs.trigger('songClick', song);
      return false;
    }
    this.songOpen = (song, e) => {
      e.stopPropagation();
      window.open(song.url, '_blank');
    }
  </script>

  <ul class="list-group">
    <a hre="#" each={ song in songs } class="list-group-item song-list" onclick={ songClick.bind(this, song) }>
      <div style='background-image: url({ song.thumb });' class='song-thumb'/>
      <span class="song-title">{ song.name }</span>
      <div class="song-action" onclick={ songOpen.bind(this, song) }>
        <i class="fa fa-external-link"/>
      </div>
    </a>
  </ul>
</app-list>