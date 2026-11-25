import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context){
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Pengaturan Aplikasi',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
            child: SwitchListTile(
              secondary: Icon(
                themeProvider.isDarkMode
                ? Icons.dark_mode
                : Icons.light_mode,
              ),
              title: const Text('Dark Mode'),
              subtitle: const Text(
                'Mengaktifkan tampilan gelap',
              ),
              value: themeProvider.isDarkMode,
              onChanged: (value){
                themeProvider.ubahTema();
              },
            ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Bahasa Aplikasi'),
                subtitle: const Text('Bahasa Indonesia'),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Pengaturan bahasa belum tersendia',
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Tentang Aplikasi'),
                subtitle: const Text('Skill Tracker v1.0.0'),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                  showAboutDialog(
                    context: context,
                    applicationName: 'Skill Tracker',
                    applicationVersion: '1.0.0',
                    applicationLegalese: 'Aplikasi untuk mengelola skill pribadi.',
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}