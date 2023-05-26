import 'package:flutter/material.dart';
import 'package:ptpm_pre_responsi_123200072/character/list_character_page.dart';
import 'package:ptpm_pre_responsi_123200072/weapon/list_weapon_page.dart';
import 'package:ptpm_pre_responsi_123200072/weapon/selected_weapon.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final selectedWeapon = Provider.of<SelectedWeapon>(context).selectedWeapon;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(60),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Image.asset(
                      'assets/genshin_logo.png',
                      width: 480,
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    if (selectedWeapon != null) ...[
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent, // Background color of the button
                            foregroundColor: Colors.black87, // Text color of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // Display the selected weapon's icon
                                Image.network(
                                  'https://api.genshin.dev/weapons/${selectedWeapon.name}/icon',
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(height: 10),
                                // Display the selected weapon's name
                                Text(selectedWeapon.name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 48,
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ListCharacter()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent, // Background color of the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                          child: Text(
                            'Character',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87, // Text color of the button
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      height: 48,
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ListWeapon()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent, // Background color of the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                          child: Text(
                            'Weapon',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87, // Text color of the button
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}


