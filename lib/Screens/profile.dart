import 'package:flutter/material.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Sample data for cards and contacts
  final List<String> cards = ['Card 1', 'Card 2', 'Card 3'];
  final List<String> contacts = ['Contact 1', 'Contact 2', 'Contact 3'];

  @override
  Widget build(BuildContext context) {
    // Create a list of card widgets
    final List<Widget> cardWidgets = cards.map((cardText) {
      return Card(
        elevation: 4, // Adds a shadow for better depth
        child: SizedBox(
          height: 200, // Fixed height for each card
          child: Center(
            child: Text(
              cardText,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Stacked card carousel section
          SizedBox(
            height: 400, // Fixed height to contain the carousel
            child: StackedCardCarousel(
              items: cardWidgets, // List of cards to stack
            ),
          ),
          // Contact list section
          Column(
            children: contacts.map((contact) {
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(contact),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Show edit dialog for the contact
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Edit Contact'),
                        content: Text('Editing $contact'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}