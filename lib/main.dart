
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
     // home: const HomePage(),
     home: const CounterPage(),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Pertama'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: isTablet
                    ? Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.tablet_mac,
                            size: 100,
                          ),
                          const SizedBox(width: 30),
                          const Expanded(
                            child: WelcomeContent(),
                          ),
                        ],
                      )
                    : const Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_android,
                            size: 100,
                          ),
                          SizedBox(height: 24),
                          WelcomeContent(),
                        ],
                      ),
              ),
            ),
          );
        },
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
            )
          ],
        ),
      ),
    );
  }
}
