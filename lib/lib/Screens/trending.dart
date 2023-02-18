import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
//import 'package:getflutter/getflutter.dart';
import 'package:telsavideo/config/api.dart';
//import 'package:telsavideo/models/Douyin.dart';
import 'package:telsavideo/screens/loading/loading.dart';
import 'package:telsavideo/screens/video.dart';

class Trending extends StatefulWidget {
  Trending({required Key key}) : super(key: key);
  State<StatefulWidget> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  late PageController pageController;
  late BuildContext context;
  RequestController api = RequestController();
  List<Widget> videos = [];
  late VideoItem firstItem;
  bool isloaded = false;
  int length = 0;
  Future<void> getTrending() async {
    try {
      var dio = new Dio();
      dio.options.headers = api.headers;
      //var response = await dio.get(RequestController.url);
      /* Douyin tiktok = Douyin.fromJson(jsonDecode(response.data));
      tiktok.billboardData.forEach(
        (item) {
          setState(() {
            getVideos(item).then((value) => {
                  print(value),
                  if (value == 50) {print('videos length: ${videos.length}')}
                });
          });
        },
      ); */
      setState(() {
        isloaded = true;
      });
    } catch (ex) {
      print('Hot videos list is empty');
      print(ex);
    }
  }

  /* Future<int> getVideos(BillboardData v) async {
    try {
      var url = v.link.split("/")[5];
      var dio = new Dio();
      dio.options.headers = api.headers;
      var response = await dio.get(api.video + url + "&dytk");
      /* VideoData videoData = VideoData.fromJson(jsonDecode(response.data));
      //获取无水印的视频地址
      api
          .getRedirects(videoData.itemList[0].video.playaddr.uri)
          .then((url) => {
                url = url.replaceAll('&amp;', '&'),
                if (url != 'error')
                  {
                    if (length == 0)
                      {
                        firstItem = new VideoItem(
                          data: videoData,
                          videourl: url,
                        )
                      },
                    videos.add(VideoItem(
                      data: videoData,
                      videourl: url,
                    )),
                  }
              })
          .whenComplete(() => {length++}); */
    } catch (ex) {
      print(ex);
    }
    return length;
  } */

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true)
      ..addListener(() {
        print(pageController.position.extentAfter);
        if (pageController.position.pixels <
            pageController.position.maxScrollExtent) {
          //load more data
        }
      });
    getTrending()
        .then((value) => print('videos ${videos.length} was finished!'));
    if (SchedulerBinding.instance!.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance!
          .addPostFrameCallback((_) => print('videos is loading!'));
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context = context;
    WidgetsBinding.instance!.addPostFrameCallback((callback) {
      // executes after build
      print(callback.inMilliseconds);
      if (callback.inMilliseconds > 0) {
        pageController.animateToPage(0,
            duration: Duration(milliseconds: 2), curve: Curves.ease);
        print(videos.length);
      }
    });
    return PageView(
        scrollDirection: Axis.vertical,
        controller: pageController,
        // itemCount: videos.length,
        // itemBuilder: (context, index) {
        //   print('index: $index, videos length:${videos.length}');
        //   if (videos.length == 0) {
        //     return Container(
        //       color: Colors.black,
        //       child: Center(
        //         child: GFLoader(
        //           type: GFLoaderType.circle,
        //           loaderColorOne: Colors.blueAccent,
        //           loaderColorTwo: Colors.white,
        //           loaderColorThree: Colors.pink,
        //         ),
        //       ),
        //     );
        //   } else {
        //     return videos[index];
        //   }
        // },
        //}
        //);
        children: videos.length == 0
            ? <Widget>[
                loading,
              ]
            : videos);
  }
}
