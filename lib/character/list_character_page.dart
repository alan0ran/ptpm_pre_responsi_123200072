import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ptpm_pre_responsi_123200072/character/detail_character_page.dart';

class ListCharacterPage{
  final String name;
  // final String skillTalents;
  ListCharacterPage({
    required this.name,
    // required this.skillTalents
  });

  factory ListCharacterPage.fromJson(String json){
    return ListCharacterPage(
      name: json,
      // skillTalents: json
    );
  }
}

class ListCharacter extends StatelessWidget {
  const ListCharacter({Key? key}) : super(key: key);

  Future<List<ListCharacterPage>> fetchCharacter() async {
    final response = await http.get(Uri.parse('https://api.genshin.dev/characters'));
    if (response.statusCode == 200) {
      final List<String> data = json.decode(response.body).cast<String>();
      final char = data.map((json) => ListCharacterPage.fromJson(json)).toList();
      return char;
    } else {
      throw Exception('Failed to fetch weapons');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genshin Impact Characters'),
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: FutureBuilder<List<ListCharacterPage>>(
            future: fetchCharacter(),
            builder: (context, snapshot){
              if (snapshot.hasData){
                final char = snapshot.data!;
                return ListView.builder(
                  itemCount: char.length,
                  itemBuilder: (context, index){
                    final character = char[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DetailCharacterPage(
                              name: character.name,
                              // skillTalents: character.skillTalents,
                            ))
                        );
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Image.network('https://api.genshin.dev/characters/' + character.name + '/icon-big'),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(character.name.toUpperCase()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }else if(snapshot.hasError){
                return Text('Error: ${snapshot.error}');
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}





