<app-bottom>
  <style scoped>
    .bottom-fix {
      position: fixed;
      bottom: 0;
      z-index: 3;
      margin-left: -15px;
    }
    .request-box {
      margin-bottom: 25px;
      width: 80%;
      margin-right: auto;
      margin-left: auto;
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
  <div class='container bottom-fix'>
    <div class='row'>
      <div class="col-sm-6">
        <div class='request-box'>
          <input id="url" placeholder="URL" />
          <a href='#' id="send" class='add-button'><span>+</span></a>
        </div>
      </div>
    </div>
  </div>
</app-bottom>