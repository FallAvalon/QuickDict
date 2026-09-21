@echo off
chcp 65001 >nul
echo ========================================================
echo  QuickDict - Полное удаление программы
echo ========================================================
echo.
echo [1/3] Завершение процесса QuickDict...
taskkill /F /IM QuickDict.exe 2>nul
taskkill /F /IM QuickDictNative.exe 2>nul
echo.
echo [2/3] Удаление из автозапуска Windows...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "QuickDict" /f 2>nul
echo.
echo [3/3] Очистка настроек и ключей...
cmdkey /delete:QuickDict/OpenRouter 2>nul
if exist "%LOCALAPPDATA%\QuickDict" (
    rmdir /s /q "%LOCALAPPDATA%\QuickDict" 2>nul
)
echo.
echo [OK] QuickDict успешно удален из системы.
echo Теперь вы можете просто удалить эту папку.
echo.
pause
