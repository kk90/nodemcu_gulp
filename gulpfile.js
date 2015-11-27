var gulp = require('gulp');
var path = require('path');
var fs = require("fs");
var watch = require('gulp-watch');
var foreach = require('gulp-foreach');
var config = require("./gulpfile_config.json")

var serialport;
var queue=[""];
var busy=false;
var endcall=function(){};


gulp.task('default', ['minify', 'write']);


gulp.task('minify', function() {

});



function writeAndDrain(data) {
	serialport.write(data, function() {
		serialport.drain(function(error) {
			setTimeout(function(){
				processQueue();
			},config.delay || 700)	
		});
	});
}

	// writeAndDrain(data, function(e, s) {
	// 	serialport.close(function(error) {
	// 		done();
	// 	})
	// });

function processQueue(){
	var next = queue.shift();

    if (!next) {
        busy = false;
        endcall();
        return;
    }
    console.log(next);
    writeAndDrain(next);
}

function pushToSerial(data) {
	queue.push(data+'\r\n');
	if (busy) return;
    busy = true;
    processQueue();
}

function writeFile(file, stream, done) {

	var fileContent = fs.readFileSync(file.history[0], "utf8");

	pushToSerial('file.remove("' + file.name + '");');
	pushToSerial('file.open("' + file.name + '","w+"); ');
	pushToSerial('w = file.writeline; ');

	var lines = fileContent.split("\n");

	for (var i =0;i< lines.length; i++) {
		pushToSerial('w([[' + lines[i] + ']]);');
	};

	pushToSerial('file.close(); ');
	pushToSerial('dofile("' + file.name + '");');
	
	endcall=function(){
		serialport.close(function(error) {
			console.log("serialport closed")
			done();
		})
	};
}


gulp.task('write', function(done) {

	var SerialPort = require("serialport").SerialPort
	serialport = new SerialPort(config.serialport, {
			baudrate: config.baudrate
		},
		function(error) {
			if (error) {
				return done(error);
			} else {
				gulp.src('src/*')
					.pipe(foreach(function(stream, file) {
						var name = path.basename(file.path);
						file.name = name;
						console.log(name);
						writeFile(file, stream, done);
						return stream;
					}))
			}

		});

	serialport.on('data', function(data) {
		console.log('data received: ' + data);
		// done();
	});



})


gulp.task("watch", function() {
	// calls "build-js" whenever anything changes
	gulp.watch("./src/*", ["default"]);
});