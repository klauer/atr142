#!../../bin/linux-x86_64/atr142

< envPaths
epicsEnvSet("ENGINEER", "$(ENGINEER=unset x1234)")
epicsEnvSet("LOCATION", "$(LOCATION=unset)")
epicsEnvSet("ADMIN_P", "XF:03IDA-CT{IOC:ATR142}")
## for tcp/ip:
epicsEnvSet("MOXA_HOST", "$(MOXA_HOST=10.3.2.52)")

## for serial:
# epicsEnvSet("ATR142_SERIALPORT", "$(ATR142_SERIALPORT=/dev/ttyS1)")
# epicsEnvSet("ATR142_BAUD", "$(ATR142_BAUD=19200)")

## Register all support components
dbLoadDatabase("../../dbd/atr142.dbd",0,0)
atr142_registerRecordDeviceDriver(pdbbase) 

# iocAdminSoft note: no trailing colon (:)
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db", "IOC=$(ADMIN_P)")
# dbLoadRecords("$(EPICS_BASE)/db/save_restoreStatus.db", "P=$(PREFIX):")

## drvAsynIPPortConfigure('port name' 'host:port [protocol]' priority 'disable auto-connect' noProcessEos)
drvAsynIPPortConfigure("P1", "$(MOXA_HOST):4021", 0, 0, 1)
drvAsynIPPortConfigure("P2", "$(MOXA_HOST):4022", 0, 0, 1)
# drvAsynIPPortConfigure("P3", "$(MOXA_HOST):4023", 0, 0, 1)
# drvAsynIPPortConfigure("P4", "$(MOXA_HOST):4024", 0, 0, 1)
# drvAsynIPPortConfigure("P4", "$(MOXA_HOST):4025", 0, 0, 1)

## for direct connection to the machine's serial port:
# drvAsynSerialPortConfigure("P1", "$(ATR142_SERIAL_PORT)", 0, 0, 0)
# asynSetOption("P1",0,"baud","$(ATR142_BAUD)")
# asynSetOption("P1",0,"parity","none")
# asynSetOption("P1",0,"bits","8")
# asynSetOption("P1",0,"stop","1")

# modbusInterposeConfig portName 'link type' 'timeout (msec)' 'write delay (msec)'
# link type 1 = RTU
# modbusInterposeConfig("P1", 1, 5000, 250)

# asynSetTraceMask("P1", 0, 0xff)
# asynSetTraceIOMask("P1", 0, 0xff)
## Set PREFIX, MODBUS_PORT, ASYN_PORT, SLAVE_ADDR and run load_atr142.cmd for each device:
# slaveAddress = 1 (device default is 254)

epicsEnvSet("TIMEOUT", 2.0)

# epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:1}")
# epicsEnvSet("SLAVE_ADDR",  "1")
# epicsEnvSet("MODBUS_PORT", "CTRON1")
# epicsEnvSet("ASYN_PORT", "P1")
# < load_ctron.cmd
# 
# epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:2}")
# epicsEnvSet("SLAVE_ADDR",  "2")
# epicsEnvSet("MODBUS_PORT", "CTRON2")
# epicsEnvSet("ASYN_PORT", "P2")
# < load_ctron.cmd

epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:3}")
epicsEnvSet("SLAVE_ADDR", "3")
epicsEnvSet("MODBUS_PORT", "ATR3")
epicsEnvSet("ASYN_PORT", "P3")
< load_atr142.cmd
 
# epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:4}")
# epicsEnvSet("SLAVE_ADDR",  "4")
# epicsEnvSet("MODBUS_PORT", "ATR4")
# epicsEnvSet("ASYN_PORT", "P4")
# < load_atr142.cmd

# epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:5}")
# epicsEnvSet("SLAVE_ADDR",  "5")
# epicsEnvSet("MODBUS_PORT", "ATR5")
# epicsEnvSet("ASYN_PORT", "P4")
# < load_atr142.cmd

## autosave probably not needed:
#save_restoreSet_status_prefix("$(PREFIX)")

iocInit()

# if necessary, copy over the records for channel finder:
#dbl > records.dbl
#system "cp records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"
