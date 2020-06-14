import 'package:contactsapp/contact.dart';
import 'package:contactsapp/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ContactDetails.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final contactssnap = Provider.of<List<Contact>>(context) ?? [];

    return StreamProvider<List<Contact>>.value(
      value: DatabaseService().contactssnap,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("ContactsApp")),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetails(contactssnap[index])));
                  },
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: contactssnap[index].imageurl != null
                        ? NetworkImage(contactssnap[index].imageurl)
                        : NetworkImage(
                            "https://pbs.twimg.com/profile_images/1110319067280269312/iEqpsbUA_400x400.png"),
                  ),
                  title: Text(contactssnap[index].name),
                  subtitle: Text(contactssnap[index].phone == null ? "" : contactssnap[index].phone),
                ),
              ),
            );
          },
          itemCount: contactssnap.length,
        ),
      ),
    );
  }
}
