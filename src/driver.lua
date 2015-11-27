function getData(callback)
	local serial_data={};
	serial_data.adc=adc.read(0);
	serial_data.time=tmr.now();
	callback(serial_data);
end
