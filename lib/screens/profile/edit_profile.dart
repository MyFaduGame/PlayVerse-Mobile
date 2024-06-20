//Third Party Imports
// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/models/location_model.dart';
import 'package:playverse/provider/location_provider.dart';
import 'package:playverse/utils/loader_dialouge.dart';
import 'package:playverse/utils/toast_bar.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/provider/user_profile_provider.dart';
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
  late LocationProvider locProvider;
  List<Country>? country;
  List<States>? state;
  List<City>? city;
  UserProfile? userProfile;
  bool isLoading = true;

  String? countryID;
  String? countryName;
  String? typeCountryName;
  String? stateID;
  String? typeStateName;
  String? stateName;
  String? cityID;
  String? typeCityName;
  String? cityName;

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
  String typeSelectedGender = '';

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    provider = Provider.of<UserProfileProvider>(context, listen: false);
    locProvider = Provider.of<LocationProvider>(context, listen: false);
    provider.getProfileInfoProvider().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    locProvider.getCountry().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    locProvider
        .getState(countryID ?? "31cdcc3f-48ae-4734-a2dd-7c86dd9e4c52")
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    locProvider
        .getCity(stateID ?? "31cdcc3f-48ae-4734-a2dd-7c86dd9e4c53")
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userProfile =
        context.select((UserProfileProvider value) => value.userModel);
    typeCountryName = userProfile?.country ?? "";
    typeCityName = userProfile?.city ?? "";
    typeStateName = userProfile?.state ?? "";
    typeSelectedGender = userProfile?.gender ?? "";
    country = context.select((LocationProvider value) => value.countryData);
    state = context.select((LocationProvider value) => value.stateData);
    city = context.select((LocationProvider value) => value.cityData);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF000019),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: poppinsFonts.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              FontAwesomeIcons.bell,
              size: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
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
                          // placeholder: (context, url) =>
                          //     const CircularProgressIndicator(),
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
                    children: <Widget>[
                      Text(
                        'Personal Information',
                        style: poppinsFonts.copyWith(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
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
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                              ),
                              controller: firstNameController,
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
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                              ),
                              controller: lastNameController,
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
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                              ),
                              cursorColor: Colors.white,
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
                                // colo: Colors.white,
                                hintText:
                                    userProfile?.expirence.toString() ?? "",
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Country",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => {
                                showModalBottomSheet(
                                  backgroundColor: const Color(0xFF000033),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ListView.builder(
                                      itemCount: country?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () => {
                                                setState(() {
                                                  countryID =
                                                      country?[index].countryId;
                                                  countryName =
                                                      country?[index].country ??
                                                          "Country Name";
                                                  locProvider
                                                      .getState(countryID ??
                                                          "31cdcc3f-48ae-4734-a2dd-7c86dd9e4c52")
                                                      .then((value) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  }).then((value) => state =
                                                          context.select(
                                                              (LocationProvider
                                                                      value) =>
                                                                  value
                                                                      .stateData));
                                                }),
                                                Navigator.pop(context),
                                              },
                                              child: Text(
                                                country?[index].country ??
                                                    "Country Name",
                                                style: poppinsFonts.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              },
                              child: Container(
                                width: screenWidth / 2.5,
                                height: 70,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  countryName == null
                                      ? typeCountryName ?? ""
                                      : countryName ?? "",
                                  style: poppinsFonts.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                              "State",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => {
                                showModalBottomSheet(
                                  backgroundColor: const Color(0xFF000033),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ListView.builder(
                                      itemCount: state?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () => {
                                                setState(() {
                                                  stateID =
                                                      state?[index].stateId;
                                                  stateName =
                                                      state?[index].state ??
                                                          "State Name";
                                                  locProvider
                                                      .getCity(stateID ??
                                                          "31cdcc3f-48ae-4734-a2dd-7c86dd9e4c53")
                                                      .then((value) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  }).then((value) => city =
                                                          context.select(
                                                              (LocationProvider
                                                                      value) =>
                                                                  value
                                                                      .cityData));
                                                }),
                                                Navigator.pop(context)
                                              },
                                              child: Text(
                                                state?[index].state ??
                                                    "State Name",
                                                style: poppinsFonts.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              },
                              child: Container(
                                width: screenWidth / 2.5,
                                height: 70,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    stateName == null
                                        ? typeStateName ?? ""
                                        : stateName ?? "",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 2.5,
                        child: Column(
                          children: [
                            Text(
                              "City",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => {
                                showModalBottomSheet(
                                  backgroundColor: const Color(0xFF000033),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ListView.builder(
                                      itemCount: city?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () => {
                                                setState(() {
                                                  cityID = city?[index].cityId;
                                                  cityName =
                                                      city?[index].city ??
                                                          "city Name";
                                                }),
                                                Navigator.pop(context)
                                              },
                                              child: FittedBox(
                                                child: Text(
                                                  city?[index].city ??
                                                      "City Name",
                                                  style: poppinsFonts.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              },
                              child: Container(
                                width: screenWidth / 2.5,
                                height: 70,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    cityName == null
                                        ? typeCityName ?? ""
                                        : cityName ?? "",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Male',
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.white;
                          },
                        ),
                        groupValue: selectedGender == ''
                            ? typeSelectedGender
                            : selectedGender,
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
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.white;
                          },
                        ),
                        groupValue: selectedGender == ''
                            ? typeSelectedGender
                            : selectedGender,
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
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.white;
                          },
                        ),
                        groupValue: selectedGender == ''
                            ? typeSelectedGender
                            : selectedGender,
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
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Text(
                        'Social Edit',
                        style: poppinsFonts.copyWith(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Instagram",
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                    ),
                    controller: instaController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
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
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                    ),
                    controller: fbController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: userProfile?.fbURL.toString() ?? "",
                      hintStyle: poppinsFonts.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    "Twitch",
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                    ),
                    controller: twitchController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: userProfile?.twURL.toString() ?? "",
                      hintStyle: poppinsFonts.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    "YouTube",
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                    ),
                    controller: ytController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: userProfile?.ytURL.toString() ?? "",
                      hintStyle: poppinsFonts.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 150),
                  // SizedBox(
                  //   width: screenWidth / 1.5,
                  //   child: NeoPopButton(
                  //     color: GeneralColors.neopopButtonMainColor,
                  //     bottomShadowColor: GeneralColors.neopopShadowColor,
                  //     onTapUp: () => {
                  //       if (base64String != "")
                  //         {data['profile_image'] = base64String},
                  //       if (firstNameController.text.isNotEmpty)
                  //         {data["first_name"] = firstNameController.text},
                  //       if (lastNameController.text.isNotEmpty)
                  //         {data["last_name"] = lastNameController.text},
                  //       if (instaController.text.isNotEmpty)
                  //         {data["insta_link"] = instaController.text},
                  //       if (fbController.text.isNotEmpty)
                  //         {data["fb_link"] = fbController.text},
                  //       if (twitchController.text.isNotEmpty)
                  //         {data["twitch_link"] = twitchController.text},
                  //       if (ytController.text.isNotEmpty)
                  //         {data["yt_link"] = ytController.text},
                  //       if (selectedGender.isNotEmpty)
                  //         {data["gender"] = selectedGender},
                  //       if (experienceController.text.isNotEmpty)
                  //         {data["expirence"] = experienceController.text},
                  //       if (countryID != null) {data["country"] = countryID},
                  //       if (stateID != null) {data["state"] = stateID},
                  //       if (cityID != null) {data["city"] = cityID},
                  //       if (selectedGender != '')
                  //         {data["gender"] = selectedGender},
                  //       updateProfile(data),
                  //     },
                  //     child: const NeoPopShimmer(
                  //       shimmerColor: Colors.white,
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 20, vertical: 15),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text(
                  //               "Update Profile",
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () => {
          if (base64String != "") {data['profile_image'] = base64String},
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
          if (selectedGender.isNotEmpty) {data["gender"] = selectedGender},
          if (experienceController.text.isNotEmpty)
            {data["expirence"] = experienceController.text},
          if (countryID != null) {data["country"] = countryID},
          if (stateID != null) {data["state"] = stateID},
          if (cityID != null) {data["city"] = cityID},
          if (selectedGender != '') {data["gender"] = selectedGender},
          updateProfile(data),
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.teal.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 50,
          width: screenWidth - 50,
          child: Center(
            child: Text(
              "Edit Profile",
              style: poppinsFonts.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  BuildContext? loaderCTX;
  Future<void> updateProfile(Map<String, dynamic> data) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        loaderCTX = ctx;
        return Center(
          child: Image.asset(
            getRandomImage(),
          ),
        );
      },
    ).then((value) => loaderCTX = null);

    provider.updateProfileProvider(data).then((value) => {
          if (value != true)
            {
              if (loaderCTX != null) Navigator.pop(loaderCTX!),
              Navigator.pop(context),
            }
          else
            {
              if (loaderCTX != null) Navigator.pop(loaderCTX!),
              Navigator.pop(context),
            },
          // Navigator.pop(context),
        });
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
