var child_process = require('child_process');
var express = require('express');
var fs = require('fs');

var app = express();

app.use('/logs', express.static('logs'));

var building = false;
var buildNumber = 0;

app.post('/build/:model', function (request, response) {
    if (building) {
        response.send(200, "Already building.");
        return;
    }

    building = true;
    buildNumber++;

    var model = request.param('model');

    var logPath = 'logs/build' + buildNumber + '.log';
    var out = fs.openSync(logPath, 'a');
    var err = fs.openSync(logPath, 'a');

    var process = child_process.spawn(
        'olpc-os-builder', ['xugar-1.0.0-' + model + '.ini'],
        {stdio: ['inherit', out, err]});

    process.on('close', function (code) {
        building = false;
    });

    response.send(200);
});

app.listen(3000);
