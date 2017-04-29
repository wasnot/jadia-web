import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/database';
import toastr from 'toastr';
import YouTubePlayer from 'youtube-player';
import riot from 'riot';
import route from 'riot-route';

import QueryString from './lib/querystring.js';

import config from './config.js';
import app from './tag/app.tag';
import "./styles/style.css";
import "./styles/toastr.css";

// Initialize Firebase
firebase.initializeApp(config.fb_config);
let songsRef = null;
let songsListId = null;

// riot initialize
route.base('/');
route('/playlist', () => {
  console.log('playlist');
  obs.trigger('changePage', 'personal');
  obs.trigger('auth');
});
route('/room..', () => {
  const q = route.query()
  const roomId = q.room_id || config.dj_room_id
  console.log(`room ${roomId}`);
  obs.trigger('changePage', 'party');
  updateList();
});
const obs = riot.observable();
riot.mixin('obs', { obs: obs });
riot.mount('*');
// observerの登録
obs.on('songClick', (song) => {
  console.log(song);
  if (player != null) {
    player.cueVideoById(song.id);
  }
});
obs.on('cancelLogin', (err) => {
  toastr.error('Login canceled!');
});
obs.on('authChecked', (user) => {
  // 初回のauth check
  console.log(`authCheck: ${user}`)
  if (user == null){
    updateList();
    return;
  }
  getPlaylistId(user);
});
obs.on('songAdded', (video) => {
  if (video !== null) {
    songsRef.push({
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
obs.trigger('auth');
// player initialize
const player = YouTubePlayer("youtube-player");
// toastr inisialize
toastr.options = {
  "closeButton": true,
  "timeOut": 2000,
  "positionClass": "toast-bottom-center",
};

const getPlaylistId = (user) => {
  // playlist
  firebase.database().ref(`users/${user.uid}`)
    .once('value')
    .then((snapshot) => {
      const user_data = snapshot.val();
      console.log('user_data');
      console.log(user_data);
      let playlistKey;
      if (user_data == null || user_data.playlist == null) {
        const playlist = firebase.database().ref('songs/').push({});
        playlistKey = playlist.key;
        firebase.database().ref(`users/${user.uid}`).set({
          name: user.displayName,
          playlist: { 
            [playlistKey]: true
          }
        });
      } else {
        playlistKey = Object.keys(user_data.playlist)[0]
      }
      console.log(`playlist: ${playlistKey}`);
      if (location.pathname === '/room') {
        updateList();
      } else {
        updateList(playlistKey);
      }
    });
}
const updateList = (listId=null) => {
  // listの更新
  console.log(`updateList ${listId}`);
  let isRoom = false;
  if (listId == null) {
    isRoom = true;
    listId = QueryString.parse().room_id || config.dj_room_id;
  }
  console.log(`updateList ${listId}, ${songsListId}`);
  if (listId === songsListId) {
    // 変更なしなら何もしない
    return;
  } else if(songsListId != null) {
    // 変更されていた場合, リスナーを解除
    firebase.database().ref(`songs/${songsListId}`).off();
    firebase.database().ref(`rooms/${songsListId}`).off();
    obs.trigger('removeAllSong');
  }
  songsListId = listId;
  console.log(`updateList ${songsListId}`);
  // データベースの参照を準備
  songsRef = firebase.database().ref(`songs/${songsListId}`);
  // 既存曲目を表示
  songsRef.orderByKey().on('child_added', snapshot => {
    const song = snapshot.val();
    obs.trigger('addSong', song);
  });
  if (isRoom) {
    firebase.database().ref(`rooms/${songsListId}`).on('value', snapshot => {
      const playing = snapshot.val().playing;
      console.log(`playing index: ${playing}`);
      obs.trigger('changeIndex', playing);
    });
  }
}

import $ from 'jquery';
window.$ = $;
window.route = route;
window.firebase = firebase;

function setIndex(index) {
  firebase.database().ref(`rooms/${roomId}`).set({ playing: index });
}
