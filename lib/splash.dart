import 'dart:async';

import 'package:catbreeds/home/view/home_page.dart';
import 'package:catbreeds/utils/scale_route.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashPage>  with TickerProviderStateMixin {


  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.push(context, ScaleRoute(page: const HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: const Color.fromRGBO(90, 72, 113, 1),
              child: Image.asset(
                "assets/loading.gif",
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
              ),
            ));
  }

}

