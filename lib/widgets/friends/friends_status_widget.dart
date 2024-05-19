//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/models/user_status_model.dart';
import 'package:playverse/provider/user_status_provider.dart';

class FriendsStatusWidget extends StatefulWidget {
  const FriendsStatusWidget({super.key});

  @override
  State<FriendsStatusWidget> createState() => _FriendsStatusWidgetState();
}

class _FriendsStatusWidgetState extends State<FriendsStatusWidget> {
  late UserStatusProvider provider;
  List<UserStatus>? userStatusModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<UserStatusProvider>(context, listen: false);
    provider.getFriendsProvider().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userStatusModel =
        context.select((UserStatusProvider value) => value.userStatusModel);
    // ignore: prefer_is_empty
    if (userStatusModel?.length == 0 || userStatusModel == null) {
      return Center(
        child: Text(
          'Tell Your Friends to Play!',
          style: openSansFonts.copyWith(fontSize: 20, color: Colors.white,),
        ),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userStatusModel?.length ?? 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: userStatusModel?[index].userStatus == 'Online'
                          ? Colors.green
                          : Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: userStatusModel?[index].profileImage == ""
                          ? "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                          : userStatusModel?[index].profileImage ??
                              "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 10,
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
