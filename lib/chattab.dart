import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:Manito/Enteringtab.dart';
import 'package:http/http.dart' as http;
import 'package:Manito/guess.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class chattab extends StatefulWidget {
  @override
  _chattabState createState() => _chattabState();
}

class _chattabState extends State<chattab> {
  int userid = 0;
  String? usernickname = '';
  String username = "지놘";
  late IO.Socket socket;
  List<String> messages = [];
  TextEditingController _controller = TextEditingController();

  bool showElements = false;

  @override
  void initState() {
    super.initState();
    initSocket();
    enddateData();
    checkDate();
  }

  int enddh = 0;
  int enddm = 0;
  int endds = 0;

  void enddateData() async {
    try {
      User user = await UserApi.instance.me();
      userid = user.id;
      usernickname = user.kakaoAccount?.profile?.nickname;
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');

      var url = Uri.parse('http://172.10.7.106:80/invite2/$userid');
      print('Sending request to $url');
      var response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String end_date = data['end_date'];
        DateTime enddate = DateTime.parse(end_date);
        int endh = enddate.year;
        int endm = enddate.month;
        int ends = enddate.day;
        setState(() {
          enddh = endh;
          enddm = endm;
          endds = ends;
        });
        print('enddate: $enddh,$enddm,$endds');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('An error occurred $e');
    }
  }

  void checkDate() {
    final now = DateTime.now();
    final targetDate = DateTime(enddh, enddm, endds);
    if (now.isAfter(targetDate)) {
      setState(() {
        showElements = true;
      });
    }
  }

  void initSocket() {
    socket = IO.io('http://172.10.7.106:80', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on('connect', (_) {
      print('connected');
      // Request stored messages when connected
      socket.emit('requestStoredMessages');
    });

    socket.on('previousMessages', (data) {
      print('Previous messages received: $data');
      setState(() {
        messages.addAll((data as List)
            .map((item) => (item['username'] as String) + ": " + (item['message'] as String))
            .toList());
      });
    });

    socket.on('chatMessage', (data) {
      setState(() {
        messages.add(data['username'] + ": " + data['message']);
      });
    });

    socket.on('connect_error', (data) {
      print('Connection Error: $data');
    });

    socket.on('disconnect', (_) {
      print('disconnected');
    });

    socket.connect();
  }

  void fetchData() async {
    try {
      User user = await UserApi.instance.me();
      userid = user.id;
      usernickname = user.kakaoAccount?.profile?.nickname;
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');

      var url = Uri.parse('http://172.10.7.106:80/user/$userid');
      print('Sending request to $url');
      var response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String dataname = data['name'];
        username = dataname;
        print('Name: $username');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('An error occurred $e');
    }
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      fetchData();
      final chatMessage = {'username': username, 'message': message};
      socket.emit('chatMessage', chatMessage);
      setState(() {
        messages.add(username + ": " + message);
      });
      _controller.clear();
    }
  }

  Future<void> sendGuess(String guess) async {
    var url = Uri.parse('http://172.10.7.106:80/createMatches');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'sourceId':userid,
      'sourceName': usernickname,
      'targetName': guess});

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Guess sent successfully');
      } else {
        print('Failed to send guess');
      }
    } catch (e) {
      print('Error occurred while sending guess: $e');
    }
  }

  void _navigateToGuessPage(String guessText) {
    sendGuess(guessText);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Guess(),
      ),
    );
  }

  @override
  void dispose() {
    socket.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    enddateData();
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xFFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF000000),
                    width: 1,
                  ),
                  color: Color(0xFF4AAAC4),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4D000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(top: 55),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 7, left: 20, right: 20),
                          width: double.infinity,
                          child: Row(children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Enteringtab(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 6),
                                width: 10,
                                height: 17,
                                child: Image.asset(
                                  'assets/chattab/back.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 119),
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  '방제목',
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color(0xFFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x4D000000),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 18, right: 18),
                          margin: EdgeInsets.only(bottom: 11),
                          width: double.infinity,
                          child: Row(children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(right: 17),
                                width: 17,
                                height: 15,
                                child: Image.asset(
                                  'assets/chattab/Notice.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  '마니또 종료일',
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      ...messages.map((message) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFFFFFF),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 11),
                          margin: EdgeInsets.only(left: 11, right: 11, bottom: 5),
                          child: Column(children: [
                            Text(
                              message,
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 15,
                              ),
                            ),
                          ]),
                        );
                      }).toList(),
                      Visibility(
                        visible: showElements,
                        child: Column(
                          children: [
                            IntrinsicHeight(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF0278A2),
                                ),
                                padding: EdgeInsets.only(
                                    top: 22, bottom: 22, left: 28, right: 28),
                                margin: EdgeInsets.only(bottom: 24, left: 90, right: 90),
                                width: double.infinity,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          '${username} 님의\n 마니또 맞추기',
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            IntrinsicHeight(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFF000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x4D000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 9),
                                margin: EdgeInsets.only(bottom: 191, left: 39, right: 39),
                                width: double.infinity,
                                child: Column(children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: '마니또를 맞춰보세요!',
                                    ),
                                    onSubmitted: (value) {
                                      _navigateToGuessPage(value);
                                    },
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 40, bottom: 40, left: 9, right: 9),
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      width: 23,
                                      height: 23,
                                      child: Image.asset(
                                        'assets/chattab/+button.png',
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFDEDEDE),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(17),
                                    color: Color(0xFFF9F8FA),
                                  ),
                                  width: 300,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _controller,
                                          maxLines: null,
                                          onSubmitted: sendMessage,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '메시지를 입력하세요!',
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.send),
                                        onPressed: () {
                                          sendMessage(_controller.text);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
