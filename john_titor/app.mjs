/**
 * John Titor - Nodejs EPC server for FG42
 *
 * Entry point module of "John Titor".
 */
// const epcServer = require('epc-server');
import Gitlab from 'gitlab';

const token = "TPU1z83XH59NpSMPyvsd";
const api = new Gitlab.ProjectsBundle({ token });

console.log("11111111111111");
api.Projects.all()
  .then(p => {
    console.log(p)
  })
  .catch(e => {
    console.error(e);
  });
