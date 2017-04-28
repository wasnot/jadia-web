import getYoutubeInfo from '../youtube.js';
import add_song from './add-song.tag';
import profile from './profile.tag';

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
    add-song {
      display: inline-block;
      width: 80%;
      margin-left: 2px;
    }
  </style>

  <div class='container bottom-fix'>
    <div class='row'>
      <div class="col-sm-6">
        <div class='bottom-bar'>
          <profile/>
          <add-song/>
        </div>
      </div>
    </div>
  </div>
</app-bottom>