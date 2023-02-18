// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:telsavideo/screens/login/hiveaccount.dart';
// import 'package:telsavideo/common/sizeconfig.dart';
// import 'package:telsavideo/screens/profile/profile.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// import 'login/auth.dart';

// var user;

// class Login1 extends StatefulWidget {
//   static const String id = "Login";

//   @override
//   State<StatefulWidget> createState() => _LoginState();
// }

// class _LoginState extends State<Login1> {
//   //StreamSubscription<User> loginStateSubscription;
//   final GlobalKey<ScaffoldState> _scaffoldKeyLogin =
//       new GlobalKey<ScaffoldState>();

//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//   late TapGestureRecognizer _myTapGestureRecognizer;

//   Dio dio = Dio();

//   String? _loggedInMessage;
//   bool showSpinner = false;
//   bool _rememberMe = false;
//   String? phoneNumber;
//   String? username;
//   String? password;
//   String? registrationToken;

//   late Map<String, dynamic> _profile;

//   bool _loading = false;

//   var user;

//   @override
//   void initState() {
//     super.initState();

//     _messaging.getToken().then((token) {
//       setState(() {
//         registrationToken = token;
//       });
//     });

//     _myTapGestureRecognizer = TapGestureRecognizer()
//       ..onTap = () {
//         launch('https://open.douyin.com/platform');
//       };
//   }

//   @override
//   void dispose() {
//     _myTapGestureRecognizer.dispose();
//     super.dispose();
//   }

//   void showInSnackBar(String value) {}

//   void sendOTP(String phoneNumber) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var map = Map<String, dynamic>();
//     map['mobile'] = phoneNumber;
//     map['user_id'] = prefs.getString('userId');

//     print(map.toString());
//     FormData formData = FormData.fromMap(map);

//     var response = await dio.post('https://api.telsacoin.io/public/sendOTP',
//         data: formData);
//     print(response.data);
//   }

//   Future<void> checkAuth() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isLoggedIn', true);
//     var isLoggedIn = (prefs.getBool('isLoggedIn') == null)
//         ? false
//         : prefs.getBool('isLoggedIn');

//     if (isLoggedIn!) {
//       // wrong call in wrong place!
//       Navigator.of(context)
//           .pushReplacement(MaterialPageRoute(builder: (context) => Profile()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authBloc = Provider.of<AuthBloc>(context);
//     SizeConfig().init(context);
//     checkAuth();
//     return Container(
//       color: Colors.white,
//       padding:
//           EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0, bottom: 50.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 color: Colors.black,
//               ),
//               Text('Help', style: TextStyle(color: Colors.black)),
//             ],
//           ),
//           SizedBox(
//             height: 150.0,
//           ),
//           Center(
//             child: Text("DTok",
//                 style: TextStyle(color: Colors.black, fontSize: 38)),
//           ),
//           Center(
//             child: Text(
//               '   DTok is a community powered video sharing app platform where users vote on videos to reward creators, curators, influencers and viewers in cryptocurrency, like a decentralized Tiktok.',
//               style: TextStyle(
//                   color: Color.fromRGBO(53, 53, 53, 1),
//                   fontSize: 12,
//                   height: 1.25),
//             ),
//           ),
//           SizedBox(
//             height: 50.0,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: RaisedButton(
//               color: Color.fromRGBO(252, 1, 86, 1),
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           FontAwesomeIcons.apple,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                         SizedBox(width: 2.0),
//                         Text(
//                           "Hive Sign In",
//                           style: TextStyle(color: Colors.white),
//                         )
//                       ])),
//               onPressed: () {
//                 print("Hive Signer Activated");
//                 showBarModalBottomSheet(
//                     context: context,
//                     builder: (context) {
//                       return HiveAccount();
//                     });
//               },
//             ),
//           ),
//           SizedBox(
//             height: 2.0,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: OutlineButton(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         FontAwesomeIcons.google,
//                         color: Colors.black,
//                         size: 16,
//                       ),
//                       SizedBox(width: 2.0),
//                       Text(
//                         'Google Sign In',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onPressed: () {
//                   authBloc.loginGoogle(context);
//                 }),
//           ),
//           SizedBox(
//             height: 5.0,
//           ),
//           SizedBox(
//             height: 2.0,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: OutlineButton(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30)),
//                 child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             FontAwesomeIcons.apple,
//                             color: Colors.black,
//                             size: 18,
//                           ),
//                           SizedBox(width: 2.0),
//                           Text("Apple Sign In")
//                         ])),
//               ),
//               onPressed: () {
//                 authBloc.loginApple(context);
//               },
//             ),
//           ),
//           SizedBox(
//             height: 5.0,
//           ),
//           /* Center(
//               child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'Sign in means to agree with',
//                   style: TextStyle(color: Color.fromRGBO(53, 53, 53, 0.8)),
//                 ),
//                 TextSpan(text: ' '),
//                 TextSpan(
//                   text: 'the user agreement',
//                   style: TextStyle(color: Color.fromRGBO(0, 164, 219, 0.8)),
//                 ),
//                 TextSpan(text: ' '),
//                 TextSpan(
//                   text: 'and',
//                   style: TextStyle(color: Color.fromRGBO(53, 53, 53, 0.8)),
//                 ),
//                 TextSpan(text: ' '),
//                 TextSpan(
//                   text: 'privacy policy',
//                   style: TextStyle(color: Color.fromRGBO(0, 164, 219, 0.8)),
//                 ),
//               ],
//             ),
//           )), */
//           /* Center(
//               child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'and',
//                   style: TextStyle(color: Color.fromRGBO(53, 53, 53, 0.8)),
//                 ),
//                 TextSpan(text: '  '),
//                 TextSpan(
//                     text: '《DTOK Service Terms》',
//                     style: TextStyle(color: Color.fromRGBO(0, 164, 219, 0.8)),
//                     recognizer: _myTapGestureRecognizer),
//               ],
//             ),
//           )), */
//           Expanded(
//               flex: 1,
//               child: Center(
//                   heightFactor: 25.0,
//                   child: Text('Other ways to log in',
//                       style:
//                           TextStyle(color: Color.fromRGBO(0, 164, 219, 0.8))))),
//         ],
//       ),
//     );
//   }
// }
