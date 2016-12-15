script = [[
<script>
function httpGetAsync()
{
    var x = document.getElementById("greyscale").value;
    var xmlHttp = new XMLHttpRequest();
    var theUrl = "?pin=" + x
    xmlHttp.onreadystatechange = function() { 
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
            ;
    }
    xmlHttp.open("GET", theUrl, true); // true for asynchronous 
    xmlHttp.send(null);
}</script>
]]

print("start webserver")
wifi.setmode(wifi.STATION)
print(wifi.sta.getip()) 
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        buf = buf.."<h1> ESP8266 Web Server</h1>";
        buf = buf.."<p>LEDs <a href=\"?pin=RED\"><button>RED</button></a>&nbsp;"
        buf = buf.."<a href=\"?pin=BLUE\"><button>BLUE</button></a>&nbsp;"
        buf = buf.."<a href=\"?pin=OFF\"><button>OFF</button></a></p>"
        buf = buf.."<input id=\"greyscale\" type=\"range\" min=\"0\" max=\"255\" oninput=\"httpGetAsync()\" value=\"30\"/><br>"
        buf = buf..script
        print("_GET.pin is ", _GET.pin)
        if(_GET.pin == "RED")then
            color_r = 255
            color_b = 0
            LED_runningLight()
        elseif(_GET.pin == "BLUE")then
            color_r = 0
            color_b = 255
            LED_runningLight()
        elseif(_GET.pin == "OFF")then
            LED_Clear()
        elseif(_GET.pin ~= nil) then
            color_r = tonumber(_GET.pin)
            color_b = 0
            LED_runningLight()
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
