var child_process = require('child_process');
var express = require('express');
var fs = require('fs');
var execSync = require('exec-sync');
var ncp = require('ncp').ncp;

var app = express();

app.use('/logs', express.static('logs'));
app.use('/logs', express.directory('logs'));

app.use('/images', express.static('images'));
app.use('/images', express.directory('images'));

var building = false;

function setup() {
    if (!fs.existsSync('logs')) {
        fs.mkdirSync('logs');
    }

    if (!fs.existsSync('images')) {
        fs.mkdirSync('images');
        fs.mkdirSync('images/xo1');
        fs.mkdirSync('images/xo1.5');
        fs.mkdirSync('images/xo1.75');
        fs.mkdirSync('images/xo4');
    }

    for (var i = 0; i < 6; i++) {
        if (!fs.existsSync('/dev/loop' + i)) {
            execSync('mknod /dev/loop'+ i + ' b 7 ' + i);
        }
    }
}

function getBuildNumber(model) {
    var filename = 'latestbuild-xo' + model;

    if (fs.existsSync(filename)) {
        return int(fs.readFileSync(filename, {encoding: 'utf8'})) + 1;
    }

    return 1;
}

setup();

app.post('/build/:model', function (request, response) {
    if (building) {
        response.send(200, "Already building.");
        return;
    }

    var model = request.params.model;
    var buildNumber = getBuildNumber(model);

    var logPath = 'logs/build' + buildNumber + '.log';
    var out = fs.openSync(logPath, 'a');
    var err = fs.openSync(logPath, 'a');

    building = true;

    var process = child_process.spawn(
        'olpc-os-builder', ['xugar-1.0.0-xo' + model + '.ini'],
        {stdio: ['ignore', out, err]});

    process.on('close', function (code) {
        var buildDir = 'images/' + model + '/' + buildNumber;
        ncp('/var/tmp/olpc-os-builder/output/', buildDir, function (err) {
            building = false;
        });
    });

    response.send(200);
});

app.listen(3000);
