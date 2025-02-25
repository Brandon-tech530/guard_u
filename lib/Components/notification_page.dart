import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  static const keyActivity = 'key-Activityy';
  static const keyUpdates = 'key-Updates';

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.blue[400],
        child: SimpleSettingsTile(
          title: 'Notifications',
          subtitle: 'Account acticity, Updates',
          leading: const Icon(
            Icons.notifications_active_outlined,
            color: Colors.orange,
          ),
          child: Container(
            color: Colors.blue[400],
            child: SettingsScreen(children: [
              buildActivity(context, keyActivity),
              buildUpdates(context, keyUpdates),
            ]),
          ),
        ),
      );
}

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


Widget buildActivity(BuildContext context, dynamic keyActivity) =>
    SwitchSettingsTile(
        title: 'Account Activity',
        settingKey: keyActivity,
        leading: const Icon(Icons.person, color: Colors.deepPurple,),);
Widget buildUpdates(BuildContext context, dynamic keyUpdates) =>
    SwitchSettingsTile(
        title: 'Check updates',
        settingKey: keyUpdates,
        leading: const Icon(Icons.update, color: Colors.blueAccent,),
        );
