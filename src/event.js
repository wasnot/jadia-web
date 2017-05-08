const event = {
  auth: {
    request: 'auth:request',
    checked: 'auth:checked',
    updated: 'auth:updated',
  },
  page: {
    changed: 'page:changed',
  },
  song: {
    removeAll: 'song:removeAll',
    remove: 'song:remove',
    add: 'song:add',
    click: 'song:click',
  },
  songDb: {
    remove: 'songDb:remove',
    add: 'songDb:add',
  },
  index: {
    changed: 'index:changed',
  },
}
export default event;