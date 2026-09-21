# QuickDict — Исходный код

Нативное легковесное Windows-приложение для мгновенного перевода выделенного текста по горячей клавише **Win + Shift + Q**.

## Особенности архитектуры
- **C++20 + Win32 API / WinHTTP**: Чистый C++ без внешних тяжелых зависимостей (Qt, Electron, .NET, Python).
- **Сетевой стек WinHTTP**: Прямое взаимодействие с Google Translate API и OpenRouter API.
- **Безопасность**: API-ключи никогда не сохраняются в открытом виде в конфигурационных файлах — используется Windows Credential Manager (`CredWriteW` / `CredReadW`).
- **Собственный легковесный JSON-парсер**: Без внешних библиотек.
- **Встроенные ресурсы**: Иконка DeathIcon встроена через `resource.rc` во всех разрешениях (16–256px).

## Структура папки
- `QuickDictNative.cpp` — основной исходный код приложения.
- `resource.h` / `resource.rc` — файлы ресурсов и иконки.
- `app_icon.ico` / `DeathIcon.png` — иконка приложения.
- `build.bat` — скрипт быстрой компиляции через MSVC x64.
- `CMakeLists.txt` — конфигурация для CMake.

## Сборка
### Вариант 1: Через build.bat
Запустите `build.bat` (требуется установленный Visual Studio или Visual Studio Build Tools с C++).

### Вариант 2: Через CMake
```bash
mkdir build
cd build
cmake ..
cmake --build . --config Release
```
