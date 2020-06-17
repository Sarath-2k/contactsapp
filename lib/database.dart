import 'package:cloud_firestore/cloud_firestore.dart';
import './contact.dart';

class DatabaseService {
  final Query dat = Firestore.instance.collection('contacts').orderBy('name');

  List<Contact> _contactListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map(
          (e) => Contact(
              name: e.data['name'],
              address: e.data['address'],
              email: e.data['email'],
              bloodgrp: e.data['bloodgrp'],
              phone: e.data['phone'],
              whatsapp: e.data['whatsapp'],
              imageurl: e.data['imageurl'],
              fathername: e.data['fathername'],
              dob: e.data['dob'],
              dom: e.data['dom'],
              dod: e.data['dod'],
              secemail: e.data['secemail'],
              secphone: e.data['secphone']),
        )
        .toList();
  }

  Stream<List<Contact>> get contactssnap {
    return dat.snapshots().map(_contactListFromSnapshot);
  }
}
