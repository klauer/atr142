TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = atr142
# atr142.dbd will be created and installed
DBD += atr142.dbd

# atr142.dbd will be made up from these files:
atr142_DBD += base.dbd

# Include dbd files from all support applications:
atr142_DBD += system.dbd
atr142_DBD += devIocStats.dbd

atr142_DBD += asyn.dbd
atr142_DBD += drvAsynIPPort.dbd
atr142_DBD += drvAsynSerialPort.dbd
atr142_DBD += modbus.dbd
atr142_DBD += mbbiDirectRecord.dbd

# Add all the support libraries needed by this IOC
atr142_LIBS += devIocStats

atr142_LIBS += modbus
atr142_LIBS += asyn

# atr142_registerRecordDeviceDriver.cpp derives from atr142.dbd
atr142_SRCS += atr142_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
atr142_SRCS_DEFAULT += atr142Main.cpp
atr142_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#atr142_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
atr142_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

