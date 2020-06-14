import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact.dart';

class ContactDetails extends StatefulWidget {
  
  final Contact contact;
  ContactDetails(this.contact);
  
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}