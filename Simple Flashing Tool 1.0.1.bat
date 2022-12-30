:RESTART

@echo off

echo.
echo ---------------------------------------
echo  Simple Flashing Tool 1.0.0 by AoMocha
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
echo --------------------------------------------------------------------------
echo ADB only (Only when booting Android with USB debugging turned on)
echo.
echo 12 - Put the attached device into fastboot mode.
echo 13 - Boot into recovery for the attached device.
echo --------------------------------------------------------------------------
echo.

SET /P ANSWER="Please select the action you want to perform. Press any other key to exit: "

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

EXIT


:1

echo Start ADB/Fastboot...

adb reboot bootloader

fastboot boot recovery.img

GOTO RESTART

:2

echo Start ADB/Fastboot...

adb reboot recovery

adb sideload rom.zip

GOTO RESTART

:3

echo Start ADB/Fastboot...

adb reboot bootloader

fastboot flash boot boot.img

GOTO RESTART

:4

SET /P ANSWER="Are you serious? If you proceed, all user data (photos, app data, etc.) on the connected device will be deleted. Only proceed if you know what you are doing. (y to execute, any other key to cancel): "

if /i {%ANSWER%}=={y} (goto :y)
if /i {%ANSWER%}=={yes} (goto :y)

GOTO RESTART

:y

adb reboot bootloader

fastboot -w

GOTO RESTART

:5

echo To take advantage of this, first enter fastboot mode.
echo This is because when you reboot, if the slot the system is written to is different from the active slot,
echo you run the risk that your phone will only boot into fastboot mode until you change the active slot.

SET /P ANSWER="Did you understand? Typing ok changes the slot to a. If you enter anything else, you will be returned to the menu: "Å@

if /i {%ANSWER%}=={ok} (goto :slota)

GOTO RESTART

:slota

echo Start ADB/Fastboot...

fastboot --set-active=a

GOTO RESTART

:6

echo Start ADB/Fastboot...

echo To take advantage of this, first enter fastboot mode.
echo This is because when you reboot, if the slot the system is written to is different from the active slot,
echo you run the risk that your phone will only boot into fastboot mode until you change the active slot.

SET /P ANSWER="Did you understand? Typing ok changes the slot to b. If you enter anything else, you will be returned to the menu: "Å@

if /i {%ANSWER%}=={ok} (goto :slotb)

GOTO RESTART

:slotb

fastboot --set-active=b

GOTO RESTART

:7

echo Start ADB/Fastboot...

adb reboot bootloader

fastboot erase cache

GOTO RESTART

:8

echo Start ADB/Fastboot...

adb reboot bootloader

fastboot erase cache

fastboot reboot

GOTO RESTART

:9

echo Start ADB/Fastboot...

adb reboot fastboot

echo If all goes well but you keep getting "waiting for any device", end this batch file with X.

fastboot reboot fastboot

GOTO RESTART

:10

echo Start ADB/Fastboot...

adb reboot recovery

echo If all goes well but you keep getting "waiting for any device", end this batch file with X.

fastboot reboot recovery

GOTO RESTART

:11

echo Start ADB/Fastboot...

fastboot reboot

GOTO RESTART

:12

echo Start ADB/Fastboot...

adb reboot bootloader

GOTO RESTART

:13

echo Start ADB/Fastboot...

adb reboot fastboot

GOTO RESTART
