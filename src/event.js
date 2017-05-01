const event = {
  auth: {
    request: 'auth:request',
    checked: 'auth:checked',
    updated: 'auth:updated',
    cancel: 'auth:cancel',
  },
  page: {
    changed: 'page:changed',
  },
  song: {
    removeAll: 'song:removeAll',
    add: 'song:add',
    added: 'song:added',
    click: 'song:click',
  },
  index: {
    changed: 'index:changed',
  },
  playlist: {
    changed: 'playlist:changed',
    select: 'playlist:select',
  },
}
export default event;