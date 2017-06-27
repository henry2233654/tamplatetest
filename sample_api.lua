--#ENDPOINT GET /_init
local ret1 = User.createRole({role_id = "engineer", parameter = {{name = "sn"}}})
local ret2 = User.createRole({role_id = "normal", parameter = {{name = "sn"}}})
local ret = ret1.status_code ~= nil and ret1 or nil
if ret == nil then
  ret = ret2.status_code ~= nil and ret2 or nil
end
if ret ~= nil then
  response.code = ret.status_code
  response.message = ret.message
else
  response.code = 200
end
--#ENDPOINT GET /keystore
obj = Keystore.list()
if (next(obj["keys"])) ~= nil then
  return to_json(obj)
else
  return "no key found"
end
--#ENDPOINT PUT /keystore/{key}
obj = Keystore.get({key=request.parameters.key})
if next(obj) == nil then
  response.message = "add a new one"
else
  response.message = "key existed,update now"
end
ret = Keystore.set({key=request.parameters.key, value=request.body.value})
--#ENDPOINT PATCH /keystore/{key}
obj = Keystore.get({key=request.parameters.key})
if next(obj) ~= nil then
  response.message = "key is existing,update..."
  Keystore.set({key=request.parameters.key, value=request.body.value})
else
  response.message = "key not found"
  return
end
--#ENDPOINT DELETE /keystore/{key}
obj = Keystore.get({key=request.parameters.key})
if next(obj) == nil then
  response.message = "key is not existing"
else
  response.message = "key is existing,delete now"
  Keystore.delete({key=request.parameters.key})
end
--#ENDPOINT POST /keystore/{key}
Keystore.set({key=request.parameters.key,
              value=request.body.value})
--#ENDPOINT GET /cpu/{times}
--limited number of 64000 instructions per execution
times = request.parameters.times
for i=0,times do
end
--#ENDPOINT GET /memory/memory/{times}
--memory usage limits of 1Mb
times = request.parameters.times
str = "abc"
for i=0,times do
  str = str .. str
end
--#ENDPOINT GET /memory/notover/1MB
tb = {}
for i=0,math.pow(2, 13) do
  --31 of \65
  table.insert(tb,"\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65")
end
str = table.concat(tb,nil)
--#ENDPOINT GET /memory/over/1MB
tb = {}
for i=0,math.pow(2, 13) do
  --32 of \65
  table.insert(tb,"\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65\65")
end
str = table.concat(tb,nil)
--#ENDPOINT GET /debug
--include all invalid lua function which is nil type
return (type(debug) == 'nil')
--#ENDPOINT GET /debug/{functionName}
functionName = request.parameters.functionName
if functionName == "debug" then
  return (type(debug.debug) == "nil")
elseif functionName == "getfenv" then
  return (type(debug.getfenv) == "nil")
elseif functionName == "gethook" then
  return (type(debug.gethook) == "nil")
elseif functionName == "getinfo" then
  return (type(debug.getinfo) == "nil")
elseif functionName == "getlocal" then
  return (type(debug.getlocal) == "nil")
elseif functionName == "getmetatable" then
  return (type(debug.getmetatable) == "nil")
elseif functionName == "getregistry" then
  return (type(debug.getregistry) == "nil")
elseif functionName == "getupvalue" then
  return (type(debug.getupvalue) == "nil")
elseif functionName == "setfenv" then
  return (type(debug.setfenv) == "nil")
elseif functionName == "sethook" then
  return (type(debug.sethook) == "nil")
elseif functionName == "setlocal" then
  return (type(debug.setlocal) == "nil")
elseif functionName == "setmetatable" then
  return (type(debug.setmetatable) == "nil")
elseif functionName == "setupvalue" then
  return (type(debug.setupvalue) == "nil")
elseif functionName == "traceback" then
  return (type(debug.traceback) == "nil")
end
--#ENDPOINT GET /string/{functionName}
functionName = request.parameters.functionName
if functionName == "byte" then
  return tostring(string.byte("0",1,1))
elseif functionName == "char" then
  return string.char(49)
elseif functionName == "find" then
  local a,b = string.find("this is a message","is")
  return a .. " " .. b
elseif functionName == "format" then
  PI = "3.1415932545334"
  return string.format("pi=%.2f", PI)
elseif functionName == "gmatch" then
  data = ""
  s = "abcd"
  for w in string.gmatch(s, "%a") do
    data = data .. w .. " "
  end
  return data
elseif functionName == "gsub" then
  print(string.gsub("banana", "a", "A", 4))
elseif functionName == "len" then
  return string.len("123456789")
elseif functionName == "lower" then
  return string.lower("AaBbCc123")
elseif functionName == "match" then
  return string.match("abcdefg", "a")
elseif functionName == "rep" then
  return string.rep("a", 3," " )
elseif functionName == "reverse" then
  response.message = string.reverse("abc")
elseif functionName == "sub" then
  response.message = string.sub("abcdefg", 3 ,6)
elseif functionName == "upper" then
  response.message = string.upper("AaBbCc")
elseif functionName == "dump" then
    return (type(string.dump) == 'nil')
end
--#ENDPOINT GET /os/{functionName}
functionName = request.parameters.functionName
if functionName == "execute" then
  return (type(os.execute) == "nil")
elseif functionName == "exit" then
  return (type(os.exit) == "nil")
elseif functionName == "getenv" then
  return (type(os.getenv) == "nil")
elseif functionName == "remove" then
  return (type(os.remove) == "nil")
elseif functionName == "rename" then
  return (type(os.rename) == "nil")
elseif functionName == "setlocale" then
  return (type(os.setlocale) == "nil")
elseif functionName == "tmpname" then
  return (type(os.tmpname) == "nil")
elseif functionName == "clock" then
  return os.clock ()
elseif functionName == "date" then
  return os.date ("%c",os.time{year=1970, month=1, day=1, hour=0, sec=1},os.time{year=1970, month=1, day=1, hour=0})
elseif functionName == "difftime" then
  return os.difftime(os.time{year=1970, month=1, day=1, hour=0, sec=1},os.time{year=1970, month=1, day=1, hour=0})
elseif functionName == "time" then
  return os.time{year=1970, month=1, day=1, hour=0, sec=1}
end
--#ENDPOINT GET /basic/{functionName}
functionName = request.parameters.functionName
if functionName == "_G" then
  local data = ""
  _G["test"] = "test"
  for key, value in pairs(_G) do
    data = data .. key .. ": " .. tostring(value) .. "\n"
  end
  return data
elseif functionName == "getfenv" then
  getfenv()
elseif functionName == "getmetatable" then
  local s = "hello world!"
  return tostring(getmetatable (s))
elseif functionName == "ipairs" then
  local data = ""
  local t = {"one", "two", "three"}
  for i, v in ipairs(t) do
    data = data .. i .. " " .. tostring(v) .. " "
  end
  return data
elseif functionName == "next" then
  local data = ""
  local t = {"one", "two", "three"}
  data = tostring(next(t ,i)) .. " "
  for i=1,3 do
    data = data .. tostring(next(t ,i)) .. " "
  end
  return data
elseif functionName == "pairs" then
  local data = ""
  local t = {"one", "two", "three"}
  for k,v in pairs(t) do
    data = data .. k .. " " .. tostring(v) .. " "
  end
  return data
elseif functionName == "rawequal" then
  local data =""
  data = tostring(rawequal (1, 1)) .. " " .. tostring(rawequal (1, 0))
  return data
elseif functionName == "rawget" then
  local data = ""
  local t = {"one", "two", "three"}
  for i=1,3 do
    data = data .. rawget (t, i) .. " "
  end
  return data
elseif functionName == "rawset" then
  local data = ""
  local t = {"one", "two", "three"}
  rawset (t, 1, "I")
  for i=1,3 do
    data = data .. t[i] .. " "
  end
  return data
elseif functionName == "select" then
  return select("#", 1,2,3,4,5,6,7,8)
elseif functionName == "setfenv" then
  setfenv(1, {})
elseif functionName == "setmetatable" then
  a = {1,2}
  b = {3,4}
  c ={}
  c.__add = function(op1, op2)
  for _, item in ipairs(op2) do
    table.insert(op1, item)
  end
  return op1
  end
  setmetatable(a, c)
  t = a+b
  response.message = table.concat(t," ")
elseif functionName == "tonumber" then
  return tonumber("1111",2)
elseif functionName == "tostring" then
  return tostring(1)
elseif functionName == "type" then
  local data = ""
  local t = {nil,123,"123",true,{1,2,3}}
  for i=1,5 do
    data = data .. type(t[i]) .. " "
  end
  return data
elseif functionName == "unpack" then
  local a,b,c = unpack({1,2,3})
  response.message = a .. " " .. b .. " " .. c
elseif functionName == "_VERSION" then
  return _VERSION
elseif functionName == "pcall" then
  local status, err = pcall(function () error({code=121}) end)
  return err.code
elseif functionName == "xpcall" then
  function myfunction ()
     n = n/nil
  end
  function myerrorhandler( err )
     print( "ERROR:", err )
  end
  status = xpcall( myfunction, myerrorhandler )
  return status
elseif functionName == "import" then
--include all invalid lua function which is nil type
    return (type(import) == 'nil')
elseif functionName == "gc" then
--if gc can be used, it will return how many Ram have been used
    response.message = collectgarbage("count")*100
elseif functionName == "dofile" then
--if file is not existing,it will throw error message
    dofile("doesnt_exist.doesnt_exist")
elseif functionName == "load" then
--a should be 100 after excuting load function
    load(function() a=100 end)()
    response.message = a
elseif functionName == "loadfile" then
--if loadfile failed,res will be nil and an error message
    res,err = loadfile("doesnt_exist")
    response.message = err
elseif functionName == "loadstring" then
--a should be 100 after excuting loadstring function
    loadstring("a = 100")()
    response.message = a
elseif functionName == "require" then
    return type(require) == 'nil'
elseif functionName == "error" then
    error ("this is the message" ,1)
elseif functionName == "assert" then
    assert (false ,"this is the message")
end
--#ENDPOINT GET /math/{functionName}
functionName = request.parameters.functionName
if functionName == "abs" then
  response.message = math.abs(-1)
elseif functionName == "acos" then
  response.message = math.acos(1)
elseif functionName == "asin" then
  response.message = math.asin(0)
elseif functionName == "atan" then
  local c, s = math.cos(0.8), math.sin(0.8)
  response.message = math.atan(s/c)
elseif functionName == "atan2" then
  return math.atan2 (1, 1)
elseif functionName == "ceil" then
  response.message = math.ceil(0.378)
elseif functionName == "cos" then
  response.message = math.cos(0)
elseif functionName == ".cosh" then
  return math.cosh (1)
elseif functionName == "deg" then
  response.message = math.deg(0)
elseif functionName == "exp" then
  response.message = math.exp(0)
elseif functionName == "floor" then
  response.message = math.floor(1.378)
elseif functionName == "fmod" then
  response.message = math.fmod(7, 3)
elseif functionName == "frexp" then
  return math.frexp (1)
elseif functionName == "huge" then
  if math.huge > 1000000000000000000000 then
    response.message = "ture"
  else
    response.message = "fales"
  end
elseif functionName == "ldexp" then
  response.message = math.ldexp (1, 1)
elseif functionName == "log" then
  response.message = math.log(math.exp(3))
elseif functionName == "log10" then
  response.message = math.log10 (10)
elseif functionName == "max" then
  response.message = math.max(1,2,3,4,5,6,7,8,9,10)
elseif functionName == "min" then
  response.message = math.min(1,2,3,4,5,6,7,8,9,10)
elseif functionName == "modf" then
  local div, rem = math.modf(5)
  response.message = div .. " " .. rem
elseif functionName == "pi" then
  response.message = math.pi
elseif functionName == "pow" then
  response.message = math.pow (10, 3)
elseif functionName == "rad" then
  response.message = math.rad(180)
elseif functionName == "random" then
  response.message = math.random(1,10)
elseif functionName == "randomseed" then
  math.randomseed (os.time())
  response.message = math.random(1,10)
elseif functionName == "sin" then
  response.message = math.sin(0)
elseif functionName == "sinh" then
  response.message = math.sinh (0)
elseif functionName == "sqrt" then
  response.message = math.sqrt (4)
elseif functionName == "tan" then
  response.message = math.tan (0)
elseif functionName == "tanh" then
  response.message = math.tanh (0)
end
--#ENDPOINT GET /table/{functionName}
functionName = request.parameters.functionName
if functionName == "concat" then
  local t = {"1","2","3","4","5"}
  response.message = table.concat(t, " ", 2, 4)
elseif functionName == "insert" then
  local t = {"1","2","3"}
  table.insert(t, 2, "two")
  response.message = table.concat(t)
elseif functionName == "maxn" then
  t = {1,2,3,4,5,6,7,9,8}
  response.message = table.maxn (t)
elseif functionName == "remove" then
  local t = {"1","2","3"}
  table.remove(t,2)
  response.message = table.concat(t)
elseif functionName == "sort" then
  t = { 3,2,5,1,4 }
  table.sort(t, function(a,b) return a<b end)
  response.message = table.concat(t)
end
--#ENDPOINT GET /cause/error
local data = {
  ["request_id"] = "wsRid",
  ["server_ip"] = "wsSip",
  message = "wsMsg"
}
return Websocket.send(data)
