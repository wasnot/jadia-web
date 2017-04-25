import getYoutubeInfo from '../youtube.js';
import add_song from './add-song.tag';

<app-bottom>
  <style scoped>
    .bottom-fix {
      position: fixed;
      bottom: 0;
      z-index: 3;
      margin-left: -15px;
    }
    .bottom-bar {
      margin-bottom: 25px;
      width: 90%;
      margin-right: auto;
      margin-left: auto;
    }
    .prof-icon {
      display: inline-block;
      width: 32px;
      height: 32px;
    }
    .img-circle {
      width: 32px;
      height: 32px;
    }
    add-song {
      display: inline-block;
      width: 80%;
      margin-left: 2px;
    }
  </style>

  <script>
    this.mixin('obs')
    this.obs.on('changePage', (page) => {
      //this.refs.roomColor.style.backgroundColor = color[page];
    })
    this.obs.on('loggedIn', (user) => {
      if (typeof user === 'undefined') {
        return;
      }
      const url = user.photoURL;
      const imgPreloader = new Image();
      imgPreloader.onload = () => this.refs.icon.src = url;
      imgPreloader.src = url;
    })
  </script>

  <div class='container bottom-fix'>
    <div class='row'>
      <div class="col-sm-6">
        <div class='bottom-bar'>
          <div class='prof-icon'>
            <img src='' alt='' class='img-circle' ref='icon' crossorigin="Anonymous"/>
          </div>
          <add-song/>
        </div>
      </div>
    </div>
  </div>
</app-bottom>