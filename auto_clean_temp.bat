@echo off
setlocal enabledelayedexpansion

:loop
echo Mengecek dan membersihkan folder %temp%...

set tempPath=%temp%

:: Menghapus file dalam folder %temp%
for /f "tokens=*" %%f in ('dir /b /a:-d "%tempPath%\*"') do (
    set "filePath=%tempPath%\%%f"
    2>nul (
        del /f /q "!filePath!" && echo File "!filePath!" berhasil dihapus.
    ) || (
        echo File "!filePath!" sedang digunakan dan tidak dapat dihapus. Melewati...
    )
)

:: Menghapus folder dalam folder %temp%
for /d %%d in ("%tempPath%\*") do (
    set "dirPath=%%d"
    2>nul (
        rd /s /q "!dirPath!" && echo Folder "!dirPath!" berhasil dihapus.
    ) || (
        echo Folder "!dirPath!" sedang digunakan dan tidak dapat dihapus. Melewati...
    )
)

echo Menunggu 5 detik sebelum pengecekan ulang...
timeout /t 5 /nobreak >nul

goto loop
