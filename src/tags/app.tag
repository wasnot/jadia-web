import event from 'event.js';
import app_navbar from 'tags/app-navbar.tag';
import app_list from 'tags/app-list.tag';
import app_view from 'tags/app-view.tag';
import app_bottom from 'tags/app-bottom.tag';

<app>
  <style scoped>
    .mode-color {
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
      'playlist': '#4BB6E9',
      'room': '#DD76A3',
      'ai': '#FEEF50',
    }
    this.mixin('obs')
    this.obs.on(event.page.changed, (page) => {
      this.refs.modeColor.style.backgroundColor = color[page];
    })
    this.on('mount', () => {
      switch (location.pathname) {
        case '/room':
          this.refs.modeColor.style.backgroundColor = color['room'];
          break;
        case '/playlist':
          this.refs.modeColor.style.backgroundColor = color['playlist'];
          break;
      }
    })
  </script>

  <div ref='modeColor' class='mode-color'/>
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
