//Third Party Imports
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';
import 'package:playverse/utils/toast_bar.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/widgets/common/back_app_bar_widget.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/provider/user_profile_provider.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  String? selectCountry;
  String base64String = "";
  late UserProfileProvider provider;
  UserProfile? userProfile;
  bool isLoading = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController fbController = TextEditingController();
  TextEditingController twitchController = TextEditingController();
  TextEditingController ytController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime dateTime = DateTime.now().subtract(const Duration(days: 365 * 18));

  bool hasTwitch = false;
  bool hasInsta = false;
  bool hasFb = false;
  bool hasYoutube = false;
  String selectedGender = '';

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    provider = Provider.of<UserProfileProvider>(context, listen: false);
    provider.getProfileInfoProvider().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userProfile =
        context.select((UserProfileProvider value) => value.userModel);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: BackAppBar(),
      ),
      body: Container(
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              GeneralColors.gradientBackgrounColor0,
              GeneralColors.gradientBackgrounColor1
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7F00FF).withOpacity(0.3),
                      spreadRadius: screenWidth * 0.40,
                      blurRadius: screenWidth * 0.300,
                    ),
                  ],
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(200, 200)),
                ),
              ),
            ),
            Positioned(
              top: screenHeight - 100,
              left: screenWidth - 100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7F00FF).withOpacity(0.3),
                      spreadRadius: screenWidth * 0.20,
                      blurRadius: screenWidth * 0.145,
                    ),
                  ],
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(200, 200)),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 100),
                  GestureDetector(
                    onTap: () => pickFileAndSendBase64(),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(
                          75,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: userProfile?.profileImage == null ||
                                userProfile?.profileImage == ""
                            ? userProfile?.gender == 'Male'
                                ? SvgPicture.asset(
                                    ProfileImages.boyProfile,
                                    width: 125,
                                    height: 125,
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    ProfileImages.girlProfile,
                                    width: 125,
                                    height: 125,
                                    fit: BoxFit.cover,
                                  )
                            : CachedNetworkImage(
                                imageUrl: userProfile?.profileImage == "" ||
                                        userProfile?.profileImage == null
                                    ? "https://img.freepik.com/premium-vector/business-people-with-star-logo-template-icon-illustration-brand-identity-isolated-flat-illustration-vector-graphic_7109-1981.jpg"
                                    : userProfile?.profileImage ?? "",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: screenWidth / 2.5,
                              child: Column(
                                children: [
                                  Text(
                                    "First Name",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: firstNameController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue, width: 1.0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: userProfile?.firstName ?? "",
                                      hintStyle: poppinsFonts.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 2.5,
                              child: Column(
                                children: [
                                  Text(
                                    "Last Name",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: lastNameController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue, width: 1.0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: userProfile?.lastName ?? "",
                                      hintStyle: poppinsFonts.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: screenWidth / 2.5,
                              child: Column(
                                children: [
                                  Text(
                                    "Experience",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: experienceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue, width: 1.0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText:
                                          userProfile?.expirence.toString() ??
                                              "",
                                      hintStyle: poppinsFonts.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: screenWidth / 2.5,
                            //   child: Column(
                            //     children: [
                            //       Text(
                            //         "Date of Birth",
                            //         style: poppinsFonts.copyWith(
                            //           color: Colors.white,
                            //           fontSize: 15,
                            //         ),
                            //       ),
                            //       const SizedBox(height: 8),
                            //       TextField(
                            //         controller: dobController,
                            //         onTap: () => {buildDatePicker()},
                            //         decoration: InputDecoration(
                            //           enabledBorder: OutlineInputBorder(
                            //               borderSide: const BorderSide(
                            //                   color: Colors.white, width: 1.0),
                            //               borderRadius:
                            //                   BorderRadius.circular(15)),
                            //           focusedBorder: OutlineInputBorder(
                            //             borderSide: const BorderSide(
                            //                 color: Colors.blue, width: 1.0),
                            //             borderRadius: BorderRadius.circular(15),
                            //           ),
                            //           hintText: userProfile?.dob ?? "None",
                            //           hintStyle: poppinsFonts.copyWith(
                            //             color: Colors.white,
                            //             fontSize: 20,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        Text(
                          "Instagram",
                          style: poppinsFonts.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: instaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: userProfile?.instaURL.toString() ?? "",
                            hintStyle: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          "FaceBook",
                          style: poppinsFonts.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: fbController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: userProfile?.fbURL.toString() ?? "",
                            hintStyle: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 'Male',
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.white;
                                },
                              ),
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value as String;
                                });
                              },
                            ),
                            Text(
                              "Male",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Radio(
                              value: 'Female',
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.white;
                                },
                              ),
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value as String;
                                });
                              },
                            ),
                            Text(
                              "Female",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Radio(
                              value: 'Other',
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.white;
                                },
                              ),
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value as String;
                                });
                              },
                            ),
                            Text(
                              "Other",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: screenWidth / 1.5,
                          child: NeoPopButton(
                            color: GeneralColors.neopopButtonMainColor,
                            bottomShadowColor: GeneralColors.neopopShadowColor,
                            onTapUp: () => {
                              HapticFeedback.vibrate(),
                              if (base64String != "")
                                {data['profile_image'] = base64String},
                              if (firstNameController.text.isNotEmpty)
                                {data["first_name"] = firstNameController.text},
                              if (lastNameController.text.isNotEmpty)
                                {data["last_name"] = lastNameController.text},
                              if (instaController.text.isNotEmpty)
                                {data["insta_link"] = instaController.text},
                              if (fbController.text.isNotEmpty)
                                {data["fb_link"] = fbController.text},
                              if (twitchController.text.isNotEmpty)
                                {data["twitch_link"] = twitchController.text},
                              if (ytController.text.isNotEmpty)
                                {data["yt_link"] = ytController.text},
                              if (selectedGender.isNotEmpty)
                                {data["gender"] = selectedGender},
                              if (experienceController.text.isNotEmpty)
                                {data["expirence"] = experienceController.text},
                              provider.updateProfileProvider(data).then(
                                    (value) => Navigator.pop(context),
                                  )
                            },
                            child: const NeoPopShimmer(
                              shimmerColor: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Update Profile",
                                      style: TextStyle(
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickFileAndSendBase64() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        File file = File(filePath);
        List<int> fileBytes = await file.readAsBytes();
        base64String = base64Encode(fileBytes);
      }
    } else {
      log("No file selected");
      showCustomToast("No File Selected");
    }
  }

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: 1950,
          maximumYear: DateTime.now().year - 18,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) => setState(() => dateTime = value),
        ),
      );
}
