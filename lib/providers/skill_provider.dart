
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/skill.dart';

class SkillProvider extends ChangeNotifier {
  List<Skill> daftarSkill = [];

  String kataPencarian = '';
  String kategoriTerpilih = 'Programming';

  List<String> daftarKategori = [
    'Programming',
    'Database',
    'Networking',
    'Tools',
    'Other',
  ];

  int get totalSkill {
    return daftarSkill.length;
  }

  int get totalHasilPencarian {
    return hasilPencarian.length;
  }

  List<Skill> get hasilPencarian {
    return daftarSkill.where((skill) {
      return skill.nama
          .toLowerCase()
          .contains(kataPencarian.toLowerCase());
    }).toList();
  }

  void cariSkill(String keyword) {
    kataPencarian = keyword;
    notifyListeners();
  }

  List<int> get indeksHasilPencarian {
    return daftarSkill.asMap().entries.where((entry) {
      return entry.value.nama
          .toLowerCase()
          .contains(kataPencarian.toLowerCase());
    }).map((entry) => entry.key).toList();
  }

  late final Future<void> _inisialisasi;

  SkillProvider() {
    _inisialisasi = muatSkill();
  }

  Future<void> muatSkill() async {
    final prefs = await SharedPreferences.getInstance();

    // Membaca format penyimpanan baru
    final dataBaru = prefs.getStringList('daftarSkillJson');

    if (dataBaru != null) {
      daftarSkill = dataBaru.map((item) {
        return Skill.fromJson(jsonDecode(item));
      }).toList();
    } else {
      // Migrasi data lama yang masih berupa List<String>
      final dataLama = prefs.getStringList('daftarSkill') ?? [];

      daftarSkill = dataLama.map((nama) {
        return Skill(
          nama: nama,
          kategori: 'Programming',
        );
      }).toList();

      await simpanSkill();
    }

    notifyListeners();
  }

  Future<void> simpanSkill() async {
    final prefs = await SharedPreferences.getInstance();

    final data = daftarSkill.map((skill) {
      return jsonEncode(skill.toJson());
    }).toList();

    await prefs.setStringList('daftarSkillJson', data);
  }

  Future<void> tambahSkill(Skill skill) async {
    await _inisialisasi;

    daftarSkill.add(skill);
    await simpanSkill();

    notifyListeners();
  }

  Future<void> hapusSkill(int index) async {
    await _inisialisasi;

    daftarSkill.removeAt(index);
    await simpanSkill();

    notifyListeners();
  }

  Future<void> editSkill(int index, Skill skillBaru) async {
    await _inisialisasi;

    daftarSkill[index] = skillBaru;
    await simpanSkill();

    notifyListeners();
  }
}
