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
  TextEditingController editingController = TextEditingController();
  final List<Contact> filteredList = List<Contact>();

  List<Contact> tempList = List<Contact>();
  copyListData(List<Contact> copiedData) {
    tempList.clear();
    filteredList.clear();
    tempList.addAll(copiedData);
    filteredList.addAll(tempList);
  }

  void filterSearch(String query) {
    List<Contact> dummySearchList = List<Contact>();
    dummySearchList.addAll(tempList);

    if (query.isNotEmpty) {
      List<Contact> tempListWithData = List<Contact>();
      dummySearchList.forEach((element) {
        if (element.name.contains(query)) {
          tempListWithData.add(element);
        }
      });
      setState(() {
        filteredList.clear();
        filteredList.addAll(tempListWithData);
      });
      return;
    } else {
      setState(() {
        filteredList.clear();
        filteredList.addAll(tempList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactssnap = Provider.of<List<Contact>>(context) ?? [];
    copyListData(contactssnap);

    return StreamProvider<List<Contact>>.value(
      value: DatabaseService().contactssnap,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("ContactsApp")),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (value) {
                  filterSearch(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContactDetails(filteredList[index])));
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: filteredList[index].imageurl != ""
                            ? NetworkImage(filteredList[index].imageurl)
                            : AssetImage("images/profile.jpg"),
                      ),
                      title: Text(filteredList[index].name),
                      subtitle: Text(filteredList[index].fathername ?? ""),
                    ),
                  ),
                );
              },
              itemCount: filteredList.length,
            ),
          ],
        ),
      ),
    );
  }
}
