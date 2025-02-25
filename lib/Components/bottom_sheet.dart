import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guard_u/Data/home_provider.dart';

class PlaceReviews extends StatefulWidget {
  const PlaceReviews({super.key});

  @override
  State<PlaceReviews> createState() => _PlaceReviewsState();
}

class _PlaceReviewsState extends State<PlaceReviews> {
  TextEditingController controller = TextEditingController();
  void addComment() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Comment'),
            backgroundColor: Colors.blue[400],
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Comment ...'),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    Provider.of<HomeProvider>(context, listen: false)
                        .comments
                        .add(controller.text);
                  });
                  controller.clear();
                  Navigator.pop(context);
                },
                color: Colors.deepPurple[300],
                child: const Text('Post'),
              ),
              const SizedBox(
                width: 40,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.deepPurple[300],
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Container(
        height: 300, // Set height for the bottom sheet
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comment Session',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer<HomeProvider>(builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[200],
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
                        child: ListTile(
                          title: Text(value.comments[index], style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),),
                          subtitle: const Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Kamau Njunguna', style: TextStyle(fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addComment,
        child: const Icon(Icons.messenger_outline),
      ),
    );
  }
}
