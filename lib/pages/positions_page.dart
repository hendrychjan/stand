import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stand/models/position_record.dart';
import 'package:stand/pages/position_detail_page.dart';
import 'package:stand/services/location_service.dart';

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

  Future<void> _handleOpenExternally(String latitude, String longitude) async {
    try {
      await LocationService.openExternally(latitude, longitude);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
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
        "Error",
        e.toString(),
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
        title: const Text("Saved"),
      ),
      body: (_loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (_positions.isEmpty)
              ? const Center(
                  child: Text(
                    "Nothing saved so far",
                    style: TextStyle(color: Colors.grey),
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
                        onSelected: (selected) => _handleMenuAction(
                            selected,
                            _positions[index].latitude,
                            _positions[index].longitude),
                        itemBuilder: (context) {
                          return const [
                            PopupMenuItem(
                              value: "copy",
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(Icons.copy),
                                  ),
                                  Text("Copy to clipboard"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "share",
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(Icons.share),
                                  ),
                                  Text("Share"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "open",
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(Icons.map),
                                  ),
                                  Text("Open in maps"),
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
