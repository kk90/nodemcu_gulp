
  wifi.setmode(wifi.STATION);
  wifi.sta.config("WRT","zu1234ia");
  print("hello world");
  print(wifi.sta.getip())


srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive",function(conn,payload) 
    print(payload) 
    conn:send("<h1> Hello, NodeMCU.</h1>")
    end) 
end)


function led(r,g,b) 
    pwm.setduty(1,r) 
    pwm.setduty(2,g) 
    pwm.setduty(3,b) 
end
pwm.setup(1,500,512) 
pwm.setup(2,500,512) 
pwm.setup(3,500,512)
pwm.start(1) 
pwm.start(2) 
pwm.start(3)
led(512,0,0) -- red
led(0,0,512) -- blue

