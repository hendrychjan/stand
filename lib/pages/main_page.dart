import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stand/services/location_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _loading = false;
  String _latitude = "";
  String _longitude = "";

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _loading = true;
      });
      Position currentPosition = await LocationService.getCurrentLocation();
      setState(() {
        _loading = false;
        _latitude = currentPosition.latitude.toString();
        _longitude = currentPosition.longitude.toString();
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _handleCopyToClipboard() async {
    try {
      await Clipboard.setData(
        ClipboardData(
          text: "$_latitude,$_longitude",
        ),
      );
      Get.snackbar(
        "Copied",
        "Copied to clipboard",
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _handleOpenExternally() async {
    try {
      final query = '$_latitude,$_longitude';
      final uri =
          Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});

      await launchUrlString(uri.toString());
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _handleShareCoordinates() async {
    try {
      await Share.share(
          "https://www.google.com/maps/place/$_latitude,$_longitude");
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.place,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            Text("Štand",
                style: TextStyle(color: Get.theme.colorScheme.primary)),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: (_loading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            _latitude.isNotEmpty ? "$_latitude," : "---",
                            style: TextStyle(
                                fontSize: 24,
                                color: Get.theme.colorScheme.secondary),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            _longitude.isNotEmpty ? _longitude : "---",
                            style: TextStyle(
                                fontSize: 24,
                                color: Get.theme.colorScheme.secondary),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.save_alt,
                              ),
                            ),
                            IconButton(
                              onPressed: (_latitude.isNotEmpty)
                                  ? _handleCopyToClipboard
                                  : null,
                              icon: const Icon(Icons.copy),
                            ),
                            IconButton(
                              onPressed: (_latitude.isNotEmpty)
                                  ? _handleShareCoordinates
                                  : null,
                              icon: const Icon(Icons.share),
                            ),
                            IconButton(
                              onPressed: (_latitude.isNotEmpty)
                                  ? _handleOpenExternally
                                  : null,
                              icon: const Icon(Icons.map),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 40),
              child: IconButton(
                icon: Icon(
                  Icons.place,
                  shadows: <Shadow>[
                    Shadow(
                      color: Get.theme.colorScheme.primary,
                      blurRadius: 10,
                    ),
                  ],
                ),
                onPressed: _getCurrentLocation,
                iconSize: 80,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
