
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/skill.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class SkillProvider extends ChangeNotifier {
  List<Skill> daftarSkill = [];

  String kataPencarian = '';
  String kategoriFilter = 'Semua';
  String urutanSkill = 'A-Z';
  String kategoriTerpilih = 'Programming';

  String exportJson(){
    final dataJson = daftarSkill.map((skill) => skill.toJson()).toList();

    return jsonEncode(dataJson);
  }

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
      final cocokNama = skill.nama.toLowerCase().contains(kataPencarian.toLowerCase());
      final cocokKategori = kategoriFilter == 'Semua' || skill.kategori == kategoriFilter;

      return cocokNama && cocokKategori;
    }).toList();
  }

  void cariSkill(String keyword) {
    kataPencarian = keyword;
    notifyListeners();
  }

  void filterKategori(String kategori){
    kategoriFilter = kategori;
    notifyListeners();
  }

  void ubahUrutanSkill(String urutan){
    urutanSkill = urutan;
    notifyListeners();
  }

  Map<String, int> get statistikKategori{
    Map<String, int> hasil = {};

    for(var kategori in daftarKategori){
      hasil[kategori] = daftarSkill.where((skill) => skill.kategori == kategori).length;
    }

    return hasil;
  }

  List<Skill> get skillTerurut{
    final hasil = hasilPencarian.toList();

    hasil.sort((a, b){
      if (urutanSkill == 'A-Z'){
        return a.nama.compareTo(b.nama);
      } else{
        return b.nama.compareTo(a.nama);
      }
    });

    return hasil;
  }

  List<int> get indeksSkillTerurut{
    final indeks = indeksHasilPencarian;

    indeks.sort((a, b){
      final namaA = daftarSkill[a].nama;
      final namaB = daftarSkill[b].nama;

      if (urutanSkill == 'A-Z'){
        return namaA.compareTo(namaB);
      } else{
        return namaB.compareTo(namaA);
      }
    });

    return indeks;
  }

  List<int> get indeksHasilPencarian {
    return daftarSkill.asMap().entries.where((entry) {
      final skill = entry.value;
      final cocokNama = skill.nama.toLowerCase().contains(kataPencarian.toLowerCase());
      final cocokKategori = kategoriFilter == 'Semua' || skill.kategori == kategoriFilter;

      return cocokNama && cocokKategori;
    }).map((entry) => entry.key).toList();
  }

  late final Future<void> _inisialisasi;

  SkillProvider() {
    _inisialisasi = muatSkill();
  }

  Future<bool> importDariFile() async{
    await _inisialisasi;

    final hasilPilihFile = await FilePicker.pickFiles();

    if(hasilPilihFile.isEmpty){
      return false;
    }

    final fileTerpilih = hasilPilihFile.first;

    if(fileTerpilih.path == null){
      throw Exception('File tidak dapat dibaca');
    }

    final file = File(fileTerpilih.path!);
    final isiFile = await file.readAsString();
    final List<dynamic> dataJson = jsonDecode(isiFile);
    final skillBaru = dataJson.map((item){
      return Skill.fromJson(item);
    }).toList();

    daftarSkill = skillBaru;
    await simpanSkill();
    notifyListeners();
    return true;
  }

  Future<String> exportKeFile() async{
    final jsonData = exportJson();
    final direktori = await getApplicationDocumentsDirectory();
    final file = File('${direktori.path}/backup_skill.json');
    
    await file.writeAsString(jsonData);
    return file.path;
  }

  Future<Uri?> simpanBackupKePerangkat() async{
    final jsonData = exportJson();

    final lokasiFile = await FilePicker.saveFile(
      dialogTitle: 'Simpan Backup Skill',
      fileName: 'backup_skill.json',
      bytes: utf8.encode(jsonData),
    );

    return lokasiFile;
  }

  Future<void> hapusSemuaSkill() async{
    await _inisialisasi;
    daftarSkill.clear();
    
    await simpanSkill();
    notifyListeners(); 
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

  Future<void> addSkill(Skill skill) async {
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
