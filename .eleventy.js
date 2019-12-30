module.exports = function (config) {
  config.addPassthroughCopy('source/assets/stylesheets');

  config.setBrowserSyncConfig({
    files: 'build/**/*',
    port: 4567,
    ui: false
  });

  return {
    dir: {
      input: 'source',
      layouts: '_includes/layouts',
      output: 'build'
    },
    htmlTemplateEngine: 'hbs',
    markdownTemplateEngine: 'hbs',
    passthroughFileCopy: true
  };
};
