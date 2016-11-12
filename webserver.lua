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
        buf = buf.."<a href=\"?pin=RND\"><button>RANDOM</button></a></p>"
        local _on,_off = "",""
        if(_GET.pin == "RED")then
            LED_runningLight()
            color_r = 255
            color_b = 0
        elseif(_GET.pin == "BLUE")then
            LED_runningLight()
            color_r = 0
            color_b = 255
        elseif(_GET.pin == "RND")then
            LED_rndLight()
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
