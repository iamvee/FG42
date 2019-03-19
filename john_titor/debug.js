var epc = require("elrpc");
var Promise = require('bluebird');

epc.startServer().then(function(server) {
	server.defineMethod("github-notifications", function(args) {
	  return Promise.resolve(args + "22222");
	});
	server.wait();
});
