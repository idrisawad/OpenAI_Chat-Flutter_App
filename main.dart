import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _openAIresponse = "";

  void _getOpenAIresponse(String message) async {
    String openAIUrl = "https://api.openai.com/v1/engines/davinci-codex/completions";
    String openAIKey = "YOUR_API_KEY_HERE";
    String prompt = "Please generate a response to this message: " + message;

    var response = await http.post(openAIUrl,
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $openAIKey"},
        body: jsonEncode({
          "prompt": prompt,
          "max_tokens": 100,
        }));

    setState(() {
      _openAIresponse = jsonDecode(response.body)["choices"][0]["text"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OpenAI Chat App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                onSubmitted: (value) {
                  _getOpenAIresponse(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your message",
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(_openAIresponse),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DALLENImageGenerator()));
                },
                child: Text("DALL-E Image Generator"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
