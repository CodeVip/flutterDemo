import 'package:first_app/CharacterDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// }


// class _CharacterListScreenState extends State<CharacterListScreen> {
//   late CharacterBloc _characterBloc;
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController _nameController = TextEditingController();
//   String _statusValue = '';
//   String _speciesValue = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _characterBloc = CharacterBloc(characterRepository: CharacterRepository());
//     _scrollController.addListener(_scrollListener);
//   }
//
//   @override
//   void dispose() {
//     _characterBloc.close();
//     _scrollController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   void _scrollListener() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       _characterBloc.add(FetchMoreCharactersEvent());
//     }
//   }
//
//   void _applyFilters() {
//     final String name = _nameController.text.trim();
//     final String status = _statusValue;
//     final String species = _speciesValue;
//     _characterBloc.add(ApplyFiltersEvent(name: name, status: status, species: species));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rick & Morty Characters'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//           padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         labelText: 'Name',
//                       ),
//                     ),
//                   ),
//               ],
//           ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(16.0),
//           //   child: Row(
//           //     children: [
//           //       Expanded(
//           //         child: TextField(
//           //           controller: _nameController,
//           //           decoration: InputDecoration(
//           //             labelText: 'Name',
//           //           ),
//           //         ),
//           //       ),
//           //       SizedBox(width: 16),
//           //       DropdownButton<String>(
//           //         value: _statusValue,
//           //         onChanged: (String? newValue) {
//           //           setState(() {
//           //             _statusValue = newValue!;
//           //           });
//           //         },
//           //         items: <String>[
//           //           // 'Alive',
//           //           // 'Dead',
//           //           // 'Unknown',
//           //         ].map<DropdownMenuItem<String>>(
//           //               (String value) {
//           //             return DropdownMenuItem<String>(
//           //               value: value,
//           //               child: Text(value),
//           //             );
//           //           },
//           //         ).toList(),
//           //         hint: Text('Status'),
//           //       ),
//           //       SizedBox(width: 16),
//           //       DropdownButton<String>(
//           //         value: _speciesValue,
//           //         onChanged: (String? newValue) {
//           //           setState(() {
//           //             _speciesValue = newValue!;
//           //           });
//           //         },
//           //         items: <String>[
//           //           // 'Human',
//           //           // 'Alien',
//           //           // 'Unknown',
//           //         ].map<DropdownMenuItem<String>>(
//           //               (String value) {
//           //             return DropdownMenuItem<String>(
//           //               value: value,
//           //               child: Text(value),
//           //             );
//           //           },
//           //         ).toList(),
//           //         hint: Text('Species'),
//           //       ),
//           //       SizedBox(width: 16),
//           //       ElevatedButton(
//           //         onPressed: _applyFilters,
//           //         child: Text('Apply Filters'),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//
//           Expanded(
//             child: BlocBuilder<CharacterBloc, CharacterState>(
//               builder: (context, state) {
//                 if (state is CharacterLoadingState) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is CharacterLoadedState) {
//                   final characters = state.characters;
//
//                return  ListView.builder(
//                     itemCount: characters.length,
//                     itemBuilder: (context, index) {
//                       final character = characters[index];
//                       return ListTile(
//                         leading: Image.network(character.image),
//                         title: Text(character.name),
//                         subtitle: Text(character.species),
//                       );
//                     },
//                   );
//                 } else if (state is CharacterErrorState) {
//                   return Center(
//                     child: Text('Error loading characters'),
//                   );
//                 }
//
//                 return SizedBox.shrink();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  List<dynamic> characters = [];
  List<dynamic> filteredCharacters = [];

  final TextEditingController _nameFilterController = TextEditingController();
  final TextEditingController _statusFilterController = TextEditingController();
  final TextEditingController _speciesFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        characters = data['results'];
        filteredCharacters = characters; // Initially, display all characters
      });
    } else {
      print('Failed to fetch characters: ${response.statusCode}');
    }
  }

  void applyFilters() {
    final nameFilter = _nameFilterController.text.toLowerCase();
    final statusFilter = _statusFilterController.text.toLowerCase();
    final speciesFilter = _speciesFilterController.text.toLowerCase();

    filteredCharacters = characters.where((character) {
      final name = character['name'].toLowerCase();
      final status = character['status'].toLowerCase();
      final species = character['species'].toLowerCase();

      return name.contains(nameFilter) &&
          status.contains(statusFilter) &&
          species.contains(speciesFilter);
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick & Morty Characters'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameFilterController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _statusFilterController,
                    decoration: InputDecoration(labelText: 'Status'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _speciesFilterController,
                    decoration: InputDecoration(labelText: 'Species'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: applyFilters,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final character = filteredCharacters[index];
                return ListTile(
                  leading: Image.network(character['image']),
                  title: Text(character['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${character['status']}'),
                      Text('Species: ${character['species']}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailScreen(character: character),
                      ),
                    );
                  },

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
