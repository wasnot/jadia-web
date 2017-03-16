window.$ = require('jquery');
window.firebase = require('firebase');
window.config = require('./config.js');
window.QueryString = require('./lib/querystring.js');
window.YoutubeInfo = require('./lib/get-youtube-info.js');

// Initialize Firebase
firebase.initializeApp(config.fb_config);
var room_id = QueryString.parse().room_id || config.dj_room_id
// データベースの参照を準備
var songsRef = firebase.database().ref('songs/' + room_id)

// 既存メッセージを表示
songsRef.orderByKey().on('child_added', function(snapshot) {
  var msg = snapshot.val();
  $('<li>').text(msg.name).appendTo('#songs');
});
firebase.database().ref('rooms/' + room_id).on('value', function(snapshot) {
  var playing = snapshot.val().playing;
  console.log('playing index: ' + playing);
});

$('#send').click(function() {
  // 新規メッセージを投稿
  getYoutubeInfo($('#url').val(), addNewSong);
});

function addNewSong(id, url, title) {
  songsRef.push({
    name: title,
    id: id,
    url: url,
    timestamp: new Date().getTime()
  });
}

function getYoutubeInfo(video_url, callback) {
  var yt_video_id = YoutubeInfo.getYoutubeIdByUrl( video_url );
  if( yt_video_id ){
    var key =
   $.getJSON(
     'https://www.googleapis.com/youtube/v3/videos?id='+ yt_video_id
      +'&part=snippet,contentDetails&key=' + yt_key
      + '&fields=items(id,snippet(title,thumbnails),contentDetails(duration))'
   ).done(function(data, status, xhr) {
     console.log(data);
     var yt_response = data.items[0], // If you need more video informations, take a look on this response: data.data
         yt_title = yt_response.snippet.title,
         yt_duration = YoutubeInfo.formatSecondsAsTime( yt_response.contentDetails.duration ),
         yt_url = 'https://www.youtube.com/watch?v=' + yt_video_id;
    //  console.log('youtube title: ' + yt_title);
    //  console.log('youtube duration: ' + yt_duration);
    //  console.log('youtube url: ' + yt_url);
     callback(yt_video_id, yt_url, yt_title);
   });
  }
}

function setIndex(index) {
  firebase.database().ref('rooms/' + room_id).set({
      playing: index
  });
}