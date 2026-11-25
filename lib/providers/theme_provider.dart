import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  bool isDarkMode = false;

  ThemeProvider(){
    muatTema();
  }

  ThemeMode get themeMode{
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> muatTema() async{
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> ubahTema() async{
    isDarkMode = !isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    notifyListeners();
  }
}