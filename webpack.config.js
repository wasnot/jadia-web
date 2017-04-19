const webpack = require('webpack');
var path = require('path');

module.exports = {
    entry: "./app/main.js",
    output: {
        path: path.join(__dirname, "public"),
        filename: "bundle.js"
    },
    plugins: [
        new webpack.ProvidePlugin({
            riot: 'riot'
        })
    ],
    module: {
        loaders: [
            {
                test: /\.tag$/,
                exclude: /node_modules/,
                loader: 'riotjs-loader',
                query: {
                    type: 'none'
                },
                enforce: 'pre'
            },
            {
                test: /\.js$|\.tag$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                query: {
                    presets: ['es2015-riot']
                }
            },
            { test: /\.css$/, loader: "style-loader!css-loader" }
        ]
    }
};
