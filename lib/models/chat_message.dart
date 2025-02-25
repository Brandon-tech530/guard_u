import 'package:hive/hive.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 0)
class ChatMessage extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String message;

  @HiveField(2)
  bool isUser;

  @HiveField(3) // ✅ New field for image path
  String? imagePath;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isUser,
    this.imagePath, // ✅ Optional imagePath
  });
}
