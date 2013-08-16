#!../../bin/linux-x86/atr142

< envPaths
epicsEnvSet("ENGINEER", "$(ENGINEER=unset x1234)")
epicsEnvSet("LOCATION", "$(LOCATION=unset)")
epicsEnvSet("PREFIX", "$(PREFIX=E1:ATR142)")
epicsEnvSet("ADMIN_P", "$(ADMIN_P=$(PREFIX):IOC)")
## for tcp/ip:
epicsEnvSet("ATR142_HOST", "$(ATR142_HOST=10.0.0.10)")
epicsEnvSet("ATR142_PORT", "$(ATR142_PORT=4014)")
epicsEnvSet("ASYN_PORT", "$(ASYN_PORT=ATR142)")
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

## Set PREFIX, MODBUS_PORT, ASYN_PORT and run load_atr142.cmd for each device:
< load_atr142.cmd

## autosave probably not needed:
#save_restoreSet_status_prefix("$(PREFIX)")

iocInit()

# if necessary, copy over the records for channel finder:
#dbl > records.dbl
#system "cp records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"
