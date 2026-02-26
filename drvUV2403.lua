-- 100 drv UV ES8266 --date= 2026-02-26 00:58:44

--[[ LUA driver for DFRobot_UVIndex240370Sensor
    (c) Tadeusz Jedynak 2026 ]]

_DEVICE_ADDR          = 0X23
_INPUTREG_UVS_DATA    = 0x06   -- UVS data
_INPUTREG_UVS_INDEX   = 0x07   -- UVS index
_INPUTREG_RISK_LEVEL  = 0x08   -- RISK LEVEL
_DEVICE_PID           = 0x427c --RISK LEVEL

id=0

function readUVdata(dev_address, dev_register , callback )
  i2c.start(id)
  i2c.address(id, dev_address, i2c.TRANSMITTER)
  i2c.write(id, dev_register)
  --i2c.stop(id)
  i2c.start(id) -- repeated start condition
  i2c.address(id, dev_address, i2c.RECEIVER)
  x=i2c.read(id, 2)
  --print( x:byte(1), x:byte(2) )
  i2c.stop(id)
  return (x:byte(1))+(256*x:byte(2))
end

-- end driver

-- beginning how to use

sda=2
scl=1
i2c.setup(0, sda or 2, scl or 1, i2c.SLOW)

TmrG=tmr.create() --10 000 = 10 sec
TmrG:register(4000, tmr.ALARM_AUTO, --120 tys = 2 minuty
 function(t)
   UV=readUVdata(_DEVICE_ADDR,_INPUTREG_UVS_DATA)
   UVi=readUVdata(_DEVICE_ADDR,_INPUTREG_UVS_INDEX)
   print(UV.."mV","UVI="..UVi)
  end)
TmrG:start() 
