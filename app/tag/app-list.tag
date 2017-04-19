<app-list>
  <style scoped>
    .list-group-item:nth-child(even) {
      background-color:#777;
      border-color: #777;
      color:white;
    }
    .list-group-item:nth-child(odd) {
      background-color:black;
      border-color: black;
      color:white;
    }
    .list-group-item.active {
      background-color: #84C6D2;
      border-color: #84C6D2;
    }
    .fa {
      color: white;
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
      e.preventDefault();
      this.obs.trigger('songClick', song);
    }
  </script>

  <ul id="songs" class="list-group">
    <button each={ song in songs } class="list-group-item" onclick={ songClick.bind(this, song) }>
      { song.name }
      <a href={ song.url } target="_blank" class="pull-right">
        <i class="fa fa-external-link"/>
      </a>
    </button>
  </ul>
</app-list>