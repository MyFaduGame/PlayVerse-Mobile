//Third Party Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playverse/app.dart';

//Local Imports
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
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment:
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
          onPressed: () =>
              {HapticFeedback.vibrate(), tabManager.onTabChanged(widget.index)},
          // onPressed: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: ((context) => widget.screenName),
          //       ),
          //     ),
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
