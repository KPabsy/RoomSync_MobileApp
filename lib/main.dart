import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(SmartRoomApp());
}

class SmartRoomApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Room Monitor',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: RoomConditionScreen(),
    );
  }
}

class RoomConditionScreen extends StatefulWidget {
  @override
  _RoomConditionScreenState createState() => _RoomConditionScreenState();
}

class _RoomConditionScreenState extends State<RoomConditionScreen> {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('conditions');

  String temp = "--";
  String hum = "--";
  String light = "--";
  String power = "--";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _listenToConditions();
  }

  void _listenToConditions() {
    _ref.onValue.listen(
      (DatabaseEvent event) {
        final data = event.snapshot.value;
        if (data != null && data is Map) {
          setState(() {
            temp = (data['temp'] is num) ? "${data['temp']} °C" : "--";
            hum = (data['hum'] is num) ? "${data['hum']} %" : "--";
            light = (data['light'] is num) ? "${data['light']} lx" : "--";
            power = (data['pow'] is num) ? "${data['pow']} W" : "--";
            isLoading = false;
          });
        } else {
          setState(() {
            temp = hum = light = power = "--";
            isLoading = false;
          });
        }
      },
      onError: (error) {
        setState(() {
          temp = hum = light = power = "--";
          isLoading = false;
        });
      },
    );
  }

  Widget _buildTile(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 36),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 20, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Room Monitor'), centerTitle: true),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              padding: EdgeInsets.all(12),
              children: [
                _buildTile('Temperature', temp, Icons.thermostat, Colors.red),
                _buildTile('Humidity', hum, Icons.water_drop, Colors.blue),
                _buildTile('Light', light, Icons.light_mode, Colors.orange),
                _buildTile('Power', power, Icons.power, Colors.green),
              ],
            ),
    );
  }
}
