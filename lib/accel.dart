import 'package:beyblade/modelpage.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class AccelerometerExample extends StatefulWidget {
  const AccelerometerExample({super.key});

  @override
  State<AccelerometerExample> createState() => _AccelerometerExampleState();
}

class _AccelerometerExampleState extends State<AccelerometerExample>
    with SingleTickerProviderStateMixin {
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

        if ((_accelerometerValues[0].x - _lastPrintedX).abs() >= 1 ||
            (_accelerometerValues[0].y - _lastPrintedY).abs() >= 0.5) {
          // Update the last printed x-value
          _lastPrintedX = _accelerometerValues[0].x;
          _lastPrintedY = _accelerometerValues[0].y;

          if (_lastPrintedX > -1.5 && _lastPrintedX < 1.5) {
            print("c");
            goBeyblade.stop_left();
            goBeyblade.stop_right();
          }
          if (_lastPrintedX < -1.5) {
            print("R");
            goBeyblade.right();
          }
          if (_lastPrintedX > 1.5) {
            print("L");
            goBeyblade.left();
          }

          if (_lastPrintedY > -1.5 && _lastPrintedY < 1.5) {
            print("center");

            goBeyblade.stop_forward();
            goBeyblade.stop_backward();
          }
          if (_lastPrintedY < -1.5) {
            print("F");
            goBeyblade.forward();
          }
          if (_lastPrintedY > 1.5) {
            print("B");
            goBeyblade.backward();
          }
        }

/*
        if ((_accelerometerValues[0].x - _lastPrintedX).abs() >= 1 || (_accelerometerValues[0].y - _lastPrintedY).abs() >= 0.5) {
          // Update the last printed x-value
          _lastPrintedX = _accelerometerValues[0].x;
          _lastPrintedY = _accelerometerValues[0].y;

          // Print direction based on x-value
          if (_lastPrintedX > -1 && _lastPrintedX < 1){
            goBeyblade.stop_left();
            goBeyblade.stop_right();
            goBeyblade.stop_backward();
            goBeyblade.stop_forward();

            if(_lastPrintedY > -2 && _lastPrintedY < 2){
              goBeyblade.stop_backward();
              goBeyblade.stop_forward();
              goBeyblade.stop_left();
              goBeyblade.stop_right();
            }
            else if(_lastPrintedY < -2){
              goBeyblade.forward();
            }
            else if(_lastPrintedY > 2){
              goBeyblade.backward();
            }
            // else{
            //   goBeyblade.backward();
            // }


            print("center");
          } else if (_lastPrintedX < -1) {
            goBeyblade.right();

            if(_lastPrintedY > -2 && _lastPrintedY < 2){
              goBeyblade.stop_backward();
              goBeyblade.stop_forward();
            }
            else if(_lastPrintedY < -2){
              goBeyblade.forward();
            }
            else if(_lastPrintedY > 2){
              goBeyblade.backward();
            }
            // else{
            //   goBeyblade.backward();
            // }

            print("right");
          } else {
            goBeyblade.left();

            if(_lastPrintedY > -2 && _lastPrintedY < 2){
              goBeyblade.stop_backward();
              goBeyblade.stop_forward();
            }
            else if(_lastPrintedY < -2){
              goBeyblade.forward();
            }

            // else{
            //   goBeyblade.backward();
            // }

            print("left");
          }
        }
*/
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
      body: Stack(children: [

        // ClipRRect(
        //   child: Container(
        //     height: double.infinity,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       color: Colors.blue, // Change the color as per your requirement
        //       shape: BoxShape
        //           .rectangle, // Change to BoxShape.circle for a circle, BoxShape.rectangle for an oval
        //       borderRadius: BorderRadius.circular(
        //           150), // Adjust the value to change the oval shape
        //     ),
        //   ),
        // ),

        AnimatedAlign(
          duration: Duration(milliseconds: 300),
          alignment: Alignment(
              -_accelerometerValues[0].x / 10, _accelerometerValues[0].y / 10),
          child:
          // Container(
          //   height: 100,
          //     width: 100,
          //     child:
          //     Image.asset("asset/beyblade.png"))

          CircleAvatar(
            radius: 100,
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
      ]),
    );
  }
}
