//Third Party Imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Local Imports
import 'package:playverse/app.dart';
import 'package:playverse/themes/app_font.dart';

class HeaderWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final int index;
  const HeaderWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.index});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: poppinsFonts.copyWith(
                color: Colors.grey.shade100,
                fontSize: 15,
              ),
            ),
            Text(
              widget.subTitle,
              style: poppinsFonts.copyWith(
                color: Colors.grey.shade100,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
        IconButton(
          onPressed: () => {tabManager.onTabChanged(widget.index)},
          icon: const Icon(
            FontAwesomeIcons.arrowRight,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class NoramlHeaderWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  const NoramlHeaderWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  State<NoramlHeaderWidget> createState() => _NoramlHeaderWidgetState();
}

class _NoramlHeaderWidgetState extends State<NoramlHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: poppinsFonts.copyWith(
                  color: Colors.grey.shade100,
                  fontSize: 15,
                ),
              ),
              Text(
                widget.subTitle,
                style: poppinsFonts.copyWith(
                  color: Colors.grey.shade100,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
