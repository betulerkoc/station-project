const path = require('path');
const fs = require('fs');
const solc = require('solc');

const stationPath = path.resolve(__dirname, 'contracts', 'Station.sol');
const source = fs.readFileSync(stationPath, 'utf8');

module.exports =  solc.compile(source,1).contracts[':Station'];
