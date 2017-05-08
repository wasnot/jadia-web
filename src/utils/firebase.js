import 'firebase/database';

export const getPlaylistId = (user) => {
  return new Promise((resolve, reject) => {
    // playlist
    firebase.database().ref(`users/${user.uid}`)
      .once('value')
      .then((snapshot) => {
        const user_data = snapshot.val();
        // console.log('user_data');
        // console.log(user_data);
        let playlistKey;
        if (user_data == null || user_data.playlist == null) {
          // user dataがなければplaylist作成
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
        resolve(playlistKey);
      })
      .catch(err => {
        reject(err);
      });
  })
}

export function setIndex(index) {
  firebase.database().ref(`rooms/${roomId}`).set({ playing: index });
}