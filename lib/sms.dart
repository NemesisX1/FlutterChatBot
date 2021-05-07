import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Sms extends StatelessWidget {
  final String from;
  final String message;
  final double _fontSize = 15;

  Sms(this.from, this.message);

  Widget userSms(BuildContext context) {
    return (Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Card(
          margin: EdgeInsets.all(5),
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * (0.5),
              ),
              child: Text(this.message,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: _fontSize)),
            ),
          )),
    ]));
  }

  Widget botSms(BuildContext context) {
    return (Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(
          FontAwesomeIcons.robot,
          color: Theme.of(context).accentColor,
          size: 15,
        ),
        SizedBox(
          width: 8,
        ),
        Card(
            margin: EdgeInsets.all(5),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * (0.5),
                ),
                child: Text(
                  this.message,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Rubik',
                      fontSize: _fontSize),
                ),
              ),
            )),
      ]),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return (this.from == 'user' ? userSms(context) : botSms(context));
  }
}
