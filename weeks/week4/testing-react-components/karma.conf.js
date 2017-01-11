// karma.conf.js
module.exports = function(config) {
  config.set({
    // use the PhantomJS browser
    browsers: ['PhantomJS'],

    // files that Karma will server to the browser
    files: [
      // all js files in src folder
      'src/**/*.js',
      // all js files in test folder
      'test/**/*.js'
    ],

    // use the Jasmine testing framework
    frameworks: ['jasmine']
  });
};
