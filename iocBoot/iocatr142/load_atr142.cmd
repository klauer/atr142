## modbusInterposeConfig(portName,
##    linkType = 1 (RTU),
##    timeoutMsec = default, (2000ms)
##    writeDelayMsec = 4 ms, (necessary for serial RTU devices, could probably be lessened)
##    )
modbusInterposeConfig("$(ASYN_PORT)", 1, 0, 4)

## drvModbusAsynConfigure(portName,
##                        tcpPortName,
##                        slaveAddress = 1, (device default is 254)
##                        modbusFunction = 3 (read),
##                        modbusStartAddress = x, 
##                        modbusLength = 20, # *** atr-142 supports max 20 word reads/writes ***
##                        dataType = 0 (UINT16), (used as a default)
##                        pollMsec = 500, 
##                        plcType = "ATR142",
## )

#### Read ports ####
## Global parameters
drvModbusAsynConfigure("$(MODBUS_PORT)_R0"   , "$(ASYN_PORT)", $(SLAVE_ADDR), 3,    0, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_R50"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 3,   50,  2, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_R500" , "$(ASYN_PORT)", $(SLAVE_ADDR), 3,  500,  1, 0, 500, "ATR142")

## Setpoints, alarms, status
drvModbusAsynConfigure("$(MODBUS_PORT)_R1000", "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 1000, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_R1100", "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 1100, 12, 0, 500, "ATR142")

## Parameters
drvModbusAsynConfigure("$(MODBUS_PORT)_R2001", "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 2001, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_R2021", "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 2021, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_R2041", "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 2041, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_R2061", "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 2061,  4, 0, 500, "ATR142")

## ASCII Display, front panel-related
drvModbusAsynConfigure("$(MODBUS_PORT)_R3000", "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 3000, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_R3020", "$(ASYN_PORT)", $(SLAVE_ADDR), 3, 3020,  2, 0, 500, "ATR142")

#### Write ports ####
drvModbusAsynConfigure("$(MODBUS_PORT)_W0"   , "$(ASYN_PORT)", $(SLAVE_ADDR), 6,    0, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_W50"  , "$(ASYN_PORT)", $(SLAVE_ADDR), 6,   50,  2, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_W500" , "$(ASYN_PORT)", $(SLAVE_ADDR), 6,  500,  1, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_W1000", "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 1000, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_W3000", "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 3000, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_W2001", "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 2001, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_W2021", "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 2021, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_W2041", "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 2041, 20, 0, 500, "ATR142")
drvModbusAsynConfigure("$(MODBUS_PORT)_W2061", "$(ASYN_PORT)", $(SLAVE_ADDR), 6, 2061,  4, 0, 500, "ATR142")

## Load ATR142 records
dbLoadRecords("$(TOP)/db/atr142.db", "P=$(PREFIX),PORT=$(MODBUS_PORT),TIMEOUT=$(TIMEOUT)")
dbLoadRecords("$(TOP)/db/atr142_params1.db", "P=$(PREFIX),PORT=$(MODBUS_PORT),BASE=2001,TIMEOUT=$(TIMEOUT)")
dbLoadRecords("$(TOP)/db/atr142_params2.db", "P=$(PREFIX),PORT=$(MODBUS_PORT),BASE=2021,TIMEOUT=$(TIMEOUT)")
dbLoadRecords("$(TOP)/db/atr142_params3.db", "P=$(PREFIX),PORT=$(MODBUS_PORT),BASE=2041,TIMEOUT=$(TIMEOUT)")
dbLoadRecords("$(TOP)/db/atr142_params4.db", "P=$(PREFIX),PORT=$(MODBUS_PORT),BASE=2061,TIMEOUT=$(TIMEOUT)")
