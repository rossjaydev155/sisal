// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:sisal/l10n/l10n.dart';
import 'package:sisal/views/feed/feed_screen.dart';
import 'package:sisal/views/instagram/instagram_screen.dart';
import 'package:sisal/views/photo/photo_screen.dart';

class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
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
    InstagramScreen(),
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


