## Установка

### 1. Установка Flutter

Проверьте установку:
```bash
flutter doctor
```

### 2. Клонирование репозитория

```bash
git clone <URL_репозитория>
cd nearby_point
```

### 3. Установка зависимостей

```bash
flutter pub get
```

### 4. Генерация кода

Проект использует `json_serializable` для работы с JSON. Выполните генерацию кода:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Настройка разрешений

#### Android
Файл `android/app/src/main/AndroidManifest.xml` должен содержать следующие разрешения (уже настроено):
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

#### iOS
Добавьте описания для доступа к геолокации в `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Приложению нужен доступ к вашему местоположению для отображения ближайших точек</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Приложению нужен доступ к вашему местоположению для отображения ближайших точек</string>
```

## Запуск приложения

### Запуск на эмуляторе/симуляторе

#### Android Emulator
```bash
# Запустите эмулятор Android через Android Studio
# или через командную строку:
flutter emulators --launch <emulator_id>

# Запустите приложение:
flutter run
```

#### iOS Simulator (только macOS)
```bash
# Откройте симулятор:
open -a Simulator

# Запустите приложение:
flutter run
```

### Запуск на физическом устройстве

1. Подключите устройство к компьютеру
2. Включите режим разработчика на устройстве
3. Проверьте подключение:
```bash
flutter devices
```
4. Запустите приложение:
```bash
flutter run
```

### Запуск на конкретной платформе

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios
```

### Запуск в режиме Release (для производительности)

```bash
flutter run --release
```

## Сборка приложения

### Android APK
```bash
flutter build apk --release
```
Файл будет создан в: `build/app/outputs/flutter-apk/app-release.apk`

## Структура проекта

```
nearby_point/
├── lib/
│   ├── core/             # Базовая функциональность
│   │   └── di/           # Dependency Injection
│   ├── data/             # Работа с данными
│   ├── domain/           # Бизнес-логика
│   ├── presentation/     # UI и состояние
│   │   └── screens/      # Экраны приложения
│   └── main.dart         # Точка входа
├── assets/
│   └── poi.json          # Данные точек интереса
└── pubspec.yaml          # Зависимости проекта
```

## Основные зависимости

- **flutter_map** (^7.0.2) - библиотека для работы с картами
- **geolocator** (^10.1.0) - определение геолокации
- **latlong2** (^0.9.1) - работа с координатами
- **provider** (^6.1.1) - управление состоянием
- **shared_preferences** (^2.2.2) - локальное хранилище
- **http** (^1.1.0) - HTTP запросы
- **flutter_polyline_points** (^2.0.1) - построение маршрутов

### Генерация кода в watch-режиме
Для автоматической генерации кода при изменениях:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Проверка кода
```bash
# Анализ кода
flutter analyze

# Форматирование кода
flutter format .

# Запуск тестов
flutter test
```
`

### Проблема: Ошибки при установке зависимостей
```bash
# Очистите кеш
flutter clean
rm -rf pubspec.lock
rm -rf .dart_tool

# Переустановите зависимости
flutter pub get
```

### Проблема: Ошибки при сборке iOS
```bash
# Перейдите в папку ios
cd ios

# Обновите pods
pod deintegrate
pod install
pod update

# Вернитесь в корень и запустите снова
cd ..
flutter clean
flutter run
```



