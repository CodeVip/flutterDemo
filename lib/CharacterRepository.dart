import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:first_app/Character.dart';

class CharacterRepository {
  static const apiUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> getCharacters() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch characters');
    }
  }

  Future<Character> getCharacterDetail(int characterId) async {
    final response = await http.get(Uri.parse('$apiUrl/$characterId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Character.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch character detail');
    }
  }
}
