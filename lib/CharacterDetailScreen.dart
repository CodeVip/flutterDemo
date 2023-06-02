import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatelessWidget {
  final dynamic character;

  CharacterDetailScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(character['image']),
            SizedBox(height: 20),
            Text('Name: ${character['name']}'),
            Text('Species: ${character['species']}'),
            Text('Status: ${character['status']}'),
            Text('Gender: ${character['gender']}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
