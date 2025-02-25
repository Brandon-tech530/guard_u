import 'package:flutter/material.dart';
import 'package:guard_u/Components/account_page.dart';
import 'package:guard_u/Components/notification_page.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Settings1 extends StatefulWidget {
  const Settings1({super.key});

  @override
  State<Settings1> createState() => _MapState();
}

class _MapState extends State<Settings1> {
  String userName = 'Brandon Sagana';
  String userTel = '+0979798787';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userTelController = TextEditingController();
  Widget buildTile(
          {required String title,
          required Icon icon,
          required VoidCallback onTap}) =>
      Container(
        color: Colors.blue[200],
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: SimpleSettingsTile(
          title: title,
          subtitle: '',
          leading: icon,
          onTap: onTap,
        ),
      );

  Widget buildLogout() => buildTile(
        title: 'Logout',
        icon: const Icon(Icons.logout, color: Colors.blue),
        onTap: () {},
      );

  Widget buildDeleteAccount() => buildTile(
        title: 'Delete Account',
        icon: Icon(Icons.delete, color: Colors.red[300]),
        onTap: () {
          Settings.clearCache();
        },
      );
  Widget buildReportBug() => buildTile(
        title: 'Report Bug',
        icon: const Icon(Icons.bug_report, color: Colors.black),
        onTap: () {},
      );
  Widget buildSendFeedback() => buildTile(
        title: 'Send Feedback',
        icon: const Icon(Icons.thumb_up, color: Colors.green),
        onTap: () {},
      );

  void changeName() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Make Changes'),
            backgroundColor: Colors.blue[400],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "User Name",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: userTelController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        userName = nameController.text;
                        userTel = userTelController.text;
                        Navigator.pop(context);
                      });
                    },
                    color: Colors.deepPurple[300],
                    child: const Text('Save'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.deepPurple[300],
                    child: const Text('Cancel'),
                  )
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      shape: BoxShape.circle,
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
                    child: const Icon(
                      Icons.person_2,
                      size: 70,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.blue[400]),
                    child: Column(
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(userTel)
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: changeName,
                      icon: const Icon(
                        Icons.arrow_circle_right,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),
            SettingsGroup(
              title: 'General',
              children: <Widget>[
                const AccountPage(),
                const NotificationPage(),
                buildLogout(),
                buildDeleteAccount()
              ],
            ),
            SettingsGroup(
              title: 'FeedBack',
              children: <Widget>[buildReportBug(), buildSendFeedback()],
            ),
          ],
        ),
      ),
    );
  }
}
