import 'package:flutter/material.dart';

class CustomCenteredRow extends StatelessWidget {
  final List<Widget> children;

  CustomCenteredRow({@required this.children});

  @override
  Widget build(BuildContext context) {
    return (Row(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Row(
          children: children,
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    ));
  }
}

class CustomCenteredColumn extends StatelessWidget {
  final List<Widget> children;

  CustomCenteredColumn({@required this.children});

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Column(
          children: children,
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    ));
  }
}

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key key, @required this.compenants}) : super(key: key);
  final List<Widget> compenants;

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          spreadRadius: 1,
          blurRadius: 1,
        )
      ]),
      child: SafeArea(
        child: Row(
          children: this.compenants,
        ),
      ),
    );
  }
}
