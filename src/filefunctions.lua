timeoffset=0;

function readfile(name)
    file.open(name, "r")
    content=file.read()
    file.close()
    return content
end

function bodyParser( message )
	return "{"..string.gfind(message,"%{(.-)%}")().."}";

end

function getTime()
    local conn=net.createConnection(net.TCP, 0) 
	conn:on("receive", function(conn, pl) 
		local time=cjson.decode((bodyParser(pl)));
			if time.time then
				timeoffset=math.floor(time.time/1000);
			end
		 end)
	conn:connect(jsonconfig.port,jsonconfig.server)
	conn:on("connection", function(sck,c)
    conn:send("GET /time HTTP/1.1\r\nHost: "..jsonconfig.server.."\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n");
    end)
	
end


function createRequest(data,id)
	local payload = {};
	payload.time=timeoffset+math.floor(tmr.now()/1000000)
	payload.device_id=id;
	payload.data=data;
	payload = cjson.encode(payload);
	return payload;
end