import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class city extends StatefulWidget {
  const city({super.key});

  @override
  State<city> createState() => cityState();
}

class cityState extends State<city> {
  final citycontroller = TextEditingController();
  static late String cityname;

  @override
  void dispose() {
    citycontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Text("City Name",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 72, 129),
      ),
      body: Column(
        children: [
          SizedBox(
            child: TextField(
              controller: citycontroller,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                cityname = citycontroller.text.toString();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => WeatherScreen()));
              },
              child: Text('Enter'))
        ],
      ),
    );
  }
}
