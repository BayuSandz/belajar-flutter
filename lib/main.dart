import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/skill_provider.dart';
import 'pages/home_page.dart';
import 'pages/addskill_page.dart';
import 'pages/showskill_page.dart';
import 'providers/theme_provider.dart';
import 'pages/settings_page.dart';


void main(){
  runApp(
    MultiProvider(
      providers: [
    ChangeNotifierProvider(
      create: (context) => SkillProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Tracker',

      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),

      themeMode: themeProvider.themeMode,
      home: const MainPage(),
    );
  },
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
  bool isDarkMode = false;

  final List<Widget> halaman = const [
    HomePage(),
    AddSkillPage(),
    ShowSkillPage(),
    SettingsPage(),
  ];

  final List<String> judulHalaman = [
    'Home',
    'Add Skill',
    'Show Skill',
    'Settings',
  ];

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(judulHalaman[halamanTerpilih]),
        centerTitle: true,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child){
          return IconButton(
            onPressed: (){
              themeProvider.ubahTema();
            },
            icon: Icon(
              themeProvider.isDarkMode
              ? Icons.light_mode
              : Icons.dark_mode,
            ),
            tooltip: themeProvider.isDarkMode
            ? 'Ganti ke Light Mode'
            : 'Gamto le Dark Moder',
          );
            },
          ),
        ],
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
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}