//import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  About({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final name = args["Name"];
    final phone = args["phone"];
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$phone'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back'),
            )
          ],
        ),
      ),
    );
  }
}
