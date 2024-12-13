import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:Manito/Enteringtab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

void main() async {
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
        builder: (context, child) {
          return ScrollConfiguration(
              behavior: NoGlowScrollBehavior(), child: child!);
        },
        home: MyHomePage(title: 'ScreenUtil Test'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime? _selectedDate;
  DateTime selectedDate = DateTime.now();
  int userid = 0;
  String? usernickname = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2300),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }



  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: Container(
          color: Color(0xFFFFFFFF),
          padding: EdgeInsets.only(top: 50.w, bottom: 200.w),
          height: 780.w,
          width: 360.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 115.w, right: 85.w),
                          child: Image.asset('assets/images/Lightmodeicon.jpg',
                              width: 200.w, height: 150.w)),
                      Container(
                          margin: EdgeInsets.only(left: 69.w, right: 69.w),
                          height: 180.w,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/yonsuri.png',
                            fit: BoxFit.fill,
                          )),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.w),
                          color: Color(0xFFFFFFF),
                        ),
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        margin: EdgeInsets.symmetric(horizontal: 60.w),
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // //카카오톡 로그인 버튼
                              InkWell(
                                onTap: () async {
                                  // 카카오톡 로그인하기 !!
                                  try {
                                    bool isInstalled =
                                        await isKakaoTalkInstalled();

                                    //카카오톡 로그인 정보가 있어도 다시 요청하는 것이니 필요 없으면 지우도록 해
                                  try {
                                    User user = await UserApi.instance.me();
                                    userid = user.id;
                                    usernickname = user.kakaoAccount?.profile?.nickname;
                                    print('사용자 정보 요청 성공'
                                        '\n회원번호: ${user.id}'
                                        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
                                        '\n이메일: ${user.kakaoAccount?.email}');
                                  } catch (error) {
                                    print('사용자 정보 요청 실패 $error');
                                  }
                                  //여기까지 카카오톡 로그인 정보가 있어도 다시 요청하는 것이니 필요 없으면 지우도록 해

                                    OAuthToken token = isInstalled
                                        ? await UserApi.instance
                                            .loginWithKakaoTalk()
                                        : await UserApi.instance
                                            .loginWithKakaoAccount();
                                        print('카카오톡으로 로그인 성공');


                                    final url = Uri.https('kapi.kakao.com', '/v2/user/me');

                                    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
                                      },
                                    );
                                    final profileInfo = json.decode(response.body);
                                    print(profileInfo.toString());

                                    fetchData();
                                    postkakaoData(userid, usernickname);
                                    Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Enteringtab())
                                        );

                                  } catch (error) {
                                    print('카카오톡으로 로그인 실패 $error');
                                  }


                                  print("프린트 동작확인");
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Enteringtab()));
                                },
                                child: Image.asset("assets/images/kklogin.png"),
                              )
                            ]),
                      ),
                    ]),
              ),
            ],
          )),
    );
  }
}

Future<void> fetchData() async {
  try {
    var url = Uri.parse('http://172.10.7.106:80/user/testid');
    print('Sending request to $url');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(await http.read(Uri.parse('http://172.10.7.106:80/user/')));
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      // 성공적으로 데이터를 받음
      print('Response data: ${response.body}'); }
    else {
      // 에러 처리
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred $e');
  }
}

Future <void> postkakaoData(ID, name) async {
  var url = Uri.parse('http://172.10.7.106:80/user/');
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({'name': name,  'id': ID, 'password': 'testpasswererord'});
  var response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 201) {
    print('User created successfully');
  } else {
    print('Failed to create user');
  }

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}



class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
