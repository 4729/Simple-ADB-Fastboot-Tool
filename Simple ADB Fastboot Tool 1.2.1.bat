:RESTART

@echo off

echo ---------------------------------------
echo  Simple Flashing Tool 1.2.1 by AoMocha
echo ---------------------------------------
echo.

echo --------------------------------------------------------------------------
echo For most things to work properly you need OEM unlock and bootloader unlock 
echo or USB debugging permission from developer options
echo --------------------------------------------------------------------------
echo General
echo.
echo 1 - Boot into a custom recovery on your connected phone (requires bootloader unlock)
echo 2 - Flash the zip file using ADB sideload. (Bootloader unlock is required to flash Custom ROMs)
echo 3 - Flash any boot image to the attached device's boot partition. (When using Magisk, etc.)
echo 4 - Wipe user data (Warning: deleted user data cannot be recovered!!!!!)
echo 5 - Change the active slot to a.
echo 6 - Change active slot to b.
echo 7 - Clear the cache on the attached device.
echo 8 - Clear the cache on the connected device and reboot.
echo 9 - Put the attached device into fastbootd mode.
echo 10 - Boot into recovery for the attached device.
echo 11 - Boot into Android system for the attached device.
echo 12 - Kill adb-server.
echo --------------------------------------------------------------------------
echo ADB only (Only when booting Android with USB debugging turned on)
echo.
echo 13 - Put the attached device into fastboot mode.
echo 14 - Boot into recovery for the attached device.
echo --------------------------------------------------------------------------
echo.

SET /P ANSWER="Please select the action you want to perform. Press any other key to exit adb-server and tool: "

if /i {%ANSWER%}=={1} (goto :1)
if /i {%ANSWER%}=={2} (goto :2)
if /i {%ANSWER%}=={3} (goto :3)
if /i {%ANSWER%}=={4} (goto :4)
if /i {%ANSWER%}=={5} (goto :5)
if /i {%ANSWER%}=={6} (goto :6)
if /i {%ANSWER%}=={7} (goto :7)
if /i {%ANSWER%}=={8} (goto :8)
if /i {%ANSWER%}=={9} (goto :9)
if /i {%ANSWER%}=={10} (goto :10)
if /i {%ANSWER%}=={11} (goto :11)
if /i {%ANSWER%}=={12} (goto :12)
if /i {%ANSWER%}=={13} (goto :13)
if /i {%ANSWER%}=={14} (goto :14)

adb kill-server
EXIT


:1

echo.
echo Start ADB/Fastboot...

echo.
adb reboot bootloader

echo.
fastboot boot recovery.img
echo.

GOTO RESTART

:2

echo.
echo Start ADB/Fastboot...

echo.
echo Boot into recovery from Android System and choose to flash the zip file or just flash the zip file. 
SET /P ANSWER="(1 to boot recovery and flash the zip, 2 to just flash the zip file. Press any other key to return to the menu.): "

if /i {%ANSWER%}=={1} (goto :rec)
if /i {%ANSWER%}=={2} (goto :zip)

GOTO RESTART

:rec

echo.
adb reboot recovery

echo.
echo After booting into recovery, press "apply update from ADB" to allow ADB sideload to receive.
SET /P ANSWER="1 to start flashing the zip file or Enter recovery again with 2: "

if /i {%ANSWER%}=={1} (goto :zip)
if /i {%ANSWER%}=={2} (goto :rec)

:zip

echo.
adb sideload rom.zip
echo.

GOTO RESTART

:3

echo.
echo Start ADB/Fastboot...

echo.
adb reboot bootloader
echo.
fastboot flash boot boot.img
echo.

GOTO RESTART

:4

echo.
echo Are you serious? If you proceed, all user data (photos, app data, etc.) on the connected device will be deleted. 
SET /P ANSWER="Only proceed if you know what you are doing. (y to execute, any other key to cancel): "

if /i {%ANSWER%}=={y} (goto :y)
if /i {%ANSWER%}=={yes} (goto :y)

GOTO RESTART

:y

echo.
echo Really? Deleted user data cannot be recovered!!!!! 
SET /P ANSWER="(Enter yes or y to delete user data. Press any other key to return to the menu.): "

if /i {%ANSWER%}=={y} (goto :y2)
if /i {%ANSWER%}=={yes} (goto :y2)

GOTO RESTART

:y2

echo.
adb reboot bootloader

echo.
fastboot -w
echo.

GOTO RESTART

:5

echo.
echo To take advantage of this, first enter fastboot mode.
echo This is because when you reboot, if the slot the system is written to is different from the active slot,
echo you run the risk that your phone will only boot into fastboot mode until you change the active slot.
echo.
SET /P ANSWER="Did you understand? Typing ok changes the slot to a. If you enter anything else, you will be returned to the menu: "Å@

if /i {%ANSWER%}=={ok} (goto :slota)

GOTO RESTART

:slota

echo.
echo Start ADB/Fastboot...
echo.
fastboot --set-active=a
echo.

GOTO RESTART

:6

echo.
echo To take advantage of this, first enter fastboot mode.
echo This is because when you reboot, if the slot the system is written to is different from the active slot,
echo you run the risk that your phone will only boot into fastboot mode until you change the active slot.
echo.
SET /P ANSWER="Did you understand? Typing ok changes the slot to b. If you enter anything else, you will be returned to the menu: "Å@

if /i {%ANSWER%}=={ok} (goto :slotb)

GOTO RESTART

:slotb

echo.
echo Start ADB/Fastboot...
echo.
fastboot --set-active=b
echo.

GOTO RESTART

:7

echo.
echo Start ADB/Fastboot...
echo.
adb reboot bootloader
echo.
fastboot erase cache
echo.

GOTO RESTART

:8

echo.
echo Start ADB/Fastboot...
echo.
adb reboot bootloader
echo.
fastboot erase cache
echo.
fastboot reboot
echo.

GOTO RESTART

:9

echo.
echo Start ADB/Fastboot...
echo.
adb reboot fastboot
echo.
echo If all goes well but you keep getting "waiting for any device", end this batch file with X.
echo.
fastboot reboot fastboot
echo.

GOTO RESTART

:10

echo.
echo Start ADB/Fastboot...
echo.
adb reboot recovery
echo.
echo If all goes well but you keep getting "waiting for any device", end this batch file with X.
echo.
fastboot reboot recovery
echo.

GOTO RESTART

:11

echo.
echo Start ADB/Fastboot...
echo.
fastboot reboot
echo.

GOTO RESTART

:12

echo.
echo Do you want to kill adb-server that is (or might be) running in the background? Killing adb-server with 1 will exit this tool.
echo If you kill adb-server in 2, the tool will keep and return to the main menu. Press any other key to return to the main menu.
SET /P ANSWER="1/2/other key: "Å@

if /i {%ANSWER%}=={1} (goto :kill)
if /i {%ANSWER%}=={2} (goto :keep)

GOTO RESTART

:kill

echo.
echo Killing "adb-server"...
echo.
adb kill-server
echo.

EXIT

:keep

echo.
echo Killing "adb-server"...
echo.
adb kill-server
echo.

GOTO RESTART

:13

echo.
echo Start ADB/Fastboot...
echo.
adb reboot bootloader
echo.

GOTO RESTART

:14

echo.
echo Start ADB/Fastboot...
echo.
adb reboot fastboot
echo.

GOTO RESTART
