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
  int flag = 0;

  List<Contact> tempList = List<Contact>();
  copyListData(List<Contact> copiedData) {
    tempList.clear();
    tempList.addAll(copiedData);
  }

  void filterSearch(String query) {
    List<Contact> dummySearchList = List<Contact>();
    dummySearchList.addAll(tempList);

    if (query.isNotEmpty) {
      List<Contact> tempListWithData = List<Contact>();
      dummySearchList.forEach((element) {
        if (element.name.toLowerCase().contains(query)) {
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

    if (flag == 0 && contactssnap.isNotEmpty) {
      filteredList.addAll(contactssnap);
      flag = 1;
    }

    return StreamProvider<List<Contact>>.value(
      value: DatabaseService().contactssnap,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("ContactsApp")),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 72,
              margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
              child: Material(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 12, left: 12, right: 12, top: 12),
                  child: TextField(
                    onChanged: (value) {
                      filterSearch(value.toLowerCase());
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        //hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
              ),
            ),
            filteredList.isEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 100, left: 28, right: 28),
                    child: Image(image: AssetImage("images/emptyList.png")),
                  )
                : Flexible(
                    child: ListView.builder(
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
                                        builder: (context) => ContactDetails(
                                            filteredList[index])));
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: filteredList[index].imageurl !=
                                        ""
                                    ? NetworkImage(filteredList[index].imageurl)
                                    : AssetImage("images/profile.jpg"),
                              ),
                              title: Text(filteredList[index].name),
                              subtitle:
                                  Text(filteredList[index].fathername ?? ""),
                            ),
                          ),
                        );
                      },
                      itemCount: filteredList.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
