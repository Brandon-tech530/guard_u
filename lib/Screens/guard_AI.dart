import '../Data/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage; // ✅ Stores selected image

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image; // ✅ Store selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text("GUARD AI"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => chatProvider.clearChat(),
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];

                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? Colors.blue
                          : Colors.deepPurple[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.imagePath != null) // ✅ Show image if exists
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Image.asset(
                              message.imagePath!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        MarkdownBody(
                          data: message.message,
                          selectable: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          if (chatProvider.messages.isNotEmpty &&
              chatProvider.messages.last.isUser == true)
            const SpinKitThreeBounce(color: Colors.blue, size: 24.0),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "How can I help you...",
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(10),
                          suffixIcon: _selectedImage != null
                              ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      _selectedImage = null; // ✅ Remove image
                                    });
                                  },
                                )
                              : null,
                        ),
                      ),
                      if (_selectedImage != null)
                        Positioned(
                          left: 10,
                          top: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              _selectedImage!.path,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty || _selectedImage != null) {
                      chatProvider.sendMessage(
                        _controller.text,
                        imagePath: _selectedImage?.path, // ✅ Send image too
                      );
                      _controller.clear();
                      setState(() {
                        _selectedImage = null; // ✅ Clear image after sending
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}