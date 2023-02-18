import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:open_file/open_file.dart';

var selectedTheme = "normal";

theme(String mode) {
  switch (mode) {
    case "blue":
      return {
        "primary": Colors.blue,
        "accent": Colors.grey,
        "text": Colors.black,
        "background": Colors.white
      };
    case "black":
      return {
        "primary": Colors.red,
        "accent": Colors.white,
        "text": Colors.white,
        "background": Colors.black
      };
    case "normal":
      return {
        "primary": Colors.red,
        "accent": Colors.grey,
        "text": Colors.black,
        "background": Colors.white
      };
      break;
  }
}

Steemit steemit = new Steemit();

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

class Steemit {
  final String url = "https://api.steemit.com";
  final String devUrl = "https://api.steemitdev.com";

  Future getAll(user) async {
    var _temp0 = await steemit.getDiscussionsByHot();
    var _temp1 = await steemit.getDiscussionsByTrending();
    var _temp2 = await steemit.getDiscussionsByCreated();
    var _temp3 = await steemit.getDiscussionsByFeed(user);

    var _tempArray = [
      _temp0,
      _temp1,
      _temp2,
      _temp3,
    ];
    return _tempArray;
  }

  //get user data from user name
  Future getUserData(username) async {
    Dio dio = new Dio();
    {
      Response response =
          await dio.get("https://steemit.com/" + username + ".json");
      return response.data;
    }
  }

  Future getDiscussionsByHot() async {
    Dio dio = new Dio();
    Response response = await dio.get(url + "/getDiscussions?by=hot");
    return (response.data);
  }

  Future getTrendingTags() async {
    Dio dio = new Dio();
    {
      DateTime now = new DateTime.now();

      Response response = await dio.get(
          "https://api.asksteem.com/trending?q=meta.video.info.title:* AND created:>=" +
              now.year.toString() +
              "-" +
              now.month.toString() +
              "-" +
              now.day.toString() +
              "&types=tags&size=50");
      return (response.data);
    }
  }

  Future getTag(var tag) async {
    Dio dio = new Dio();
    {
      DateTime now = new DateTime.now();

      Response response = await dio.get(
          "https://api.asksteem.com/search?q=created:>=" +
              now.year.toString() +
              "-" +
              now.month.toString() +
              "-" +
              now.day.toString() +
              " AND meta.video.content.tags:dtube&include=meta,payout&sort_by=net_votes&pg=3&order=desc&types=post");
      print("https://api.asksteem.com/search?q=created:>=" +
          now.year.toString() +
          "-" +
          now.month.toString() +
          "-" +
          now.day.toString() +
          " AND meta.video.content.tags:dtube&include=meta,payout&sort_by=net_votes&pg=3&order=desc&types=post");
      return (response.data);
    }
  }

  Future getDiscussionsByTrending() async {
    Dio dio = new Dio();
    Response response =
        await dio.get("https://video.telsacoin.io/getDiscussions?by=trending");
    return (response.data);
  }

  Future getDiscussionsByCreated() async {
    Dio dio = new Dio();
    Response response =
        await dio.get("https://video.telsacoin.io/getDiscussions?by=created");
    return (response.data);
  }

  Future getDiscussionsByFeed(var user) async {
    Dio dio = new Dio();
    Response response = user != null
        ? await dio.post("https://api.steemit.com", data: {
            "id": "4",
            "jsonrpc": "2.0",
            "method": "call",
            "params": [
              "database_api",
              "get_discussions_by_feed",
              [
                {
                  "tag": user == null ? "bostrot" : user,
                  "limit": 100,
                  "truncate_body": 1
                }
              ]
            ]
          })
        : await dio.get("https://video.telsacoin.io/getDiscussions?by=feed");
    return (response.data);
  }

  Future getDiscussionsByBlog(var user) async {
    Dio dio = new Dio();
    Response response = await dio.post("https://api.steemit.com", data: {
      "id": 5,
      "jsonrpc": "2.0",
      "method": "call",
      "params": [
        "database_api",
        "get_discussions_by_blog",
        [
          {"tag": user, "limit": 100, "truncate_body": 1}
        ]
      ]
    });
    return (response.data);
  }

  Future getAccount(var user) async {
    Dio dio = new Dio();
    Response response = await dio.post("https://api.steemit.com", data: {
      "id": 6,
      "jsonrpc": "2.0",
      "method": "call",
      "params": [
        "database_api",
        "get_accounts",
        [
          [user]
        ]
      ]
    });
    return (response.data);
  }

  Future getDiscussionsBySearch(var search) async {
    Dio dio = new Dio();
    Response response =
        await dio.get("https://video.telsacoin.io/search?q=$search");
    return (response.data);
  }

  Future getSteemPrice() async {
    Dio dio = new Dio();
    Response response =
        await dio.get("https://api.coinmarketcap.com/v1/ticker/STEEM/");
    return (response.data);
  }
}

int toInt(double doub) {
  double multiplier = 100.0;
  return (multiplier * doub).round();
}

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
initializeNotifications() {
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('ic_launcher');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      // didReceiveLocalNotificationStream.add(
      //   ReceivedNotification(
      //     id: id,
      //     title: title,
      //     body: body,
      //     payload: payload,
      //   ),
      // );
    },
    notificationCategories: darwinNotificationCategories,
  );
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );

  //var initializationSettingsIOS = new initializationSettingsDarwin();
  var initializationSettings = new InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin!.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: (details) => {},
    onDidReceiveNotificationResponse: (payload) => onSelectNotification,
  );
}

Future<dynamic> onSelectNotification(String? payload) async {
  debugPrint('notification payload: ' + payload!);
  //OpenFile.open("/storage/emulated/0/Download/" + payload);
  /*await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    )*/
}

Future showNotification(String title, var body) async {
  print("showNotification");
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channel', 'Downloads',
      channelDescription: 'Notifications for finished downloads.',
      importance: Importance.max,
      priority: Priority.high);

  const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );

  const DarwinNotificationDetails macOSNotificationDetails =
      DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );

  //var iOSPlatformChannelSpecifics = new ();
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
  try {
    await flutterLocalNotificationsPlugin!
        .show(0, title, body, platformChannelSpecifics, payload: body);
  } catch (e) {
    print(e);
  }
}

broadcastVote(
    BuildContext context, String author, String permlink, int weight) async {
  var _tempAuthData = {
    "user": await retrieveData("user"),
    "key": await retrieveData("key")
  };
  Dio dio = new Dio();
  dio.options.headers = {
    'Content-Type': 'application/json',
    'authorization': _tempAuthData["key"]
  };
  Response response =
      await dio.post("https://v2.steemconnect.com/api/broadcast", data: {
    "operations": [
      [
        "vote",
        {
          "voter": _tempAuthData["user"].toString(),
          "author": author,
          "permlink": permlink,
          "weight": weight
        }
      ]
    ]
  });
  toast(context, "Voted sucessfully");
  return (response.data);
}

broadcastComment(
    BuildContext context, String author, String permlink, String text) async {
  var _tempAuthData = {
    "user": await retrieveData("user"),
    "key": await retrieveData("key")
  };
  var rng = new Random().nextInt(25);
  String randStr = rng.toString();
  Dio dio = new Dio();
  dio.options.headers = {
    'Content-Type': 'application/json',
    'authorization': await _tempAuthData["key"]
  };
  Response response =
      await dio.post("https://v2.steemconnect.com/api/broadcast", data: {
    "operations": [
      [
        "comment",
        {
          "parent_author": author,
          "parent_permlink": permlink,
          "author": _tempAuthData["user"].toString(),
          "permlink": randStr,
          "title": randStr,
          "body": text,
          "json_metadata": "{\"app\":\"dtube/0.7\"}"
        }
      ]
    ]
  });
  toast(context, "Commented sucessfully");
  return (response.data);
}

broadcastSubscribe(context, String author, bool subscribe) async {
  var _tempAuthData = {
    "user": await retrieveData("user"),
    "key": await retrieveData("key")
  };
  Dio dio = new Dio();
  dio.options.headers = {
    'Content-Type': 'application/json',
    'authorization': await _tempAuthData["key"]
  };
  Response response =
      await dio.post("https://v2.steemconnect.com/api/broadcast", data: {
    "operations": [
      [
        "custom_json",
        {
          "required_auths": [],
          "required_posting_auths": [_tempAuthData["user"].toString()],
          "id": "follow",
          "json": "[\"follow\",{\"follower\":\"" +
              _tempAuthData["user"] +
              "\",\"following\":\"" +
              author +
              "\",\"what\":[" +
              (subscribe ? "\"blog\"" : "\"\"") +
              ")]}]"
        }
      ]
    ]
  });
  toast(context, subscribe ? "Subscribed" : "Unsubscribed");
  return (response.data);
}

launchURL(var url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void saveData(var key, var data) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, data);
}

void saveDataMap(var key, List<String> data) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, data);
}

retrieveData(var key) async {
  final prefs = await SharedPreferences.getInstance();
  return (prefs.getString(key));
}

retrieveDataMap(var key) async {
  final prefs = await SharedPreferences.getInstance();
  return (prefs.getStringList(key));
}

String linkify(String text) {
  text = text.replaceAll("\\n", "\n");
  var urlPattern =
      r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  var result = new RegExp(urlPattern, caseSensitive: false).allMatches(text);

  for (Match m in result) {
    String? match = m.group(0);
    text = text.replaceFirst(
        match!, "<a href=\"" + match + "\">" + match + "</a>");
  }
  return text;
}

toast(context, text) {
  double _tempSpeed = text.length / 10;
  return Scaffold.of(context).showBottomSheet((context) => (new SnackBar(
        content: new Text(text),
        duration: Duration(seconds: _tempSpeed.round()),
      )));
}

void _showSnackBar(String msg, BuildContext context) {
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  });
}

String readTimestamp(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + 'DAY AGO';
    } else {
      time = diff.inDays.toString() + 'DAYS AGO';
    }
  }

  return time;
}

/// send tip
void showMsg(BuildContext context, String? title, String? msg,
    {int? time = 1200}) {
  Timer _timer = Timer(Duration(milliseconds: time!), () {
    Navigator.of(context).pop();
  });
  showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          content: SingleChildScrollView(
            child: Text(
              msg!,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).then((val) {
    if (_timer.isActive) {
      _timer.cancel();
    }
  });
}
