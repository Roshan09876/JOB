import 'dart:async';
import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';

class Proximity extends StatefulWidget {
  const Proximity({super.key});

  @override
  State<Proximity> createState() => _ProximityState();
}

class _ProximityState extends State<Proximity> {
  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscription.add(proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        _proximityValue = event.proximity;
      });
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
          'Proximity',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Center(
        child: _proximityValue >= 3
            ? Text(
                'Object is Far',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            : Text(
                'Object is Near',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
      ),
    );
  }
}
