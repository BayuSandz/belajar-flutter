import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/skill.dart';
import '../providers/skill_provider.dart';

class ShowSkillPage extends StatefulWidget{
  const ShowSkillPage({super.key});

  @override
  State<ShowSkillPage> createState() => _DaftarSkillPageState();
}

class _DaftarSkillPageState extends State<ShowSkillPage>{
  final TextEditingController pencarianController = TextEditingController();

  @override
  void dispose(){
    pencarianController.dispose();
    super.dispose();
  }

  Future<void> importDataSkill() async{
    try{
      final berhasil = await context.read<SkillProvider>().importDariFile();

      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            berhasil
            ? 'Data skill berhasil diimport!'
            : 'Import dibatalkan',
          ),
        ),
      );
    } catch (e){
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengimport data: $e'),
        ),
      );
    }
  }

  Future<void> exportDataSkill() async{
    try{
      final lokasiFile = await context
      .read<SkillProvider>()
      .simpanBackupKePerangkat();

      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            lokasiFile == null
            ? 'Export dibatalkan'
            : 'Backup berhasil disimpan: $lokasiFile',
          ),
        ),
      );
    } catch(e){
      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal membuat backup: $e'),
        ),
      );
    }
  }

  Future<void> editSkill(int index) async{
    final provider = context.read<SkillProvider>();
    final skillLama = provider.daftarSkill[index];

    String namaSkill = skillLama.nama;
    String kategori = skillLama.kategori;

    await showDialog(
      context: context,
      builder: (dialogContext){
        return AlertDialog(
          title: const Text('Edit Skill'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: namaSkill,
                decoration: const InputDecoration(
                  labelText: 'Nama Skill',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  namaSkill = value;
                },
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: kategori,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: provider.daftarKategori.map((item){
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value){
                  if(value != null){
                    kategori = value;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),

            ElevatedButton(
              onPressed: () async{
                if(namaSkill.trim().isEmpty){
                  return;
                }

                final skillBaru = Skill(
                  nama: namaSkill.trim(),
                  kategori:  kategori,
                );

                await provider.editSkill(index, skillBaru);
                if(!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> konfirmasiHapus(int index) async{
    final provider = context.read<SkillProvider>();
    final nama = provider.daftarSkill[index].nama;

    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext){
        return AlertDialog(
          title: const Text('Hapus Skill?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus $nama?',
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if(konfirmasi == true){
      await provider.hapusSkill(index);
    }
  }

  Future<void> konfirmasiHapusSemua() async{
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext){
        return AlertDialog(
          title: const Text('Hapus Semua Skill?'),
          content: const Text(
            'Apakah kamu yakin ingin menghapus seluruh skill? '
            'Tindakan ini tidak dapat dibatalkan.',
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Hapus Semua'),
            ),
          ],
        );
      },
    );

    if(!mounted) return;

    if(konfirmasi == true){
      await context.read<SkillProvider>().hapusSemuaSkill();
    }
  }

  @override
  Widget build(BuildContext context){
    return Consumer<SkillProvider>(
      builder: (context, provider, child){
        final daftarIndeks = provider.indeksSkillTerurut;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kelola Skill',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              //Pencarian
              TextField(
                controller: pencarianController,
                decoration: InputDecoration(
                  hintText: 'Cari Skill...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed:(){
                      pencarianController.clear();
                      provider.cariSkill('');
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: provider.cariSkill,
              ),

              const SizedBox(height: 16),

              //Filter Kategori
              DropdownButtonFormField<String>(
                initialValue: provider.kategoriFilter,
                decoration: const InputDecoration(
                  labelText: 'Filter Kategori',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem(
                    value: 'Semua',
                    child: Text('Semua Kategori'),
                  ),
                  ...provider.daftarKategori.map((kategori){
                    return DropdownMenuItem(
                      value: kategori,
                      child: Text(kategori),
                    );
                  }),
                ],
                onChanged: (value){
                  if(value != null){
                    provider.filterKategori(value);
                  }
                },
              ),

              const SizedBox(height: 12),

              //Pengurutan
              DropdownButtonFormField<String>(
                initialValue: provider.urutanSkill,
                decoration: const InputDecoration(
                  labelText: 'Urutan Skill',
                  border: OutlineInputBorder(),
                ),
                items: const[
                  DropdownMenuItem(
                    value: 'A-Z',
                    child: Text('A-Z'),
                  ),
                  DropdownMenuItem(
                    value: 'Z-A',
                    child: Text('Z-A'),
                  ),
                ],
                onChanged: (value){
                  if(value != null){
                    provider.ubahUrutanSkill(value);
                  }
                },
              ),

              const SizedBox(height: 16),

              //Statistik Jumlah
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text('Total Skill'),
                            const SizedBox(height: 8),
                            Text(
                              '${provider.totalSkill}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text('Hasil Pencarian'),
                            const SizedBox(height: 8),
                            Text(
                              '${provider.totalHasilPencarian}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              //Export dan Import
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: exportDataSkill,
                      icon: const Icon(Icons.download),
                      label: const Text('Export JSON'),
                    ),
                  ),

                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: importDataSkill,
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Import JSON'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              //Hapus Semua
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: provider.totalSkill == 0
                  ? null
                  : konfirmasiHapusSemua,
                  icon: const Icon(Icons.delete_forever),
                  label: const Text('Hapus Semua Skill'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Daftar Skill',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              if(daftarIndeks.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Belum ada skill yang ditemukan.',
                  ),
                ),
              )
              else
              ...daftarIndeks.map((indeksAsli){
                final skill = provider.daftarSkill[indeksAsli];

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.code),
                    title: Text(skill.nama),
                    subtitle: Text(skill.kategori),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: (){
                            editSkill(indeksAsli);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: (){
                            konfirmasiHapus(indeksAsli);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}