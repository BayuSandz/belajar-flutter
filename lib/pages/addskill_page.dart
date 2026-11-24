import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/skill.dart';
import '../providers/skill_provider.dart';

class AddSkillPage extends StatefulWidget{
  const AddSkillPage({super.key});

  @override
  State<AddSkillPage> createState() => _AddSkillPageState();
}

class _AddSkillPageState extends State<AddSkillPage>{
  final TextEditingController skillController = TextEditingController();

  String kategoriSkill = 'Programming';

  Future<void> addSkill() async{
    final namaSkill = skillController.text.trim();

    if(namaSkill.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama skill tidak boleh kosong'),
        ),
      );
      return;
    }

    final skillBaru = Skill(
      nama: namaSkill,
      kategori: kategoriSkill,
    );

    await context.read<SkillProvider>().addSkill(skillBaru);

    if (!mounted) return;

    skillController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Skill berhasil ditambahkan!'),
      ),
    );
  }

  @override
  void dispose(){
    skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final provider = context.read<SkillProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.start,
        children: [
          const Text(
            'Tambah Skill Baru',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: skillController,
            decoration: const InputDecoration(
              labelText: 'Nama Skill',
              hintText: 'Contoh: Flutter, Dart, MySQL',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.code),
            ),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: kategoriSkill,
            decoration: const InputDecoration(
              labelText: 'Kategori Skill',
              border: OutlineInputBorder(),
            ),
            items: provider.daftarKategori.map((kategori){
              return DropdownMenuItem<String>(
                value: kategori, child: Text(kategori),
              );
            }).toList(),

            onChanged: (value){
              if(value != null){
                setState((){
                  kategoriSkill = value;
                });
              }
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: addSkill,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Skill'),
            ),
          ),
        ],
      ),
    );
  }
}