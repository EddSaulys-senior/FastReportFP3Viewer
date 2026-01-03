[![Delphi Version](https://img.shields.io/badge/Delphi-11%20Alexandria-blue.svg)](https://www.embarcadero.com/products/delphi)
![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)

# FastReport FP3 Viewer (Delphi)
[![Download (latest)](https://img.shields.io/github/v/release/EddSaulys-senior/FastReportFP3Viewer?label=Загрузить&style=for-the-badge)](https://github.com/EddSaulys-senior/FastReportFP3Viewer/releases/latest/download/FastReportViewer.exe)

Небольшой просмотрщик **готовых** отчетов FastReport в формате `*.fp3` (Prepared Report), с возможностью ассоциации расширения в Windows.

Проект написан на Delphi (VCL). Просмотр выполняется через `TfrxReport.PreviewPages.LoadFromFile(...);` и последующий показ через `ShowPreparedReport`. 

## Возможности

- Открытие `*.fp3` из командной строки (двойной клик в проводнике после ассоциации).
- Открытие `*.fp3` через `OpenDialog`, если файл не передан.
- Регистрация ассоциации `*.fp3` → ваше приложение в профиле текущего пользователя (HKCU).
- “Скрытый хост”: главная форма не всплывает после закрытия окна предпросмотра (используется `Application.ShowMainForm := False`). 

## Требования

- Embarcadero Delphi 11 Alexandria (или новее).
- FastReport VCL (проект тестировался с FastReport VCL 2022.3). 
- Windows 10/11.

## Как это работает

FastReport хранит подготовленный (сформированный) отчет в `PreviewPages` и сохраняет его в файлы `*.fp3`.   
Для отображения `*.fp3` достаточно загрузить страницы и вызвать `ShowPreparedReport` (это важно — именно `ShowPreparedReport`, а не `ShowReport`). 

Пример (ключевой код):

```pascal
frxReport1.PreviewPages.LoadFromFile(AFileName); // *.fp3
frxReport1.ShowPreparedReport;
```

## ☕ Поддержка / Support

Если эта утилита сэкономила вам время, вы можете поддержать автора:

👉 [**Поддержать на Boosty (RU/International Cards)**](https://boosty.to/lised/donate)

Разработано с ❤️ для Delphi-сообщества.
