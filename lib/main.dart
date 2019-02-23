import 'package:flutter/material.dart';
import 'package:promeater/screens/home_screen.dart';
import 'package:promeater/screens/settings_screen.dart';
import 'package:promeater/utils/appStatusProvider.dart';
import 'package:promeater/utils/proteinProvider.dart';
import 'package:promeater/utils/dateHelper.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final statusProvider = AppStatusProvider();
  final proteinProvider = ProteinProvider();

  @override
  StatelessElement createElement() {
    weeklyReset();

    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Promeater',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(title: 'Promeater'),
    );
  }

  void weeklyReset() {
    final appStatusFuture = statusProvider.getAppStatus();
    final currentWeek = weekNumber(DateTime.now());
    appStatusFuture.then((appStatus) {
      if (appStatus.lastResetWeek != currentWeek) {
        resetAllProteins();
        appStatus.lastResetWeek = currentWeek;
        statusProvider.updateAppStatus(appStatus);
      }
    });
  }

  void resetAllProteins() {
    final proteinsFuture = proteinProvider.getProteins();
    proteinsFuture.then((proteins) {
      for (int i; i < proteins.length; i++) {
        proteins[i].current = 0;
        proteinProvider.updateProtein(proteins[i]);
      }
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomeScreen(), SettingsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
