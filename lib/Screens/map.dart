import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:guard_u/Data/home_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore_for_file: use_build_context_synchronously

class Map1 extends StatefulWidget {
  const Map1({super.key});

  @override
  State<Map1> createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  late MapController mapController;
  LatLng? currentLocation;
  //List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _getUserLocation(); // Fetch user's location on start
  }

  // Function to request permission and get the user's location
  Future<void> _getUserLocation() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        Provider.of<HomeProvider>(context, listen: false).markers.add(
              Marker(
                point: currentLocation!,
                width: 40,
                height: 40,
                child: const Icon(Icons.person_pin_circle,
                    color: Colors.blue, size: 40),
              ),
            );
      });

      // Move the map to user's location
      mapController.move(currentLocation!, 15.0);
    } else {
      // Handle permission denial
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
    }
  }

  // Function to show dialog and get place name
  void _showAddMarkerDialog(LatLng position) {
    TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Marker"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Enter place name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    Provider.of<HomeProvider>(context, listen: false)
                        .markers
                        .add(
                          Marker(
                            point: position,
                            width: 60,
                            height: 74,
                            child: Column(
                              children: [
                                Text(nameController.text,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 10)),
                                const Icon(Icons.location_pin,
                                    color: Colors.red, size: 40),
                              ],
                            ),
                          ),
                        );
                  });
                }
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentLocation == null
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loader until location is fetched
            : Consumer<HomeProvider>(builder: (context, value, child) {
                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: currentLocation!,
                    initialZoom: 13.0,
                    onLongPress: (_, position) =>
                        _showAddMarkerDialog(position), // Detect long press
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: value.markers, // ✅ Correct way to add markers
                    ),
                  ],
                );
              }));
  }
}
