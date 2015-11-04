#!../../bin/linux-x86_64/atr142

< envPaths
epicsEnvSet("ENGINEER", "klauer x3615)")
epicsEnvSet("LOCATION", "3IDA mono")
epicsEnvSet("IOC_PREFIX", "XF:03IDA-CT{IOC:$(IOCNAME)}")

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.3.0.255")

## for tcp/ip:
epicsEnvSet("MOXA_HOST", "10.3.2.52")

## for serial:
# epicsEnvSet("ATR142_SERIALPORT", "$(ATR142_SERIALPORT=/dev/ttyS1)")
# epicsEnvSet("ATR142_BAUD", "$(ATR142_BAUD=19200)")

## Register all support components
dbLoadDatabase("../../dbd/atr142.dbd",0,0)
atr142_registerRecordDeviceDriver(pdbbase) 

dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db", "IOC=$(IOC_PREFIX)")
dbLoadRecords("$(EPICS_BASE)/db/save_restoreStatus.db", "P=$(IOC_PREFIX)")

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
epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:1}")
epicsEnvSet("SLAVE_ADDR",  "1")
epicsEnvSet("MODBUS_PORT", "CTRON1")
epicsEnvSet("ASYN_PORT", "P1")
< load_ctron.cmd

epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:2}")
epicsEnvSet("SLAVE_ADDR",  "2")
epicsEnvSet("MODBUS_PORT", "CTRON2")
epicsEnvSet("ASYN_PORT", "P2")
< load_ctron.cmd

# epicsEnvSet("PREFIX", "XF:03IDA-CT{HDCMHeater:3}")
# epicsEnvSet("SLAVE_ADDR", "3")
# epicsEnvSet("MODBUS_PORT", "ATR3")
# epicsEnvSet("ASYN_PORT", "P3")
# < load_atr142.cmd
 
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

## autosave/restore machinery
save_restoreSet_status_prefix("$(IOC_PREFIX)")
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

system("install -m 777 -d ${TOP}/as/save")
system("install -m 777 -d ${TOP}/as/req")

set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")

iocInit()

## more autosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
# create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

# if necessary, copy over the records for channel finder:
cd ${TOP}
dbl > ./records.dbl
system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"

