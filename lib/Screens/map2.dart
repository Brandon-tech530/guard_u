import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:guard_u/Data/home_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Model class to store the place information
class LocationInfo {
  final LatLng coordinates;
  final String name;
  final String description;

  LocationInfo({
    required this.coordinates,
    required this.name,
    required this.description,
  });
}

class Map2 extends StatefulWidget {
  const Map2({super.key});

  @override
  State<Map2> createState() => _Map2State();
}

class _Map2State extends State<Map2> {
  late MapController mapController;
  LatLng? currentLocation;
  //List<Marker> markers = [];
  List<LocationInfo> savedLocations = [];

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
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        Provider.of<HomeProvider>(context, listen: false).markers.add(
          Marker(
            point: currentLocation!,
            width: 40,
            height: 40,
            child: const Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 40,
            ),
          ),
        );
      });

      // Move the map to user's location
      mapController.move(currentLocation!, 15.0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
    }
  }

  // Function to show dialog and get place name and description
  void _showAddMarkerDialog(LatLng position) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Location Info"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Place Name",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Place Description",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  final locationInfo = LocationInfo(
                    coordinates: position,
                    name: nameController.text,
                    description: descriptionController.text,
                  );

                  setState(() {
                    savedLocations.add(locationInfo);

                    Provider.of<HomeProvider>(context, listen: false).addPlace(
                      nameController.text,
                      descriptionController.text,
                    );

                    Provider.of<HomeProvider>(context, listen: false).markers.add(
                      Marker(
                        point: position,
                        width: 80,
                        height: 80,
                        child: Column(
                          children: [
                            Text(
                              locationInfo.name,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }
                Navigator.pop(context);
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
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: currentLocation!,
                initialZoom: 13.0,
                onLongPress: (_, position) => _showAddMarkerDialog(position),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: Provider.of<HomeProvider>(context, listen: false).markers),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (var location in savedLocations) {
            debugPrint(
                "Name: ${location.name}, Description: ${location.description}, Coordinates: ${location.coordinates.latitude}, ${location.coordinates.longitude}");
          }
        },
        child: const Icon(Icons.list),
      ),
    );
  }
}
