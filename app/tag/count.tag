import name from './name.tag';

<count>
    <p>カウント: { count }</p>
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
    </script>
</count>
