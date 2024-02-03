import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String locationInfo = 'Joylashuvni aniqlash uchun tugmani bosing';
  Position? currentPosition;

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        currentPosition = position;
        locationInfo =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        locationInfo = 'Joylashuvni aniqlashda xatolik yuz berdi: $e';
      });
    }
  }

  Future<void> _getNewLocation() async {
    try {

      double newLatitude = 37.7749;
      double newLongitude = -122.4194;

      double distance =  Geolocator.distanceBetween(
          currentPosition!.latitude,
          currentPosition!.longitude,
          newLatitude,
          newLongitude);

      setState(() {
        locationInfo = 'Yangi joyga masofa: $distance metr';
      });
    } catch (e) {
      setState(() {
        locationInfo = 'Masofani hisoblashda xato: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolokatorga misol'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              locationInfo,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getLocation,
              child: Text('Joylashuvni korsating'),
            ),
            SizedBox(height: 22),
            ElevatedButton(
              onPressed: currentPosition != null ? _getNewLocation : null,
              child: Text('Orasidagi masofani xisoblang'),
            ),
          ],
        ),
      ),
    );
  }
}