import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guard_u/Screens/map2.dart';
import 'package:guard_u/Screens/profile.dart';
import 'package:guard_u/Components/drawer.dart';
import 'package:guard_u/Data/home_provider.dart';
import 'package:guard_u/Components/home_tile.dart';
import 'package:guard_u/Components/bottom_sheet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void showReviews() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.blue[200],
        builder: (context) {
          return const PlaceReviews();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],

      // AppBar for the application
      appBar: AppBar(
        title: const Text('GUARD-U'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),

      // The Slide drawer in the application
      drawer: Drawer(backgroundColor: Colors.blue[400], child: const Drawer1()),

      // The Main information in Home page
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true, // Ensures ListView takes only necessary space
            physics: const BouncingScrollPhysics(), // Smooth scrolling
            itemCount: value.places.length,
            itemBuilder: (context, index) {
              return Review(
                placeName: value.places[index][0],
                placeDescription: value.places[index][1],
                reviews: showReviews,
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Map2()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
