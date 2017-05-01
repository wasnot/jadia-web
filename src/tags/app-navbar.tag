import login from 'tags/login.tag';
import room from 'tags/room.tag';

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
  </style>

  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">
          <img alt="JADIA" src="img/jadia_logo0307.png" class="brand-logo">
        </a>
      </div>
      <ul class="nav navbar-nav navbar-right">
        <virtual data-is='login'/>
        <virtual data-is='room'/>
      </ul>
    </div>
  </nav>
</app-navbar>
