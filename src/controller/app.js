import firebase from 'firebase';
import route from 'riot-route';
import YouTubePlayer from 'youtube-player';
import riot from 'riot';
import toastr from 'toastr';

import QueryString from 'libs/querystring.js';
import {getPlaylistId} from 'utils/firebase.js';
import config from 'config.js';
import app from 'tags/app.tag';
import event from 'event.js';

class App {
  constructor() {
    this.songsRef = null;
    this.songsListId = null;

    route('/playlist', () => {
      console.log('playlist');
      this.obs.trigger(event.page.changed, 'personal');
      this.obs.trigger(event.auth.request);
    });
    route('/room..', () => {
      const q = QueryString.parse();
      const roomId = q.room_id || config.dj_room_id;
      console.log(`room ${roomId}`);
      this.obs.trigger(event.page.changed, 'party');
      this.updateList();
    });

    this.obs = riot.observable();
    riot.mixin('obs', { obs: this.obs });
    riot.mount('*');

    // observerの登録
    this.obs.on(event.auth.cancel, (err) => {
      toastr.error('Login canceled!');
    });
    this.obs.on(event.auth.checked, (user) => {
      // 初回のauth check
      console.log(`authCheck: ${user}`)
      if (user == null){
        this.updateList();
        return;
      }
      getPlaylistId(user)
        .then(playlistKey => {
          if (location.pathname === '/room') {
            this.updateList();
          } else {
            this.updateList(playlistKey);
          }
        })
        .catch(err => {
          console.log(err);
        });
    });
    this.obs.on(event.song.added, (video) => {
      if (video !== null) {
        this.songsRef.push({
          name: video.title,
          id: video.id,
          url: video.url,
          thumb: video.thumb,
          timestamp: new Date().getTime(),
        });
        toastr.success('Request Added!');
      } else {
        toastr.error('Invalid Youtube url');
      }
    });
    // authのリクエスト
    this.obs.trigger(event.auth.request);
  }

  updateList(listId=null) {
    // listの更新
    // console.log(`updateList ${listId}`);
    let isRoom = false;
    if (listId == null) {
      isRoom = true;
      listId = QueryString.parse().room_id || config.dj_room_id;
    }
    // console.log(`updateList ${listId}, ${songsListId}`);
    if (listId === this.songsListId) {
      // 変更なしなら何もしない
      return;
    } else if(this.songsListId != null) {
      // 変更されていた場合, リスナーを解除
      firebase.database().ref(`songs/${this.songsListId}`).off();
      firebase.database().ref(`rooms/${this.songsListId}`).off();
      this.obs.trigger(event.song.removeAll);
    }
    this.songsListId = listId;
    // console.log(`updateList ${songsListId}`);
    // データベースの参照を準備
    this.songsRef = firebase.database().ref(`songs/${this.songsListId}`);
    // 既存曲目を表示
    this.songsRef.orderByKey().on('child_added', snapshot => {
      this.obs.trigger(event.song.add, snapshot.val());
    });
    if (isRoom) {
      // roomならindexの監視
      firebase.database().ref(`rooms/${this.songsListId}`).on('value', snapshot => {
        if (snapshot.val() == null){
          console.log('playing index: null');
          return;
        }
        const playing = snapshot.val().playing;
        console.log(`playing index: ${playing}`);
        this.obs.trigger(event.index.changed, playing);
      });
    }
  }
}
export default App;