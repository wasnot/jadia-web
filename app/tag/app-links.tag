import ring from './ring.tag';

<app-links>
    <style scoped>
        :scope {
            display: block;
            padding: 2em 0;
        }

    </style>

    <ring each={ opts.items } title={ title } url={ url }/>
</app-links>
