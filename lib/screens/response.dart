import 'dart:convert'; // Import the 'dart:convert' library

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResponseScreen extends StatefulWidget {
  final String inputText;

  const ResponseScreen({Key? key, required this.inputText}) : super(key: key);

  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  String? response;

  @override
  void initState() {
    super.initState();
    fetchResponse();
  }

  Future<void> fetchResponse() async {
    final apiKey = 'sk-proj-F1cSjfPC71ne7BiejbXkT3BlbkFJYyZTvATf3UvLbR1LJRGj'; // Your API key

    // Customize the prompt for food-related queries
    final prompt = 'Find ingredients and instructions for making ${widget.inputText}';

    try {
      final url = Uri.parse('https://api.openai.com/v1/completions');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey', // Include your API key in the headers
          'OpenAI-Beta': 'v1', // Include the OpenAI-Beta header
        },
        body: jsonEncode({
          'model': 'text-davinci-003', // Specify the model
          'prompt': prompt, // Send the customized prompt
          'temperature': 0.7,
          'max_tokens': 100,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          this.response = response.body;
        });

        // Print the response in the terminal
        print('Response: ${response.body}');
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch response. Status code: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: response != null
              ? Text(
            response!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          )
              : CircularProgressIndicator(), // Show a loading indicator while fetching the response
        ),
      ),
    );
  }
}
