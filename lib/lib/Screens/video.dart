import 'package:flutter/material.dart';
// import 'package:telsavideo/models/Douyin.dart';
// import 'package:telsavideo/widgets/video_description.dart';
// import 'package:telsavideo/widgets/actions_toolbar.dart';
// import 'package:telsavideo/widgets/player.dart';

class VideoItem extends StatefulWidget {
  final Object data;
  final String videourl;
  const VideoItem({Key? key, required this.data, required this.videourl})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /* DouyinVideoPlayer(
            url: widget.videourl,
          ), */
          //title(),
          /* VideoDescription(
            description: widget.data.itemList[0].desc,
            musicName: widget.data.itemList[0].music.title,
            authorName: widget.data.itemList[0].music.author,
            userName: widget.data.itemList[0].author.nickname,
          ),
          ActionsToolbar(
            comments:
                widget.data.itemList[0].statistics.commentCount.toString(),
            userImg: widget.data.itemList[0].author.avatarMedium.urlList[0],
            favorite: widget.data.itemList[0].statistics.diggCount,
            coverImg: widget.data.itemList[0].music.covermedium.urlList[0],
          ), */
        ],
      ),
    );
  }
}
