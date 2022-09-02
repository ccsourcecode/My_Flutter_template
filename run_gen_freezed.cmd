REM flutter clean    # if freezed class cannot be generated
REM flutter pub get

start flutter pub run build_runner build --delete-conflicting-outputs

PAUSE