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
    .request-box {
      display: inline-block;
      width: 80%;
      margin-left: 2px;
      margin-right: 34px;
      background-color: #e6e6e6;
      border-radius: 4px;
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
          <div class='request-box'>
            <input id="url" placeholder="URL" />
            <a href='#' id="send" class='add-button'><span>+</span></a>
          </div>
        </div>
      </div>
    </div>
  </div>
</app-bottom>