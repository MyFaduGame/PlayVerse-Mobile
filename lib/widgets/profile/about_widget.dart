import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/screens/gems/gems_screen.dart';
import 'package:playverse/screens/profile/edit_profile.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/toast_bar.dart';

class AboutWidget extends StatefulWidget {
  final UserProfile userModel;
  const AboutWidget({
    super.key,
    required this.userModel,
  });

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const EditProfileScreen()),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Edit',
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const Icon(
                    FontAwesomeIcons.pen,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              width: 1,
              color: Colors.white,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Experience',
                  style: poppinsFonts.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.userModel.expirence.toString(),
                  style: poppinsFonts.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              height: 30,
              width: 1,
              color: Colors.white,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const GemsScreen()),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Gems',
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.userModel.gems.toString(),
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Table(
          children: <TableRow>[
            TableRow(
              children: <TableCell>[
                TableCell(
                  child: Text(
                    "ReferCode:",
                    style: poppinsFonts.copyWith(
                      color: const Color(0xFFBF99FF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TableCell(
                  child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                            text: widget.userModel.referCode.toString()),
                      ).then(
                        (value) => showCustomToast("Copied to ClipBoard"),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          widget.userModel.referCode.toString(),
                          style: poppinsFonts.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.copy,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            TableRow(
              children: <TableCell>[
                TableCell(
                  child: Text(
                    "Country:",
                    style: poppinsFonts.copyWith(
                      color: const Color(0xFFBF99FF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    widget.userModel.country ?? "Add Country",
                    style: poppinsFonts.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
            TableRow(
              children: <TableCell>[
                TableCell(
                  child: Text(
                    "State:",
                    style: poppinsFonts.copyWith(
                      color: const Color(0xFFBF99FF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    widget.userModel.state ?? "Add State",
                    style: poppinsFonts.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
            TableRow(
              children: <TableCell>[
                TableCell(
                  child: Text(
                    "City:",
                    style: poppinsFonts.copyWith(
                      color: const Color(0xFFBF99FF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    widget.userModel.city ?? "Add City",
                    style: poppinsFonts.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
