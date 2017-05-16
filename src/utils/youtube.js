import $ from 'jquery';
import YoutubeInfo from 'libs/get-youtube-info.js';

import config from 'config.js';
import YoutubeVideo from 'models/youtube-video.js';

export function getYoutubeInfo(video_url, callback) {
  return new Promise((resolve, reject) => {
    const yt_video_id = YoutubeInfo.getYoutubeIdByUrl(video_url);
    if (yt_video_id) {
      const url = 'https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails&' +
        `id=${yt_video_id}&key=${config.yt_key}&` +
        'fields=items(id,snippet(title,thumbnails),contentDetails(duration))';
      const key = $.getJSON(url)
        .done((data, status, xhr) => {
          console.log(data);
          const yt_response = data.items[0], // If you need more video informations, take a look on this response: data.data
            yt_title = yt_response.snippet.title,
            yt_duration = YoutubeInfo.formatSecondsAsTime(yt_response.contentDetails.duration),
            yt_thumb = yt_response.snippet.thumbnails.default.url,
            yt_url = `https://www.youtube.com/watch?v=${yt_video_id}`;
          const video = new YoutubeVideo({
            title: yt_title,
            url: yt_url,
            id: yt_video_id,
            thumb: yt_thumb
          });
          resolve(video);
          if (typeof callback === 'function'){
            callback(true, video);
          }
        });
    } else {
      reject();
      if (typeof callback === 'function'){
        callback(false);
      }
    }
  });
}

export function searchYoutubeVideo(query) {
  return new Promise((resolve, reject) => {
    if (!query) {
      reject();
      return;
    }
    const url = 'https://www.googleapis.com/youtube/v3/search?part=snippet&' +
      `key=${config.yt_key}&q=${query}&` +
      'type=video&fields=items(id,snippet(title,thumbnails)),pageInfo,nextPageToken';
    const key = $.getJSON(url)
      .done((data, status, xhr) => {
        console.log(data);
        const videos = data.items.map((elem) => new YoutubeVideo({
            title: elem.snippet.title,
            url: `https://www.youtube.com/watch?v=${elem.id.videoId}`,
            id: elem.id.videoId,
            thumb: elem.snippet.thumbnails.default.url
          }));
        resolve(videos, data.nextPageToken);
      });
  });
}