//Third Party Imports
import 'package:flutter/cupertino.dart';

class SpacingUtils {
  horizontalSpacing(double? size) {
    return SizedBox(
      height: size ?? 10,
    );
  }

  // static bool scrollNotifier(Object? notification, VoidCallback callback) {
  //   if (notification is ScrollEndNotification) {
  //     final before = notification.metrics.extentBefore;
  //     final max = notification.metrics.maxScrollExtent;

  //     if (before == max) callback();
  //   }
  //   return false;
  // }
}

class Utils {
  static Future showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        useRootNavigator: false,
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [child],
          cancelButton: CupertinoActionSheetAction(
            onPressed: onClicked,
            child: const Text('Select'),
          ),
        ),
      );
  static bool scrollNotifier(Object? notification, VoidCallback callback) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max) callback();
    }
    return false;
  }
  // static void showSnackBar(String text) {
  //   final snackBar = SnackBar(
  //     content: Text(text),
  //     behavior: SnackBarBehavior.floating,
  //   );

  // Keys.messangerKey.currentState!
  //   ..removeCurrentSnackBar()
  //   ..showSnackBar(snackBar);
}

  // static void toastMessage(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //     fontSize: 16,
  //   );
  // }

  // static void toast(String msg) =>
  //     Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);

  // static Future<List<String>> imagesToBase64(List<File> images) async {
  //   List<String> base64 = [];
  //   for (var e in images) {
  //     String temp = base64Encode(e.readAsBytesSync());
  //     base64.add(temp);
  //   }
  //   return base64;
  // }

  // static bool isEmail(String email) {
  //   String p =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regExp = RegExp(p);

  //   return regExp.hasMatch(email);
  // }

  // static bool isPhone(String input) {
  //   return RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
  //       .hasMatch(input);
  // }

  // static bool isNum(String input) => int.tryParse(input) != null;

