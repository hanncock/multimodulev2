import 'package:flutter/material.dart';

class TrailInput extends StatelessWidget {
  const TrailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Input name"),
          Container(
            height: 30,
            color: Colors.red,
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ],
      ),
    );
  }
}
