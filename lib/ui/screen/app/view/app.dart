// ignore_for_file: lines_longer_than_80_chars, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sisal/common/l10n/l10n.dart';
import 'package:sisal/ui/screen/feed/view/feed_page.dart';
import 'package:sisal/ui/screen/instagram/view/instagram_page.dart';
import 'package:sisal/ui/screen/photo/view/photo_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFC5D932), // Colore personalizzato.
          titleTextStyle: TextStyle(
            color: Colors.black, // Colore del testo nella barra.
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black, // Colore delle icone nella barra.
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC5D932),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF025930), // Versione scura.
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const FeedScreen(),
    const InstagramScreen(),
    const PhotoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Instagram'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Foto'),
        ],
      ),
    );
  }
}
void main() => runApp(const App());