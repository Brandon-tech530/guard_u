import 'package:popover/popover.dart';
import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  final String placeName;
  final String placeDescription;
  final VoidCallback reviews;

  const Review(
      {super.key,
      required this.placeName,
      required this.placeDescription,
      required this.reviews});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  void report() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Report Problem'),
            backgroundColor: Colors.blue[400],
            content: const TextField(
              decoration:
                  InputDecoration(hintText: 'Describe the problem or issue...'),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.deepPurple[300],
                child: const Text('Summit'),
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
    return Container(
      width: 350,
      margin:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Spacing
      padding: const EdgeInsets.all(12), // Adds internal spacing
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade700,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.blue.shade100,
            offset: const Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to top
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.placeName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    height: 5), // Spacing between title and description
                GestureDetector(
                  onTap: () {
                    // Navigate to map center of the map should be the selected location
                  },
                  child: Text(
                    widget.placeDescription,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => showPopover(
              height: 100,
              width: 150,
              context: context,
              bodyBuilder: (context) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: widget.reviews,
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: const Center(child: Text('Comment')),
                      ),
                    ),
                    GestureDetector(
                      onTap: report,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.blue[400]),
                        child: const Center(child: Text('Report')),
                      ),
                    ),
                  ],
                );
              },
            ),
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
