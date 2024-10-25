import 'package:flutter/material.dart';
import 'package:live_location_tracking/screens/attendance_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Ensures Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Location Tracking',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Location Tracker")),
      drawer: AppDrawer(),
      body: Center(child: Text('Welcome to Live Location Tracking')),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Cameron Williamson"),
            accountEmail: Text("cameronwilliamson@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.timer),
            title: Text('Timer'),
            onTap: () {
              // Add implementation for Timer
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Attendance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AttendanceScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
