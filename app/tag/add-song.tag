import getYoutubeInfo from '../youtube.js';

<add-song>
  <style scoped>
    .request-box {
      display: inline-block;
      width: 80%;
      margin-left: 2px;
      margin-right: 34px;
      background-color: #e6e6e6;
      border-radius: 4px;
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
    this.addSong = (e) => {
      e.preventDefault();
      // リクエストの追加
      getYoutubeInfo(this.refs.url.value, (result, video) => {
        if (result && video) {
          this.refs.url.value = '';
          this.obs.trigger('songAdded', video);
        } else {
          this.obs.trigger('songAdded', null);
        }
      });
    }
  </script>
  
  <div class='request-box'>
    <input ref='url' placeholder="URL" />
    <a href='#' ref="add" class='add-button' onclick={ addSong }><span>+</span></a>
  </div>
</add-song>