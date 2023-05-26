import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailCharacterPage extends StatefulWidget {
  final String name;

  DetailCharacterPage({
    required this.name,
  });

  @override
  State<DetailCharacterPage> createState() => _DetailCharacterPageState();
}

class Skill{
  final String skillTalents;
  // final String skillTalents;
  Skill({
    required this.skillTalents,
    // required this.skillTalents
  });

  factory Skill.fromJson(String json){
    return Skill(
      skillTalents: json,
      // skillTalents: json
    );
  }
}

class _DetailCharacterPageState extends State<DetailCharacterPage> {
  Map<String, dynamic>? charData;
  List<dynamic> skillTalents = [''];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCharacterData();
  }

  Future<void> fetchCharacterData() async {
    try {
      final response = await http.get(Uri.parse('https://api.genshin.dev/characters/${widget.name}'));
      if (response.statusCode == 200) {
        setState(() {
          charData = json.decode(response.body);
          skillTalents = charData!['skillTalents'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load character data. Error: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load character data. Error: $error');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail ${charData!['name']}',
        ),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black87,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : charData != null
          ?
      Padding(padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              'https://api.genshin.dev/characters/${widget.name}/gacha-splash',
              height: 200,
              // fit: BoxFit.fill,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    'https://api.genshin.dev/nations/${charData!['nation'].toLowerCase()}/icon',
                    height: 50,
                  ),
                  Image.network(
                    'https://api.genshin.dev/elements/${charData!['vision'].toLowerCase()}/icon',
                    height: 50,
                  ),
                  Text(
                    charData!['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  charData!['rarity'],
                      (index) => Icon(
                    Icons.star,
                    color: Colors.amberAccent,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${charData!['affiliation']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 18),
            Text(
              '${charData!['description']}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Column(
                  children: [
                    Image.network(
                      'https://api.genshin.dev/characters/${widget.name}/talent-na',
                      height: 90,
                    ),
                    SizedBox(height: 70),
                    Image.network(
                      'https://api.genshin.dev/characters/${widget.name}/talent-na',
                      height: 90,
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skillTalents[0]['description'],
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 50),
                      Text(
                        skillTalents[1]['description'],
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

      )

          : Center(
        child: Text('Failed to load weapon data.'),
      ),
    );
  }
}
