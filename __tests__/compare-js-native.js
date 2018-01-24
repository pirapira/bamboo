// A small script to test if both versions (JS and native) output the same
// string given the same programs as input
// To run: `node compare-js-native.js`

const fs = require('fs');
const path = require('path');
const execSync = require('child_process').execSync;
const examplesFolder = '../src/parse/examples';

fs.readdir(examplesFolder, (err, files) => {
  files.forEach(file => {
    console.log(`Comparing native vs js output for file: ${file}...`);
    const filePath = path.join(examplesFolder, file);
    const jsOutput = execSync(`node ../lib/js/src/exec-js/bambooJs.js < ${filePath}`).toString();
    const nativeOutput = execSync(`../bamboo.native < ${filePath}`).toString();
    const equal = jsOutput === nativeOutput;
    console.log(`Result: ${equal ? 'ok' : 'DIFF'}\n`);
  });
})