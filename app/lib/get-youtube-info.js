var YoutubeInfo = {
  getYoutubeIdByUrl: function( url ){
    var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
    var match = url.match(regExp);

    if(match&&match[7].length==11){
      return match[7];
    }
    return false;
  },
  formatSecondsAsTime: function( secs ) {
    var hr = Math.floor(secs / 3600),
        min = Math.floor((secs - (hr * 3600)) / 60),
        sec = Math.floor(secs - (hr * 3600) - (min * 60));

    if (hr < 10) {
        hr = "0" + hr;
    }
    if (min < 10) {
        min = "0" + min;
    }
    if (sec < 10) {
        sec = "0" + sec;
    }
    if (hr) {
        hr = "00";
    }
    return hr + ':' + min + ':' + sec;
  },
}
module.exports = YoutubeInfo
