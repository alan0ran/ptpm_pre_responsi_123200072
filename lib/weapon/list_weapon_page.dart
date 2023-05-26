import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:ptpm_pre_responsi_123200072/weapon/detail_weapon_page.dart';
import 'package:ptpm_pre_responsi_123200072/weapon/selected_weapon.dart';

class Weapon {
  final String name;

  Weapon({required this.name});

  factory Weapon.fromJson(String json) {
    return Weapon(name: json);
  }
}

class ListWeapon extends StatelessWidget {
  const ListWeapon({Key? key}) : super(key: key);

  Future<List<Weapon>> fetchWeapon() async {
    final response = await http.get(Uri.parse('https://api.genshin.dev/weapons'));
    if (response.statusCode == 200) {
      final List<String> data = json.decode(response.body).cast<String>();
      final weapons = data.map((json) => Weapon.fromJson(json)).toList();
      return weapons;
    } else {
      throw Exception('Failed to fetch weapons');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genshin Impact Weapons'),
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: FutureBuilder<List<Weapon>>(
          future: fetchWeapon(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final weapons = snapshot.data!;
              return ListView.builder(
                itemCount: weapons.length,
                itemBuilder: (context, index) {
                  final weapon = weapons[index];
                  return InkWell(
                    onTap: () {
                      Provider.of<SelectedWeapon>(context, listen: false).setSelectedWeapon(weapon);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeaponDetailPage(name: weapon.name)),
                      );
                    },
                    child: Card(
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Image.network(
                                'https://api.genshin.dev/weapons/' + weapon.name + '/icon',

                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(weapon.name.toUpperCase()),
                              ],
                            )
                          ],
                        )
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


