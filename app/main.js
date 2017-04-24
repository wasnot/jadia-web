import $ from 'jquery';
import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/database';
import toastr from 'toastr';
import YouTubePlayer from 'youtube-player';
import riot from 'riot';

import QueryString from './lib/querystring.js';

import config from './config.js';
import getYoutubeInfo from './youtube.js';
import app from './tag/app.tag';
// import "./styles/style.css";

// Initialize Firebase
firebase.initializeApp(config.fb_config);

const obs = riot.observable();
riot.mixin('obs', { obs: obs });
riot.mount('*');
obs.on('songClick', (song) => {
  console.log(song);
  if (typeof window.player !== 'undefined') {
    window.player.cueVideoById(song.id);
  }
});
obs.trigger('changePage', 'personal');

const roomId = QueryString.parse().room_id || config.dj_room_id;
// データベースの参照を準備
const songsRef = firebase.database().ref('songs/' + roomId);
// 既存曲目を表示
songsRef.orderByKey().on('child_added', snapshot => {
  const song = snapshot.val();
  obs.trigger('addSong', song);
});
firebase.database().ref('rooms/' + roomId).on('value', snapshot => {
  const playing = snapshot.val().playing;
  console.log('playing index: ' + playing);

  $('.list-group-item').each(function (index) {
    if (index == playing) {
      $(this).addClass('active');
    } else {
      $(this).removeClass('active');
    }
  });
  if (typeof $('.list-group-item.active') !== 'undefined' && $('.list-group-item.active').length != 0) {
    $('app-list').animate({
      scrollTop: $('.list-group-item.active').position().top
    }, "slow", "swing");
  }
});
toastr.options = {
  "closeButton": true,
  "timeOut": 2000,
  "positionClass": "toast-bottom-center",
};
window.player = YouTubePlayer("youtube-player");
window.$ = $;

$('#send').click(() => {
  // リクエストの追加
  getYoutubeInfo($('#url').val(), (result, video) => {
    if (result && video) {
      songsRef.push({
        name: video.title,
        id: video.id,
        url: video.url,
        thumb: video.thumb,
        timestamp: new Date().getTime(),
      });
      toastr.success('Request Added!');
      $('#url').val('');
    } else {
      toastr.error('Invalid Youtube url');
    }
  });
});

function setIndex(index) {
  firebase.database().ref('rooms/' + roomId).set({ playing: index });
}
