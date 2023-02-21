const approuter = require('@sap/approuter');
const util = require('util');

const ar = approuter();

ar.beforeRequestHandler.use('/', function (req, res, next) {
  //implement your extension coding here
  next();
});

ar.start();
