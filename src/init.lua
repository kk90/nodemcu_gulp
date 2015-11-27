jsonconfig=""

dofile("filefunctions.lua")
dofile("driver.lua")

function initializeDevice()
    jsonconfig=cjson.decode(readfile("config.json"))
    wifi.setmode(wifi.STATION)
    wifi.sta.config(jsonconfig.wifiname,jsonconfig.wifipass)
    jsonconfig.serialnumber=node.chipid().."_"..node.chipid().."_"..wifi.sta.getmac();
    tmr.alarm(0, 5000, 0, function() 
    	getTime(); 

    end )   
end

initializeDevice()

tmr.alarm(2, jsonconfig.interval, 1, function() 
	getData(function(data)
	    print(createRequest(data,jsonconfig.serialnumber));
	end)

-- sk=net.createConnection(net.TCP, 0)
-- sk:connect(80,jsonconfig.server)
-- sk:on("connection", function(sck,c)
-- sk:send("GET / HTTP/1.1\r\nHost: "..jsonconfig.server.."\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
-- end)
end )


