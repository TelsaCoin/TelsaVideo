/* import 'package:flutter/material.dart';
//import 'package:money_formatter/money_formatter.dart';
import 'package:telsavideo/common/icons.dart';

class ActionsToolbar extends StatelessWidget {
  final int favorite;
  final String comments;
  final String userImg;
  final String coverImg;

  const ActionsToolbar(
      {Key? key,
      required this.favorite,
      required this.comments,
      required this.userImg,
      required this.coverImg});

  static const double ActionWidgetSize = 60.0;
  static const double ActionIconSize = 35.0;
  static const double ShareActionIconSize = 25.0;
  static const double ProfileImageSize = 50.0;
  static const double PlusIconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    MoneyFormatter fmf =
        MoneyFormatter(amount: double.parse(favorite.toString()));

    MoneyFormatter fmf2 = MoneyFormatter(amount: double.parse(comments));

    return Align(
        alignment: Alignment.bottomRight,
        widthFactor: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getFollowAction(),
            _getSocialAction(
                icon: DouyinIcons.heart,
                title: '${fmf.output.compactNonSymbol}'),
            _getSocialAction(
                icon: DouyinIcons.chat_bubble,
                title: '${fmf2.output.compactNonSymbol}'),
            _getSocialAction(
                icon: DouyinIcons.reply, title: '分享', isShare: true),
            _getMusicPlayerAction()
          ],
        ));
  }

  Widget _getSocialAction(
      {String? title, IconData? icon, bool isShare = false}) {
    return Container(
        margin: EdgeInsets.only(top: 15.0),
        width: 60.0,
        height: 60.0,
        child: Column(children: [
          Icon(icon, size: isShare ? 25.0 : 35.0, color: Colors.grey[300]),
          Padding(
            padding: EdgeInsets.only(top: isShare ? 5.0 : 2.0),
            child:
                Text(title!, style: TextStyle(fontSize: isShare ? 10.0 : 12.0)),
          )
        ]));
  }

  Widget _getFollowAction({String? pictureUrl}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        width: 60.0,
        height: 60.0,
        child: Stack(children: [_getProfilePicture(), _getPlusIcon()]));
  }

  Widget _getPlusIcon() {
    return Positioned(
      bottom: 0,
      left: ((ActionWidgetSize / 2) - (PlusIconSize / 2)),
      child: Container(
          width: PlusIconSize, // PlusIconSize = 20.0;
          height: PlusIconSize, // PlusIconSize = 20.0;
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 43, 84),
              borderRadius: BorderRadius.circular(15.0)),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 20.0,
          )),
    );
  }

  Widget _getProfilePicture() {
    return Positioned(
        left: (ActionWidgetSize / 2) - (ProfileImageSize / 2),
        child: Container(
            //padding:EdgeInsets.all(1.0), // Add 1.0 point padding to create border
            height: ProfileImageSize, // ProfileImageSize = 50.0;
            width: ProfileImageSize, // ProfileImageSize = 50.0;
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              //borderRadius: BorderRadius.circular(ProfileImageSize / 2)),
              image: DecorationImage(
                  image: NetworkImage(
                    userImg,
                  ),
                  fit: BoxFit.cover),
            )));
  }

  LinearGradient get musicGradient => LinearGradient(colors: [
        Colors.grey[800]!,
        Colors.grey[900]!,
        Colors.grey[900]!,
        Colors.grey[800]!
      ], stops: [
        0.0,
        0.4,
        0.6,
        1.0
      ], begin: Alignment.bottomLeft, end: Alignment.topRight);

  Widget _getMusicPlayerAction() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        width: ActionWidgetSize,
        height: ActionWidgetSize,
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(11.0),
            height: ProfileImageSize,
            width: ProfileImageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: musicGradient,
              border: Border.all(color: Colors.black87, width: 11.0),
              image: DecorationImage(
                image: NetworkImage(coverImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]));
  }
}
 */