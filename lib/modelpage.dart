import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Call extends StatelessWidget {
  const Call({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            fetchData();
          },
          child: Text('Fetch Data'),
        ),
      ),
    );
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.6:30010/remote/preset/NewRemoteControlPreset/'));
    if (response.statusCode == 200) {
      // Handle successful response
      print('Response: ${response.body}');
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }
}
