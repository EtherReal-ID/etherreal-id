export function configure(aurelia) {
  aurelia.use
    .standardConfiguration()
    .developmentLogging()
    .plugin('aurelia-animator-css')
    .plugin('aurelia-api', config => {

    // Register hosts
    config.registerEndpoint('api', '');
  });

  aurelia.start().then(a => a.setRoot());
}