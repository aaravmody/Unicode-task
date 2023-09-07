import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/cityname.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String naam = cityState.cityname;
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<Map<String, dynamic>> getWeather() async {
    try {
      String cityName = naam;
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=f23c50611adde2284c87e599966892a5'),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 72, 129),
        centerTitle: true,
        actions: [
          InkWell(
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getWeather(),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: const CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final data = snapshot.data!;
            final currenttemp = data['list'][0]['main']['temp'].toString();
            final tempAsDouble = double.parse(currenttemp);
            final current = (tempAsDouble - 273).toStringAsFixed(2);
            final sky = data['list'][0]['weather'][0]['main'];
            final pressure = data['list'][0]['main']['pressure'];
            final wind = data['list'][0]['wind']['speed'];
            final humidity = data['list'][0]['main']['humidity'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '$current °C',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Icon(
                                  sky == 'Clouds' || sky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  sky,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ), //gap between the 2 placeholders
                  //weatherforecast card
                  const Text(
                    'Weather Forecast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          HourlyForecastItem(
                            time: DateFormat.Hm()
                                .format(DateTime.parse(
                                    data['list'][i + 1]['dt_txt']))
                                .toString(),
                            temperature: (double.parse(data['list'][i + 1]
                                            ['main']['temp']
                                        .toString()) -
                                    273)
                                .toStringAsFixed(2),
                            icon: data['list'][i + 1]['weather'][0]['main'] ==
                                        'Clouds' ||
                                    data['list'][i + 1]['weather'][0]['main'] ==
                                        'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                          ),
                      ],
                    ),
                  ),
                  //additional info
                  const SizedBox(height: 20),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Hourly(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: humidity.toString(),
                      ),
                      Hourly(
                        icon: Icons.air,
                        label: 'Wind speed',
                        value: wind.toString(),
                      ),
                      Hourly(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: pressure.toString(),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}

class Hourly extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const Hourly({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(label),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForecastItem(
      {super.key,
      required this.time,
      required this.temperature,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Icon(
              icon,
              size: 32,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$temperature °C',
            ),
          ],
        ),
      ),
    );
  }
}
