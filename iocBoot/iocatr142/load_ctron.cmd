## modbusInterposeConfig(portName,
##    linkType = 1 (RTU),
##    timeoutMsec = default, (2000ms)
##    writeDelayMsec = 4 ms, (necessary for serial RTU devices, could probably be lessened)
##    )
modbusInterposeConfig("$(ASYN_PORT)", 1, 0, 4)

## drvModbusAsynConfigure(portName,
##                        tcpPortName,
##                        slaveAddress = 1,
##                        modbusFunction = 3 (read),
##                        modbusStartAddress = x, 
##                        modbusLength = 32, # ctron max length is 32 bytes (16 words)
##                        dataType = 0 (UINT16), (used as a default)
##                        pollMsec = 500, 
##                        plcType = "ATR142",
##                        )

#### Read ports ####
## Setpoints
drvModbusAsynConfigure("$(MODBUS_PORT)_R0"   , "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 0x00, 16, 0, 500, "CTRON")
drvModbusAsynConfigure("$(MODBUS_PORT)_R10"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 0x10, 16, 0, 500, "CTRON")
drvModbusAsynConfigure("$(MODBUS_PORT)_R20"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 0x20, 16, 0, 500, "CTRON")
drvModbusAsynConfigure("$(MODBUS_PORT)_R30"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 0x30, 16, 0, 250, "CTRON")
drvModbusAsynConfigure("$(MODBUS_PORT)_R40"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 0x40, 16, 0, 250, "CTRON")

#### Write ports ####
# drvModbusAsynConfigure("$(MODBUS_PORT)_W0"   , "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 0x00, 16, 0, 500, "CTRON")
# drvModbusAsynConfigure("$(MODBUS_PORT)_W10"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 0x10, 16, 0, 500, "CTRON")
# drvModbusAsynConfigure("$(MODBUS_PORT)_W20"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 0x20, 16, 0, 500, "CTRON")
drvModbusAsynConfigure("$(MODBUS_PORT)_W30"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 0x30, 16, 0, 250, "CTRON")
drvModbusAsynConfigure("$(MODBUS_PORT)_W40"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 0x40, 16, 0, 250, "CTRON")

## Load CTRON records
dbLoadRecords("$(TOP)/db/jumo_ctron.db", "P=$(PREFIX),PORT=$(MODBUS_PORT),TIMEOUT=$(TIMEOUT)")
