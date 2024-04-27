import 'package:flutter/material.dart';
import 'response.dart'; // Import the response screen file

class HomeScreen extends StatelessWidget {
  final TextEditingController textFieldController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'ChefMate-AI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Ready to explore new flavors? What kind of food are you interested in today?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.asset(
              'images/ChefMate_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: textFieldController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Start typing here...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // Check if the text field is not empty
                if (textFieldController.text.isNotEmpty) {
                  // If not empty, navigate to the response screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResponseScreen(inputText: textFieldController.text)),
                  );
                } else {
                  // If empty, show a snackbar to prompt the user to enter text
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter text before discovering!'),
                    ),
                  );
                }
              },
              child: Text('Discover!'),
            ),
          ),
        ],
      ),
    );
  }
}
