//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/models/article_models.dart';
import 'package:playverse/provider/article_provider.dart';
import 'package:playverse/screens/articles/article_detail_screen.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/helper_utils.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late ArticlesProvider provider;
  List<Articles>? articlesList;
  bool isLoading = true;

  bool loading = true, loader = false, paginateUpcoming = true;
  int offsetUpcoming = 1;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ArticlesProvider>(context, listen: false);
    paginationArticles();
  }

  Future<void> paginationArticles() async {
    if (!paginateUpcoming) return;
    setState(() {
      loader = true;
      isLoading = false;
    });
    await provider.getArticles(offsetUpcoming).then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Selector<ArticlesProvider, List<Articles>?>(
            selector: (p0, p1) => p1.articlesList,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, paginationArticles),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: value?.length,
                    itemBuilder: (BuildContext context, int index) {
                      // ignore: prefer_is_empty
                      return value?.length == 0
                          ? Center(
                              child: Text(
                                "No Articles to Display",
                                style:
                                    poppinsFonts.copyWith(color: Colors.white),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetialScreen(
                                    articleDetail: value![index],
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                height: 250,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: value?[index].image ?? "",
                                          fit: BoxFit.cover,
                                          // width: 1000,
                                          // placeholder: (context, url) =>
                                          //     const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      value?[index].title ?? "Article Title",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: poppinsFonts.copyWith(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            value?[index].description ??
                                                "Article Description",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: openSansFonts.copyWith(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: Colors.pink[200],
                                          ),
                                          child: IconButton(
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleDetialScreen(
                                                  articleDetail: value![index],
                                                ),
                                              ),
                                            ),
                                            color: Colors.white,
                                            icon: const Icon(
                                              FontAwesomeIcons.arrowRightLong,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ),
              );
            },
          );
  }
}
