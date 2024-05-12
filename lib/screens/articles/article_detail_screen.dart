//Third Party Imports
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/article_models.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';

class ArticleDetialScreen extends StatefulWidget {
  final Articles articleDetail;
  const ArticleDetialScreen({super.key, required this.articleDetail});

  @override
  State<ArticleDetialScreen> createState() => _ArticleDetialScreenState();
}

class _ArticleDetialScreenState extends State<ArticleDetialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF252849),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: BackAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat('EEEE , dd MMMM yyyy')
                    .format(widget.articleDetail.articleDate ?? DateTime.now()),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: openSansFonts.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SpacingUtils().horizontalSpacing(20),
              Text(
                widget.articleDetail.title ?? "Article Title",
                style: poppinsFonts.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 10,
                // overflow: TextOverflow.ellipsis,
              ),
              SpacingUtils().horizontalSpacing(20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: widget.articleDetail.image ?? "",
                    fit: BoxFit.cover,
                    height: 400,
                    width: 1000,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SpacingUtils().horizontalSpacing(20),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.white,
                    ],
                    begin: Alignment.center,
                    tileMode: TileMode.mirror,
                  ),
                ),
                width: double.infinity,
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.articleDetail.description ?? "None",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  maxLines: null,
                  // overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
