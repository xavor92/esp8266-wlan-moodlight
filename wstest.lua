local i
local buffer
color_g, color_r, color_b = 0,0, 255
print(colors)

function LED_rndLight_fct()
    --buffer:fade(2)
    --buffer:set(i%buffer:size()+1, math.random(255), math.random(255), math.random(255))
    buffer:fill(math.random(255), math.random(255), math.random(255))
    ws2812.write(buffer)
    i=i+1
    end

function LED_runningLight_fct()
    buffer:fade(2)
    buffer:set(i%buffer:size()+1, color_g, color_r, color_b)
    ws2812.write(buffer)
    i=i+1
    end

function LED_Init()
    print("LED_Init")
    ws2812.init()
    buffer = ws2812.newBuffer(64, 3)
    i = 0
    buffer:fill(0,0,0)
    ws2812.write(buffer)
    end

function LED_runningLight()
    tmr.alarm(0, 50, tmr.ALARM_AUTO, LED_runningLight_fct)
    end

function LED_rndLight()
    tmr.alarm(0,100, tmr.ALARM_AUTO, LED_rndLight_fct)
    end

LED_Init()