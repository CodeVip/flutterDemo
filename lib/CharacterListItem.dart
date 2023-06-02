import 'package:flutter/material.dart';
import 'package:first_app/Character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;


  const CharacterListItem({required this.character});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(character.image),
      ),
      title: Text(character.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status: ${character.status}'),
          Text('Species: ${character.species}'),
          Text('Species: ${character.species}'),
        ],
      ),
    );
  }
}
