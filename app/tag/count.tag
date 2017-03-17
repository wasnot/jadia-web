import name from './name.tag';

<count>
    <p>カウント: { count }</p>
    <h2>{ opts.title }</h2>
    <button onclick="{ show_count }">click</button>
    <button onclick={ add }>+</button>
    <button onclick={ minus }>-</button>
    <script>
        this.count = 10;
        this.add = function () {
            this.count += 1;
        }
        this.minus = function () {
            this.count -= 1;
        }
        self = this
        let count = 0

        this.show_count = function () {
            count += 1
            alert(`count: ${count}`)
        }
    </script>
</count>
