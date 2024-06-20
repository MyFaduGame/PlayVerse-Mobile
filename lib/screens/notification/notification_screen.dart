//Third Party Imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Local Imports
import 'package:playverse/main.dart';
import 'package:playverse/themes/app_font.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000019),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          "Notifications",
          style: poppinsFonts.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {tabManager.onTabChanged(0)},
            icon: const Icon(
              FontAwesomeIcons.house,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
