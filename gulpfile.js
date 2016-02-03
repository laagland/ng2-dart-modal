'use strict';

var $ = require('gulp-load-plugins')();

// Include gulp
var gulp = require('gulp');

// Include plugins
var plumber = require('gulp-plumber');
var lazypipe = require('lazypipe');
var browserSync = require('browser-sync');

// Loading manifest
var manifest = require('asset-builder')('./manifest.json');
var config = manifest.config || {};
var paths = manifest.paths || {};

// Setting up sass lazypipe
var sassTasks = lazypipe()
  .pipe($.plumber)
  .pipe($.changed, paths.cssDir,{extension: '.css'})
  .pipe($.sourcemaps.init)
  .pipe($.compass, {
    css: 'web/assets/css',
    sass: 'web/assets/scss'
  })
  .pipe($.pleeease, {
    autoprefixer: {
      browsers: [
        'last 2 versions', 'ie 9'
      ]
    }
  })
  .pipe($.sourcemaps.write, '.');

// Define watch task
gulp.task('watch', ['styles', 'serve'], function() {
    gulp.watch(paths.sass, ['styles']);
    gulp.watch(paths.css, ['sync']);
});

// Define styles task
gulp.task('styles', function () {
  return gulp.src(paths.sass)
    .pipe(plumber(function (error) {
        this.emit('end');
    }))
    .pipe(sassTasks())
    .pipe(gulp.dest(paths.cssDir));
});

//Define sync task
gulp.task('sync', function (){
    gulp.src(paths.css)
      .pipe(browserSync.reload({stream: true}));
});

// Define serve task
gulp.task('serve', function() {
  browserSync.init({
      proxy: config.devUrl
  });
});

// Default Task
gulp.task('default', ['watch']);