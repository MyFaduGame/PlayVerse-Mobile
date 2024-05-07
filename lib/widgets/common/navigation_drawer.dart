//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

//Local Imports
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/widgets/common/navigation_drawer_widget.dart';

class NavigationBarCustom extends StatefulWidget {
  final AdvancedDrawerController controller;
  final int index;
  final Widget childBody;
  final UserProfile userProfile;
  const NavigationBarCustom(
      {super.key,
      required this.controller,
      required this.childBody,
      required this.index,
      required this.userProfile});

  @override
  State<NavigationBarCustom> createState() => _NavigationBarCustomState();
}

class _NavigationBarCustomState extends State<NavigationBarCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController animateController;
  @override
  void initState() {
    super.initState();
    animateController = AnimationController(vsync: this);
    log(widget.index.toString(), name: 'index');
  }

  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      animationController: animateController,
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: GeneralColors.sideEclipseColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: widget.controller,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(
        milliseconds: 800,
      ),
      animateChildDecoration: true,
      rtlOpening: true,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      drawer: NavigationBarWidget(
        userProfile: widget.userProfile,
        index: widget.index,
        controller: widget.controller,
      ),
      child: widget.childBody,
    );
  }
}
