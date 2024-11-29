@echo off
:: Interval pengecekan dalam detik (ubah sesuai kebutuhan)
set "interval=5"

:loop
echo Memeriksa keberadaan mode tamu...

:: Path ke folder Guest Profile
set "guestProfilePath=%LOCALAPPDATA%\Google\Chrome\User Data\Guest Profile"

:: Cek apakah folder Guest Profile ada
if exist "%guestProfilePath%" (
    echo Mode tamu aktif. Membersihkan cache...

    :: Path ke folder cache
    set "cachePath=%guestProfilePath%\Cache"
    set "codeCachePath=%guestProfilePath%\Code Cache"

    :: Hapus file dalam folder Cache
    if exist "%cachePath%" (
        echo Menghapus cache di folder Cache...
        del /f /q "%cachePath%\*.*" >nul 2>&1
        echo Cache dihapus.
    )

    :: Hapus file dalam folder Code Cache
    if exist "%codeCachePath%" (
        echo Menghapus file sementara di folder Code Cache...
        del /f /q "%codeCachePath%\*.*" >nul 2>&1
        echo File sementara dihapus.
    )

    echo Pembersihan selesai untuk mode tamu.
) else (
    echo Tidak ada sesi mode tamu yang ditemukan.
)

:: Tunggu sebelum memeriksa kembali
echo Menunggu %interval% detik sebelum pengecekan berikutnya...
timeout /t %interval% >nul

:: Ulangi proses
goto loop
