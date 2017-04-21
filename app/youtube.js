import $ from 'jquery';
import YoutubeInfo from './lib/get-youtube-info.js';

import config from './config.js';

class YoutubeVideo {
  constructor(title, url, id) {
    this.title = title;
    this.url = url;
    this.id = id;
  }
}

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
        const video = new YoutubeVideo(yt_title, yt_url, yt_video_id);
        callback(true, video);
      });
  } else {
    callback(false);
  }
}
export default getYoutubeInfo