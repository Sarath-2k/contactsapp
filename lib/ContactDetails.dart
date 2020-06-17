import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'contact.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;
  ContactDetails(this.contact);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

Widget visibilityText(String key, String value) {
  return Visibility(
    visible: value != "",
    child: Padding(
      padding: const EdgeInsets.only(left: 4),
      child: ListTile(
        leading: Text(key),
        title: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    ),
  );
}

Widget emailTile(String email, Function emailFn) {
  return Visibility(
    visible: email != "",
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              child: Text(
            email,
            style: TextStyle(fontSize: 16),
          )),
          IconButton(icon: Icon(Icons.mail), onPressed: emailFn),
        ],
      ),
    ),
  );
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

  _secemailURL() async {
    String smsURL = "mailto:" + (widget.contact.secemail).toString();
    launch(smsURL);
  }

  _secphoneURL() async {
    String phoneURL = "tel:+91" + (widget.contact.secphone).toString();
    launch(phoneURL);
  }

  _secsmsURL() async {
    String smsURL = "sms:+91" + (widget.contact.secphone).toString();
    launch(smsURL);
  }

  @override
  Widget build(BuildContext context) {

    widget.contact.email ?? "osnu";

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Padding(
            padding: const EdgeInsets.all(36.0),
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
              padding: const EdgeInsets.only(left: 4, top: 8),
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
            visible: widget.contact.secphone != "",
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    widget.contact.secphone,
                    style: TextStyle(fontSize: 18),
                  )),
                  IconButton(icon: Icon(Icons.message), onPressed: _secsmsURL),
                  IconButton(icon: Icon(Icons.phone), onPressed: _secphoneURL),
                ],
              ),
            ),
          ),
          emailTile(widget.contact.email, _emailURL),
          emailTile(widget.contact.secemail, _secemailURL),
          visibilityText("Address:", widget.contact.address),
          visibilityText("Date of Birth:", widget.contact.dob),
          visibilityText("Date of Marriage:", widget.contact.dom),
          visibilityText("Date of Death:", widget.contact.dod),
          visibilityText("Blood group:", widget.contact.bloodgrp),
        ]),
      ),
    );
  }
}
