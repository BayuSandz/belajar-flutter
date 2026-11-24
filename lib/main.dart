import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/skill_provider.dart';
import 'pages/home_page.dart';
import 'pages/addskill_page.dart';
import 'pages/showskill_page.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => SkillProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Tracker',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int halamanTerpilih = 0;

  final List<Widget> halaman = const [
    HomePage(),
    AddSkillPage(),
    ShowSkillPage(),
  ];

  final List<String> judulHalaman = [
    'Home',
    'Add Skill',
    'Show Skill',
  ];

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(judulHalaman[halamanTerpilih]),
        centerTitle: true,
      ),

      body: IndexedStack(
        index: halamanTerpilih,
        children: halaman,
      ),
      
      bottomNavigationBar: NavigationBar(
        selectedIndex: halamanTerpilih,
        onDestinationSelected: (index){
          setState((){
            halamanTerpilih = index;
          });
        },
        destinations: const[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Tambah',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Daftar Skill',
          ),
        ],
      ),
    );
  }
}