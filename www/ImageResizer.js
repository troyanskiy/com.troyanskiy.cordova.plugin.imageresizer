var exec = require('cordova/exec');

exports.resize = function(options) {

  options = options || {};

  if (!options.src) {
    return Promise.reject(new Error('DST was not specified'));
  }
  if (!options.dst) {
    return Promise.reject(new Error('DST was not specified'));
  }
  if (!options.dstWidth && !options.dstHeight) {
    return Promise.reject(new Error('Please specify final size'));
  }

  options.srcOffsetX = options.srcOffsetX || 0;
  options.srcOffsetY = options.srcOffsetY || 0;

  options.srcWidth = options.srcWidth || -1;
  options.srcHeight = options.srcHeight || -1;

  options.dstOffsetX = options.dstOffsetX || 0;
  options.dstOffsetY = options.dstOffsetY || 0;

  options.dstWidth = options.dstWidth || -1;
  options.dstHeight = options.dstHeight || -1;

  return new Promise(function(resolve, reject) {
    exec(resolve, reject, "ImageResizer", "resize", [
      options.src,
      options.dst,
      options.srcOffsetX,
      options.srcOffsetY,
      options.srcWidth,
      options.srcHeight,
      options.dstOffsetX,
      options.dstOffsetY,
      options.dstWidth,
      options.dstHeight
    ]);
  });

};
