var log = require('debug')('damndatabases');

// Clear Log
if(process.env.NODE_ENV != 'production')
  require('damn-utils').ConsoleUtil.clear();
log('Register CoffeeScript');
require('coffee-script/register');
log('Load API');
require('./app/express');