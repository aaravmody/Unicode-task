import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> users = [];

  void fetchContacts() async {
    users = await ContactsService.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text('Contacts',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          backgroundColor: Color.fromARGB(255, 2, 72, 129),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/about',
                      arguments: users[index]);
                },
                leading: Icon(Icons.person),
                title: Text(
                  users[index].givenName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  users[index].phones![0].value!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              elevation: 3,
            );
          },
          itemCount: users.length,
        ));
  }
}
