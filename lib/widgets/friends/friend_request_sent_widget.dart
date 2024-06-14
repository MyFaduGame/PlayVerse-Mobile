//Third Party Imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';

//Local Imports
import 'package:playverse/screens/profile/user_profile.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/models/friends_model.dart';
import 'package:playverse/provider/friends_provider.dart';

class SentFriendRequests extends StatefulWidget {
  const SentFriendRequests({super.key});

  @override
  State<SentFriendRequests> createState() => _SentFriendRequestsState();
}

class _SentFriendRequestsState extends State<SentFriendRequests> {
  late FriendListProvider provider;
  List<SentFriendRequest>? friendRequests;
  bool isLoading = true;

  bool loading = true, loader = false, paginateUpcoming = true;
  int offsetUpcoming = 1;

  Future<void> paginationFriends() async {
    if (!paginateUpcoming) return;
    setState(() {
      loader = true;
      isLoading = false;
    });
    await provider.getSentFriendRequests(offsetUpcoming).then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.sentFriendRequests.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<FriendListProvider>(context, listen: false);
    paginationFriends();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Selector<FriendListProvider, List<SentFriendRequest>?>(
            selector: (p0, p1) => p1.sentFriendRequests,
            builder: (context, value, child) {
              return value?.isEmpty ?? true
                  ? Center(
                      child: SizedBox(
                        width: screenWidth / 1.5,
                        child: NeoPopButton(
                          color: GeneralColors.neopopButtonMainColor,
                          bottomShadowColor: GeneralColors.neopopShadowColor,
                          onTapUp: () => {},
                          child: const NeoPopShimmer(
                            shimmerColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Text(
                                "All Set!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      itemCount: value?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: (value?[index].profileImage == null)
                                    ? "${value?[index].gender}" == 'Male'
                                        ? SvgPicture.asset(
                                            ProfileImages.boyProfile,
                                            height: 100,
                                          )
                                        : SvgPicture.asset(
                                            ProfileImages.girlProfile,
                                            height: 100,
                                          )
                                    : Image.network(
                                        value?[index].profileImage ??
                                            "https://images.unsplash.com/photo-1621155346337-1d19476ba7d6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGltYWdlfGVufDB8fDB8fHww",
                                        height: 100,
                                      ),
                              ),
                              FittedBox(
                                child: Text(
                                  "${value?[index].userName}",
                                  style: poppinsFonts.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6E17FF),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: IconButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => UserProfileScreen(
                                            userId:
                                                value?[index].userFriendId ??
                                                    "User Id",
                                          )),
                                    ),
                                  ),
                                  color: Colors.white,
                                  icon: const Icon(
                                    FontAwesomeIcons.info,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
            },
          );
  }
}
