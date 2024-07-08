import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:Manito/chattab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '32298497b998bde126209ad87a0efe8e',
    javaScriptAppKey: '32de79ed16b88e0c7eaa46702533c4c3',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 780),
      builder: (BuildContext context, Widget? child) => MaterialApp(
        title: 'ScreenUtil Test',
        home: MyHomePage(title: 'ScreenUtil Test'),
      ),
    );
  }
}

// This widget is the root of your application.
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: 'Flutter Demo',
//     theme: ThemeData(
//       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       useMaterial3: true,
//     ),
//     home: const MyHomePage(title: 'Flutter Demo Home Page'),
//   );
// }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover),
      ),
      child: Container(
        color: Color(0xFFFFFFFF),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 123, bottom: 235),
              height: 780,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 88, left: 18),
                      child: Text(
                        '앱 이름 이름 이름 이름 이름 이름',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin:
                              EdgeInsets.only(bottom: 5, left: 69, right: 69),
                          height: 245,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/yonsuri.png',
                            fit: BoxFit.fill,
                          )),
                    ),
                    IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFF8C5B3F),
                        ),
                        padding: EdgeInsets.only(left: 25, right: 25),
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // //카카오톡 로그인 버튼
                              InkWell(
                                onTap: () async {
                                  try {
                                    bool isInstalled =
                                        await isKakaoTalkInstalled();

                                    OAuthToken token = isInstalled
                                        ? await UserApi.instance
                                            .loginWithKakaoTalk()
                                        : await UserApi.instance
                                            .loginWithKakaoAccount();
                                        print('카카오톡으로 로그인 성공');

                                    final url = Uri.https('kapi.kakao.com', '/v2/user/me');

                                    final response = await http.get(
                                      url,
                                      headers: {
                                        HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
                                      },
                                    );

                                    final profileInfo = json.decode(response.body);
                                    print(profileInfo.toString());


                                    Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => chattab())
                                        );

                                  } catch (error) {
                                    print('카카오톡으로 로그인 실패 $error');
                                  }
                                },
                                child: Image.asset("assets/images/kklogin.png"),
                              )
                            ]),
                      ),
                    ),
                  ]),
            ),
          ],
        )),
      ),
    ));
  }
}
