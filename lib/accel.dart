import 'package:beyblade/modelpage.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class AccelerometerExample extends StatefulWidget {
  const AccelerometerExample({super.key});

  @override
  State<AccelerometerExample> createState() => _AccelerometerExampleState();
}

class _AccelerometerExampleState extends State<AccelerometerExample> with SingleTickerProviderStateMixin{
// List to store accelerometer data
  List<AccelerometerEvent> _accelerometerValues = [];

  Call goBeyblade = Call();

// StreamSubscription for accelerometer events
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late double _lastPrintedX = 0.0; // Store the last printed x-value
  late double _lastPrintedY = 0.0; // Store the last printed x-value

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        // Update the _accelerometerValues list with the latest event
        _accelerometerValues = [event];

        if ((_accelerometerValues[0].x - _lastPrintedX).abs() >= 1) {
          // Update the last printed x-value
          _lastPrintedX = _accelerometerValues[0].x;

          // Print direction based on x-value
          if (_lastPrintedX > -1 && _lastPrintedX < 1) {
            goBeyblade.stop_left();
            goBeyblade.stop_right();
            print("center");
          } else if (_lastPrintedX < -1) {
            goBeyblade.right();
            print("right");
          } else {
            goBeyblade.left();
            print("left");
          }
        }


        // if ((_accelerometerValues[0].y - _lastPrintedY).abs() >= 0.2) {
        //   // Update the last printed x-value
        //   _lastPrintedY = _accelerometerValues[0].y;
        //
        //   // Print direction based on x-value
        //   if (_lastPrintedY > -0.1 && _lastPrintedY < 0.1) {
        //     goBeyblade.stop_forward();
        //     goBeyblade.stop_backward();
        //     print("center");
        //   } else if (_lastPrintedY < -0.1) {
        //     goBeyblade.forward();
        //     print("down");
        //   } else {
        //     goBeyblade.backward();
        //     print("up");
        //   }
        // }
      });



















      //   if(_accelerometerValues[0].x.toInt() > -0.5 && _accelerometerValues[0].x.toInt() < 0.5){
      //     print("center");
      //   }
      //   else  if(_accelerometerValues[0].x.toInt() < -0.5){
      //     print("right");
      //   }
      //   else{
      //     print("left");
      //   }
      //   // print(_accelerometerValues);
      // });
    });

    // Subscribe to accelerometer events

  }

  @override
  void dispose() {
    // Cancel the accelerometer event subscription to prevent memory leaks
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedAlign(
        duration: Duration(milliseconds: 300),
        alignment: Alignment(-_accelerometerValues[0].x/5, _accelerometerValues[0].y/10),
        child: CircleAvatar(radius: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Accelerometer Data:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                if (_accelerometerValues.isNotEmpty)
                  Text(
                    'X: ${_accelerometerValues[0].x.toStringAsFixed(2)}, '
                        'Y: ${_accelerometerValues[0].y.toStringAsFixed(2)}, '
                        'Z: ${_accelerometerValues[0].z.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  )
                else
                  Text('No data available', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
