cd rust-coinselect
git pull
cd ..
flutter_rust_bridge_codegen generate
git add -A
git commit -m "feat: update generated frb"
## in client project using coinselect_flutter_ffi
flutter pub cache clean
flutter clean
flutter pub get
