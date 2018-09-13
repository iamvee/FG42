/**
 * John Titor - Nodejs EPC server for FG42
 *
 * John Titor acts as an agent to execute requested codes from FG42 elisp implementation
 * and returns the response to the elisp code or the other way around.
 *
 * For more info checkout: https://github.com/kiwanami/emacs-ecp
 */
import epc from 'elrpc';


epc.startServer().then((server) => {
  server.defineMethod("echo", function(args) {
    return args;
  });
  server.wait();
});
