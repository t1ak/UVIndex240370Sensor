-- 308 uart2 drv UV ESP32 --date= 2026-03-24 12:25:56

--[[ LUA uart driver for DFRobot_UVIndex240370Sensor
    (c) Tadeusz Jedynak 2026 ]]

_INPUTREG_UVS_DATA    = 0x06   -- UVS data
_INPUTREG_UVS_INDEX   = 0x07   -- UVS index

idx=7

-- uart 2
uart.on(2, "data", 7, -- 7 bajtów
  function(x)
    UARTread = x:byte(5)+(256*x:byte(4))
    if idx==6 then print("UV="..UARTread.."mV") end
    if idx==7 then print("UVI="..UARTread) end
  end)

-- uart2 error handler
uart.on(2, "error",
  function(data)
    print("error from uart:", data)
  end)

uart.setup(2, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, {tx = 17, rx = 16}) uart.start(2)

-- beginning how to use
TmrG=tmr.create() --4 000 = 4 sec
TmrG:register(4000, tmr.ALARM_AUTO,
 function(t)
   if idx==6 then idx=7 else idx=6 end
   if idx==6 then uart.write(2,35,4,0x00,0x06,0x00,0x01,0xD7,0x49) end -- 0x06 UV mV
   if idx==7 then uart.write(2,35,4,0x00,0x07,0x00,0x01,0x86,0x89) end -- 0x07 UV index 0 - 11
  end)
TmrG:start()

print(" = = = DFRobot_UVIndex240370Sensor = = =")
print("         Tadeusz Jedynak 2026")

