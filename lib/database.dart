import 'package:cloud_firestore/cloud_firestore.dart';
import './contact.dart';

class DatabaseService {
  final CollectionReference contactCollection =
      Firestore.instance.collection('contacts');

  List<Contact> _contactListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((e) => Contact(
            name: e.data['name'],
            address: e.data['address'],
            email: e.data['email'],
            bloodgrp: e.data['bloodgrp'],
            phone: e.data['phone'],
            whatsapp: e.data['whatsapp'],
            imageurl: e.data['imageurl']))
        .toList();
  }

  Stream<List<Contact>> get contactssnap {
    return contactCollection.snapshots().map(_contactListFromSnapshot);
  }
}
