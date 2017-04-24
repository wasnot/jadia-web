<app-list>
  <style scoped>
    .fa {
      color: white;
    }
    .song {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      width: 95%;
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
    <a hre="#" each={ song in songs } class="list-group-item" onclick={ songClick.bind(this, song) }>
      <span class="song">{ song.name }</span>
      <div class="pull-right" onclick={ songOpen.bind(this, song) }>
        <i class="fa fa-external-link"/>
      </div>
    </a>
  </ul>
</app-list>