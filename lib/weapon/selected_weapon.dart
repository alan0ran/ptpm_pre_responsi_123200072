import 'package:flutter/material.dart';
import 'package:ptpm_pre_responsi_123200072/weapon/list_weapon_page.dart';

class SelectedWeapon extends ChangeNotifier {
  Weapon? _selectedWeapon;

  Weapon? get selectedWeapon => _selectedWeapon;

  void setSelectedWeapon(Weapon weapon) {
    _selectedWeapon = weapon;
    notifyListeners();
  }
}
