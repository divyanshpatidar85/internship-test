import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/api.dart';
import 'package:quadb_tech/custom-container.dart';
import 'package:quadb_tech/splash.dart';

void main() {
  runApp(MultiProvider(
    providers: [
          ChangeNotifierProvider(create: (_) => ApiData()),
          
        ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const SplashScreen(),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }



  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     
      body:NetflixContainer(),
    );
  }
}
