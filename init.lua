function startup()
    print('in startup')
    dofile('webserver.lua')
    end

print('starting webserver.lua in 5 seconds')
tmr.alarm(0,5000,0,startup)