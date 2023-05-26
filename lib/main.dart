import 'package:flutter/material.dart';
import 'package:ptpm_pre_responsi_123200072/home_page.dart';
import 'package:ptpm_pre_responsi_123200072/weapon/selected_weapon.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectedWeapon>(
      create: (_) => SelectedWeapon(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Genshin Impact App',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: HomePage(),
      ),
    );
  }
}

