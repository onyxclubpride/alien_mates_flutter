@echo off
rem
rem Usage:
rem   release.bat <config>
rem   release.bat
rem

:build

call flutter clean
rem When flutter sdk directory is changed, pubspec.lock should be deleted.
del pubspec.lock
call flutter pub get
call flutter run

goto end

:end