import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stand/exceptions/location_service_exception.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    // Test if location services are enabled
    await _checkLocationServicesAvailable();

    // Test if location permissions are granted
    await _checkLocationPermissions();

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<void> copyToClipboard(String latitude, String longitude) async {
    await Clipboard.setData(
      ClipboardData(
        text: "$latitude,$longitude",
      ),
    );
  }

  static Future<void> openExternally(String latitude, String longitude) async {
    final query = "$latitude,$longitude";
    final uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});

    await launchUrlString(uri.toString());
  }

  static Future<void> shareCoordinates(
      String latitude, String longitude) async {
    await Share.share("https://www.google.com/maps/place/$latitude,$longitude");
  }

  static Future<void> _checkLocationServicesAvailable() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      throw LocationServiceException(
        type: LocationServiceExceptionType.serviceUnavailable,
        message: "Location services unavailable",
      );
    }
  }

  static Future<void> _checkLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationServiceException(
          type: LocationServiceExceptionType.permissionDenied,
          message: "Location permissions denied",
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw LocationServiceException(
        type: LocationServiceExceptionType.permissionDeniedForever,
        message: "Location permissions denied forever",
      );
    }
  }
}
