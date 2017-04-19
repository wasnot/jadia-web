import $ from 'jquery';
import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/database';
import toastr from 'toastr';
import YouTubePlayer from 'youtube-player';

import config from './config.js';
import QueryString from './lib/querystring.js';
import YoutubeInfo from './lib/get-youtube-info.js';

// import app from './tag/app.tag';
// riot.mount('*')

// Initialize Firebase
firebase.initializeApp(config.fb_config);
const room_id = QueryString.parse().room_id || config.dj_room_id
// データベースの参照を準備
const songsRef = firebase.database().ref('songs/' + room_id)
// 既存曲目を表示
songsRef.orderByKey().on('child_added', snapshot => {
    const song = snapshot.val();
    $('<button class="list-group-item"">')
      .text(song.name)
      .append($(`<a href="${song.url}" target="_blank" class="pull-right">`)
        .append($('<i class="fa fa-external-link" style="color: white;">')))
      .on('click', () => typeof window.player !== "undefined" && window.player.cueVideoById(song.id))
      .appendTo('#songs');
});
firebase.database().ref('rooms/' + room_id).on('value', snapshot => {
    const playing = snapshot.val().playing;
    console.log('playing index: ' + playing);

    $('.list-group-item').each(function(index) {
        if (index == playing) {
            $(this).addClass('active');
        } else {
            $(this).removeClass('active');
        }
    });
    $('html').animate({
        scrollTop: $('.list-group-item.active').position().top
    },"slow", "swing");
}); 
toastr.options = {
    "closeButton": true,
    "timeOut": 2000,
    "positionClass": "toast-bottom-center",
};
if (location.pathname == '/player') {
    window.player = YouTubePlayer("youtube-player");
}

$('#send').click(() => {
    // リクエストの追加
    getYoutubeInfo($('#url').val(), () => {
        toastr.success('Request Added!');
    });
});

function getYoutubeInfo(video_url, callback) {
    const yt_video_id = YoutubeInfo.getYoutubeIdByUrl(video_url);
    if (yt_video_id) {
        const key = $.getJSON('https://www.googleapis.com/youtube/v3/videos?id=' + yt_video_id + '&part=snippet,contentDetails&key=' + config.yt_key + '&fields=items(id,snippet(title,thumbnails),contentDetails(duration))')
        .done((data, status, xhr) => {
            console.log(data);
            const yt_response = data.items[0], // If you need more video informations, take a look on this response: data.data
                yt_title = yt_response.snippet.title,
                yt_duration = YoutubeInfo.formatSecondsAsTime(yt_response.contentDetails.duration),
                yt_url = 'https://www.youtube.com/watch?v=' + yt_video_id;
            songsRef.push({name: yt_title, id: yt_video_id, url: yt_url, timestamp: new Date().getTime()});
            callback();
        });
    } else {
        toastr.error('Invalid Youtube url');
    }
}

function setIndex(index) {
    firebase.database().ref('rooms/' + room_id).set({playing: index});
}
