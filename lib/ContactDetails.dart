import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'contact.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;
  ContactDetails(this.contact);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  _whatsappURL() async {
    String whatsappURL =
        "https://wa.me/91" + (widget.contact.whatsapp).toString();
    launch(whatsappURL);
  }

  _phoneURL() async {
    String phoneURL = "tel:+91" + (widget.contact.phone).toString();
    launch(phoneURL);
  }

  _smsURL() async {
    String smsURL = "sms:+91" + (widget.contact.phone).toString();
    launch(smsURL);
  }

  _emailURL() async {
    String smsURL = "mailto:" + (widget.contact.email).toString();
    launch(smsURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: widget.contact.imageurl != ""
                          ? NetworkImage(widget.contact.imageurl)
                          : AssetImage("images/profile.jpg"),
                      radius: 80,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.contact.name,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                visible: widget.contact.fathername != "",
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, top: 12),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      widget.contact.fathername,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.contact.phone != "",
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        widget.contact.phone,
                        style: TextStyle(fontSize: 18),
                      )),
                      Visibility(
                        visible: widget.contact.whatsapp != "",
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: InkWell(
                            onTap: _whatsappURL,
                            child: Container(
                              height: 32,
                              width: 32,
                              child: Image(
                                image: AssetImage("images/WhatsApp.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(icon: Icon(Icons.message), onPressed: _smsURL),
                      IconButton(icon: Icon(Icons.phone), onPressed: _phoneURL),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widget.contact.email != "",
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        widget.contact.email,
                        style: TextStyle(fontSize: 16),
                      )),
                      IconButton(icon: Icon(Icons.mail), onPressed: _emailURL),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widget.contact.address != "",
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      widget.contact.address,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.contact.bloodgrp != "",
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ListTile(
                    leading: Icon(
                      Icons.album,
                      color: Colors.red,
                    ),
                    title: Text(
                      widget.contact.bloodgrp,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
