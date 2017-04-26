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
// import "./styles/style.css";

// Initialize Firebase
firebase.initializeApp(config.fb_config);
let songsRef = null;
let songsListId = config.dj_room_id;

// riot initialize
route.base('/');
route('/playlist', () => {
  console.log('playlist');
  obs.trigger('changePage', 'personal');
});
route('/room..', () => {
  const q = route.query()
  const roomId = q.room_id || config.dj_room_id
  console.log('room ' + roomId);
  obs.trigger('changePage', 'party');
});
const obs = riot.observable();
riot.mixin('obs', { obs: obs });
riot.mount('*');
// observerの登録
obs.on('songClick', (song) => {
  console.log(song);
  if (typeof player !== 'undefined') {
    player.cueVideoById(song.id);
  }
});
obs.on('cancelLogin', (err) => {
  toastr.error('Login canceled!');
});
obs.on('loggedIn', (user) => {
  console.log('loggedIn');
  if (typeof user === 'undefined'){
    return;
  }
  firebase.database().ref('users/' + user.uid).once('value', (snapshot) => {
    const user_data = snapshot.val();
    console.log('user_data');
    console.log(user_data);
    if (user_data === null) {
      const playlistKey = firebase.database().ref('songs/').push({});
      firebase.database().ref('users/' + user.uid).set({
        name: user.displayName,
        playlist: {
          playlistKey: true
        }
      });
    }
  });
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
// player initialize
const player = YouTubePlayer("youtube-player");
// toastr inisialize
toastr.options = {
  "closeButton": true,
  "timeOut": 2000,
  "positionClass": "toast-bottom-center",
};

const updateList = () => {
  const roomId = QueryString.parse().room_id || config.dj_room_id;
  // データベースの参照を準備
  songsRef = firebase.database().ref('songs/' + roomId);
  // 既存曲目を表示
  songsRef.orderByKey().on('child_added', snapshot => {
    const song = snapshot.val();
    obs.trigger('addSong', song);
  });
  firebase.database().ref('rooms/' + roomId).on('value', snapshot => {
    const playing = snapshot.val().playing;
    console.log('playing index: ' + playing);
    obs.trigger('changeIndex', playing);
  });
}
updateList();

import $ from 'jquery';
window.$ = $;
window.route = route;
window.firebase = firebase;

function setIndex(index) {
  firebase.database().ref('rooms/' + roomId).set({ playing: index });
}
