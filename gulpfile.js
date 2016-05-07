var gulp = require('gulp')
var connect = require('gulp-connect')

gulp.task('default', ['connect']);

gulp.task('connect', [], function () {
  return connect.server({
    root: [ 'demo' ],
    port: 9002
  });
});
