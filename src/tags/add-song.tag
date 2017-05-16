import {getYoutubeInfo, searchYoutubeVideo} from 'utils/youtube.js';
import event from 'event.js';

<add-song>
  <style scoped>
    .request-box {
      width: 100%;
      background-color: #e6e6e6;
      border-radius: 4px;
    }
    .dropdown-menu {
      width: 100%;
    }
    input{
      vertical-align: middle;
      margin-left: 10px;
      width: 90%;
      width: calc(100% - 40px);
      height: 26px;
      background: transparent;
      border: transparent;
    }
    .add-button {
      color: white;
      background-color: #D42D26;
      border-radius: 9px;
      width: 18px;
      height: 18px;
      text-align: center;
      display: inline-block;
      vertical-align: middle;
      line-height: 15px;
      text-decoration: none;
    }
    .add-button:hover {
      background-color: #B61E18;
    }
  </style>

  <script>
    this.mixin('obs')
    this.suggestSongs = []
    this.addSong = (e) => {
      e.preventDefault();
      // リクエストの追加
      const val = this.refs.url.value;
      getYoutubeInfo(val)
        .then((video) => {
          this.refs.url.value = '';
          this.obs.trigger(event.songDb.add, video);
        }, () =>{
          console.log(val);
          if (!val || val.startsWith('http') || val.includes('youtu')) {
            this.obs.trigger(event.songDb.add, null);
            return
          }
          searchYoutubeVideo(val)
            .then((videos) => {
              console.log(videos);
              this.suggestSongs = videos;
              this.refs.dropup.classList.add('open');
              this.update();
            }, () => {
              this.obs.trigger(event.songDb.add, null);
            });
        });
    }
    this.songClick = (e) => {
      this.obs.trigger(event.songDb.add, e.item.song);
      return false;
    }
    this.input = (e) => {
      //console.log('input');
      //console.log(e.target.value);
    }
    this.downKey = 0
    this.keydown = (e) => {
      this.downKey = e.keyCode;
    }
    this.keyup = (e) => {
      if (e.keyCode == 13 && e.keyCode == this.downKey) {
        console.log('enter!');
        this.addSong(e);
      }
    }
  </script>
  
  <div class='request-box'>
    <div class="dropup" ref='dropup'>
      <button class='hidden' id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"/>
      <ul class="dropdown-menu" aria-labelledby="dLabel">
        <li each={ song in suggestSongs }>
          <a hre="#" onclick={ songClick }>{ song.title }</a>
        </li>
      </ul>
    </div>
    <input ref='url' placeholder="URL" oninput={ input } onkeyup={ keyup } onkeydown={ keydown }/>
    <a href='#' ref="add" class='add-button' onclick={ addSong }><span>+</span></a>
  </div>
</add-song>