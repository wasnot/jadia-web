<ring>
    <style scoped>
        :scope {
            display: inline-block;
            font-size: 120%;
            height: 7em;
            line-height: 7em;
            margin: 0.5em;
            overflow: hidden;
            position: relative;
            width: 7em;
        }
        a {
            background: gray;
            border-radius: 50%;
            color: white;
            display: block;
            height: 100%;
            text-decoration: none;
        }
        a:hover {
            background: #3ebbd3;
        }

    </style>

    <a href={ opts.url }>{ opts.title }</a>
</ring>
