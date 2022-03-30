
import 'package:animator/animator.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/global.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptomarket/constance/global.dart' as globals;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptomarket/api/apiProvider.dart';
import 'package:cryptomarket/model/liveCryptoNewsModel.dart';
import 'package:cryptomarket/modules/news/newsDescription.dart';

class AppDrawer extends StatefulWidget {

  const AppDrawer({key}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

var appBarheight = 0.0;

class _AppDrawerState extends State<AppDrawer> {
  var appBarheight = 0.0;
  bool _isInProgress = false;

  late CryptoNewsLive cryptoNewsLive;

  @override
  void initState() {
    super.initState();
    getLatestNews();
  }

  getLatestNews() async {
    setState(() {
      _isInProgress = true;
    });
    cryptoNewsLive = await ApiProvider().cryptoNews('Bitcoin');
    setState(() {
      _isInProgress = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    return Container(
      color: AllCoustomTheme.getThemeData().primaryColor,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 16, top: 0),
        itemCount: cryptoNewsLive.articles!.length,
        itemBuilder: (BuildContext context, int index) {
          return Animator<double>(
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
            cycles: 1,
            builder: (_, anim, __) => Transform.scale(
              scale: anim.value,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) => NewsDescription(
                        title: cryptoNewsLive.articles![index].title,
                        url: cryptoNewsLive.articles![index].url,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    MagicBoxGradiantLine(
                      height: 3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(27),
                        ),
                        color: AllCoustomTheme.boxColor(),
                      ),
                      child: Column(
                        children: <Widget>[
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            margin: EdgeInsets.all(0),
                            // ignore: unnecessary_null_comparison
                            child: cryptoNewsLive.articles![index] != null &&
                                // ignore: unnecessary_null_comparison
                                cryptoNewsLive.articles![index].urlToImage != null &&
                                cryptoNewsLive.articles![index].urlToImage != ''
                                ? CachedNetworkImage(
                              errorWidget: (context, url, error) => CircleAvatar(
                                backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                                child: Icon(
                                  Icons.error_outline,
                                ),
                              ),
                              imageUrl: cryptoNewsLive.articles![index].urlToImage,
                              fit: BoxFit.fill,
                            )
                                : SizedBox(),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            // ignore: unnecessary_null_comparison
                            cryptoNewsLive.articles![index].title != null && cryptoNewsLive.articles![index].title != ""
                                ? cryptoNewsLive.articles![index].title
                                : "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE14,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              // ignore: unnecessary_null_comparison
                              cryptoNewsLive.articles![index].description != null &&
                                  cryptoNewsLive.articles![index].description != ""
                                  ? cryptoNewsLive.articles![index].description
                                  : "",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AllCoustomTheme.getsecoundTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Author',
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      // ignore: unnecessary_null_comparison
                                      cryptoNewsLive.articles![index].author != null && cryptoNewsLive.articles![index].author != ""
                                          ? cryptoNewsLive.articles![index].author
                                          : "",
                                      style: TextStyle(
                                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                      ),
                                    )
                                  ],
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      getConvertTime(
                                        cryptoNewsLive.articles![index].publishedAt.toString(),
                                      ),
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Animator<double>(
                                    tween: Tween<double>(begin: 0.8, end: 1.1),
                                    curve: Curves.easeInToLinear,
                                    cycles: 0,
                                    builder: (_, anim, __) => Transform.scale(
                                      scale: anim.value,
                                      child: Container(
                                        height: 28,
                                        width: 28,
                                        decoration: BoxDecoration(
                                          border: new Border.all(color: Colors.white, width: 1.5),
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              globals.buttoncolor1,
                                              globals.buttoncolor2,
                                            ],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 3),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
