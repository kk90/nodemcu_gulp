require('os')
require('./tests/luaunit')

filefun=require("./src/filefunctions")






function test_Time()
	local message=[[HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Fri, 27 Nov 2015 01:32:24 GMT
Content-Type: application/json
Transfer-Encoding: chunked
Connection: keep-alive
X-Powered-By: PHP/5.5.9-1ubuntu4.14
Cache-Control: private, must-revalidate
pragma: no-cache
expires: -1
Set-Cookie: XSRF-TOKEN=eyJpdiI6Ilp0ZCtmUTNCeXRjMmo2S1ZHNFpxVWc9PSIsInZhbHVlIjoiTWxpYzd3MCs3TU9iamc4SVBIbWd3d2JrUGpYVDVQWXc0SUlSSCtuaExLY1ZWRWhYSXByWGNFTllxS0FsdlBsRVJYVTVcL09FOFB1TnFnWGl1bVJuQzNnPT0iLCJtYWMiOiJkZDM5YjZiN2UxYjNmMGZhZGZjYzU2N2ZhNWJlNmRhOTBlNDVmMzk1NmEyMDhiYjViODEwYjhhOGJmMDM3MGJkIn0%3D; expires=Fri, 27-Nov-2015 03:32:24 GMT; Max-Age=7200; path=/
Set-Cookie: laravel_session=eyJpdiI6IkM0ZXh5S2VrOEVESFBMYjRwXC9XcFdRPT0iLCJ2YWx1ZSI6ImNERFRkWUpjUGY0ZU0rUmtxNWFuc0ZsNUxRQkFJakllanZ6OXhaT2FjcXczSWNhSHMxK3pwQUZ3b2h1YXI1NmpUeEpZQk9DOFlORmFMWDdvNmVocGNRPT0iLCJtYWMiOiI5ZDhiOWJmNGUwMmY3NzA2ZmI2YjhkYjY0Njc3YTA5MzNkOGZlZGY5ZDBhNDNmNmJjMTkxZjBhYjA1MjE4Y2Q3In0%3D; expires=Fri, 27-Nov-2015 03:32:24 GMT; Max-Age=7200; path=/; httponly

16
{"time":1448587944781}
0
]]





	assertEquals( bodyParser( message ),[[{"time":1448587944781}]]);
end





os.exit(LuaUnit.run())
