import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/screens/to_do.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 5000),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => ToDo())));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network("https://assets1.lottiefiles.com/packages/lf20_x62chJ.json",width: 600),
          Text("To do list will load shortly!"),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("In the meantime, feel free to think of things to be done."),
              Icon(Icons.not_interested_rounded)
            ],
          ),
        ],
      )
    );
  }
}