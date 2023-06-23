import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:stand/exceptions/location_service_exception.dart';
import 'package:stand/forms/position_record_form.dart';
import 'package:stand/models/position_record.dart';
import 'package:stand/pages/positions_page.dart';
import 'package:stand/services/location_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        _latitude = currentPosition.latitude.toString();
        _longitude = currentPosition.longitude.toString();
      });
    } on LocationServiceException catch (e) {
      String message;
      switch (e.type) {
        case LocationServiceExceptionType.serviceUnavailable:
          message = AppLocalizations.of(context)!
              .locationServiceError_locationServiceNotAvailable;
          break;
        case LocationServiceExceptionType.permissionDenied:
          message = AppLocalizations.of(context)!
              .locationServiceError_locationPermissionDenied;
          break;
        case LocationServiceExceptionType.permissionDeniedForever:
          message = AppLocalizations.of(context)!
              .locationServiceError_locationPermissionDenied;
          break;
        case LocationServiceExceptionType.unknown:
          message =
              AppLocalizations.of(context)!.locationServiceError_unknownError;
          break;
      }
      Get.snackbar(
        AppLocalizations.of(context)!.error,
        message,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        AppLocalizations.of(context)!.error,
        AppLocalizations.of(context)!.errorDescription,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _handleSaveLocation() async {
    Get.dialog(
      AlertDialog(
        surfaceTintColor: Colors.white,
        content: PositionRecordForm(
          latitude: _latitude,
          longitude: _longitude,
          onSubmit: (PositionRecord newRec) async {
            try {
              await newRec.save();
              Get.back();
              if (context.mounted) {
                Get.snackbar(
                  AppLocalizations.of(context)!.locationServiceInfo_savedTitle,
                  AppLocalizations.of(context)!
                      .locationServiceInfo_savedDescription,
                );
              }
            } catch (e) {
              Get.back();
              if (context.mounted) {
                Get.snackbar(
                  AppLocalizations.of(context)!.error,
                  AppLocalizations.of(context)!.errorDescription,
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<void> _handleCopyToClipboard() async {
    try {
      await LocationService.copyToClipboard(_latitude, _longitude);
      if (context.mounted) {
        Get.snackbar(
          AppLocalizations.of(context)!.locationServiceInfo_clipTitle,
          AppLocalizations.of(context)!.locationServiceInfo_clipDescription,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        AppLocalizations.of(context)!.error,
        AppLocalizations.of(context)!.errorDescription,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _handleOpenExternally() async {
    try {
      await LocationService.openExternally(_latitude, _longitude);
    } catch (e) {
      Get.snackbar(
        AppLocalizations.of(context)!.error,
        AppLocalizations.of(context)!.errorDescription,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _handleShareCoordinates() async {
    try {
      await LocationService.shareCoordinates(_latitude, _longitude);
    } catch (e) {
      Get.snackbar(
        AppLocalizations.of(context)!.error,
        AppLocalizations.of(context)!.errorDescription,
        snackPosition: SnackPosition.TOP,
      );
    }
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
            Text(
              AppLocalizations.of(context)!.mainPage_appBarTitle,
              style: TextStyle(color: Get.theme.colorScheme.primary),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.to(() => const PositionsPage());
            },
            icon: Icon(
              Icons.list,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ],
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
                              onPressed: (_latitude.isNotEmpty)
                                  ? _handleSaveLocation
                                  : null,
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
