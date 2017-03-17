<app-footer>
  <style scoped>
    :scope { display: block }
    p { font-size: 90% }
  </style>

  <p>{ opts.message } - { year }</p>

  <script>
    this.year = (new Date()).getFullYear()
  </script>
</app-footer>
