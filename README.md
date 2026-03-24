# UVIndex240370Sensor
driver for DFRobot UV Sensor writen in LUA

## Ultra Violet sensor DFRobot_UVIndex240370Sensor
simple driver for UVIndex240370Sensor written in LUA (c) Tad1ak 2026

<img width="436" height="315" alt="UVsensorA" src="https://github.com/user-attachments/assets/266ff953-c218-451c-babf-6c7aa82dffcf" />

## Dependencies
drvUV2403.lua have been tested with Lua 5.1.4 on ESP-IDF v3.3-beta1 integer build They require the following modules. i2c and UART
functionalities

## Output
driver returns two values: UVdata [mV] and UVI (UVindex)
