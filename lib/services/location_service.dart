import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    // Test if location services are enabled
    await _checkLocationServicesAvailable();

    // Test if location permissions are granted
    await _checkLocationPermissions();

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<void> _checkLocationServicesAvailable() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      throw Exception("Location services not available");
    }
  }

  static Future<void> _checkLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw Exception("Location permissions denied forever");
    }
  }
}
