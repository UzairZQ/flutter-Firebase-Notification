import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print('FireBase Background Message Title: ${message.notification!.title}');
  print('FireBase Background Message Body: ${message.notification!.body}');
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    runApp(MyApp());
  } catch (e) {
    print('Firebase Messagin Error: ${e.toString()}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then(
      (value) {
        print('Value of the token is: ${value}');
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('FireBase onMessage Title: ${message.notification!.title}');
      print('FireBase  onMessage Body: ${message.notification!.body}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          'FireBase onMessageOpenedApp Title: ${message.notification!.title}');
      print('FireBase onMessageOpenedApp Body: ${message.notification!.body}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Firebase Notification",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff4338CA),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff4338CA), Color(0xff6D28D9)],
              stops: [0.5, 1.0],
            ),
          ),
        ),
      ),
      body: Container(
          // Place as the child widget of a scaffold
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/backgrounds%2Fcasey-horner-G2jAOMGGlPE-unsplash.jpg?alt=media&token=54d2effa-1220-4bc2-b03c-caed9feb22db"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container() // Place child here
          ),
    );
  }
}
