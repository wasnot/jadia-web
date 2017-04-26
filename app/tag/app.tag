import app_navbar from './app-navbar.tag';
import app_list from './app-list.tag';
import app_view from './app-view.tag';
import app_bottom from './app-bottom.tag';

<app>
  <style scoped>
    .room-color {
      position: absolute;
      width: 50%;
      height: 100%;
      z-index: -1;
    }
    .rapper {
      max-width: 920px;
      padding-left: 20px;
    }
    .content-rapper {
      height: 90%;
      height: -webkit-calc(100% - 50px);
      height: calc(100% - 50px);
      padding-left: 30px;
      padding-right: 30px;
    }
    .content-row {
      background-color: black;
    }
    .content {
      overflow: auto;
      height: 100%;
      padding-left: 0px;
    }
    .height-fill {
      height: 100%;
    }
    .width-fill {
      padding-right: 0px;
      padding-left: 0px;
    }
    .bottom {
      height: 0px;
    }
    @media (min-width: @screen-sm-min) {

    }
  </style>

  <script>
    const color = {
      'personal': '#4BB6E9',
      'party': '#DD76A3',
      'ai': '#FEEF50',
    }
    this.mixin('obs')
    this.obs.on('changePage', (page) => {
      this.refs.roomColor.style.backgroundColor = color[page];
    })
    this.on('mount', () => {
      switch (location.pathname) {
        case '/room':
          this.refs.roomColor.style.backgroundColor = color['party'];
          break;
        case '/playlist':
          this.refs.roomColor.style.backgroundColor = color['personal'];
          break;
      }
    })
  </script>

  <div ref='roomColor' class='room-color'/>
  <div class='height-fill'>
    <div class='container'>
      <app-navbar/>
    </div>
    <div class='container content-rapper'>
      <div class='row height-fill content-row'>
        <app-view class='col-sm-6 col-xs-12'/>
        <app-list class='col-sm-6 col-xs-12 content'/>
      </div>
    </div>
    <div class='container bottom'>
      <app-bottom/>
    </div>
  </div>
</app>
