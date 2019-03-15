const webpack = require('webpack');
const path = require('path');
const webpackMerge = require('webpack-merge');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin')
// const StyleLintPlugin = require('stylelint-webpack-plugin');

const modeConfig = env => require(`./build-utils/webpack.${env}`)(env);
const presetConfig = require("./build-utils/loadPresets");

module.exports = ({ mode, presets, asset_path} = { mode: "production", presets: [], asset_path: "/"}) => {
  console.log(`Building for: ${mode}`);

// Try the environment variable, otherwise use root
console.log('asset_path', asset_path); // 'local'
// __webpack_public_path__ = asset_path;
  return webpackMerge(
    {
      mode,

      entry: {
        main: path.join(__dirname, './src/index.js'),
        vendor: path.join(__dirname, './src/assets/js/vendor.js'),
      },
        output: {
            publicPath: asset_path
        },
        devServer: {
            disableHostCheck: true,
        },
        module: {
            rules: [
                {
                    test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
                    use: [{
                        loader: 'file-loader',
                        options: {
                            name: '[name].[hash].[ext]',
                            outputPath: 'fonts/'
                        }
                    }]
                },
                {
                    test: /\.(png|jpg|gif|svg)(\?v=\d+\.\d+\.\d+)?$/,
                    use: [{
                        loader: 'file-loader',
                        options: {
                            name: '[name].[hash].[ext]',
                            outputPath:  'images/'
                        }
                    }
                    ]
                }
            ]
        },

      plugins: [
        new HtmlWebpackPlugin({
          template: 'src/assets/index.html',
          inject: 'body',
          filename: 'index.html',
        }),

        // new StyleLintPlugin(),

        new CopyWebpackPlugin([
          { from: 'src/assets/favicon.ico' }
        ]),
          new CopyWebpackPlugin([
              { from: 'src/semantic-ui', to: "semantic-ui" }
          ]),
      ]
    },
    modeConfig(mode),
    presetConfig({ mode, presets }),
  )
};
