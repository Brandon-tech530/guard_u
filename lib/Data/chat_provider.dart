import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatProvider extends ChangeNotifier {
  final Uuid uuid = const Uuid();
  final List<ChatMessage> _messages = [];
  final Box<List> _chatBox = Hive.box<List>('chat_history');
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: '12345678899998764785', // Replace with your actual API key
  );

  List<ChatMessage> get messages => _messages;

  ChatProvider() {
    _loadChatHistory();
  }

  void _loadChatHistory() {
    final savedChats = _chatBox.get('chats', defaultValue: []);
    if (savedChats != null) {
      for (var chat in savedChats) {
        _messages.add(ChatMessage(
          id: chat['id'],
          message: chat['message'],
          isUser: chat['isUser'],
        ));
      }
    }
  }

  void _saveChatHistory() {
    _chatBox.put(
        'chats',
        _messages
            .map((msg) => {
                  'id': msg.id,
                  'message': msg.message,
                  'isUser': msg.isUser,
                })
            .toList());
  }

  Future<void> sendMessage(String userMessage, {String? imagePath}) async {
  final userChat = ChatMessage(
    id: uuid.v4(),
    message: userMessage,
    isUser: true,
    imagePath: imagePath, // ✅ Store image if provided
  );

  _messages.add(userChat);
  notifyListeners();

  try {
    final response = await _model.generateContent([
      Content.text(userMessage)
    ]);
    final botMessage = response.text ?? "I'm not sure how to respond.";
    
    _messages.add(ChatMessage(
      id: uuid.v4(),
      message: botMessage,
      isUser: false,
    ));
  } catch (e) {
    _messages.add(ChatMessage(
      id: uuid.v4(),
      message: "Error: $e",
      isUser: false,
    ));
  }

  _saveChatHistory();
  notifyListeners();
}


  void clearChat() {
    _messages.clear();
    _chatBox.clear();
    notifyListeners();
  }
}
