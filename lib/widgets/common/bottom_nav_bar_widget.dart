import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playverse/app.dart';
import 'package:playverse/themes/app_images.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int bottomIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 25,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: bottomIndex,
      onTap: (value) => {
        setState(() {
          if (value == 0) {
            Navigator.pop(context);
            tabManager.onTabChanged(0);
            bottomIndex = value;
          } // Home Page
          if (value == 1) {
            Navigator.pop(context);
            tabManager.onTabChanged(1);
            bottomIndex = value;
          } // Tournaments Page
          if (value == 2) {
            Navigator.pop(context);
            tabManager.onTabChanged(2);
            bottomIndex = value;
          } // Streams Page
          if (value == 3) {
            Navigator.pop(context);
            tabManager.onTabChanged(9);
            bottomIndex = value;
          } // Friends Page
          if (value == 4) {
            Navigator.pop(context);
            tabManager.onTabChanged(10);
            bottomIndex = value;
          } // Store Page
        })
      },
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
          ),
          label: "",
          activeIcon: Icon(
            FontAwesomeIcons.houseUser,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            BottomAppBarImages.tournamentImageUnFill,
            color: Colors.grey,
            height: 25,
            width: 25,
          ),
          label: "",
          activeIcon: Image.asset(
            BottomAppBarImages.tournamentImageFill,
            color: Colors.white,
            height: 25,
            width: 25,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            BottomAppBarImages.streamUnFill,
            color: Colors.grey,
            height: 25,
            width: 25,
          ),
          label: "",
          activeIcon: Image.asset(
            BottomAppBarImages.streamFill,
            color: Colors.white,
            height: 25,
            width: 25,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            BottomAppBarImages.friendsUnFill,
            color: Colors.grey,
            height: 25,
            width: 25,
          ),
          label: "",
          activeIcon: Image.asset(
            BottomAppBarImages.friendsFill,
            color: Colors.white,
            height: 25,
            width: 25,
          ),
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.bagShopping,
            color: Colors.grey,
          ),
          label: "",
          activeIcon: Icon(
            FontAwesomeIcons.bagShopping,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
