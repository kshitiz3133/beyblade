import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Call extends StatelessWidget {
  Call({Key? key}) : super(key: key);

  // String ipAddress = "192.168.189.96";
  String ipAddress = "10.21.81.88";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                forward();
              },
              child: Text('Forward'),
            ),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    left();
                  },
                  child: Text('Left'),
                ),

                SizedBox(width: 30,),

                ElevatedButton(
                  onPressed: () {
                    right();
                  },
                  child: Text('Right'),
                ),
              ],
            ),

            SizedBox(height: 10,),

            ElevatedButton(
              onPressed: () {
                backward();
              },
              child: Text('Backward'),
            ),

           SizedBox(height: 40,),

            ElevatedButton(
              onPressed: () {
                stop_backward();
                stop_forward();
                stop_right();
                stop_left();
              },
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/'));
    if (response.statusCode == 200) {
      // Handle successful response
      print('Response: ${response.body}');
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  void forward() async {
    var body = jsonEncode({ 'Parameters': {}});
    http.put(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/function/Forward'),
        body: body);
  }

  void backward() async {
    var body = jsonEncode({ 'Parameters': {}});
    http.put(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/function/Backward'),
        body: body);
  }

  void left() async {
    var body = jsonEncode({ 'Parameters': {}});
    http.put(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/function/Left'),
        body: body);
  }

  void right() async {
    var body = jsonEncode({ 'Parameters': {}});
    http.put(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/function/Right'),
        body: body);
  }

  void stop_right() async {
    var body = jsonEncode({ 'Parameters': {}});
    http.put(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/function/Stop Right'),
        body: body);
  }

  void stop_left() async {
    var body = jsonEncode({ 'Parameters': {}});
    http.put(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/function/Stop Left'),
        body: body);
  }

  void stop_forward() async {
    var body = jsonEncode({ 'Parameters': {}});
    http.put(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/function/Stop Forward'),
        body: body);
  }

  void stop_backward() async {
    var body = jsonEncode({ 'Parameters': {}});
    http.put(Uri.parse(
        'http://${ipAddress}:30010/remote/preset/NewRemoteControlPreset/function/Stop Backword'),
        body: body);
  }

}