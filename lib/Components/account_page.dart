import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  static const keyLanguage = 'key-language';
  static const keyLocation = 'key-location';
  static const keyPassword = 'key-password';

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.blue[400],
        child: SimpleSettingsTile(
          title: 'Account Settings',
          subtitle: 'Privacy, Security, Languange',
          leading: const Icon(
            Icons.person,
            color: Colors.deepPurple,
          ),
          child: Container(
            color: Colors.blue[400],
            child: SettingsScreen(children: [
              buildLanguage(context, keyLanguage),
              buildLocation(context, keyLocation),
              buildPassword(context, keyPassword),
              buildPrivacy(context),
              buildSecurity(context),
              buildAccountInfo(context)
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

Widget buildPrivacy(BuildContext context) => buildTile(
      title: 'Privacy',
      icon: const Icon(Icons.lock, color: Colors.blue),
      onTap: () {},
    );
Widget buildSecurity(BuildContext context) => buildTile(
      title: 'Security',
      icon: const Icon(Icons.security, color: Colors.red),
      onTap: () {},
    );
Widget buildAccountInfo(BuildContext context) => buildTile(
      title: 'Account Info',
      icon: const Icon(Icons.text_snippet, color: Colors.purple),
      onTap: () {},
    );
Widget buildLanguage(BuildContext context, dynamic keyLanguage) =>
    DropDownSettingsTile(
        title: 'Language',
        settingKey: keyLanguage,
        selected: 1,
        values: const <int, String>{
          1: 'English',
          2: 'Spanish',
          3: 'Chinese',
          4: 'Hindi',
        });
Widget buildLocation(BuildContext context, dynamic keyLocation) =>
    TextInputSettingsTile(
        title: 'Location',
        settingKey: keyLocation,
        initialValue: 'Kenya',
        onChange: (locatin) {});
Widget buildPassword(BuildContext context, dynamic keyPasswerd) =>
    TextInputSettingsTile(
        title: 'Change Password',
        settingKey: keyPasswerd,
        obscureText: true,
        validator: (password) => password != null && password.length >= 6 ? null : 'Enter 6 characters',);
