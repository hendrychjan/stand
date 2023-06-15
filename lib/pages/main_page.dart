import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:stand/services/location_service.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            _longitude.isNotEmpty ? _longitude : "---",
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.save_alt),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.copy),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.map),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 40),
              child: IconButton.filled(
                icon: const Icon(Icons.place),
                onPressed: _getCurrentLocation,
                iconSize: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
