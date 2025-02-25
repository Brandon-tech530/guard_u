import 'package:flutter/material.dart';
import 'package:guard_u/Screens/map.dart';
import 'package:guard_u/Screens/profile.dart';
import 'package:guard_u/Screens/guard_AI.dart';
import 'package:guard_u/Screens/settings.dart';

class Drawer1 extends StatefulWidget {
  const Drawer1({super.key});

  @override
  State<Drawer1> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer1> {
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Profile()));
                  },
                  child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          //darker shadow at bottom right
                          BoxShadow(
                            color: Colors.blue.shade700,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          //lighter shadow at top left
                          BoxShadow(
                            color: Colors.blue.shade100,
                            offset: const Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.person_2),
                        ],
                      ))),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Map1()));
                  },
                  child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          //darker shadow at bottom right
                          BoxShadow(
                            color: Colors.blue.shade700,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          //lighter shadow at top left
                          BoxShadow(
                            color: Colors.blue.shade100,
                            offset: const Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Map',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.map_outlined),
                        ],
                      ))),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ChatScreen()));
                  },
                  child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          //darker shadow at bottom right
                          BoxShadow(
                            color: Colors.blue.shade700,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          //lighter shadow at top left
                          BoxShadow(
                            color: Colors.blue.shade100,
                            offset: const Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Guard AI',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.assistant),
                        ],
                      ))),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Settings1()));
                  },
                  child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          //darker shadow at bottom right
                          BoxShadow(
                            color: Colors.blue.shade700,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          //lighter shadow at top left
                          BoxShadow(
                            color: Colors.blue.shade100,
                            offset: const Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.settings),
                        ],
                      ))),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    //darker shadow at bottom right
                    BoxShadow(
                      color: Colors.blue.shade700,
                      offset: const Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    //lighter shadow at top left
                    BoxShadow(
                      color: Colors.blue.shade100,
                      offset: const Offset(-4, -4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: MaterialButton(
                  onPressed: () {},
                  child: const Icon(Icons.logout),
                )),
          ],
        );
  }
}
