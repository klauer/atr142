atr142 EPICS Driver
-------------------

Modbus-based EPICS support for the Pixsys Electronics ATR142 multi-setpoint controller.

Requirements
============

Though it may work on other versions, the driver was tested on these:

1. EPICS base 3.14.12.3 http://www.aps.anl.gov/epics/
2. asyn 4-21 http://www.aps.anl.gov/epics/modules/soft/asyn/
3. Modbus 2-4 http://cars9.uchicago.edu/software/epics/modbus.html

Optional
========

1. EDM http://ics-web.sns.ornl.gov/edm/log/getLatest.php
   Screens are provided in $TOP/op/edl for EDM.

Installation
============

1. Install EPICS
    1. If using a Debian-based system (e.g., Ubuntu), use the packages here http://epics.nsls2.bnl.gov/debian/
    2. If no packages are available for your distribution, build from source
2. Edit configure/RELEASE
    1. Point the directories listed in there to the appropriate places
    2. If using the Debian packages, everything can be pointed to /usr/lib/epics
3. Edit iocBoot/iocatr142/st.cmd
    1. Change the shebang on the top of the script if your architecture is different than linux-x86:
        #!../../bin/linux-x86/atr142
        (check if the environment variable EPICS_HOST_ARCH is set, or perhaps `uname -a`, or ask someone if
         you don't know)
    2. Change the communications settings. If using RS-485 over a serial device server, set the IP address and port in the following:
        ## For tcp/ip:
        epicsEnvSet("ATR142_HOST", "$(ATR142_HOST=10.0.0.10)")
        epicsEnvSet("ATR142_PORT", "$(ATR142_PORT=4014)")
        epicsEnvSet("ASYN_PORT",   "$(ASYN_PORT=ATR142)")
        epicsEnvSet("MODBUS_PORT", "$(MODBUS_PORT=MOD_$(ASYN_PORT))")
    3. If instead using serial directly connected to the machine, uncomment and set the port and rate:
        ## for serial:
        #epicsEnvSet("ATR142_SERIALPORT", "$(ATR142_SERIALPORT=/dev/ttyS1)")
        #epicsEnvSet("ATR142_BAUD", "$(ATR142_BAUD=19200)")

        Comment out drvAsynIPPortConfigure
        and uncomment:
        ## for direct connection to the machine's serial port:
        # drvAsynSerialPortConfigure("$(ASYN_PORT)", "$(ATR142_SERIAL_PORT)", 0, 0, 0)
        # asynSetOption("$(ASYN_PORT)",0,"baud","$(ATR142_BAUD)")
        # asynSetOption("$(ASYN_PORT)",0,"parity","none")
        # asynSetOption("$(ASYN_PORT)",0,"bits","8")
        # asynSetOption("$(ASYN_PORT)",0,"stop","1")
           
    4. Set the slave address according to what was set in the front panel:
        # slaveAddress = 1 (device default is 254)
        epicsEnvSet("SLAVE_ADDR",  "1")

    5. For each atr142 configured, Set PREFIX, MODBUS_PORT, ASYN_PORT, SLAVE_ADDR and run load_atr142.cmd for each device:
        < load_atr142.cmd

4. Go to the top directory and `make`
5. If all goes well:

    `cd iocBoot/iocatr142`  
    `chmod +x st.cmd`  
    `./st.cmd`  
6. Run EDM:
    `export EDMDATAFILES=$TOP/op/edl:$EDMDATAFILES`
    `edm -x -m "P=E1:ATR142:" atr142_all`
