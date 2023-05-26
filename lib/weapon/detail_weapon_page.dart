import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeaponDetailPage extends StatefulWidget {
  final String name;

  WeaponDetailPage({required this.name});

  @override
  _WeaponDetailPageState createState() => _WeaponDetailPageState();
}

class _WeaponDetailPageState extends State<WeaponDetailPage> {
  Map<String, dynamic>? weaponData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeaponData();
  }

  Future<void> fetchWeaponData() async {
    try {
      final response = await http.get(Uri.parse('https://api.genshin.dev/weapons/${widget.name}'));
      if (response.statusCode == 200) {
        setState(() {
          weaponData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load weapon data. Error: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Failed to load weapon data. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail ${weaponData!['name']}',
        ),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black87,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : weaponData != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              'https://api.genshin.dev/weapons/${widget.name}/icon',
              fit: BoxFit.cover,
            ),
            Text(
              weaponData!['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Text(
            //   'Type: ${weaponData!['type']}',
            //   style: TextStyle(fontSize: 18),
            // ),
            SizedBox(height: 8),
            // Text(
            //   // 'Rarity: ${weaponData!['rarity']}',
            //   'Rarity: ',
            //   style: TextStyle(fontSize: 18),
            // ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  weaponData!['rarity'],
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
              'Base Attack: ${weaponData!['baseAttack']}',
              style: TextStyle(fontSize: 18),
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
