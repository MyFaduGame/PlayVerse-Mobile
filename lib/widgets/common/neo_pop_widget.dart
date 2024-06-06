//Third Party Imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';

//Local Imports
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';

class NeoPopButtonWidget extends StatefulWidget {
  final String text;
  final String? textImage;
  final VoidCallback navigation;
  const NeoPopButtonWidget({
    super.key,
    required this.text,
    this.textImage,
    required this.navigation,
  });

  @override
  State<NeoPopButtonWidget> createState() => _NeoPopButtonWidgetState();
}

class _NeoPopButtonWidgetState extends State<NeoPopButtonWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth / 1.5,
      child: NeoPopButton(
        color: GeneralColors.neopopButtonMainColor,
        bottomShadowColor: GeneralColors.neopopShadowColor,
        onTapUp: widget.navigation,
        child: NeoPopShimmer(
          shimmerColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.textImage != null)
                  SvgPicture.asset(
                      widget.textImage ?? AuthScreenImages.loginIcon),
                Text(
                  widget.text,
                  style: poppinsFonts.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
