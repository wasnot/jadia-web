<app-navbar>
  <style scoped>
    .navbar {
      background-color: black;
      border-color: black;
      margin-bottom: 0;
      z-index: 3;
      border-radius: 0px;
    }
    .navbar-brand {
      position: absolute;
      width: 100%;
      padding: 0;
    }
    .brand-logo {
      max-height: 70%;
      text-align: center;
      left: 0;
      margin: 0 auto;
    }
    .header-button {
      border:solid 1px white;
      color: white;
      padding: 5px 40px;
    }
    .header-button:hover {
      color: gray;
    }
  </style>

  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">
          <img alt="Brand" src="img/jadia_logo0307.png" class="brand-logo">
        </a>
      </div>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">
          <span class='header-button'>Login</span>
        </a></li>
        <li><a href="#">
          <span class='header-button'>Room</span>
        </a></li>
      </ul>
    </div>
  </nav>
</app-navbar>
