import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // 시계 형식
import 'dart:async';             // 서버에서 시간 따옴

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momentum',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white, // 전체 '텍스트' 테마 설정과 관련
          displayColor: Colors.white,
        )
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),  // 처음 페이지의 구성은 여기서 바꿔야함
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { // 첫화면 꾸미기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Background(
        imagePath: 'image/cat.jpg',
        child: Padding(
          padding: const EdgeInsets.all(20.0), // 배경 테두리에서 공간을 20 띄우기
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Links(),  // Row()로 links랑 검색 아이콘 같이 넣으면 되는 거 아닌가? NO (나중에 기능 넣을 때 수정곤란 ㅜㅜ => 클래스 이용하자)

              ),
              Align(
                alignment: Alignment.topRight,
                child: Weather(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Setting(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Todo(),
              ),
              Align(
                alignment: Alignment.center,
                child: Clock(),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Quote()
            ),
            Align(
              alignment: FractionalOffset(0.5,0.75),
              child: Focus1()
            ),
            ],
          )

        ),
      ), // 구성 채우기

    ) ;
  }
}

class Links extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(   // Row가 공간을 나누는 박스라고 생각하면 편
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Links"),
        Container(height: 0, width: 20,),  // links와 아이콘 사이 공백 만들기
        Icon(Icons.search, color: Colors.white,),
    ]
    );
  }
}

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.wb_sunny_outlined, color : Colors.white),
        Container(height: 0, width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("14º"),
            Text("서울"),
          ],

        ),

      ],
    );
  }
}
class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.settings,color: Colors.white,);
  }
}
class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Todo");
  }
}
/*
class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("17:30",style: TextStyle(fontSize: 150,));
  }
}
*/

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  String _timeString;      // 받아온 시간정보를 보기 편한 형태로 만듦
  Timer _timer;            // 시간정보 받아옴

  @override
  void initState(){      //ClockState라는 클래스의 초기 상태 설정하기
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());  //DURATION 주기로 (Timer t) => getTime() 실생히킴
                                                   // (Timer t) => getTime() : Timer t 받아서 getTime() 리턴하는 이름없는 함수
    super.initState();
        
  }
  @override
  void dispose() {                // Clock 클래스 종료할 때 무슨 작업할지
    // TODO: implement dispose
    _timer.cancel();              // 시간 받아오는 거 중지
    super.dispose();
  }

   String _formatDateTime(DateTime dateTime) {   // dataTime은 변수명
     return DateFormat('HH:mm:ss').format(dateTime);  // dateTime을 'HH:mm:ss' 형식으로 리턴
   }
  void _getTime(){          //getTime이라는 함수 만들기
    final DateTime now = DateTime.now(); // 현재시간을 now라는 변수에 저장
    final String formattedDateTime = _formatDateTime(now); // now를 formatDateTime 함수를 통해서 형식 설정함
    setState(() {                      // () => 이름 없는 함수가 설정되어 있음
      _timeString = formattedDateTime; // Duration 주기로 getTime 실행시키는데 그 getTime이 실행하는 동작이 이름없는 함수!!
                                       // 함수가 하는일 => _timeString을 formattedDataTime으로 선언 (1초마다 이렇게 업데이트 됨)
      });

  }

  @override
  Widget build(BuildContext context) {
    return Text(_timeString, style: TextStyle(fontSize: 150),);
  }
}

class Quote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('"Always walk through life as if you have something new to learn nad you will."');
  }
}
class Focus1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(               // child의 크기에 맞춰서 폭을 맞춰줌
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('What is your main focus for today?', style: TextStyle(fontSize: 30),),
            TextField(
              enabled: false,  //메시지 입력가능 여부
              decoration: InputDecoration(
                  disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white,),
                  ),
              ),
            )
          ],
        ),
    );
  }
}

class Background extends StatelessWidget {

  final Widget child;
  final String imagePath;  // final로 된 것은 안바뀐다는 뜻 (변수설정해주기)

  Background({this.child, this.imagePath}); // {} : 자바는 생성자 형식 깐깐하게 맞춰야하는
                                           // data는 보다 유연

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit : BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
