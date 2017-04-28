<profile>
  <style>
    .prof-icon {
      display: inline-block;
      width: 32px;
      height: 32px;
    }
    .img-circle {
      width: 32px;
      height: 32px;
    }
  </style>
  <script>
    this.mixin('obs')
    this.obs.on('changePage', (page) => {
      //this.refs.roomColor.style.backgroundColor = color[page];
    })
    this.obs.on('authChecked', (user) => {
      if (user == null) {
        return;
      }
      const url = user.photoURL;
      this.refs.icon.src = url;
      this.refs.icon.title = user.displayName;
    })
  </script>

  <div class='prof-icon'>
    <img src='' alt='' class='img-circle' ref='icon' referrerpolicy="no-referrer"/>
  </div>
</profile>