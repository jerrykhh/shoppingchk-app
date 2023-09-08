import 'package:geolocator/geolocator.dart';

class GEOLocation {
  GEOLocation._privateConstructor();
  static final GEOLocation _locationPermission =
      GEOLocation._privateConstructor();
  static GEOLocation get instasnce => _locationPermission;
  bool? _isEnable;

  Future<bool> isServiceEnable() async {
    if (!_isEnable!) return false;

    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    _isEnable = serviceEnabled;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _isEnable = false;
      }
    }
    return _isEnable!;
  }

  Future<Position> determinePosition(
      {LocationAccuracy desiredAccuracy = LocationAccuracy.best,
      bool forceAndroidLocationManager = false,
      Duration? timeLimit}) async {
    bool locationServiceEnable = await isServiceEnable();
    if (!locationServiceEnable) return Future.error("Collect Location Error");

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: desiredAccuracy,
        forceAndroidLocationManager: forceAndroidLocationManager,
        timeLimit: timeLimit);
  }
}
