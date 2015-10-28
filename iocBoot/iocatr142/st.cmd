#!../../bin/linux-x86_64/atr142

< envPaths
epicsEnvSet("ENGINEER", "$(ENGINEER=unset x1234)")
epicsEnvSet("LOCATION", "$(LOCATION=unset)")
epicsEnvSet("ADMIN_P", "XF:03IDA-CT{IOC:ATR142}")
## for tcp/ip:
epicsEnvSet("ATR142_HOST", "$(ATR142_HOST=10.3.2.52)")
epicsEnvSet("ATR142_PORT", "$(ATR142_PORT=4006)")
epicsEnvSet("ASYN_PORT",   "$(ASYN_PORT=ATR142)")
epicsEnvSet("MODBUS_PORT", "$(MODBUS_PORT=MOD_$(ASYN_PORT))")

## for serial:
#epicsEnvSet("ATR142_SERIALPORT", "$(ATR142_SERIALPORT=/dev/ttyS1)")
#epicsEnvSet("ATR142_BAUD", "$(ATR142_BAUD=19200)")

## Register all support components
dbLoadDatabase("../../dbd/atr142.dbd",0,0)
atr142_registerRecordDeviceDriver(pdbbase) 

# iocAdminSoft note: no trailing colon (:)
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db", "IOC=$(ADMIN_P)")
#dbLoadRecords("$(EPICS_BASE)/db/save_restoreStatus.db", "P=$(PREFIX):")

## drvAsynIPPortConfigure(portName, hostInfo, priority, noAutoConnect, noProcessEos)
drvAsynIPPortConfigure("$(ASYN_PORT)", "$(ATR142_HOST):$(ATR142_PORT)", 0, 0, 1)

## for direct connection to the machine's serial port:
# drvAsynSerialPortConfigure("$(ASYN_PORT)", "$(ATR142_SERIAL_PORT)", 0, 0, 0)
# asynSetOption("$(ASYN_PORT)",0,"baud","$(ATR142_BAUD)")
# asynSetOption("$(ASYN_PORT)",0,"parity","none")
# asynSetOption("$(ASYN_PORT)",0,"bits","8")
# asynSetOption("$(ASYN_PORT)",0,"stop","1")

## Set PREFIX, MODBUS_PORT, ASYN_PORT, SLAVE_ADDR and run load_atr142.cmd for each device:
# slaveAddress = 1 (device default is 254)

# epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:3}")
# epicsEnvSet("SLAVE_ADDR", "3")
# epicsEnvSet("MODBUS_PORT", "ATR3")
# < load_atr142.cmd
# epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:4}")
# epicsEnvSet("SLAVE_ADDR",  "4")
# epicsEnvSet("MODBUS_PORT", "ATR4")
# < load_atr142.cmd
epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:5}")
epicsEnvSet("SLAVE_ADDR",  "5")
epicsEnvSet("MODBUS_PORT", "ATR5")
< load_atr142.cmd

## autosave probably not needed:
#save_restoreSet_status_prefix("$(PREFIX)")

iocInit()

# if necessary, copy over the records for channel finder:
#dbl > records.dbl
#system "cp records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"
