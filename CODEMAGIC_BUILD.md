# هدهودک — Codemagic Build

این پروژه برای Build ابری با Codemagic آماده شده است.

Workflow:
- Flutter stable
- flutter pub get
- flutter build apk --release

خروجی APK در:
build/app/outputs/flutter-apk/*.apk

نکته: برای انتشار رسمی، امضای Android release/keystore را در Codemagic تنظیم کنید.
