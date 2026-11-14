
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
  final TextEditingController skillController = TextEditingController();

  List<String> daftarSkill = [];

  void tambahSkill(){
    String skill = skillController.text.trim();

    if (skill.isNotEmpty){
      setState((){
        daftarSkill.add(skill);
      });

      skillController.clear();
    }
  }

  @override
  void dispose(){
    skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Skill'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
          controller: skillController,
          decoration: const InputDecoration(
            labelText: 'Nama Skill',
            hintText: 'Masukkan nama skill',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 15),

        ElevatedButton(
          onPressed: tambahSkill,
          child: const Text('Tambah Skill'),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: ListView.builder(
            itemCount: daftarSkill.length,
            itemBuilder: (context, index){
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.code),
                  title: Text(daftarSkill[index]),
                ),
              );
            },
          ),
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
