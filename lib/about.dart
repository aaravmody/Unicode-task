//import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/contact_2.dart';

class About extends StatelessWidget {
  About({super.key});

  @override
  Widget build(BuildContext context) {
    final name = MyHomePageState.cname;
    final phone = MyHomePageState.cphone;
    // final image = MyHomePageState.cimage;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text("Contact Info ",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Icon(
                Icons.person_outlined,
                color: Colors.white,
                size: 32,
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 72, 129),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  foregroundImage: AssetImage('Icon(Icons.person)'),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              color: Colors.blue,
                              spreadRadius: 2,
                              blurRadius: 10)
                        ]),
                    child: ListTile(
                      title: Text(name),
                      leading: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              color: Colors.blue,
                              spreadRadius: 2,
                              blurRadius: 10)
                        ]),
                    child: ListTile(
                      title: Text(phone),
                      onTap: (() {
                        launch('tel: ${phone}');
                      }),
                      leading: Icon(Icons.phone),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
