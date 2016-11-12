print("start wstest")
ws2812.init()
local i = 0
local buffer = ws2812.newBuffer(64, 3)
color_g, color_r, color_b = 0,0, 255
buffer:fill(0, 0, 0)
print(colors)

function LED_tmr_fct()
    buffer:fade(2)
    buffer:set(i%buffer:size()+1, color_g, color_r, color_b)
    ws2812.write(buffer)
    i=i+1
    end
    
tmr.alarm(0, 50, tmr.ALARM_AUTO, LED_tmr_fct)
        
print("end wstest")