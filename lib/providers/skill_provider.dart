
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkillProvider extends ChangeNotifier {

  List<String> daftarSkill = [];
  String kataPencarian = '';

  List<String> get hasilPencarian{
    return daftarSkill.where((skill){
      return skill.toLowerCase().contains(kataPencarian.toLowerCase());
    }).toList();
  }

  void cariSkill(String keyword){
    kataPencarian = keyword;
    notifyListeners();
  }

  List<int> get indeksHasilPencarian{
    return daftarSkill.asMap().entries.where((entry){
      return entry.value.toLowerCase().contains(kataPencarian.toLowerCase());
    }).map((entry) => entry.key).toList();
  }

  late final Future<void> _inisialisasi;

  SkillProvider() {
    _inisialisasi = muatSkill();
  }

  Future<void> muatSkill() async {
    debugPrint('MULAI MEMUAT DATA');

    final prefs = await SharedPreferences.getInstance();

    daftarSkill = prefs.getStringList('daftarSkill') ?? [];

    debugPrint('DATA DIMUAT: $daftarSkill');

    notifyListeners();
  }

  Future<void> simpanSkill() async {
    final prefs = await SharedPreferences.getInstance();

    final berhasil = await prefs.setStringList(
      'daftarSkill',
      daftarSkill,
    );

    debugPrint('DATA DISIMPAN: $daftarSkill');
    debugPrint('STATUS PENYIMPANAN: $berhasil');

    final hasilBaca = prefs.getStringList('daftarSkill');
    debugPrint('HASIL BACA: $hasilBaca');
  }

  Future<void> tambahSkill(String skill) async {
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

  Future<void> editSkill(int index, String skillBaru) async {
    await _inisialisasi;

    daftarSkill[index] = skillBaru;
    await simpanSkill();

    notifyListeners();
  }
}
