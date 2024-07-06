import 'package:flutter/material.dart';
import 'package:week_2/chattab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 780),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(title: 'screenutil'),
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
          image: DecorationImage(image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover
          ),
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
                padding: EdgeInsets.only( top: 123, bottom: 235),
                height: 780,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only( bottom: 88, left: 18),
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
                            margin: EdgeInsets.only( bottom: 5, left: 69, right: 69),
                            height: 245,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/YonSuri1.png',
                              fit: BoxFit.fill,
                            )
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF8C5B3F),
                          ),
                          padding: EdgeInsets.only( left: 25, right: 25),
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [ //카카오톡 로그인 버튼
                                InkWell(
                                  onTap: () {
                                    // 새로운 화면으로 이동
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => chattab())
                                    );
                                  },
                                  child: Image.asset("assets/images/kklogin.png"),
                                )
                              ]
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            ],
          )
      ),
    ),
      )
    );
  }
}