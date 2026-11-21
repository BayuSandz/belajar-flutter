
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/skill_provider.dart';
import 'models/skill.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SkillProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Belajar Flutter',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      //home: const CounterPage(),
    );
  }
}

class JudulAplikasi extends StatelessWidget {
  const JudulAplikasi({super.key});

  @override
  Widget build(BuildContext context){
    return const Text(
      'Aplikasi Pertama',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      )
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//HomePage Awal
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Aplikasi Pertama'),
  //     ),
  //     body: LayoutBuilder(
  //       builder: (context, constraints) {
  //         final isTablet = constraints.maxWidth >= 600;

  //         return Center(
  //           child: ConstrainedBox(
  //             constraints: const BoxConstraints(
  //               maxWidth: 900,
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(24),
  //               child: isTablet
  //                   ? Row(
  //                       mainAxisAlignment:
  //                           MainAxisAlignment.center,
  //                       children: [
  //                         const Icon(
  //                           Icons.tablet_mac,
  //                           size: 100,
  //                         ),
  //                         const SizedBox(width: 30),
  //                         const Expanded(
  //                           child: WelcomeContent(),
  //                         ),
  //                       ],
  //                     )
  //                   : const Column(
  //                       mainAxisAlignment:
  //                           MainAxisAlignment.center,
  //                       children: [
  //                         Icon(
  //                           Icons.phone_android,
  //                           size: 100,
  //                         ),
  //                         SizedBox(height: 24),
  //                         WelcomeContent(),
  //                       ],
  //                     ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

//Membuat Layout dengan Container
  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Belajar Layout'),
  //       centerTitle: true,
  //     ),
  //     body: Center(
  //       child: Padding(
  //         padding: const EdgeInsets.all(24),
  //         child: Container(
  //           width: 250,
  //           height: 150,
  //           decoration: BoxDecoration(
  //             color: Colors.blue,
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child:const Center(
  //             child: Text(
  //               'Halo Bayu',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //  }

  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Profile Card'),
  //       centerTitle: true,
  //     ),

      // CARD PROFILE
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: Container(
      //     padding: const EdgeInsets.all(20),
      //     decoration: BoxDecoration(
      //       color: const Color.fromARGB(255, 66, 82, 93),
      //       borderRadius: BorderRadius.circular(16),
      //     ),
      //     child: Row(
      //       children: [
      //         const CircleAvatar(
      //           radius: 35,
      //           child: Icon(Icons.person, size: 40),
      //         ),

      //         const SizedBox(width: 16),

      //         const Expanded(

      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               Text(
      //                 'Bayu Ari Sandy',
      //                 style: TextStyle(
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               SizedBox(height: 6),
      //               Text('Teknik Informatika'),
      //               Text('Flutter Developer'),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // ),

// LIST VIEW
//       body: ListView(
//   padding: const EdgeInsets.all(16),
//   children: [
//     Card(
//       child: ListTile(
//         leading: const Icon(Icons.code),
//         title: const Text('Dart'),
//         subtitle: const Text('Bahasa pemrograman Flutter'),
//       ),
//     ),
//     Card(
//       child: ListTile(
//         leading: const Icon(Icons.phone_android),
//         title: const Text('Flutter'),
//         subtitle: const Text('Framework pengembangan aplikasi'),
//       ),
//     ),
//     Card(
//       child: ListTile(
//         leading: const Icon(Icons.storage),
//         title: const Text('Database'),
//         subtitle: const Text('Penyimpanan data aplikasi'),
//       ),
//     ),
//     Card(
//       child: ListTile(
//         leading: const Icon(Icons.water), 
//         title: const Text('Java'),
//         subtitle: const Text('Bahasa Pemrograman'),
//       ),
//     ),
//     Card(
//       child: ListTile(
//         leading: const Icon(Icons.dashboard),
//         title: const Text('UI/UX Design'),
//         subtitle: const Text('Desain Aplikasi'),
//       ),
//     ),
//   ],
// ),
 //   );
 // }
// }

// Text Field
class HomePage extends StatefulWidget {
  const HomePage({super.key});

@override 
State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String kategoriSkill = 'Programming';

  final TextEditingController pencarianController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  final FocusNode fokusHalaman = FocusNode();
  final FocusNode fokusNamaSkill = FocusNode();


  Future <void> tambahSkill() async{
  final namaSkill = skillController.text.trim();

  if (namaSkill.isEmpty) {
    return;
  }

  final skillBaru = Skill(
    nama: namaSkill,
    kategori: kategoriSkill,
  );

  await context.read<SkillProvider>().tambahSkill(skillBaru);
  final hasilExport = context.read<SkillProvider>().exportJson();

  debugPrint('Hasil Export Json:');
  debugPrint(hasilExport);

  skillController.clear();
}

  void hapusSkill(int index) {
    context.read<SkillProvider>().hapusSkill(index);
  }

  void editSkill(int index) {
  final skillLama =
      context.read<SkillProvider>().daftarSkill[index];

  String namaSkill = skillLama.nama;
  String kategori = skillLama.kategori;

  showDialog(
    context: context,
    builder: (dialogContext) {
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
              onChanged: (value) {
                namaSkill = value;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: context
                  .read<SkillProvider>()
                  .daftarKategori
                  .map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  kategori = value;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (namaSkill.trim().isEmpty) {
                return;
              }

              final skillBaru = Skill(
                nama: namaSkill.trim(),
                kategori: kategori,
              );

              context
                  .read<SkillProvider>()
                  .editSkill(index, skillBaru);

              Navigator.pop(dialogContext);
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  );
}

  void konfirmasiHapus(int index){
    showDialog(
      context: context,
      builder: (dialogContext){
        return AlertDialog(
          title: const Text('Hapus Skill?'),
          content: Text('Apakah kamu yakin ingin menghapus ${context.read<SkillProvider>().daftarSkill[index].nama}?',
        ),

        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(dialogContext);
            },
            child: const Text('Batal'),
          ),

          ElevatedButton(
            onPressed: (){
              hapusSkill(index);
              Navigator.pop(dialogContext);
            },
            child: const Text('Hapus'),
          ),
        ],
        );
      },
    );
  }

  void konfirmasiHapusSemua(){
    showDialog(
      context: context,
      builder: (dialogContext){
        return AlertDialog(
          title: const Text('Hapus Semua Skill?'),
          content: const Text(
            'Apakah kamu yakin ingin menghapus seluruh skill?'
            'Tindakan ini tidak dapat dibatalkan.',
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(dialogContext);
                WidgetsBinding.instance.addPostFrameCallback((_){
                  fokusNamaSkill.unfocus();
                });
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: (){
                context.read<SkillProvider>().hapusSemuaSkill();
                Navigator.pop(dialogContext);
                WidgetsBinding.instance.addPostFrameCallback((_){
                  fokusNamaSkill.unfocus();
                });
              },
              child: const Text('Hapus Semua'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose(){
    skillController.dispose();
    pencarianController.dispose();
    fokusHalaman.dispose();
    fokusNamaSkill.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Skill'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
          controller: skillController,
          focusNode: fokusNamaSkill,
          decoration: const InputDecoration(
            labelText: 'Nama Skill',
            hintText: 'Masukkan nama skill',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: kategoriSkill,
          decoration: const InputDecoration(
            labelText: 'Kategori Skill',
            border: OutlineInputBorder(),
          ),
          items: context.read<SkillProvider>().daftarKategori.map((kategori){
            return DropdownMenuItem<String>(
              value: kategori,
              child: Text(kategori),
            );
          }).toList(),
          onChanged: (value){
            setState((){
              kategoriSkill = value!;
            });
          },
        ),

        ElevatedButton(
          onPressed: tambahSkill,
          child: const Text('Tambah Skill'),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: pencarianController,
          decoration: InputDecoration(
            hintText: 'Cari Skill...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: (){
                pencarianController.clear();
                context.read<SkillProvider>().cariSkill('');
              },
            ),
            border: const OutlineInputBorder(),
          ),
          onChanged: (value){
            context.read<SkillProvider>().cariSkill(value);
          },
        ),

        const SizedBox(height: 15),

        Consumer<SkillProvider>(
          builder: (context, provider, child){
            return DropdownButtonFormField<String>(
              value: provider.kategoriFilter,
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
                if (value != null){
                  provider.filterKategori(value);
                }
              },
            );
          },
        ),

        const SizedBox(height: 12),

        Consumer<SkillProvider>(
          builder: (context, provider, child) {
            return DropdownButtonFormField<String>(
              value: provider.urutanSkill,
              decoration: const InputDecoration(
                labelText: 'Urutkan Skill',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'A-Z',
                  child: Text('A - Z'),
                ),
                DropdownMenuItem(
                  value: 'Z-A',
                  child: Text('Z - A'),
                ),
              ],
              onChanged: (value){
                if (value != null){
                  provider.ubahUrutanSkill(value);
                }
              },
            );
          },
        ),

        const SizedBox(height: 12,),

        Consumer<SkillProvider>(
          builder: (context, provider, child){
            return Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text('Total Skill'),
                          const SizedBox(height: 8,),
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
            );
          },
        ),

        const SizedBox(height: 20),

        Consumer<SkillProvider>(
          builder: (context, provider, child){
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Statistik Kategori', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...provider.statistikKategori.entries.map((entry){
                    final total = provider.totalSkill;
                    final persentase = total == 0 ? 0.0 : entry.value/total;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key),
                              Text('${entry.value} skill'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: persentase,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ],
                      ),
                    );
                  }),
                  ],
                ),
              ),
            );
          },
        ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: konfirmasiHapusSemua,
                icon: const Icon(Icons.delete_forever),
                label: const Text('Hapus Semua Skill'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 12),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: context.watch<SkillProvider>().indeksSkillTerurut.length,
            itemBuilder: (context, index){
              final provider = context.watch<SkillProvider>();
              final indeksAsli = provider.indeksSkillTerurut[index];
              final skill = provider.daftarSkill[indeksAsli];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.code),
                  title: Text(skill.nama),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: (){
                          editSkill(indeksAsli);
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color:Colors.red),
                        onPressed: (){
                          konfirmasiHapus(indeksAsli);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ],
        ),
      ),
    );
  }
}

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Membuat variable
    String nama = 'Bayu';
    int umur = 23;
    String jurusan = 'Teknik Informatika';

    // 2. Membuat fungsi
    String buatSapaan(){
      return 'Halo, nama saya $nama';
    }

    // 3. Menampilkan data aplikasi
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          buatSapaan(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text('Umur: $umur tahun'),
        Text('Jurusan: $jurusan'),
        const SizedBox(height: 20),
        const Text('Saya sedang belajar Flutter!'),
      ],
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int angka = 0;

  void resetAngka(){
    setState((){
      angka = 0;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Angka: $angka',
              style: const TextStyle(fontSize: 30),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    setState((){
                      angka++;
                    });
                  },
                  child: const Text('Tambah'),
                ),
                const SizedBox(width: 16),

                ElevatedButton(
                  onPressed: (){
                    setState((){
                      if (angka > 0){
                        angka--;
                      }
                    });
                  },
                  child: const Text('Kurang'),
                )
              ]
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: resetAngka,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
