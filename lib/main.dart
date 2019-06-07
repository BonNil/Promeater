import 'package:flutter/material.dart';
import 'package:promeater/screens/home_screen.dart';
import 'package:promeater/screens/settings_screen.dart';
import 'package:promeater/style_variables.dart';
import 'package:promeater/utils/app_status_provider.dart';
import 'package:promeater/utils/protein_provider.dart';
import 'package:promeater/utils/date_helper.dart';

void main() async {
  await weeklyReset();
  runApp(App());
}

Future<void> weeklyReset() async {
  final statusProvider = AppStatusProvider();
  final appStatusFuture = statusProvider.getAppStatus();
  final currentWeek = weekNumber(DateTime.now());
  final appStatus = await appStatusFuture;
  if (appStatus.lastResetWeek != currentWeek) {
    await resetAllProteins();
    appStatus.lastResetWeek = currentWeek;
    statusProvider.updateAppStatus(appStatus);
  }
}

Future<void> resetAllProteins() async {
  final proteinProvider = ProteinProvider();
  final proteins = await proteinProvider.getProteins();
  for (int i = 0; i < proteins.length; i++) {
    final protein = proteins[i];
    protein.current = 0;
    await proteinProvider.updateProtein(protein);
  }
}

class App extends StatelessWidget {
  final statusProvider = AppStatusProvider();
  final proteinProvider = ProteinProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Promeater',
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: TextTheme(
              body1: TextStyle(color: Colors.grey[700]))),
      home: const HomePage(title: 'Promeater'),
    );
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
      body: Container(
          child: _children[_currentIndex]),
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
