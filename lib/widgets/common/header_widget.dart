import 'package:flutter/material.dart';
import 'package:playverse/themes/app_font.dart';

class HeaderWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  const HeaderWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          widget.title,
          style: poppinsFonts.copyWith(
            color: Colors.grey.shade100,
            fontSize: 24,
          ),
        ),
        Text(
          widget.subTitle,
          style: poppinsFonts.copyWith(
            color: Colors.grey.shade100,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
