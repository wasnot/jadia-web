<app-list>
  <style scoped>
    .list-group-item:nth-child(even) {
      background-color:#777;
      border-color: #777;
      color:white;
    }
    .list-group-item:nth-child(odd) {
      background-color:black;
      border-color: black;
      color:white;
    }
    .list-group-item.active {
      background-color: #84C6D2;
      border-color: #84C6D2;
    }
  </style>
  
  <ul id="songs" class="list-group"/>
</app-list>