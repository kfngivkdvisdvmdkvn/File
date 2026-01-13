@echo off
setlocal enabledelayedexpansion

REM --------------------------------------------------
REM 1) หาไดรฟ์ที่รันสคริปต์ (แฟลชไดรฟ)
REM --------------------------------------------------
set USB=%~d0

echo ตรวจพบแฟลชไดรฟที่: %USB%
cd /d %USB%

REM --------------------------------------------------
REM 2) ตรวจหาไฟล์ Ghost64.exe
REM --------------------------------------------------
if not exist "%USB%\ghost64.exe" (
    echo ไม่พบ ghost64.exe ในแฟลชไดรฟ!
    pause
    exit
)

REM --------------------------------------------------
REM 3) หาไฟล์ .GHO อัตโนมัติ
REM --------------------------------------------------
set GHO_FILE=
for %%a in ("%USB%\*.gho") do (
    set GHO_FILE=%%a
)

if "%GHO_FILE%"=="" (
    echo ไม่พบไฟล์ .GHO ในแฟลชไดรฟ!
    pause
    exit
)

echo พบไฟล์อิมเมจ: %GHO_FILE%
echo พร้อมจะ Restore อัตโนมัติ...

REM --------------------------------------------------
REM 4) รัน Ghost64 แบบอัตโนมัติ
REM    -clone,MODE=restore,SRC=imagefile,DST=disk number
REM    DISK=1 = ดิสก์หลักในเครื่อง
REM --------------------------------------------------
echo กำลังเริ่มกระบวนการ Restore อัตโนมัติ...
"%USB%\ghost64.exe" -clone,mode=restore,src="%GHO_FILE%",dst=1 -sure -rb

REM  -sure  = ไม่ถามยืนยัน
REM  -rb    = รีเครื่องอัตโนมัติเมื่อเสร็จ
