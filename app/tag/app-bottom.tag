<app-bottom>
  <style scoped>
    .footer {
      position: fixed;
      bottom: 0;
      width: 100%;
      height: 80px;
      background-color: white;
      z-index: 3;
    }
    .footer-container {
      height: 100%;
    }
    .footer-player {
      height: 50px;
      width: 100px;
      margin-top: 15px;
    }
    .mycenter {
      position: absolute;
      top: 50%;
      left:50%;
      transform: translate(-50%,-50%);
    }
  </style>

  <footer class="footer">
    <div class="container footer-container">
      <div id="youtube-player" class="footer-player"></div>
      <div class="mycenter">
          <input id="url" placeholder="URL" />
          <button id="send">リクエスト</button>
      </div>
    </div>
  </footer>
</app-bottom>