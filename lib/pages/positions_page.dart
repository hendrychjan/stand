import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stand/models/position_record.dart';
import 'package:stand/pages/position_detail_page.dart';
import 'package:stand/services/location_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PositionsPage extends StatefulWidget {
  const PositionsPage({super.key});

  @override
  State<PositionsPage> createState() => _PositionsPageState();
}

class _PositionsPageState extends State<PositionsPage> {
  bool _loading = true;
  final List<PositionRecord> _positions = [];

  Future<void> _loadSavedPositions() async {
    setState(() {
      _loading = true;
    });
    List<PositionRecord> p = await PositionRecord.getAll();
    setState(() {
      _positions.clear();
      _positions.addAll(p);
      _loading = false;
    });
  }

  Future<void> _handleCopyToClipboard(String latitude, String longitude) async {
    try {
      await LocationService.copyToClipboard(latitude, longitude);
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

  Future<void> _handleOpenExternally(String latitude, String longitude) async {
    try {
      await LocationService.openExternally(latitude, longitude);
    } catch (e) {
      Get.snackbar(
        AppLocalizations.of(context)!.error,
        AppLocalizations.of(context)!.errorDescription,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _handleShareCoordinates(
      String latitude, String longitude) async {
    try {
      await LocationService.shareCoordinates(latitude, longitude);
    } catch (e) {
      Get.snackbar(
        AppLocalizations.of(context)!.error,
        AppLocalizations.of(context)!.errorDescription,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _handleMenuAction(
      String action, String latitude, String longitude) async {
    switch (action) {
      case "copy":
        await _handleCopyToClipboard(latitude, longitude);
        break;
      case "share":
        await _handleShareCoordinates(latitude, longitude);
        break;
      case "open":
        await _handleOpenExternally(latitude, longitude);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _loadSavedPositions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Get.theme.colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)!.positionsPage_appBarTitle,
        ),
      ),
      body: (_loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (_positions.isEmpty)
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.positionsPage_empty,
                    style: const TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _positions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => Get.to(
                        () => PositionDetailPage(
                          position: _positions[index],
                          onDataChanged: _loadSavedPositions,
                        ),
                      ),
                      title: Text(_positions[index].title),
                      subtitle: Text(
                        "${_positions[index].latitude}, ${_positions[index].longitude}",
                      ),
                      trailing: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: (Get.theme.brightness == Brightness.light)
                              ? Colors.black
                              : Colors.white,
                        ),
                        onSelected: (selected) => _handleMenuAction(
                            selected,
                            _positions[index].latitude,
                            _positions[index].longitude),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: "copy",
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.copy,
                                      color: (Get.theme.brightness ==
                                              Brightness.light)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .positionsPage_clipAction,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "share",
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.share,
                                      color: (Get.theme.brightness ==
                                              Brightness.light)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .positionsPage_shareAction,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "open",
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.map,
                                      color: (Get.theme.brightness ==
                                              Brightness.light)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .positionsPage_openInMapsAction,
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
