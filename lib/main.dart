import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guard_u/Screens/login.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:guard_u/Data/home_provider.dart';
import 'package:guard_u/Data/chat_provider.dart';
import 'package:guard_u/models/chat_message.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatMessageAdapter());
  await Hive.openBox<List>('chat_history'); // Open the chat history box
  await Settings.init(cacheProvider: SharePreferenceCache());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GUARD-U',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const LogIn(),
      ),
    );
  }
}
