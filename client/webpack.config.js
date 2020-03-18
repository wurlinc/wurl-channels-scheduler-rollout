/* eslint-disable no-console */
const path = require('path');

const TsconfigPathsPlugin = require('tsconfig-paths-webpack-plugin');
// see https://www.npmjs.com/package/extract-css-chunks-webpack-plugin
const MiniCssExtractPlugin = require('extract-css-chunks-webpack-plugin');
const CompressionPlugin = require('compression-webpack-plugin')

const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

// const HardSourceWebpackPlugin = require('hard-source-webpack-plugin');

const webpack = require('webpack');

const entry = {
  main: './app/bundles/Main/startup/registration.tsx',
  // We need to load this dynamically. It's almost 1Mb
  // 'rox-browser': './node_modules/rox-browser/dist/rox-browser.js',
  'es5-shim': 'es5-shim/es5-shim',
  'es5-sham': 'es5-shim/es5-sham',
  'babel-polyfill': 'babel-polyfill',
}

const devBuild = process.env.NODE_ENV !== 'production';
const nodeEnv = devBuild ? 'development' : 'production';

const JS_AND_TS_FILES_RE = /\.(t|j)s(x)?$/

const pluginList = []
const webpackAnalysisFileName = path.resolve(__dirname, '../doc/webpack-analysis.html')

if (!process.env.HMR) {
  pluginList.push(new BundleAnalyzerPlugin({
    analyzerMode: 'static',
    reportFilename: webpackAnalysisFileName,
    openAnalyzer: false,
  }))
}

const Dotenv = require('dotenv-webpack');
pluginList.push(
  new Dotenv({
    path: '../.env', // Path to .env file (this is the default)
  })
)

pluginList.push(
  new webpack.ProvidePlugin({
    Promise: 'es6-promise',
  }))
pluginList.push(new webpack.WatchIgnorePlugin([
  // Ignore intermediate files from typings-for-css-modules-loader
  /css\.d\.ts$/,
]))

if (process.env.DISABLE_WEBPACK_GZIP !== 'true') {
  pluginList.push(new CompressionPlugin())
}


pluginList.push(new MiniCssExtractPlugin({
  // Options similar to the same options in webpackOptions.output
  // both options are optional
  filename: '[name].css',
  chunkFilename: '[id].css',
}),
)

const resolvePlugins = [
]

resolvePlugins.push(
  new TsconfigPathsPlugin({
    configFile: './webpack.tsconfig.json',
    baseUrl: '.',
    logLevel: 'info',
    // colors: true
  }),
)

pluginList.push(
  new webpack.DefinePlugin({
    'process.env': {
      JEST_TEST: false, // mock_environment
      NODE_ENV: JSON.stringify(nodeEnv),
      ROX_CLIENT_KEY: JSON.stringify(process.env.ROX_CLIENT_KEY),
      PORT: 8080,
    },
  }),
)

// If we want HMR, we add react-hot-loader before the main entry point
// and add the HotModuleReplacementPlugin:
if (process.env.HMR) {
  console.log('Webpacking with HMR');
  entry.main = ['react-hot-loader/patch', './app/bundles/Main/startup/registration']

  pluginList.push(new webpack.NamedModulesPlugin())
  pluginList.push(new webpack.NoEmitOnErrorsPlugin())
  pluginList.push(new webpack.HotModuleReplacementPlugin())
  // TODO: Update this...
  // pluginList.push(new webpack.optimize.CommonsChunkPlugin({
  //   name: "vendor",
  //   minChunks: function(module){
  //     return module.context && module.context.includes("node_modules");
  //   }
  // }))
}

const scssRules = [
  {
    loader: 'style-loader',
  },
  {
    loader: 'dts-css-modules-loader',
    options: {
      namedExport: true,
      banner: '// This file is generated automatically by webpack - dts-css-modules-loader',
    },
  },
  {
    loader: 'css-loader',
    options: {
      // css-loader options go here.
      modules: {
        localIdentName: '[name]__[local]__[hash:base64:5]',
        // namedExport: true,
      },
      localsConvention: 'camelCase',
      importLoaders: 3,
      sourceMap: devBuild,
    },
  },
  'sass-loader',
]
const moduleRules = [
  {
    test: /\.scss$/,
    use: scssRules,
  },
  {
    test: /\.mjs$/,
    include: /node_modules/,
    type: 'javascript/auto',
  },
  {
    test: JS_AND_TS_FILES_RE,
    loader: 'babel-loader',
    exclude: /node_modules/,
    // use: 'ts-loader'
    // use: 'awesome-typescript-loader'
  },
  // TODO Check if we need this - it may be unnecessary as of Babel 7.
  // Try removing it and running the webapp, and also
  // removing imports-loader from package.json.
  {
    test: require.resolve('react'),
    loader: 'imports-loader?shim=es5-shim/es5-shim&sham=es5-shim/es5-sham',
  },
  {
    test: /bcrypt-pbkdf/,
    use: 'null-loader',
  },
  {
    test: /ecc-jsbn/,
    use: 'null-loader',
  },
  {
    test: /jsbn/,
    use: 'null-loader',
  },
  {
    test: /tweetnacl/,
    use: 'null-loader',
  },
  {
    test: /\.mjs$/,
    use: 'null-loader',
  },
]

const loaders = {
  // 'css-loader': { test: /\.(s)?css$/},
  // 'sass-loader': { test: /\.scss$/},
  // 'typings-for-css-modules-loader': { test: /\.(s)?css$/},
  'babel-loader': {test: JS_AND_TS_FILES_RE},

  // 'awesome-typescript-loader': { test: /\.ts(x)?$/}
}
  // { test: /\.css$/, use: 'css-loader' },
  // { test: /\.ts$/, use: 'ts-loader' }

const webpackMode = process.env.NODE_ENV !== 'production' ? 'development' : 'production'

const chunkedOutput = {
  filename: '[name]-bundle.js',
  chunkFilename: '[name]-[chunkhash]-bundle.js',
  // chunkFilename: '[name].[chunkhash].js',
  path: path.resolve('../public/webpack'),
  // the url to the output directory resolved relative to the HTML page
  // Rails puts things in /assets
  publicPath: '/webpack/', // string
  // library: "MyLibrary", // string,
  // the name of the exported library
  // libraryTarget: "umd", // universal module definition    // the type of the exported library
  /* Advanced output configuration (click to show) */
}

const config = {
  // Chosen mode tells webpack to use its built-in optimizations accordingly.
  mode: webpackMode, // "production" | "development" | "none"
  stats: {
    // Display bailout reasons
    // optimizationBailout: true
  },
  entry,
  // Here the application starts executing
  // and webpack starts bundling
  output: chunkedOutput,
  loader: loaders,
  module: {
    rules: moduleRules,
  },
  plugins: pluginList,
  resolve: {
    modules: [path.resolve('./app/bundles/Main/startup'), 'node_modules'],
    extensions: ['*', 'mjs', '.ts', '.tsx', '.js', '.jsx', '.gql', '.graphql'],
    plugins: resolvePlugins,
    alias: {
      // 'wurl-base': './node_modules/wurl-base/src/',
    },
  },
  // list of additional plugins
  /* Advanced configuration (click to show) */
  node: {
    fs: 'empty',
    net: 'empty',
    tls: 'empty',
    // Skip these on webpack build as well (sshpk's optionalDeps)
    'ecc-jsbn': 'empty',
    'bcrypt-pbkdf': 'empty',
    jsbn: 'empty',
    tweetnacl: 'empty',
    // TODO How do we make it import promise. Or maybe we don't need it (already in browser?)
    'ts-promise': false,
  },
}

if (devBuild) {
  console.log('Webpack dev build for Rails'); // eslint-disable-line no-console
  // Remove here in favor of SourceMapDevToolPlugin (above), which improves HMR performance:
  // module.exports.devtool = 'eval-source-map';
} else {
  console.log('Webpack production build for Rails'); // eslint-disable-line no-console
}

if (process.env.HMR) {
  config.devServer = {
    host: 'localhost',
    port: 8080,
    disableHostCheck: true, // process.env.NODE_ENV === 'development'
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
    useLocalIp: false,
  }
}

// config.plugins.push(SplitChunksPlugin())

const splitChunks = {
  chunks: 'async',
  minSize: 30000,
  maxSize: 0,
  minChunks: 1,
  maxAsyncRequests: 5,
  maxInitialRequests: 3,
  automaticNameDelimiter: '~',
  name: true,
  cacheGroups: {
    vendors: {
      test: /[\\/]node_modules[\\/]/,
      priority: -10,
    },
    default: {
      minChunks: 2,
      priority: -20,
      reuseExistingChunk: true,
    },
  },
  // chunks: (chunk) => {
  //   // exclude `my-excluded-chunk`
  //   let optimize = chunk.name == 'rox'
  //   console.log(`Chunk name: ${chunk.name}. Optimize? ${optimize}`)
  //   return optimize
  // }
}

config.optimization = {
  // Each entry chunk embeds runtime.
  // runtimeChunk: 'single',
  splitChunks,

}

module.exports = config
